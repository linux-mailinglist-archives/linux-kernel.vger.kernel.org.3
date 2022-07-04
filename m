Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F47A565887
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiGDOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiGDOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:22:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87827AE5A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:22:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so17162055ybr.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f7GCjrAcSAsu/ypl12a5quBo43EP7p9sXAwHZPyD/2Q=;
        b=JtwyT7qdgun6fYNp9iUiZ/uqg3d1hS152OWs5iRmwcCXkNdgou3z9qOTvpANk+RyKT
         x70A72E7I+Dg9L1DqySc+xlo33pzs00ObOP1N5RSl1KkoFYBsHYU1Wk6yzoX2dXFeCFf
         VID7RgCvLIgpqCRDlCdS0aQMT1QglyfhxgF2qpBkcu1bHItsyry5S8RwHyVkKoSsi69g
         X8h9Mw/ya+AU85pfq9NnPzxgarwXC63243Ti7CpQnaAeWD043JYYmX2fJXdmSRaVj95f
         aKGVP/mMCFRc12zaNxdYxAqwCrl8RG5N/p8w6y5On0MQR7rM6BfMl0r4ragVZo6gufy9
         c+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f7GCjrAcSAsu/ypl12a5quBo43EP7p9sXAwHZPyD/2Q=;
        b=V1usoihGqUEgvVc7bzMbYqD8HCkM46Q4V7wqYbA3HO3+bTtgLm7SZwYtHgN5dlaMIm
         Qv9WipAEmvEaUoo/gR9H2fhjDXc6oNFzczSmiDQZlv1PLxCgG+kiqiJbwk4Ot6zc7lif
         zuEQV0iWwcluTiZ65u6KDT7czOa2c2t8fGXdgHzf9jimy896Ns2HE22MIovxGwtSuako
         HNLSX80AtFM8VZJNP3a19PBy+IvPNzTs1bjIV8c834cL/pV0s2ZTyP3QvgcMZDs8Fpa7
         IUef7xMFpJK/ajWqS79AlcMwtWbs5d/zZ18P4dQEmpG/skCaoYBbSeg9/ejxkhQW5eNT
         N8Aw==
X-Gm-Message-State: AJIora/0G1CVEUh+SFt/Y3DGISkXOq3Kw0xdVrtOw4lSJ2tepVlEZxC+
        0HtChCDTNsFjSH8pPNrolTtmVA5TWwvlrGyWdKxvA37uSP0=
X-Google-Smtp-Source: AGRyM1ushTHHDnbOyETy7v5TIxf3atKX2K0aICP360J987HLiubpw+ZakNUYKuX7Tcft3kAjzHu7NS/h53ElxKsDp9U=
X-Received: by 2002:a05:6902:114d:b0:66d:9fa6:4bd4 with SMTP id
 p13-20020a056902114d00b0066d9fa64bd4mr24525224ybu.362.1656944560333; Mon, 04
 Jul 2022 07:22:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:f944:0:0:0:0:0 with HTTP; Mon, 4 Jul 2022 07:22:39 -0700 (PDT)
In-Reply-To: <20220704142034.1511271-1-martin.fernandez@eclypsium.com>
References: <20220704142034.1511271-1-martin.fernandez@eclypsium.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 4 Jul 2022 11:22:39 -0300
Message-ID: <CAKgze5b6hvxRm0Yrj19yyBwAns-CdDs7furJuevu3-3Wsf99MA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22, Martin Fernandez <martin.fernandez@eclypsium.com> wrote:
> Right now the only way to check this is by greping the kernel logs,
> which is inconvinient. This is currently checked for fwupd for
> example.
>
> I understand that cpuinfo is supposed to report every feature in the
> cpu but since AMD is doing the same for sme/sev I think is good to
> have this for Intel too.
>
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fd5dead8371c..7311172aceaf 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
>
>  	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> !TME_ACTIVATE_ENABLED(tme_activate)) {
>  		pr_info_once("x86/tme: not enabled by BIOS\n");
> +		if (mktme_status == MKTME_UNINITIALIZED)
> +			clear_cpu_cap(c, X86_FEATURE_TME);
>  		mktme_status = MKTME_DISABLED;
>  		return;
>  	}
> --
> 2.30.2
>
>

I'm sorry, disregard this patch. I wrongly sent an old one. My apologies.
