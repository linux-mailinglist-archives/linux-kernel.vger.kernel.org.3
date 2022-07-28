Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57146584898
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiG1XPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiG1XPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:15:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF767393A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:15:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so5606911eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EMgR3r/5USP32zGR0vJlVbcUsNeEC3RV1rZfC68/TZ4=;
        b=DFmAxk+++JyHq3e6SsxFu2Lej6OEn+mKsyCIELvgqpY6A6MW0gKmnVGyFlju8Cyrl+
         atep2zO0iCCeUo75O3924iv/YN5TyG0aeEqRLknHNgFtg+9u8hQGoqwYPH6oJps5xCCX
         qTQVZbCWgsROJPygaqSZTDwBZ8XyOzeRPsInQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EMgR3r/5USP32zGR0vJlVbcUsNeEC3RV1rZfC68/TZ4=;
        b=ahYPBiYPzHQ70voDEhVAd3n64F15VJqZmoBQqatQB/dASbTv0159+vCtaRyoZAWoAn
         UZi3/ZRl2b/bxeum2KFpWwJD28x1lmFKM+W3GIIkt5A6f4NmoDgEomOYLKwciGelNEMX
         vF4KF6EXdxgALQiyR4dmMkYp4Nkgx6Z4oxDzYvwjgcNwKUj5GNrphBPy38ZLEzf7DkOF
         sKW2BHSBXrWx9wS3XfUCau/3Y4a29WHHpW/6On0QlIDgdi6hZMEVJlxCJqeX/4oEY1XJ
         qkhp4p38L4kFO6so93wF9bHsvGAUmpA2k5q1jf2p/mlioted7dVMnDKr6Grqolg3d7qF
         ZYVg==
X-Gm-Message-State: AJIora9Rtjgt5QkCeok8asLLmSsaK4Y6kYpflPJZcJflhzRQ2LYxoIog
        KD7kcj8mhjrEM1QM2HDWIjWjsucKn1YUsETg
X-Google-Smtp-Source: AGRyM1uOWHqRUJ3aia5+thXQL1yAgsD6KN/KsroZvC8i9qCBMC/PxUf3TvCz/sJ1pVMFi6dj14B5Yw==
X-Received: by 2002:a17:906:93ef:b0:72b:44e2:bdd8 with SMTP id yl15-20020a17090693ef00b0072b44e2bdd8mr845536ejb.192.1659050141693;
        Thu, 28 Jul 2022 16:15:41 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709064b0600b0072fa1571c9asm919731eju.104.2022.07.28.16.15.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 16:15:41 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso3315209wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:15:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr951437wmq.154.1659050140559; Thu, 28
 Jul 2022 16:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3GTzeJUdcjVv-1fL7h7e6XRFPA65-5xseQ4=tyZE8UDg@mail.gmail.com>
In-Reply-To: <CAK8P3a3GTzeJUdcjVv-1fL7h7e6XRFPA65-5xseQ4=tyZE8UDg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jul 2022 16:15:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdnnAmDopTKXbS5u3Ty8GgAfuFOSOycsCfe6pSAqunHg@mail.gmail.com>
Message-ID: <CAHk-=wgdnnAmDopTKXbS5u3Ty8GgAfuFOSOycsCfe6pSAqunHg@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] SoC branches for 5.20
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> This is another large merge window for us, with over 1000 patches from 177
> contributors. I'm sending these early since I'll be out of office for the next
> few days.

Hmm. I'm missing 2/6. I don't see it on lore either, so I don't think
the problem is on my end..

            Linus
