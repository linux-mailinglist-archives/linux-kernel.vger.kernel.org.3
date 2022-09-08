Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170255B1557
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIHHHP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Sep 2022 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:07:13 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C709E882;
        Thu,  8 Sep 2022 00:07:12 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id r6so12193638qtx.6;
        Thu, 08 Sep 2022 00:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fqGh8aE73orRi3PD0A1JVDOgqPEzP/eUkgDD6hWkr2g=;
        b=VSZOsVpivw8+nQuMO/UxMj4+Vlj9ES4HuCy9pfDow11FNQL8NgYQW04esaPNMlv7yM
         VpAYU24b/9tTisy8oMDiKrAlrERUFwRFPZvZ010ra4Kh8zt67gyi/h7h407rBI7s5NjE
         bhw2rJcJKMol3hUKTdBEwc09g4ozO5+DhbyvNP3M5QB+XLpyGH7Sot20DPHZ2pYD9EDy
         sapdCGH2SEd9xOhaBE8Z5ETRH7lCGGXUj0oMHvrlIy1TjMrDt4lrv7wwRspwEPmgZxFc
         mJRXPIl1jROpOtSCHV9V0DUsEIjZUYNK+dxvjCOps2RwhHFNPGqDgJqzzdLGc0BPEbs7
         cCNA==
X-Gm-Message-State: ACgBeo3PUVipmB3N8IVeXZfZeG/n4OCPqjixBCHs91kCJlgnCyJ5BXS7
        qQLRL2pHqMXbNP5sMmu7uFmXHOS9i6sKYQ==
X-Google-Smtp-Source: AA6agR6HImK3KcfftDuVoX1jojYZsDyXrzf6pjBcKuNV228qMn3SXpHlHH3c3B/yBis00UvlW7AkHw==
X-Received: by 2002:a05:622a:101:b0:344:80f8:ffd5 with SMTP id u1-20020a05622a010100b0034480f8ffd5mr6585026qtw.648.1662620831321;
        Thu, 08 Sep 2022 00:07:11 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a445600b006bb83c2be40sm15971178qkp.59.2022.09.08.00.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:07:11 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso153897197b3.5;
        Thu, 08 Sep 2022 00:07:11 -0700 (PDT)
X-Received: by 2002:a25:8247:0:b0:6a9:443a:cc0b with SMTP id
 d7-20020a258247000000b006a9443acc0bmr6067365ybn.89.1662620461133; Thu, 08 Sep
 2022 00:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
 <7423117.EvYhyI6sBW@kista> <84f28dc3-3b65-ea70-4fa4-765d0c773c28@microchip.com>
In-Reply-To: <84f28dc3-3b65-ea70-4fa4-765d0c773c28@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Sep 2022 09:00:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVcoHqPa5AqoPqvw=ZuHdqG7p5HWOHUx9ecNZvzUG4Xw@mail.gmail.com>
Message-ID: <CAMuHMdWVcoHqPa5AqoPqvw=ZuHdqG7p5HWOHUx9ecNZvzUG4Xw@mail.gmail.com>
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
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

Hi Conor,

CC soc people

On Wed, Sep 7, 2022 at 10:43 PM <Conor.Dooley@microchip.com> wrote:
> On 06/09/2022 21:29, Jernej Škrabec wrote:
> > Dne četrtek, 01. september 2022 ob 20:10:13 CEST je Palmer Dabbelt napisal(a):
> >> On Sun, 14 Aug 2022 22:08:03 PDT (-0700), samuel@sholland.org wrote:
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts create
> >>>  mode 100644
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-common-regulators.dtsi create
> >>>  mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
> >>>  create mode 100644
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts create
> >>>  mode 100644
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
> >>>  create mode 100644
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
> >>>  create mode 100644
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi create
> >>>  mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
> >>>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
> >>>  create mode 100644
> >>>  arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts create mode
> >>>  100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts create mode
> >>>  100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
> >>
> >> I'm assuming these are aimed at the RISC-V tree?  I'm generally OK with
> >> that, though the DT folks have pointed out a handful of issues that look
> >> pretty reasonable to me.
> >
> > DT changes for Allwinner ARM SoCs go trough sunxi tree. Should this be handled
> > differently for RISC-V?
>
> Microchip RISC-V DT go via a Microchip tree to Palmer. The other stuff gets
> picked directly by him as it has no clear "owner". I think it would be nice
> to be consistent for the new {renesas,sunxi} stuff and send those via vendor
> trees to Palmer too. Just my 2 cents...

Wasn't the intention behind the rename s/arm-soc/soc/ to start
accepting PRs for non-arm DT, too?
Especially if we start having dependencies due to riscv DTS files
including arm64 DTS snippets through scripts/dtc/include-prefixes/arm64/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
