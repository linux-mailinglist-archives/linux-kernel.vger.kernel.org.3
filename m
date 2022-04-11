Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3A4FC125
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbiDKPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiDKPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:44:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC613A72E;
        Mon, 11 Apr 2022 08:42:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so2033799wms.0;
        Mon, 11 Apr 2022 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7h7zW/g4PfNAudy66iCt4m1NQqQSgys4bZrKB4uCGY=;
        b=hddp6YLKjumuwdP+E7FPKw3TWZatgjRIUfjSzdGB8Q4hCF3v3f/iGzSKZtmueeHU+e
         KRIjtMmkUIlCaYgBKrigky3sXmK+1n6pZl7vLztd/ZgsSwOpvPEujhntCfWQR9qcnhPc
         VkB5DeAHmXAu/ZCeXh+YrFLnj9cPVKP+MXWT7nVIF1v300s1bMwkLnN/RSlDKfLecOQm
         nyq27Dqo+y0xSK0kARblTC4y5OhcvN05eSMZpXVaQVXNhyz+DA0xUt65jGzjaiTkYjp/
         CLLyuf+5rYkDm0HHN/oihR0PvaBXcS944k7Nw4vgRp974kangH2W9jFuqIw+LOtEFdUL
         1NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7h7zW/g4PfNAudy66iCt4m1NQqQSgys4bZrKB4uCGY=;
        b=YGSF26FuVo7MoVOCSh7GVc2WGNcmbXler8ia5/ZGnlJbR9oPf9GmaDWw0Y4CTi1jhk
         jzcp8qi0tiXCijAjs0peNZMTbLVyg4qlfiW6M0QB2dasnWunvSAVJ+BM0HySEeTSwSve
         FDqQqnnn8KgGLbZlaQzFGnIGCsgy5zXUIXL+fmjh2326pxhyLQH05R4lrXcS0isSM6pk
         ky9eIncMY/3A11uvO2GqwyDnVj3Xo+7egvBgbBOyXOHMLczfa+uLf4rjolHYmwyhcSFb
         +1nvw2O3jBrsjz/JyNZ35MtrR4vPHQV2OH43L5g0MHb1rpsGtKAIr/r+UgJp6YryqvDl
         ZX8g==
X-Gm-Message-State: AOAM533xLdTe1MYL/I0BYDt4Wiw/RKlFCzzut9M7YwXbjS6Y5DhDOn3F
        NqKRX4gsZx7xKa3Sb8zbVFI=
X-Google-Smtp-Source: ABdhPJwo3xdsBcI3wA3ZfKhrcy46qcsEsn4nWlhyOstZp2cVG1Ht+akGpDoqKdZU73H3xKiWTaOlaw==
X-Received: by 2002:a05:600c:a45:b0:346:5e67:cd54 with SMTP id c5-20020a05600c0a4500b003465e67cd54mr30122018wmq.127.1649691721232;
        Mon, 11 Apr 2022 08:42:01 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm12314323wry.36.2022.04.11.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:42:00 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 0/2] Fix missing TCU clock for X1000/X1830 SoCs
Date:   Mon, 11 Apr 2022 16:42:39 +0100
Message-Id: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically a resend of v3, except the device tree patches are
now combined into one patch.

v3: https://lore.kernel.org/linux-mips/20220224150326.525707-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (2):
  mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node
  clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs

 arch/mips/boot/dts/ingenic/x1000.dtsi |  5 ++--
 arch/mips/boot/dts/ingenic/x1830.dtsi |  5 ++--
 drivers/clk/ingenic/tcu.c             | 38 ++++++++++++++++++---------
 3 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.35.1

