Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D058DA7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiHIOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiHIOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:43:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8D1B7AD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7z/JIUVgUhFXekW4Gduj7+h/qYJwWZYYv/506cYfRO4=; b=X6wAY4JSpD1MsTGMIps4uXR5+K
        fdixl0iqHE7B7Bon+LpUoDec++73sL08sVAJRflcDWBhGUKQa8ssHAXqitz6BesQEJwCGDSJHf2gq
        /Cmeh9Fsn1lZS49+AAVsTvAtwc6keu7assWYRuztEb4S65hHqOWgvQMKocYlTHlXiiZ1If8VI/rtS
        kXL9KxSaom4Gy3hdgPu2uZDhq1occseSvi7Vf42G6V7Pymb/IULH77VbXKyfLpw0hNaVMHHx+OXm+
        +K6zIVjZdNuuSgcmm+TEVkxHzp2rq1X/+XO+HyA3a9s13jDLGdWhuBZGrA7deQQsmZmP/PD7ADVke
        jBNGfMtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLQSL-00FU2x-6I; Tue, 09 Aug 2022 14:43:41 +0000
Date:   Tue, 9 Aug 2022 15:43:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, alex.sierra@amd.com,
        akpm@linux-foundation.org, hch@lst.de, apopple@nvidia.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: re-allow pinning of zero pfns (again)
Message-ID: <YvJynaZPAJayhgBK@casper.infradead.org>
References: <166002010021.381133.11357879752637949308.stgit@omen>
 <YvJTi0fAgl/T4WA4@casper.infradead.org>
 <cd25ebd9-52f9-2e66-841e-fc94b3949f7d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd25ebd9-52f9-2e66-841e-fc94b3949f7d@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 10:14:12AM -0400, Felix Kuehling wrote:
> Am 2022-08-09 um 08:31 schrieb Matthew Wilcox:
> > On Mon, Aug 08, 2022 at 10:42:24PM -0600, Alex Williamson wrote:
> > > The below referenced commit makes the same error as 1c563432588d ("mm: fix
> > > is_pinnable_page against a cma page"), re-interpreting the logic to exclude
> > > pinning of the zero page, which breaks device assignment with vfio.
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
> moveable, which is probably true, but not part of the original condition. A
> more formally correct rewrite would be:
> 
> 	if (is_zero_pfn(page_to_pfn(page)))
> 		return true;
> 	if (is_device_coherent_page(page))
> 		return false;
> 	return !is_zone_moveable_page(page);

It's definitely true that the zero page is never device-coherent, nor
movable.  Moreover, we want to avoid calling page_to_pfn() if we can.
So it should be the last condition that we check.
