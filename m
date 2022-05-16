Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36CB52882B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbiEPPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiEPPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:12:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F82A8;
        Mon, 16 May 2022 08:12:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d21so5053697wra.10;
        Mon, 16 May 2022 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1FJwil/7+XIwiXsq5I+6Eb/YvE5VJgEZyQaNqTaaDc=;
        b=I31xUdj8VH0Q+b9sUcm9wcgk9wZYanoUdZTbi6PvI39lfkD62Dv4vFTs2lST2Dl0Or
         3DivGVQ5+AlKvo8YS84BZB6bPxiSdnZ0exa1aAELLQNL0D7kWNQigKEirWEyABRAaXBi
         4GEZ7APvHtcmd2OKh6lQw8vWaEU+q9Feg0I3iY9dp0hG4IrlZCVGh4oc9Pl39bU0bx5j
         eMsvvzdN1eu/Tcq0lRCdy+f0mxSZXoOpvoVNsyooPX2IMZO8T61ccFZF4V9NmerNyLHK
         xNqJxaHKI//jch/jR7OZx8rFFweG5kWW9lG2AzRIfvqBbh6ZriMK27D1PEHJeR1lEq/x
         gzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1FJwil/7+XIwiXsq5I+6Eb/YvE5VJgEZyQaNqTaaDc=;
        b=jVd/gmO2Oo0jOD4xQkQD2WnEE7TJHPKX2IKRFtx9UjaWzlqfdDtLdM0rrM8CRJxfSL
         h220VFP6baMWySpQfaAcnkZzTqyrzQ5xMSlkz/6zIQ1DQcuVDJqmmMvs4jRXyKCFSDPo
         wTPxvFhIkz29aPewedIcKShU/MHMeV8EQUpDEkXlZOe7zb5Rrp7o7WhQ98VCIqlnDlJ1
         j3mFj8WmD0/VtSCSihDxDVCR8lbWTVsDX2qcpDlRJPijZVSOVccBmgpJ8UwyoPwnxeKZ
         k5yIXlQGlf4rIiHliqH3ubXWPHi+dwk1WXU5dLCCLGGsv00wn8Te/rIidcSBsGEU9wCn
         j57A==
X-Gm-Message-State: AOAM532u2KxERFZVS3whrOVkEUmKiJroER8jyvCmK/vfpgTVbvkVCTQq
        a+J+3efLt/0fYIAI8u2l0aA=
X-Google-Smtp-Source: ABdhPJxuqO1uXReP9VrJqtOoLvpX21uGjiDIi805z04XmYH3Q+a6sHOZfKCJaag+PCEz7vqDj4bhUg==
X-Received: by 2002:adf:e195:0:b0:20d:110c:b890 with SMTP id az21-20020adfe195000000b0020d110cb890mr1657865wrb.232.1652713952708;
        Mon, 16 May 2022 08:12:32 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id bg33-20020a05600c3ca100b003942a244f57sm8962540wmb.48.2022.05.16.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:12:32 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v5 0/3] Add support for Sercomm partitions
Date:   Mon, 16 May 2022 15:12:28 +0000
Message-Id: <20220516151228.885222-1-csharper2005@gmail.com>
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
v4:
 - Add Acked-by to the first patch

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

