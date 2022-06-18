Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B855014B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383851AbiFRAXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383741AbiFRAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E99193EC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9092B82BC5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D093C3411B;
        Sat, 18 Jun 2022 00:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655511797;
        bh=boOYcCWS4dikNpyUU4qRuS9iiJRGhxU9Epcn4+r8HHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tMUqy2qF8GrCyvWIsrKoV++Je8osV39RUvp9XutD2Q6NrmK2mMSj7KypK+2gCWDA6
         zyuQmID8ExnBce8qvhWt4YzdV8r0y4TEVOkZewgZXGwTo2vvNPH1hCy2yDpDmws9wC
         gjKLe3zjGj2DeJjXbLExfT62s1jhOyK6W0oiuThE=
Date:   Fri, 17 Jun 2022 17:23:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ying Huang <ying.huang@intel.com>, <peterx@redhat.com>,
        <apopple@nvidia.com>, <osalvador@suse.de>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <hch@lst.de>, <dhowells@redhat.com>, <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
Message-Id: <20220617172316.de2d41877e86be344052b9f5@linux-foundation.org>
In-Reply-To: <a836d04a-d26b-3eea-3e0e-27af0d2d9651@huawei.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
        <20220530113016.16663-2-linmiaohe@huawei.com>
        <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
        <b2ddcd64-2779-ede9-3615-ad5bc90a3bc1@huawei.com>
        <87bkvdfzvm.fsf@email.froward.int.ebiederm.org>
        <e10023d7-3d19-1edf-86af-4cb79071b78f@huawei.com>
        <87y1yga1r2.fsf@email.froward.int.ebiederm.org>
        <cb17bad6-dbfa-013c-f879-c1883575f72b@huawei.com>
        <87ilph90dx.fsf@email.froward.int.ebiederm.org>
        <a836d04a-d26b-3eea-3e0e-27af0d2d9651@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 17:19:53 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> > 
> > 
> > If the checks are not made to guarantee they are all checking against
> > the same mm, the code needs a comment to say that there is a tiny race.
> > The comment should say we don't care about the tiny race because
> > the worst that can happen is that a page is migrated to a different
> > numa node.  And so we don't care.
> > 
> > 
> 
> I tend to do this one. To make sure, is the below code change what you suggest?

Eric went quiet.

As I understand it, any changes arising from this discussion can be
done as a followup patch.  So I'm planning on moving this 4-patch
series into the non-rebasing mm-stable branch late next week.


