Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6D506F58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352886AbiDSNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347187AbiDSNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABC03C4B6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76AAC616CD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4BAC385A5;
        Tue, 19 Apr 2022 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375826;
        bh=l4gigy3iODJQ8aF6vkclNEbKoZHxSxxrBtC8fcT83JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adAsUeF8sXGrAV9UjKuVAbxBCr1Z3Hj0eUmbHyY7Wcy388GLqoiFHyd92z6CMe1w5
         UaCUoB6KMdLDADxfNIzVdT7ojRM5tjkHHfn3oa8yyAZnVlV5ed3/+4IWxYnt/eSCx6
         d8/lRG03Q7OcBWdG0YkOq17Kz4f9S+/E9X59RViTMTHN+XzOn12Oam8VqqnlBHy1tb
         7G9RTpV7pMI/ns/mS20UE2hnALBZSd34NtL7aSuRdigbDW80TlHLRDp4yOqjpuYnFF
         kZO/Ak4WAur6w6Q0WZvxWhWivYZogNYna7cqKvqUQNwaa6drmZ8cEPnj/7baBZ3h7M
         REJ8hYRP2ehsA==
Date:   Tue, 19 Apr 2022 14:43:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Steven Price <steven.price@arm.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        lengxujun2007@126.com, arnd@arndb.de, smuchun@gmail.com,
        duanxiongchun@bytedance.com, quic_qiancai@quicinc.com,
        aneesh.kumar@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: mm: fix pmd_leaf()
Message-ID: <20220419134339.GA6143@willie-the-truck>
References: <20220411122653.40284-1-songmuchun@bytedance.com>
 <20220413101929.GA1229@willie-the-truck>
 <64d4288e-7776-a3fd-5ee4-70486dfd0394@arm.com>
 <20220414100535.GB2298@willie-the-truck>
 <YlgC877mS2LjsqS8@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlgC877mS2LjsqS8@FVFYT0MHHV2J.usts.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 07:18:11PM +0800, Muchun Song wrote:
> On Thu, Apr 14, 2022 at 11:05:35AM +0100, Will Deacon wrote:
> > On Wed, Apr 13, 2022 at 11:39:49AM +0100, Steven Price wrote:
> > > On 13/04/2022 11:19, Will Deacon wrote:
> > > > The documentation/comment that Steven referred to also desperately needs
> > > > clarifying as it currently states:
> > > > 
> > > >   "Only meaningful when called on a valid entry."
> > > > 
> > > > whatever that means.
> > > 
> > > The intention at the time is that this had the same meaning as
> > > pmd_huge() (when CONFIG_HUGETLB_PAGE is defined), which would then match
> > > this patch. This is referred in the comment, albeit in a rather weak way:
> > > 
> > > >  * This differs from p?d_huge() by the fact that they are always available (if
> > > >  * the architecture supports large pages at the appropriate level) even
> > > >  * if CONFIG_HUGETLB_PAGE is not defined.
> > > 
> > > However, the real issue here is that the definition of pmd_leaf() isn't
> > > clear. I know what the original uses of it needed but since then it's
> > > been used in other areas, and I'm afraid my 'documentation' isn't
> > > precise enough to actually be useful.
> > > 
> > > At the time I wrote that comment I think I meant "valid" in the AArch64
> > > sense (i.e. the LSB of the entry). PROT_NONE isn't 'valid' by that
> > > definition (and I hadn't considered it). But of course that definition
> > > of 'valid' is pretty meaningless in the cross-architecture case.
> > 
> > arm64 'valid' + PROT_NONE is roughly what 'present' means. So we could say
> > that this only works for present entries, but then Muchun's latest patch
> > wants to work with !present which is why I tried to work this through.
> >
> 
> My bad. In the previous version, Aneesh seems want to make
> pmd_leaf() works for a not present page table entry, I am
> trying doing this in this version.  Seems like I do the right
> thing in the previous version from your explanation.
> 
> I'll use the previos version and fix pud_leaf() as well and
> update the documentation.  Do you think this is okay?

Yes, thanks, that sounds good to me. We can define both of these as present
&& !table.

Will
