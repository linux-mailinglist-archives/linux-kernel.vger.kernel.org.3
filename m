Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B488575609
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbiGNT6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbiGNT6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:58:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60465B043;
        Thu, 14 Jul 2022 12:58:16 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-002-247-249-041.2.247.pool.telefonica.de [2.247.249.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF8681EC0434;
        Thu, 14 Jul 2022 21:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657828691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLDHu8LrB8hyxxiIBDSSkY5wHsm8HoeB6IqXcX6azAE=;
        b=KkG0hKZ20oUpDoCGWacTZX6XRWIC7gmitANZlIPsUXcP2oD6jOG3BVHF7Rhk09p6Nc2qOd
        la5cFd6r9bmkhtBhYriubZ2eRt/WyQTni6+p0wBGoxmam1S/bLe0MRLG3FDZMmk4+L45nZ
        Sciw6uDM+J5MJOz6ENqs6/2fklGFbtg=
Date:   Thu, 14 Jul 2022 19:58:08 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
CC:     pawan.kumar.gupta@linux.intel.com,
        antonio.gomez.iglesias@linux.intel.com, linux-doc@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Add BHI_DIS support
In-Reply-To: <20220714195236.9311-1-daniel.sneddon@linux.intel.com>
References: <20220714195236.9311-1-daniel.sneddon@linux.intel.com>
Message-ID: <7D1E33F3-A390-4691-86C2-F7CB3E8309B3@alien8.de>
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

On July 14, 2022 7:52:35 PM UTC, Daniel Sneddon <daniel=2Esneddon@linux=2Ei=
ntel=2Ecom> wrote:
>Branch History Injection (BHI) attacks can be mitigated using the
>BHI_DIS_S indirect predictor control bit located in MSR_IA32_SPEC_CTRL
>register=2E Set BHI_DIS in MSR_IA32_SPC_CTRL to prevent predicted
>targets of indirect branches executed in CPL0, CPL1, or CPL2 from
>being selected based on branch history from branches executed in CPL3=2E
>Support for this feature is enumerated by CPUID=2E7=2E2=2EEDX[BHI_CTRL] (=
bit 4)=2E
>
>Users wanting BHI protection can specify spectre_v2=3Deibrs,bhi_dis to
>enable hardware BHI protections=2E  On platforms where BHI protections
>are not available in the hardware revert to eibrs,retpoline
>mitigations=2E

Why is this a separately selectable option and not automatically enabled?

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
