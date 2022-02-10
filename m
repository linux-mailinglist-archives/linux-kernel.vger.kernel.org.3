Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA684B1232
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiBJP7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:59:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbiBJP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:59:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E773E5D;
        Thu, 10 Feb 2022 07:59:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so3619626wmq.3;
        Thu, 10 Feb 2022 07:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBkaEtppjIdvRqQzatDwBLZj9pqZ7aXbGEZtGIQhqCQ=;
        b=OUjF/bTwjTt65gFZqbXNvr8rNT5GYCuoWFVD1ah0VjqENAvZN0izKGeItjNxfB51vW
         yijAhi3Kutns9V1iWa1LKkzdMmM+P9BhXR7v+15kk01/QeLevmYWWxk8BLalzApvr8Fi
         um0THjhZja42eWnXTY65YOpYrKvN0ZyTvDLq6gT4bKrT9tCNAkPaYiZH3FFOIfbjIpVW
         oDFUqOG54ONWe7x1f4GztJder26J3HiHy06fpRoMZ2DnBGqNrYUMaXEtFluHB092vGZY
         RqIqK1Kb8gvHJGQHC4N3fiJDRAfMaqnGO1tTGwPe8GBrTCGRhy3R5wlzK97xh9XxSb+G
         JEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBkaEtppjIdvRqQzatDwBLZj9pqZ7aXbGEZtGIQhqCQ=;
        b=Si6bj8MVJToJW0aafJwvLVwrGBzN8XAOZL3JPYakrhrUeGL5Mc4Q8hmdOjQ6f78Ybj
         MIyoRD3Rvwgm/XsgJW0TddL08fV+0690QuH06bX5Uw6DRh5HgsWQ/VTlBKnI120gd9NW
         0cIlOIBj4p4bsImIV7ZkThImzBLXBBRb5rDASMg7uphelEjBPaKSB9ySWcBk7GyGfQQ8
         +e041jFpWn9Tiy5P8PMMqJRMKkHPqYok5KkgEa/TJNqiDLbQiDG6QxXbsjHyqPbGXIkC
         ykNLLFQDkzqYiPVdQYoqbxDa3UKBSL0hNfGkzjSov4XU1e9vIqO7G0JI20wh0F7fy1Gp
         XJLA==
X-Gm-Message-State: AOAM532UCVRT0OqGSeGyv/aVSk1nKyI3YLhBqMqNzttY+5QJKzn+hOdI
        LO8tBrS5e5SrRCiIgG8ipvpbHRkz7eXjWw==
X-Google-Smtp-Source: ABdhPJzxo2NQNX2s5Pr0xANuiGS1KH2RSfz5xcLf24jM0AeCV5RoE3NWtczH4jRpFqShHXRmUDVpUg==
X-Received: by 2002:a05:600c:4e16:: with SMTP id b22mr2720187wmq.8.1644508762016;
        Thu, 10 Feb 2022 07:59:22 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id p2sm12990551wrt.101.2022.02.10.07.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 07:59:21 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Joe Hung <joe_hung@ilitek.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add support for Imagis touchscreens
Date:   Thu, 10 Feb 2022 17:58:29 +0200
Message-Id: <20220210155835.154421-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
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

Add support for Imagis touchscreens, used on various mobile
devices such as Samsung Galaxy J5 (2015), J3 (2015), J5 (2016).

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 329 ++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.35.0

