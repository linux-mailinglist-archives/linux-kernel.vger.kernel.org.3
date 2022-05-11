Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFA52410E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349358AbiEKXbF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 May 2022 19:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349375AbiEKXa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:30:57 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378553B6C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:30:56 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id r11so6794624ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82LtQvcmXEI9bSU6aE32LRoQ75jfHNnbnp/OWfCob4A=;
        b=YDCV1QwPJPyOEXnVtu/CSOdG8Qn+mkuMlL/tLoRBGDzzFF57u9kKUblnWdJJ2uTQ6n
         16j+0bBRNywmjzrUjVruzrHOAad7b9SzRcEV8ojtCTPO77c688ZtK3du3Q75oNvrQrL0
         djRawYJnMHu1QJvUnxR+RGfpEs4tA8v8sSFH96v/FrpfvyuAoyB0wSJ4O3ClijxPqTsf
         oUBA939G63Z8gmJTfucU/TUPzhrP4UP6JMAqGauqI+aTvMJ/Vk085yLKLX7PevBR9wuO
         LXLBveZifbo3J+wyXkrHRbIEfFkABNnMMCFp2+yMNCP+3LVP1UOVHsaQTG2BtHgnnMbi
         8Y9g==
X-Gm-Message-State: AOAM531tbK9n5GLOriedmkAhe/7AR33utmyviuaMmBxZDXkWtwN7ANgz
        DQogKQJvuMtnW5iKP9RbBtHasdLY6p4IrKNDIW0=
X-Google-Smtp-Source: ABdhPJy6L7LndQLIhm/RpB8v7sd4uAh7ABfVk1w7xt0uCtyO2bIyQJnNwA8Gu9veZKKBbC2qShJmh6PD9uKoehe0cTU=
X-Received: by 2002:a5b:491:0:b0:64a:f42f:6973 with SMTP id
 n17-20020a5b0491000000b0064af42f6973mr12909923ybp.20.1652311856106; Wed, 11
 May 2022 16:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220511160319.1045812-2-mailhol.vincent@wanadoo.fr> <324f245e-15e2-a1f2-bc8a-46255a1a859f@wanadoo.fr>
In-Reply-To: <324f245e-15e2-a1f2-bc8a-46255a1a859f@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 12 May 2022 08:30:45 +0900
Message-ID: <CAMZ6Rq+d_eKXQQZ1p-yUpqC-SOjpa83o_QpZci-GN9qd9UKa5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate
 constant expressions
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 12 May 2022 at 05:56, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 11/05/2022 à 18:03, Vincent Mailhol a écrit :
> > For x86_64, the current ffs() implementation does not produce
> > optimized code when called with a constant expression. On the
> > contrary, the __builtin_ffs() function of both GCC and clang is able
> > to simplify the expression into a single instruction.
> >
>
> [...]
>
> >
> > ** Statistics **
> >
> > On a allyesconfig, before applying this patch...:
> >
> > | $ objdump -d vmlinux.o | grep bsf | wc -l
> > | 3607
> >
> > ...and after:
> >
> > | $ objdump -d vmlinux.o | grep bsf | wc -l
> > | 792
> >
> > So, roughly 26.7% of the call to ffs() were using constant expression
> > and were optimized out.
> >
> >
> nitpicking: numbers look odd.

And they are. Thanks for spotting the issue.

>     3607 is the exact same number as in patch 2/2. (ok, could be)
>     26.7% is surprising with these numbers. (I guess it is (total_before
> - remaining) / total_before x 100 = (3607-792)/36.07 = 78.0%)

The 3607 is incorrect (copy/paste issue, sorry). The correct figure is
1081. And:

(1081-792)/1081 = 26.7%

Will amend the comment and send v3 right away.

> (but patch looks great to me :)

Thanks! :)

> CJ
