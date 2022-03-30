Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71E74EC7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347968AbiC3PIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347872AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998EE9BAD7;
        Wed, 30 Mar 2022 08:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E4CB81D55;
        Wed, 30 Mar 2022 15:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3FC340EC;
        Wed, 30 Mar 2022 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648652797;
        bh=cF3Tkbah1THOvPGff6bjcZOkUZaKeiu0Q+LnQbzKrOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9k8gSv7rdFYscqqrJAcj22E35efVxU0154JfV18g31JVB04GGeSU3mDwOfngxam9
         QJFlmBi67hgMbVdBUgkc6IR2gLAA9xOxS0xj8i5vXc87I9J7aAN5x50K5igTAiuneu
         o3EF6CAydHM3YXyacPPAbakbZo66Hm1TzqqQSqI/qeVqwbhvjx0xmYwgojR8TpxjqS
         JeiYShQgZumLS7+GJosszS4l7psvy1mA+Pby1CB1yImwBkicmafIGq3NNQ/VRn62fC
         5TLKCDc0YoqxBp8mRterlm6FANlHuWgHhLhiqMiGUqYZOb0P2jaU7OMlEXNsrryB7P
         IRTdjTKIm4MEw==
Date:   Wed, 30 Mar 2022 18:07:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sgx: Allow RW for TCS pages
Message-ID: <YkRyPzaYlbDZg7bR@iki.fi>
References: <20220319163010.101686-1-jarkko@kernel.org>
 <e838769b-8b90-79f9-d149-e495667493b5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e838769b-8b90-79f9-d149-e495667493b5@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 01:28:39PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/19/2022 9:30 AM, Jarkko Sakkinen wrote:
> > Not allowing to set RW for added TCS pages leads only to a special case
> > to be handled in the user space run-time. Thus, allow permissions to be
> > set RW. Originally, it would have probably made more sense to check up
> > that the permissions are RW.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> > index 83df20e3e633..f79761ad0400 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -215,7 +215,7 @@ static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
> >  	 * CPU will silently overwrite the permissions as zero, which means
> >  	 * that we need to validate it ourselves.
> >  	 */
> > -	if (pt == SGX_SECINFO_TCS && perm)
> > +	if (pt == SGX_SECINFO_TCS && (perm != 0 || perm != (PROT_READ | PROT_WRITE)))
> >  		return -EINVAL;
> >  
> >  	if (secinfo->flags & SGX_SECINFO_RESERVED_MASK)
> 
> The comments above sgx_ioc_enclave_add_pages() seem to indicate that zero 
> permissions are required:
> 
> "A SECINFO for a TCS is required to always contain zero permissions because
>  CPU silently zeros them. Allowing anything else would cause a mismatch in
>  the measurement."

I think this can be left out for now but fixing the relative addressing
is an obvious fix.

BR, Jarkko
