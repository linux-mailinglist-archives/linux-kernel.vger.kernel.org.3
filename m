Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF75A2376
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiHZIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245239AbiHZIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:46:10 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA176B8DF;
        Fri, 26 Aug 2022 01:46:07 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id a4so744399qto.10;
        Fri, 26 Aug 2022 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o4DTZaQCZNcA9UZkl0hcqgSEdHaR0mKbqsnuvAS05gY=;
        b=KYgLDC5P9mnqOTYDtW65F+MDfufdSGBBqIu7k+JsgchzSrVg9ycQeJo5iIpuQT4bX7
         sysfnQzu0KQj2z5ppPIGOCtyCU8ZrJGZDyyouXtosgJAiMWvTYu+J2IsJR0+AmcRGrde
         WrcaGaGcXLs1zyTYrQi47SlTv2Hravwd/BQMSbujK8eOd/3JUbHFOKTdZgvLiOsm+/ys
         F0Ipewmbpvt5AkyPo7D0l78D5ld0JqPZdssvxAo8EaOGneHY6/IlJBVg1RAbHBZainCg
         Zm1zmIvkOkW6ZBzrLnSCs6u/8xIi3IfI7y6u6MkywDGC3+9J6KReCvB1enOyXSDjikBw
         eB4A==
X-Gm-Message-State: ACgBeo1b5M8dOSBcqrxmbzd4bEmolQWTzzj9Pteal6R/Xq5OlMX4jRM9
        N0krHT84KFcZXwD1c0XgB9dxOgrqlBeXYA==
X-Google-Smtp-Source: AA6agR40bS0kXHJfn911mfRKa6f2abzY8auQX/4lrw5rlIufgqs0eUGUch7PIGqal+D0KGpyEIVOBA==
X-Received: by 2002:ac8:584b:0:b0:343:6f4a:d04e with SMTP id h11-20020ac8584b000000b003436f4ad04emr6912128qth.425.1661503566731;
        Fri, 26 Aug 2022 01:46:06 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id hh11-20020a05622a618b00b0033aac3da27dsm899247qtb.19.2022.08.26.01.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:46:06 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-33dc31f25f9so19147207b3.11;
        Fri, 26 Aug 2022 01:46:06 -0700 (PDT)
X-Received: by 2002:a25:d80b:0:b0:696:6d79:4891 with SMTP id
 p11-20020a25d80b000000b006966d794891mr1516074ybg.89.1661503566221; Fri, 26
 Aug 2022 01:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com> <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Aug 2022 10:45:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXSniVs_LmdDpwqjR2i1KERS6T0pUAyBrQZoBUXkLtYw@mail.gmail.com>
Message-ID: <CAMuHMdUXSniVs_LmdDpwqjR2i1KERS6T0pUAyBrQZoBUXkLtYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 11:43 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
