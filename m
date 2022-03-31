Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409CA4EDA62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiCaNUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCaNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:20:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDC5005C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:18:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 262651F4680D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648732726;
        bh=/j3LkwFKB0+7mnH+l8R0tnH8GNWzHifzKE/6jt5U3UY=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=H8mj86TA9sdhniqsX1XxpjpuZkudIKTwl7mQJDIqf+7521RRaNcE5M25LZXsh6CyQ
         47unameFmfkGHw8fots1KAhClVG/lfWvKHkQD7nlz/0frggY9s/aYSesfjdBcTDZfW
         zO0knkpgJ4ut1REKs4f+ym5jW6tzehEeC4lyVH+qQ/Vh4HlGGpwnO3sbdbLS1DVhDt
         OWsXPG4o5Q1W1yRQxTKeMQsBLuTrxJqppda3Jpx8JvuQjLWYG3h3m1ze2Y9m2xk2Fv
         Fw/aQXdOjgH/arnwZ6+i14tvdFpXcpIxr0NV2KSH87Yi9yh2MC9LkuaAtPhSYiNIdp
         3TMLR/hQZ134Q==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation off when not supported
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com> <YkS3OKLS1Cixs9up@zn.tnic> <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <20220331084536.y4sl7qcfzltsnnew@guptapa-desk>
In-reply-to: <20220331084536.y4sl7qcfzltsnnew@guptapa-desk>
Date:   Thu, 31 Mar 2022 15:18:42 +0200
Message-ID: <87lewqz2dp.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawan Gupta <pawan.kumar.gupta@linux.intel.com> writes:

Hi Pawan,

>   void update_srbds_msr(void)
>   {
>   	u64 mcu_ctrl;
>   
> -	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
> -		return;
> -
> -	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		return;
> -
> -	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
> +	if (!boot_cpu_has_bug(X86_BUG_SRBDS) ||
> +	    !boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
>   		return;

Just to clarify, this changes the behavior wrt the hypervisor case:
currently it just bails out of update_srbds_msr(), with your patch it'd
clear RNGDS_MITG_DIS from MSR_IA32_MCU_OPT_CTRL. Is that what you
intended?

Ricardo
