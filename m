Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FB555390
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377296AbiFVStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376918AbiFVStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:49:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B205313BF;
        Wed, 22 Jun 2022 11:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9482B8208E;
        Wed, 22 Jun 2022 18:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A37FC34114;
        Wed, 22 Jun 2022 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655923782;
        bh=UGwK8U1CCaVfUgZAsLw+SYJ97g3dLCKIIomeuZiBQ1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bZVT9UVsA84wtb28RRbkCP0+NC6uhTn6OwNN8hldf7jfAOb4e8eihS1G4q19GfWvm
         aRdf7WUvX08IC68x4Slo5jEg54I5AYWVjqIr/WQyDwyLgQOeuIxP4uxlaBeYMdU58e
         cXCLzglwW9AfkLEPqvNsN0YZ8ut6Uek+6XAR7TLA=
Date:   Wed, 22 Jun 2022 11:49:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-Id: <20220622114930.c907cbd361a7f71fb83eaf8f@linux-foundation.org>
In-Reply-To: <YrNF0i01rU/r3yQn@monkey>
References: <20220622155408.3ba2a9b7@canb.auug.org.au>
        <20220622171117.70850960@canb.auug.org.au>
        <YrNF0i01rU/r3yQn@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 09:39:46 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6905,10 +6905,8 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
> >  /* See description above.  Architectures can provide their own version. */
> >  __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
> >  {
> > -	unsigned long hp_size = huge_page_size(h);
> > -
> >  #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> > -	if (hp_size == PMD_SIZE)
> > +	if (huge_page_size(h) == PMD_SIZE)
> >  		return PUD_SIZE - PMD_SIZE;
> >  #endif
> >  	return 0UL;
> > -- 
> 
> Thanks Stephen,  my bad for not building !CONFIG_ARCH_WANT_HUGE_PMD_SHARE and,
> the error is pretty obvious. :(
> 
> Andrew, do you want me to send an updated version of the patch?  Or,
> would you prefer to include Stephen's fix?

I added Stephen's fix, thanks.
