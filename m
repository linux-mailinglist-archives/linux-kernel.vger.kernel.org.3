Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B574D2DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiCILVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCILVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:21:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABA13DFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:20:16 -0800 (PST)
Received: from zn.tnic (p200300ea9719385972594b3b791fe3f2.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3859:7259:4b3b:791f:e3f2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A00C1EC03AD;
        Wed,  9 Mar 2022 12:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646824811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KXgHs6lRPpmJUOieXfnSboHcoHSA9UjDKL1SUOGT8lQ=;
        b=OGERzaXTFFkzLz8jjn3SjJj1N4exWCyNMnmr33pu8IL5rOhOdNn/Ba9mbvCTxukIL15pjW
        QCkE8vAeAqdbnOiYcXwu4ANS8sQn7Sk6wmGr+17kr3xtDA2GjuuSvtjXHtRD4UHXix+L0M
        hu0m7AIsRKk63uR9d2v5Zi0UPTErzL8=
Date:   Wed, 9 Mar 2022 12:20:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cathy Zhang <cathy.zhang@intel.com>
Cc:     linux-sgx@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 09/11] x86/microcode: Expose EUPDATESVN procedure via
 sysfs
Message-ID: <YiiNPWdsYtWiULZm@zn.tnic>
References: <20220309104050.18207-1-cathy.zhang@intel.com>
 <20220309104050.18207-10-cathy.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220309104050.18207-10-cathy.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On all your patches for the future: don't forget to Cc LKML.

On Wed, Mar 09, 2022 at 06:40:48PM +0800, Cathy Zhang wrote:
> EUPDATESVN is the SGX instruction which allows enclave attestation
> to include information about updated microcode without a reboot.
> 
> Microcode updates which affect SGX require two phases:
> 
> 1. Do the main microcode update
> 2. Make the new CPUSVN available for enclave attestation via
>    EUPDATESVN.
> 
> Before a EUPDATESVN can succeed, all enclave pages (EPC) must be
> marked as unused in the SGX metadata (EPCM). This operation destroys
> all preexisting SGX enclave data and metadata. This is by design and
> mitigates the impact of vulnerabilities that may have compromised
> enclaves or the SGX hardware itself prior to the update.
> 
> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
> ---
>  arch/x86/include/asm/microcode.h     |  5 ++++
>  arch/x86/include/asm/sgx.h           |  5 ++++
>  arch/x86/kernel/cpu/microcode/core.c | 44 ++++++++++++++++++++++++++++

Why is all this code here at all?

What does that have *actually* to do with microcode loading?

AFAICT, you want to hook into microcode_check() which runs after the
microcode update and do your EUPDATESVN there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
