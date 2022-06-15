Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABE54C9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348796AbiFONdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351382AbiFONdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:33:49 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909836161;
        Wed, 15 Jun 2022 06:33:46 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id d23so8744487qke.0;
        Wed, 15 Jun 2022 06:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCKyWx8csaPOZiwVdiAanKrrMm8ghNkRwANxa87W2Oc=;
        b=RgI4zc8uCUPGknLSpTSdiSR06Hzkbu0MCwTEpmrs6F/gbBumih2SiMY3ZhTXU7iZ3c
         GXY99uWfLPAeuQSbL2yZJGDNUlRl1EKrainB0SUNCXKpSBcaRrtnGOHSB8Mvic5Pr0Tj
         4Es+lmAFqjlkofumRmzEuWUnOyNotWQ8gfGWyw25eJJru1RoiL1elolIEboZBMrYEYIc
         ckW3SfXU2kODVwp2hkQiJZyKTFaDVjutyRf3wwUkX3CO3/ei51dc+5v0RoQ+cd9nx1Eb
         J6E2rFR+0O53qrr6PJHV+LGxWw2HBL28Q6DGDcFInakbn5azbVPqhT25EdkQbMxwpVdc
         IEqg==
X-Gm-Message-State: AJIora8mfaffOCCQjy95zXxur34l6VYe+I8IY9v/Zv0gckhvZ8Sk+3+/
        X7pK2bG4GrugbHeLxZfh1slQN2vxXSVZYg==
X-Google-Smtp-Source: AGRyM1vJVuYn/eVytR7ZATOFYPWj890NIqQneR/fTIlXZmtI60URaNKg3VAhAuoc3XAwdzFSpbfJdw==
X-Received: by 2002:a05:620a:15ed:b0:6a9:78fa:cca6 with SMTP id p13-20020a05620a15ed00b006a978facca6mr3637090qkm.129.1655300025538;
        Wed, 15 Jun 2022 06:33:45 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a440c00b0069fc13ce23dsm12901998qkp.110.2022.06.15.06.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:33:45 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id t1so20567365ybd.2;
        Wed, 15 Jun 2022 06:33:45 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr9852542ybg.365.1655300024964; Wed, 15
 Jun 2022 06:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
 <YqZDAiB/taLwmamr@shikoro> <CAMuHMdWO0zgmRKMpcSXSdshj6Fh8uu3Ch_FCVDEocdaVPaAUUQ@mail.gmail.com>
 <YqcCdipmKU90Kq1c@shikoro>
In-Reply-To: <YqcCdipmKU90Kq1c@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 15:33:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiQ3yLX+o+DXysqy=P8=QHBRrfnGzgCTsJ5DdHPWshWg@mail.gmail.com>
Message-ID: <CAMuHMdWiQ3yLX+o+DXysqy=P8=QHBRrfnGzgCTsJ5DdHPWshWg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a779f0: Add thermal support
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Hi Wolfram,

On Mon, Jun 13, 2022 at 11:25 AM Wolfram Sang <wsa@kernel.org> wrote:
> > No need to resend, I can fix that while applying.
>
> Thanks!
>
> > Unless you want to make other changes, which I believe is not the case,
> > as only the DT bindings patch needed a new version?
>
> Nope, no changes needed.

Actually other changes are needed, as "make dtbs_check" complains,
rightfully:

    arm64/boot/dts/renesas/r8a779f0-spider.dtb: thermal-zones:
'sensor-thermal1', 'sensor-thermal2', 'sensor-thermal3' do not match
any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$',
'pinctrl-[0-9]+'
            From schema:
Documentation/devicetree/bindings/thermal/thermal-zones.yaml

As I have already queued this patch, I will amend the commit, by
changing the node names to sensor[123]-thermal.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
