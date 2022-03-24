Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64444E6380
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350240AbiCXMoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCXMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:44:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED1C4C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:43:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0970F1F745;
        Thu, 24 Mar 2022 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648125782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtkJHll3BGHTPIchNMgaGNfzKDZMQ29t02N6cPbRei8=;
        b=WmEIeEQumjQlWOh3pJEUKzE7T8O+U2xNXKX+KlcLt/ijrxWI05XaNwqkjRNdnoOmkICLWn
        gM6tYrTi4FDvr2gWUm341gRjdASUkBoB313ZN0eUGPnUlRRQsbSDHtwaZc/U1aYzt/Ltcd
        Hiezll6ttvEyIPTX+1v0xaYTZnI4iq0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8E96A3B93;
        Thu, 24 Mar 2022 12:43:01 +0000 (UTC)
Date:   Thu, 24 Mar 2022 13:42:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Juergen Gross <jgross@suse.com>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: blocking vs. non-blocking mmu notifiers
Message-ID: <YjxnULAWb3PLvrky@dhcp22.suse.cz>
References: <8e8ec786-74db-157b-a290-b1537941e91d@suse.com>
 <YjrsOnxaPYc3rbdj@dhcp22.suse.cz>
 <20220323163146.GI64706@ziepe.ca>
 <YjtPpxlE/zWwnJ0W@dhcp22.suse.cz>
 <20220323170404.GK64706@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323170404.GK64706@ziepe.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-03-22 14:04:04, Jason Gunthorpe wrote:
> On Wed, Mar 23, 2022 at 05:49:43PM +0100, Michal Hocko wrote:
> > > The bug here is that prior to commit a81461b0546c ("xen/gntdev: update
> > > to new mmu_notifier semantic") wired the mn_invl_range_start() which
> > > takes a mutex to invalidate_page, which is defined to run in an atomic
> > > context.
> > 
> > Yeah, we have already identified that but quickly realized that the
> > whole mmu notifier overhaul which this fix depends on would be no no for
> > backporting to our older code base. So we are trying to find our way
> > around that.
> 
> IMHO you don't need everything, just commit 369ea8242c0f ("mm/rmap:
> update to new mmu_notifier semantic v2") which adds the missing
> start/end outside the lock for the page callbacks.
> 
> Then you can take safely a8146 into gntdev.

Thanks Jason!

-- 
Michal Hocko
SUSE Labs
