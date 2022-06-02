Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EED53C0CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiFBW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiFBW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:27:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1A33365
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:27:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so12594979ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lkEm3X5HzLB+VEej4UrcRIdtwa8kr6O7GlkHLzBLBw=;
        b=gFZIssbt+h/sxsyvNCH7artU5gehoIt/kKoK/9oNcChP/4Sv5nBc/4jjQorEbwGZxy
         78rVbf6zRNHC51dOFpIHY9049CgamsSMbEQYdKzOBB42x+hPXXhdPYjpW4dLfttqT1HH
         L9RZH0Ko5Onvj0xmEoOIQJl3MYHYCouYjpS9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lkEm3X5HzLB+VEej4UrcRIdtwa8kr6O7GlkHLzBLBw=;
        b=59V43XyMTIf1fjbi3dC2rXjR1zRtp3856FEjf+kLx/V/oerE6xaN96FPAnmcmBLeAa
         I4rxyZryI2auVbk6cp3rGTjxAQwyWLg6BgppldyEnFUtcL2AmeKD+zUeAp5nK7KkQDq3
         diEIqfdsGvHz0PFlTp8+MaTeffNp85taZ016i23phyorgutaLR1KR+aipTdc11Iqormp
         jor1gsppvMVsAqzVskybv6S9Oib18emsMzQdtTay9gNM70UyA8X+0F87+YaiaL0VVdOX
         01gPYMFtqW/VwpJ0hfLlxlISo4+NVoMYOJwMsjM1k5lAtmdEUKv0l7f+6eSY0C1pyVcB
         i1dQ==
X-Gm-Message-State: AOAM533FGPfojdb8+d8zwLJiXMlfYfTdwL4gOHCdnUsDygPwbW8f0nQh
        ze2IaC1doD3olRpUvARMqqM9Y6HKUijr6VPMfyo=
X-Google-Smtp-Source: ABdhPJxsHYTr5G3MIzY2HvegMuHcH7ZYosw2vOwq6oS10ZsZAw4ZrbE/ZNWnNvS3h/0bOArckluVjQ==
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id hr1-20020a1709073f8100b006ff1a3d9092mr6174398ejc.319.1654208868426;
        Thu, 02 Jun 2022 15:27:48 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id cz20-20020a0564021cb400b0042dd85bd23bsm3008350edb.55.2022.06.02.15.27.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 15:27:47 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u8so3823464wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:27:46 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr24746wrq.97.1654208866390; Thu, 02 Jun
 2022 15:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a13uAiBJkqD9UMmnfFn3AAY2ZqQisVQdovRy5dKiyJaXQ@mail.gmail.com>
In-Reply-To: <CAK8P3a13uAiBJkqD9UMmnfFn3AAY2ZqQisVQdovRy5dKiyJaXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jun 2022 15:27:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJ1dUVVMkHOk88xsYJtqfyGZ_8hSGJoZG5K+uwUYT3A@mail.gmail.com>
Message-ID: <CAHk-=wjhJ1dUVVMkHOk88xsYJtqfyGZ_8hSGJoZG5K+uwUYT3A@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] ARM: multiplatform changes, part 2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>
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

On Thu, Jun 2, 2022 at 2:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> The second part of the multiplatform changes now converts the
> Intel/Marvell PXA platform along with the rest.

I _think_ the conflicts were all trivial, but hey, since I can't
really even build-test them, please do check the result out...

                   Linus
