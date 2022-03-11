Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB824D61A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348604AbiCKMiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiCKMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:38:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2E1B45EC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:37:17 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-247-254-048.2.247.pool.telefonica.de [2.247.254.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD1E01EC0347;
        Fri, 11 Mar 2022 13:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647002232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oq41xZrY/MyPw65YYgn+VmNTNE6/MaYtYT7L5NwXPC8=;
        b=aaEuLCJssRrOmm/JVzhDI67RrOIyRD9eNm7S1uFN7QDKvwwaVPCPSClUTESVg0Xf5/4iUt
        sjRTYA3LM0zZKnKneInasbNbp0QX66NNmgGB6Jaiv+sihPUDC/mIYMmi4aOQknZYgZsxcs
        NR1ZJJc4I9SyDuzO23371VueYk1qgd4=
Date:   Fri, 11 Mar 2022 12:37:09 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org
CC:     linux-mm@kvack.org, x86@kernel.org, shuah@kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, will@kernel.org, mingo@redhat.com,
        oleg@redhat.com, catalin.marinas@arm.com, ananth.narayan@amd.com
Subject: Re: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
User-Agent: K-9 Mail for Android
In-Reply-To: <20220310111545.10852-4-bharata@amd.com>
References: <20220310111545.10852-1-bharata@amd.com> <20220310111545.10852-4-bharata@amd.com>
Message-ID: <808EE3DA-69B1-47E3-825E-6DDCE1331F65@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>diff --git a/arch/x86/kernel/setup=2Ec b/arch/x86/kernel/setup=2Ec
>index f7a132eb794d=2E=2E12615b1b4af5 100644
>--- a/arch/x86/kernel/setup=2Ec
>+++ b/arch/x86/kernel/setup=2Ec
>@@ -740,6 +740,12 @@ dump_kernel_offset(struct notifier_block *self, unsi=
gned long v, void *p)
> 	return 0;
> }
>=20
>+static inline void __init uai_enable(void)
>+{
>+	if (boot_cpu_has(X86_FEATURE_UAI))

cpu_feature_enabled

>+		msr_set_bit(MSR_EFER, _EFER_UAI);
>+}


--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
