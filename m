Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC35220E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbiEJQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347191AbiEJQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:20:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23006B00D;
        Tue, 10 May 2022 09:16:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e2so24513017wrh.7;
        Tue, 10 May 2022 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jr74PyVWD1/63U5wp0lr9an8U2SlYbja1K4X3Dr9fys=;
        b=IgcA7J7Jc9zsBzAOhysXl1fXR61GQn8h7+YdC9OPT2G9+lE/W7ZBjdq1k4tXjMOzg9
         a8Bes1nCJs+0aPsq3i5m0iPc8rhlaIDKbdObNi3oOeg0HcL60MLEgCN6fQnq4P6YHDrJ
         kLWWGzAh0AGqfDbREsb3dRZf/4UpucvW6AHvZcV8zI/G0BEQPBkd3icGz2/N0dpFb7cF
         odl/uuqP9Kl2ggkmemp6PJSje+gMxX/GiDjs3H9BNxUwrwL0C6+GwQWiE2AZR0ovMq8x
         NL/eKUzc9Nrjld8KkJZ5ZdLs0CqbNeRTvUa1nhG9yrZsKRulMo2yLSOwguf1myPnzBtP
         A47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jr74PyVWD1/63U5wp0lr9an8U2SlYbja1K4X3Dr9fys=;
        b=Cg2/n8DzpldUugqfAFiHpY3BQH37DiM3qy8JPykYb/JA//apK6nU0gqdeQkKANTvwf
         L94TjwKpMzN+3WuYRm4ulL2vrwK3p8/1hkiD+M4iovGmzjNyvhT95Z2IJmA5kWCNgAww
         vfKOXETszZiK2y4LcGrM4jioOvWpl9VVuVEDAKKDwzkdLhRRNkiCGP+Al9aNlKtkrVWf
         DcTMzfdk6nE4z3DVKHZ0OTPL+ppDVvh81WqBW8UwP3Ef6KQ47hgT4QjH9Pnp0r3Qdn/S
         tiwirmNtIaJUin0pKFyH+V/8uPmlhploIro4ziTRyip7GA+CxBLFejTzJ7NN27PfugVz
         btYw==
X-Gm-Message-State: AOAM531Svb0J1nPK8Z2jl+GCeoOQAFTsLXSkFyXEcIs36mxp7tKjvV9r
        5akykVoiSqznUQ7e7REjjT4=
X-Google-Smtp-Source: ABdhPJwbe9yD9HIi2JdlrOrApRC25IDTLiNLpBXgkqAdLbkF28y22Aa6nOfVTo/1FE8z4RnPa0BAYg==
X-Received: by 2002:adf:f0cb:0:b0:20a:ef39:d42b with SMTP id x11-20020adff0cb000000b0020aef39d42bmr19894165wro.8.1652199413461;
        Tue, 10 May 2022 09:16:53 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d4309000000b0020c5253d8f0sm14634833wrq.60.2022.05.10.09.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:16:53 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v4 0/3] Add support for Sercomm partitions
Date:   Tue, 10 May 2022 16:16:41 +0000
Message-Id: <20220510161641.20655-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This patch series add support for Sercomm mtd partition table parser. It's
used in some Beeline, Netgear and Sercomm routers. The Sercomm partition
map table contains real partition offsets, which may differ from device to
device depending on the number and location of bad blocks on NAND.

Changes since:
v3:
 - Fix commit message of the first patch
 - Add Reviewed-by to the second patch

v2:
 - Fix mistakes in dt-binding
 - Add patch for new vendor prefix
 - Add vendor prefix to scpart-id property

v1:
 - Add dt-binding in a separate patch
 - Remove redundant braces and logical NOT operator
 - Define pr_fmt
 - Replace kcalloc by kzalloc
 - Use of_get_child_count() and alloc big enough array before the
   for_each_child_of_node()

Mikhail Zhilkin (3):
  dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
  dt-bindings: mtd: partitions: Extend fixed-partitions binding
  mtd: parsers: add support for Sercomm partitions

 .../mtd/partitions/fixed-partitions.yaml      |  55 +++-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/mtd/parsers/Kconfig                   |   9 +
 drivers/mtd/parsers/Makefile                  |   1 +
 drivers/mtd/parsers/scpart.c                  | 240 ++++++++++++++++++
 5 files changed, 305 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/parsers/scpart.c

-- 
2.25.1

