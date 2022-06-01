Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A853AB5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353829AbiFAQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFAQyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:54:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A365D36
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 598A1CE1C98
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81773C385A5;
        Wed,  1 Jun 2022 16:54:44 +0000 (UTC)
Date:   Wed, 1 Jun 2022 17:54:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference
 of noderef expression
Message-ID: <YpeZ0M5we/0yzxVC@arm.com>
References: <202205280635.XKlMkfKD-lkp@intel.com>
 <YpZJBoxqvaCLRQfX@arm.com>
 <YpcaTwI4SvV3IrwF@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcaTwI4SvV3IrwF@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 09:50:39AM +0200, Mark Brown wrote:
> On Tue, May 31, 2022 at 05:57:42PM +0100, Catalin Marinas wrote:
> > This looks wrong indeed. IIUC, something like below but waiting for Mark
> > to confirm:
> > 
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 819979398127..ac521b3403d6 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -1965,7 +1965,7 @@ void __efi_fpsimd_end(void)
> >  							   0,
> >  							   SVCR_SM_MASK);
> >  					if (!system_supports_fa64())
> > -						ffr = efi_sm_state;
> > +						ffr = false;
> 
> Yes, that looks right - feel free to add my Reviewed-by or I'll
> do that when I see the patch sent properly.

I'm no longer convinced that's the right fix. In __efi_fpsimd_begin(),
ffr is true if either !system_supports_fa64() or SVCR.SM is set. The FFR
state would be saved in this case.

In __efi_fpsimd_end(), shouldn't we just restore the FFR state if
efi_sm_state, irrespective of system_supports_fa64() (as it was checked
in the beginning). Something like:

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 819979398127..8bc9080adab2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1960,13 +1960,12 @@ void __efi_fpsimd_end(void)
 			 * streaming mode.
 			 */
 			if (system_supports_sme()) {
-				if (__this_cpu_read(efi_sm_state)) {
+				if (__this_cpu_read(efi_sm_state))
 					sysreg_clear_set_s(SYS_SVCR,
 							   0,
 							   SVCR_SM_MASK);
-					if (!system_supports_fa64())
-						ffr = efi_sm_state;
-				}
+				else
+					ffr = false;
 			}
 
 			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl()),

-- 
Catalin
