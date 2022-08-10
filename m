Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582658E4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiHJCMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHJCMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:12:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D97E331
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FC27B81A10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C390C433D6;
        Wed, 10 Aug 2022 02:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660097549;
        bh=mk2uW891Ph7QCIkkZA5XSEm1+XrXQwcsEZKt1nJZdPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P2rdO5+8XuOckGFqAGCLmNVeQdyrR6LB7XD57kbDWblgOmnljFX/6hy/c2Pt/9ecE
         iv1yJUd/77YPr+rbu1Bq0dr/SsijaoRZHXZ4ByszNRZnUTMXhAAMV8q8/epG98iRmW
         wjaBbHrPBFmp7z7Ry9YlP5+yI5mY6zwPDe4Z8+IE=
Date:   Tue, 9 Aug 2022 19:12:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        alex.sierra@amd.com, hch@lst.de, apopple@nvidia.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: re-allow pinning of zero pfns (again)
Message-Id: <20220809191227.4694677c360c4a64164f7136@linux-foundation.org>
In-Reply-To: <cd25ebd9-52f9-2e66-841e-fc94b3949f7d@amd.com>
References: <166002010021.381133.11357879752637949308.stgit@omen>
        <YvJTi0fAgl/T4WA4@casper.infradead.org>
        <cd25ebd9-52f9-2e66-841e-fc94b3949f7d@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 10:14:12 -0400 Felix Kuehling <felix.kuehling@amd.com> wrote:

> Am 2022-08-09 um 08:31 schrieb Matthew Wilcox:
> > On Mon, Aug 08, 2022 at 10:42:24PM -0600, Alex Williamson wrote:
> >> The below referenced commit makes the same error as 1c563432588d ("mm: fix
> >> is_pinnable_page against a cma page"), re-interpreting the logic to exclude
> >> pinning of the zero page, which breaks device assignment with vfio.

If two people made the same error then surely that's a sign that we
need a comment which explains things to the next visitor.

> > Perhaps we need to admit we're not as good at boolean logic as we think
> > we are.
> >
> > 	if (is_device_coherent_page(page))
> > 		return false;
> > 	if (is_zone_movable_page(page))
> > 		return false;
> > 	return is_zero_pfn(page_to_pfn(page));
> >
> > (or whatever the right logic is ... I just woke up and I'm having
> > trouble parsing it).
> 
> This implies an assumption that zero-page is never device-coherent or 
> moveable, which is probably true, but not part of the original 
> condition. A more formally correct rewrite would be:
> 
> 	if (is_zero_pfn(page_to_pfn(page)))
> 		return true;
> 	if (is_device_coherent_page(page))
> 		return false;
> 	return !is_zone_moveable_page(page);
> 

Yes please, vastly better.

And a nice thing about this layout is that it leaves places where we
can add a nice little comment against each clause of the test, to
explain why we're performing each one.

