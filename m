Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52614FDE05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiDLLTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354351AbiDLLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:18:57 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4515FC6;
        Tue, 12 Apr 2022 03:04:19 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id d71so5149367qkg.12;
        Tue, 12 Apr 2022 03:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkkpP++oa/oLxNyX5NfWKhI/0x3q2YFDCI0qRMj71FY=;
        b=QobhyaSYu8asIPsXGQfqnBtxZDJTNUM14VuQe56uC9bC9akvysSk+AGAV9YFr1P2Sl
         CMi7WuTKe/tXcV0OuNDZbtM9UZpPo92lKGYMioVtP3Pa2+F5GBi2uRtadfiJR19uKRNQ
         4awt9QAr/YYLRxt4ypMr7p7yHfSt6tQDmKhQwj7N8YWd7VnpbpfxERnD1pxHl1q2xpJQ
         LbCwxc3YcgEgi9S1nK2VnL7E23jY0JVv2d25EhhOLnlwVfLaLGQeef1DcHLZ6uVniXJh
         fx99pi/0qC/wF//eTLG/660aPA8GrW40cJjq30IG+L81JlLV58awJm6QtqmFdmjzCeCt
         4AAA==
X-Gm-Message-State: AOAM533jwyEv+otVrOdynIRBAFYjlghuVTjWvSF7av7/SAFbqQ9eWSw1
        9JpsYeJetpCdcySQTrgzCLA+P2SJVr0TpQ==
X-Google-Smtp-Source: ABdhPJxakEtECcG/hYmXx8kxQF1oL/PFdfus54OlZAW5ND0QImFXK7kFFtLlBVqzVeJo5hH8hzpVFw==
X-Received: by 2002:a05:620a:998:b0:69c:1bb0:68c7 with SMTP id x24-20020a05620a099800b0069c1bb068c7mr2419641qkx.279.1649757858467;
        Tue, 12 Apr 2022 03:04:18 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm5641398qkj.17.2022.04.12.03.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 03:04:18 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id f38so32206064ybi.3;
        Tue, 12 Apr 2022 03:04:17 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr15315650ybq.393.1649757857406; Tue, 12
 Apr 2022 03:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <19358863deae03b1b26f473e878305a1c6e40d19.1649681638.git.geert+renesas@glider.be>
 <YlVJc3z1xXT2emIc@ninjato> <CAMuHMdUGkba3hiRJPEw26oBdc6_MK_eBO==Z9QeinaoeZv8Qbw@mail.gmail.com>
 <YlVLEnRaARVmWZnZ@ninjato>
In-Reply-To: <YlVLEnRaARVmWZnZ@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 12:04:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAQ08K6NCdBGrY+-vBrsTQHi6UHaER4eCON1t9JEG1RA@mail.gmail.com>
Message-ID: <CAMuHMdWAQ08K6NCdBGrY+-vBrsTQHi6UHaER4eCON1t9JEG1RA@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Simplify single/double data
 register access
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
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

Hi Wolfram,

On Tue, Apr 12, 2022 at 11:49 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > > +                     regmap_write(rpc->regmap, RPCIF_SMWDR0, *p++);
> > >
> > > Last '++' can be omitted?
> >
> > I know. But I think it looks nicer this way ;-)
>
> I have to admit it looks a little like "I copy&pasted without thinking"
> to me :)

But that's not what happened. I even compared the assembler output of
various solutions.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
