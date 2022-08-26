Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF75A2B72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHZPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiHZPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:40:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36182D13;
        Fri, 26 Aug 2022 08:40:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p18so1879673plr.8;
        Fri, 26 Aug 2022 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kXi+O9SmfFr0wIAIHbndQDWXvpUKE/sOBy8ucqGXfPc=;
        b=pyDV3cAtKC80txGNdOfJbP7FVtPZ2ZgOFddH0NxUOhnaTgWc4Y+J6MG6nAHNRINTsk
         T5yBh70292xQ3SepCwlb/nrW0eYmm6tVuj9HbEw4QlPaHlcTtOZWyl2gvCxAo7bB1ZqF
         GyjtEvBvh0HOKx6G+wPqbhXgjSS1DzJEmkhsJe0qgZ2jHB7PwpPMM4Vbllk5Ytw9zT6L
         s7QmY+RRH3L6BB+UygiQuDXG0ATubYU+5gavpg79AfcMQVx6yjKV2Zsqlc9BnbIck7+I
         p4qi6wZshtaC6Tc5ajVC1slMdt9VsNQrWUZHXvR0c55+/JZaSjpcwLUVVF9811v39PvF
         buXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kXi+O9SmfFr0wIAIHbndQDWXvpUKE/sOBy8ucqGXfPc=;
        b=Js1kJt7nJwdJCz2fwVxTb0SidoDIdAqB9P88PB1rlx+OgiItYqpu0js3cCNisuEeHL
         vg/zKz5dREK2rzglF6wSgYuAbqoRg/+0xTYg9Cddm29IZv1bAK+4AdltaWBZ+RDYiRnp
         79eD/X9EYl73dycdUgQ4vtbMZ2Urwx4u3DBE8+xLuwA2ijbvILj+QbJK1UFd/az0q1US
         FZlHsjRJP3v7iVFZeiRABuEah6GcoMVFbOVAA+ruJQXUdbSXe20decXxx27wyZr3T4x0
         QxFnjKebwhn+xtp9dMTHrd3GuJ3cWWW+NJNyBWtcKO+4OBqEk4C3bU2N63XxJ1ZPAHa6
         YEmg==
X-Gm-Message-State: ACgBeo3ZYFD5IO3ekP46bPv83/SbHW+1b3m2ZAdbTjG9rMzSqTKxsqE7
        UG9bck7zMY+bMjRdTk9Ss8iS4e8IbE8YT09fERxQ1bt9
X-Google-Smtp-Source: AA6agR5zLcR+E74lv5yh+qE3mtyPxGhDgAzKkfj/gyJLSA426fXXQn2u/1gzeBcflc0ufoofrwNh2crPRGOmXjYONjg=
X-Received: by 2002:a17:90b:4ad2:b0:1fa:f9d3:df64 with SMTP id
 mh18-20020a17090b4ad200b001faf9d3df64mr4892578pjb.19.1661528443970; Fri, 26
 Aug 2022 08:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <YwgCrqutxmX0W72r@gmail.com>
In-Reply-To: <YwgCrqutxmX0W72r@gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 26 Aug 2022 11:40:25 -0400
Message-ID: <CAH8yC8ktFYKy1qjz6Gi0NcWv1GZTi=mqP2hADFaAwbfivDpxzQ@mail.gmail.com>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Langley <agl@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 7:24 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi,
>
> Intel and ARM recently published documentation that says that no instructions
> are guaranteed to be constant-time with respect to their data operands, unless a
> "data independent timing" flag in the IA32_UARCH_MISC_CTL register (Intel) or
> DIT register (arm64) is set:
>
> * https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
> * https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/DIT--Data-Independent-Timing
>
> This is a major problem for crypto code, which needs to be constant-time,
> especially with respect to keys.  And since this is a CPU issue, it affects all
> code running on the CPU.  While neither company is treating this as a security
> disclosure, to me this looks exactly like a CPU vulnerability.
>
> For Intel, given that the mitigation is to set an MSR flag, it seems that the
> kernel will need to do that -- similar to the MSR flags that enable mitigations
> for speculative execution vulnerabilities.
>
> For arm64, it's not clear to me whether the DIT flag is privileged or not.  If
> privileged, I expect it would need to be set by the kernel just like the Intel
> flag.  If unprivileged, I expect there will still be work to do in the kernel,
> as the flag will need to be set when running any crypto code in the kernel.
>
> I'm wondering if people are aware of this issue, and whether anyone has any
> thoughts on whether/where the kernel should be setting these new CPU flags.
> There don't appear to have been any prior discussions about this.  (Thanks to
> Adam Langley, who maintains BoringSSL, for bringing this to my attention.)

The thought that comes to mind for me is, please make setting/clearing
the bit available in userland. Libraries like Botan, Crypto++ and
OpenSSL could benefit from it.

Jeff
