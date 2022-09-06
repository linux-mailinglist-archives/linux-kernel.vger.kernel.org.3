Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34735ADE2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiIFDw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:52:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1806412AE9;
        Mon,  5 Sep 2022 20:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1300B815CB;
        Tue,  6 Sep 2022 03:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C9C433D6;
        Tue,  6 Sep 2022 03:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662436337;
        bh=zFRC/saudT5ocL2B+pAQnl1JeST/8SgqT3A8O4f16tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGHiVYHi2xZXjHMJndgvoCYl7B5uCh4D314q8MY3hkraS4Cxm8rrwqj+UFEP06f5N
         TEzPRuibE996H8IA2HME4cS/EMJs0iWdsNs2xINnp6ka70dUHHOPIloaIeghn0zdAW
         zSgxigkCg5v0h7XSgzcYeLwrj9iB/aJISZWHNNMZW4z2WzokVBs6rlhlVAXc2+pbJ4
         mbKD7eFhCI5Owbh/E6II290tfSvfyF2bwjosq3ZG002YtQqDFpqgYkliZEqBeOcNZl
         cSIWDJGURww8adOmiMwN5IgZLopICS3DzkmNX512ngC+XdCWxqTW33q15lELAbCZCc
         ZvRqYxbXkv24A==
Date:   Tue, 6 Sep 2022 06:52:14 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/sgx: Use a heap allocated list head for
 unsanitized pages
Message-ID: <YxbD7oWO1D6JmyER@kernel.org>
References: <20220906031230.107108-1-jarkko@kernel.org>
 <c387b67e-7545-db72-25f7-7e368dddd75d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c387b67e-7545-db72-25f7-7e368dddd75d@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 08:20:18PM -0700, Dave Hansen wrote:
> On 9/5/22 20:12, Jarkko Sakkinen wrote:
> > Allocate the list head for the unsanitized pages from heap, and transfer
> > its to ownership to ksgxd, which takes care of destroying it. Remove
> > sgx_dirty_page_list, as a global list is no longer required.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > Depends on https://lore.kernel.org/linux-sgx/20220906000221.34286-1-jarkko@kernel.org/T/#t
> > Would this be plausible?
> > ---
> >  arch/x86/kernel/cpu/sgx/main.c | 44 ++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> What's the benefit?  I guess it saves 16 bytes of kernel image for ~20
> lines of code.  Does it add more than 16 bytes to kernel text? ;)

That's why I asked, and added RFC. It was so small step that I thought to
try it out.

I agree that it does not save memory for any significant amount but it
does take a bit way from driver global data, which is IMHO most of the
time +1 (simplifies state). Not saying that enough to pick this but
perhaps it will find its place as part of a patch set. By itself it
does not stand, I agree.

BR, Jarkko
