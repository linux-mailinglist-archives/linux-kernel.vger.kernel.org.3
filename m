Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5724056D3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGKE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:29:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F2517E29;
        Sun, 10 Jul 2022 21:29:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v12so4784637edc.10;
        Sun, 10 Jul 2022 21:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DttVB14cH7FHBMmOjyJF3G0VYFKo+sEsLDSk8HgieQg=;
        b=nE/54efZBUx9zWQH+3wzN+1js0Mkof/OoZf0ksfF2yE7z4/DzJzBVEbelq1X38IDPJ
         edfD/P0BpMhJgui4YWm33VDrvXnhK+Biolo/g7P2PVwmvgXx5N89WB5eAkYeLmZq05ac
         ZbeqZje2Dp8eL5QH4veQ/ultoTGHeCV+uY4TwJQJ3hHyFJMhxs6kILjWafdH7IQvjXeG
         DzPmwlAx2mkGfpldYyL9lRvlcdGvuxY1tLmIAE458KCcTKNX08q1mc1ZG5pREzBcY3cU
         D1bqjwHq/7PEgl8scBZbT2G8PoRwBxLqf2gMzxGA3GTozPjRDRlc7zGMbIgqePskU4AC
         L/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DttVB14cH7FHBMmOjyJF3G0VYFKo+sEsLDSk8HgieQg=;
        b=pxVLg/GaiKTRj/Y5OcA/PLwJzmiPpufXFZGu+ND+CCuHqa3XpoTwUS/ebdJCMdip8l
         lF3X1t/bKPHZ0pUNcz0hFy4QvbSeqn4Xkg+thEl/jIZOxjqK518ENoyvomaqyJnyYdrK
         wTr+wkYrQW7jPr8qwoDUfTJqgjiUmLogo5sXCGx9E/ULGmX4YE/XqpvxW0UtmzShHUgT
         5IIGOwBAUmJyB8/+zwyS7AwSfZWsi858WRxd91eFFSPwOwgOffLS9fig4rM0GrN9aGbn
         5XKMC+ojM2ihW0BX4ZRKhv/E+EpxmJWdlbWDwG1KlEO6nBjUhQ8EQzDJhhEG82qdvZbv
         zF/A==
X-Gm-Message-State: AJIora87s0H3q27oJ3cNal/ENnvAUUdZiMtZkEZzvrxjSNt+XbMU52gZ
        cLNMU6z8x0NfWF1WUc2ZzKAt46JvKjSsS7WU
X-Google-Smtp-Source: AGRyM1vBD4LDgfY5nOBIXTtmIxj8tgyFfGgQKzmBKaGVYnkqYXSkGVHsimLQrlRxuwEniEF4naGc5Q==
X-Received: by 2002:a05:6402:4518:b0:43a:3b90:7457 with SMTP id ez24-20020a056402451800b0043a3b907457mr22482188edb.422.1657513793088;
        Sun, 10 Jul 2022 21:29:53 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00726298147b1sm2203100ejg.161.2022.07.10.21.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:29:52 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] media: i2c: ak7375: Add regulator management
Date:   Mon, 11 Jul 2022 08:28:36 +0400
Message-Id: <20220711042838.213351-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series adds needed regulator management for the AK7375 VCM.
A DT schema conversion is made before adding new properties.

Yassine Oudjana (3):
  media: dt-bindings: ak7375: Convert to DT schema
  media: dt-bindings: ak7375: Add supplies
  media: i2c: ak7375: Add regulator management

 .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ---
 .../devicetree/bindings/media/i2c/ak7375.yaml | 52 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 drivers/media/i2c/ak7375.c                    | 39 ++++++++++++++
 4 files changed, 92 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.yaml

-- 
2.37.0

