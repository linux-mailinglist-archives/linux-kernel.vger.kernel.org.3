Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3A567911
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiGEVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGEVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:01:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C14BFB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:01:48 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6072742431
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657054906;
        bh=BZ3TTPllU2RNx61rLK2KPq+axv5Y7LrzDROkWqt5HLQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Rls6SjXdQkGc4rLaj7PNxtQH8mOHip+hf3+lfmAtQUkwqXeaJgAz9DUrXmJ+JusTq
         lVwrxCQ3Js6RxBiBAV3rH2d/hX19Z/L0jZdno/fxvFHjyZXJrE8FH9yTgnRXRO1p9D
         NxxOUl8invvi/TZFvuhjPE7+0xTxheN01A8JMomX+iufUtLoUVSCrAdnDFps7f+lMy
         UcLUl1M01KNyuJNF390wnvh56XM71N96cLU0/P8YVHAd+JfSEFY89YawR58rQaX+D4
         pm1IISnVFxN4FNYQ9ocn+aufJyJJn7mcf6RNsiKRRIyGWcjHhbVYMmUvRgv5pAfnQ/
         hZaGHcP2oEKmA==
Received: by mail-wm1-f69.google.com with SMTP id j35-20020a05600c1c2300b003a167dfa0ecso7283921wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZ3TTPllU2RNx61rLK2KPq+axv5Y7LrzDROkWqt5HLQ=;
        b=eZvxIuHA1hb3+YXo0P/VdiLDH0pWkcbdaWHu+ad6F+vI1RLQR6rUOW2Phdl7wtpspe
         eOmNQZ2BXV6wSVnUFDRYb/yGoepctXxc5pk1vnE/91Ix8yMT8nwEPzP6wg7yixhYLhgr
         o0kdbPopBeC1129jGkPSH+6N/pofSogrL30oSvCvpCqClSo6MYFmxvZ3kKchiFh9r9iL
         shsiWtPjF5ayjyokmYqPXagG3wdPEVtuCdRQZjuomqDEu1WA3gUhOCyGtHdvDmRXLhF7
         ILWvgjRA/HPWFPWWGzCOmm/GK9F28I5krOCGJZK+LHqc2ateAHQKdhD6mWJBnnb6wYYQ
         Xpvw==
X-Gm-Message-State: AJIora8RIxCy9rEZe1kKlE6QSOcO/hLSILuupVmbFyqaFEIN+5+O7spf
        mWjnGBDblUzZQ+jxNV7s04NC4gm1VhbDS+ca958XwoQWlYp/2YNx4eZt66nTlZovtkrTL3RmaFW
        1UvyqLdlkn8uDh44tlGYF6Uvm8qezZNkCBz0xORa3DQ==
X-Received: by 2002:adf:d1e9:0:b0:21d:2154:2bc7 with SMTP id g9-20020adfd1e9000000b0021d21542bc7mr32198649wrd.105.1657054905430;
        Tue, 05 Jul 2022 14:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJ6GR25rmzYj+5MOIYxx8GnVDHsnsL8L8SKcrRNOoJrGmGln63zLuDAwKc99O7ChnLFoDsbg==
X-Received: by 2002:adf:d1e9:0:b0:21d:2154:2bc7 with SMTP id g9-20020adfd1e9000000b0021d21542bc7mr32198623wrd.105.1657054905236;
        Tue, 05 Jul 2022 14:01:45 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm2517667wru.28.2022.07.05.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:01:44 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/4] Add HiFive Unmatched LEDs
Date:   Tue,  5 Jul 2022 23:01:39 +0200
Message-Id: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the two LEDs on the HiFive Unmatched
RISC-V board.

Emil Renner Berthing (4):
  leds: pwm-multicolor: Don't show -EPROBE_DEFER as errors
  dt-bindings: leds: pwm-multicolor: Add active-low property
  leds: pwm-multicolor: Support active-low LEDs
  riscv: dts: sifive unmatched: Add PWM controlled LEDs

 .../bindings/leds/leds-pwm-multicolor.yaml    |  4 ++
 .../boot/dts/sifive/hifive-unmatched-a00.dts  | 42 +++++++++++++++++++
 drivers/leds/rgb/leds-pwm-multicolor.c        |  8 +++-
 3 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.37.0

