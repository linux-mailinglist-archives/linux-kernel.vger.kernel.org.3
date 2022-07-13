Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69452573C92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiGMSdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiGMSdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:33:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F8D6168
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:33:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id os14so21384644ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KifgCMjgebK/NLp6nn+G8EJhgQBv0NBPfKiflov1mlU=;
        b=WXkiCM2m7cWXxt53oQNuRjMlHN9tRHeiD9hdMvRX9/jmGDWKVCpWfb/ymYf0GUrQkn
         2gcUvM0fppN4jvlrJBHSQ6kMpDV+0P4G+reqg6RPyFytwCdFGVuiwifzJXcN+e0T0eK3
         apqVZARbdC+XmrVpwiiRoZeHilhOPB7mXQ0Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KifgCMjgebK/NLp6nn+G8EJhgQBv0NBPfKiflov1mlU=;
        b=acGkdHiwLHt3UrTnjQyXLx+pp7VkmiTsxMFqC3WYkypjx+TWGF1tjquBMC5aBy11g1
         86nb+toxha3A0br5F9rzRPgvFlP7bzZokeg6Z0IakEL8kFrTJS4kcIkm0NjhPFbfMgjx
         XdnfHQo3saSuwGe/Tfbt2Xw1i5xqeb3vgmWcSZNohezwT/W9/dto6t2VELMSWHd7Nhx/
         qKYR+O3ws6b7O4yLvBbtCb+Z0G8VlYLC6jnrEqtkJMJ/DGvis20sgyhj4K4oWPtu3SW/
         xBzxpzSaziFp2qZhORFQgvAHwluCzXuNOXmoIQTc8/pGsgzhwmcsQRntViFId16XxjKt
         H/8Q==
X-Gm-Message-State: AJIora9vcvKKt/F0bhdLpXVLwp/rnbF2e+k28iF0y2TrYoihUUI1BEoG
        W4s9o2QWti4qaUGH7YpqSkQrG954Lnr5tr0ju7M=
X-Google-Smtp-Source: AGRyM1vsWwqX1dkD6rz1GFKXhL0hd/59FbSlczaWG1evRkcczUYvH2wIFoEKCCKX6UpVJi2vrwQzfg==
X-Received: by 2002:a17:906:5a68:b0:72b:3e88:fec1 with SMTP id my40-20020a1709065a6800b0072b3e88fec1mr4782411ejc.741.1657737220201;
        Wed, 13 Jul 2022 11:33:40 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906c41600b0072321c99b78sm5223845ejz.57.2022.07.13.11.33.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:33:39 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id b26so16697118wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:33:39 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr4440805wrv.281.1657737218805; Wed, 13
 Jul 2022 11:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220712183238.844813653@linuxfoundation.org> <CA+G9fYtntg7=zWSs-dm+n_AUr_u0eBOU0zrwWqMeXZ+SF6_bLw@mail.gmail.com>
 <eb63e4ce-843f-c840-060e-6e15defd3c4d@roeck-us.net>
In-Reply-To: <eb63e4ce-843f-c840-060e-6e15defd3c4d@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 11:33:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
Message-ID: <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.55-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 6:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Looking into the log, I don't think that message is related to the crash.
>
> ...
> [  105.653777] Modules linked in: x86_pkg_temp_thermal
> [  105.902123] ---[ end trace cec99cae36bcbfd7 ]---
> [  105.902124] RIP: 0010:xaddw_ax_dx+0x9/0x10    <--- crash
> [  105.902126] Code: 00 0f bb d0 c3 cc cc cc cc 48 0f bb d0 c3 cc cc

Yeah, the code you snipped, shows

  20: 66 0f c1 d0          xadd   %dx,%ax
  24: c3                    ret
  25: cc                    int3
  26: cc                    int3
  27: cc                    int3
  28: cc                    int3
  29:* 0f 1f 80 00 00 00 00 nopl   0x0(%rax) <-- trapping instruction
  30: 0f c1 d0              xadd   %edx,%eax
  33: c3                    ret
  34: cc                    int3
  35: cc                    int3
  36: cc                    int3
  37: cc                    int3
  38: 48 0f c1 d0          xadd   %rdx,%rax
  3c: c3                    ret
  3d: cc                    int3

and that's a bit odd.

It says "xaddw_ax_dx+0x9/0x10", but I think somebody jumped to
"xaddw_ax_dx+8", hit the 'int3', and the RIP points to the next
instruction (because that's how int3 works).

And the fastop code says:

 * fastop functions have a special calling convention:
...
 * Moreover, they are all exactly FASTOP_SIZE bytes long,

but that is clearly *NOT* the case for xaddw_ax_dx, because it's 16
bytes in size, and the other ones are 8 bytes. That's where the "nopl"
comes from: it's the alignment instruction to the next fastop
function.

Compare that to the word-sized 'xaddl' case rigth afterwards: that one
*is* just 8 bytes in size, so the 64-byte 'xaddq' comes 8 bytes aftrer
it, and there's no 7-byte padding nop-instruction.

So I think that that is where the "xaddw_ax_dx+8" comes from: some
code assumes that FASTOP_SIZE is 8, but that xaddw_ax_dx case was
actually 9 bytes and thus got that "int3 + padding" in the next 8
bytes.

The whole kvm x86 emulation thiing is quite complicated and has lots
of instruction size #defines and magic.

I'm not familiar enough with it to go "Ahh, it's obviously XYZ", but
I'm sure PeterZ and Borislav know exactly what's going on.

                 Linus
