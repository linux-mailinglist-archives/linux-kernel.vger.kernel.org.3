Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1957C110
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiGTXpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGTXpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:45:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B397434F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:45:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f11so77938pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KU83ueWiecIonFgsOmua6688d0DkD2VFBOUlUHHUAy4=;
        b=crqyaOZ4h4DvzDOZlV8IFj5TO9FwtQgfTEFwl7cozQVhZWdxg5P1oS0n1BbIuVeFKp
         sbFQo7UrR1IARKp4/YvvT1zQw53mH8orfl2Ymz0+ZC6W5iUeJArzkbAUQqmoF/hKDrLJ
         I+y+qIEaE6fK8dVPnwEZRQ+mmk1Ns6FDHr444ik57iNKxOzMmC/H5AHvYJFYveyesD5U
         tY5Lfz5lm6GQsJ6XyfW8NPwrkb16SHYikabjdrJnYs+5peu3N+4Qwh8UimWvjFY0fc/k
         9f+ws98TNylPdg3Ci2/quhtHPmPQcZx0P4ZTki4g9R+HO07lEoUC5AaVMYi1YzPxEAZ+
         Zadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KU83ueWiecIonFgsOmua6688d0DkD2VFBOUlUHHUAy4=;
        b=wGAplHeY2ih077hX483YMOmp8Nd/9MSZ7DJkGOQhF3/FzxQtIc9xeOD5kS5jfOJQyI
         xAWHP4yGfyqSaloYSFU8Wfr9u3rkuRXbLEI1YNJ44RSlunyJYoQuCjY3M1VCo4miwLWJ
         l49QwjbGGryOQOzDvyCd7Qx7zEiPolqlkDUyiuVKJadBERIk/zZDYD8q07SDeFGeX5Jf
         PFVTHKyCemDjqymOJHMQsKENiXUDHy9Q3ACrH/Mug+NdGonefwK3Hlsh3nr3H7V5Wad5
         EkjIXPjp2K8yp2oYgLEIzmLWzfNfa/ULECoMAb6KiElPkMdpjMSxdzzGEa5nvlNUDySX
         RoLg==
X-Gm-Message-State: AJIora//jkvJG/rgrwY1tazvAGX7WS0ByrnjLKkn+7wIG0sjlEX9NPG+
        fZ1TFB868+Ss93KM4sNAS5PzI7pw3ThwmQ==
X-Google-Smtp-Source: AGRyM1vdQBK5v2aRMnAgAs2deluNWkY6gyBVKGcHEL3CX6GnUFo74D++CqaEmv7x7kTuGW4DwqbD/g==
X-Received: by 2002:a05:6a00:2407:b0:52b:29dd:915 with SMTP id z7-20020a056a00240700b0052b29dd0915mr34501978pfh.60.1658360701446;
        Wed, 20 Jul 2022 16:45:01 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b0016be96e07d1sm128016plh.121.2022.07.20.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:45:00 -0700 (PDT)
Date:   Wed, 20 Jul 2022 23:44:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 02/11] KVM: x86: emulator: introduce
 update_emulation_mode
Message-ID: <YtiTeZQ/n0LPTV/W@google.com>
References: <20220621150902.46126-1-mlevitsk@redhat.com>
 <20220621150902.46126-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621150902.46126-3-mlevitsk@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022, Maxim Levitsky wrote:
> +static inline int update_emulation_mode(struct x86_emulate_ctxt *ctxt)

Maybe emulator_recalc_and_set_mode()?  It took me a second to understand that
"update" also involves determining the "new" mode, e.g. I was trying to figure
out where @mode was :-)

> +{
> +	u64 efer;
> +	struct desc_struct cs;
> +	u16 selector;
> +	u32 base3;
> +
> +	ctxt->ops->get_msr(ctxt, MSR_EFER, &efer);
> +
> +	if (!ctxt->ops->get_cr(ctxt, 0) & X86_CR0_PE) {
> +		/* Real mode. cpu must not have long mode active */
> +		if (efer & EFER_LMA)
> +			return X86EMUL_UNHANDLEABLE;

If we hit this, is there any hope of X86EMUL_UNHANDLEABLE doing the right thing?
Ah, SMM and the ability to swizzle SMRAM state.  Bummer.  I was hoping we could
just bug the VM.

> +		ctxt->mode = X86EMUL_MODE_REAL;
> +		return X86EMUL_CONTINUE;
> +	}
