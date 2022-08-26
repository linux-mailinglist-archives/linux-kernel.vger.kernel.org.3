Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183415A237A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiHZIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiHZIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:46:35 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E57858A;
        Fri, 26 Aug 2022 01:46:34 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id d1so607369qvs.0;
        Fri, 26 Aug 2022 01:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UwO7kSrSBJD9spTOoBkhHHMZKoBHoCSJjB8g/b48pqI=;
        b=EmyC+JhUMKxbiHT1a+mcjmlgGe6q7PenTA4RV6cEo0Idyyeq+dXwMA85BY2ZtQV7eo
         jzP3hLfLZzDh8oxmj80nJUPaHozw0zLICjV/sYBaI2M7Hx2gYxhZWBUBWzApm54oEPYH
         V9MxuwruWx0vK8jAjdbnh8EXrZBoJVZPZGATx1t5yWar3iQVodOVtnFqGY1zuYvKzYWE
         KFDU7T58wjb7prosZNUfU6mCLAswzMX43HwLn2xCFvCeiiTEaXL2zlG/zZR0umD5ytAC
         pVHxwqI7Ti8eVbId6oEnd8hhOySkbEnboFF06avp1Z1SRmJDq6A0Muowgdgq6KPzf8IF
         EFHg==
X-Gm-Message-State: ACgBeo3FaIPTBjqxBkNOMsgjllYTm+KKwIAk+gP86Fu5wTLBNX2LI6oq
        txSOa8aUdLQSb9rO4P+gSJAhvldq4V1FTg==
X-Google-Smtp-Source: AA6agR6Gq1Ye7iB3Y5Qi9Ej2BjNK+GFbn5N7wfc0knDiSh3iz1O6+aXE/JUYClR1PPi3ENPsyhCIeA==
X-Received: by 2002:a05:6214:1c47:b0:474:8d1e:f432 with SMTP id if7-20020a0562141c4700b004748d1ef432mr7045622qvb.94.1661503593433;
        Fri, 26 Aug 2022 01:46:33 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id ey12-20020a05622a4c0c00b0034359fc348fsm881347qtb.73.2022.08.26.01.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:46:33 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-33dce2d4bc8so19602207b3.4;
        Fri, 26 Aug 2022 01:46:32 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr4237698ybl.604.1661503592723; Fri, 26
 Aug 2022 01:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com> <20220824094327.33685-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220824094327.33685-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Aug 2022 10:46:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWohq1NKiDZivYuFbGNn-bro7niO4QzKin8rXxmeueAnQ@mail.gmail.com>
Message-ID: <CAMuHMdWohq1NKiDZivYuFbGNn-bro7niO4QzKin8rXxmeueAnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
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
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family. Hence move its compatible value to the R-Car Gen4 section.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
