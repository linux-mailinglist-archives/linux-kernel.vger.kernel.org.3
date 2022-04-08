Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC54F9AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiDHQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiDHQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:36:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849724959;
        Fri,  8 Apr 2022 09:34:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so16107601lfb.0;
        Fri, 08 Apr 2022 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pz40nRgvhtcOeXUbzgyo9Hq14GrnezoaHqBr+KLvPIo=;
        b=NOIUQsr6XphXreR0Ws3aESzt6zh125cSmmUwY+ZOQLs8O6OUb4qHsG8YTp+btiQw3S
         v6ceYcQ66PpxMlfOA9B1O3YEAvx8LqrXvjN6NrTmrWZwhU/1a2ZrvKyW7SUbW0yDURXY
         HnF7XNSUNEoPdwlHmVcIvjfGHoiTLwUppVoAIF8JJ/m1m5OTGpCjJ2+vbmLVB4Oo7j0T
         CmqtGgqhDvLlsNNyJ2k1kc1CDRGTIG3z+BoLPnXJlrcyUGEQ8sy09gkm+XObgLA6h5Bm
         5gU11d3p60aUF4HiOnVZ/Nc7BXIppHqC8hp5HLQZ9cavka/bgFdYIjMsmLV/5lhvSmKN
         e11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pz40nRgvhtcOeXUbzgyo9Hq14GrnezoaHqBr+KLvPIo=;
        b=n9WpLAR2eWd5ryIVGxKrH35c3/SDmCQoaB2ndBl/OOYJxOB1IvDtTTqhaMzUqHzRNW
         0woyDHxcVw7MQ8+AW5Zpa74vTNmV+gONdu79pxTAvkjIA6m1AVOQHxBZyrzwLQ2B5f69
         CkkdbXMCkBaDwsury9VJbQa38EVbMmyr7aR9nZngfUsnZMxsXhAS22n1iWuzdXwHLKUO
         020Vb2Wtri4x35iOnViirzURmmwb1+5h7nxTd1KXHVgM5XPegHX9orpfdMdsp2DBk2wz
         ldalk0CEfpuVlwygPfJJSnjuG3WkHo2vCGfw+brI0VmftYUwbrpgFKCy0D2pSeuS2uDO
         F0sQ==
X-Gm-Message-State: AOAM533+GINLp6m4eAHjrnFfoYlRN0gTsGH9Y/WuRMn8hNNAOoTaA9/2
        eMpPse70oZWrEfmC2HLqzdC+4yu1wFs=
X-Google-Smtp-Source: ABdhPJxq6jWHs4Q8uMOLnsxSSSKI55rbTZr/y0gclVa6MyldkPT7fEd3IQU521XN1VdJl8L7ZCJOIg==
X-Received: by 2002:a05:6512:4002:b0:46b:8490:2ba3 with SMTP id br2-20020a056512400200b0046b84902ba3mr2565733lfb.632.1649435642808;
        Fri, 08 Apr 2022 09:34:02 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q4-20020a0565123a8400b0044a27a8c63asm2495403lfu.80.2022.04.08.09.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:34:02 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] Make AUX gpio pin optional for ktd2692
Date:   Fri,  8 Apr 2022 19:33:26 +0300
Message-Id: <20220408163330.200898-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some appliances of ktd2692 don't have the AUX pin connected to
a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
for driving the front flash LED, has the pin not connected anywhere on
schematics. Make specifying the AUX pin optional, since it is additional
functionality and only affects amount of current going through the LED.

Also convert the txt device-tree bindings to yaml and pick up maintenance
over the yaml binding and the driver itself.

v2:
- fix the dt_binding_check
v3:
- set the aux_gpio to NULL to avoid passing ERR_PTR as a gpio
v4:
- maintainership -> maintenance (description)
- remove the if (led->aux_gpio)
- use devm_gpiod_get_optional for aux gpio

Markuss Broks (2):
  dt-bindings: leds: convert ktd2692 bindings to yaml
  leds: ktd2692: Make aux-gpios optional

 .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
 MAINTAINERS                                   |  6 ++
 drivers/leds/flash/leds-ktd2692.c             | 18 ++--
 4 files changed, 103 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt

-- 
2.35.1

