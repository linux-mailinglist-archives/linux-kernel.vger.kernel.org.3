Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AF4F6C51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiDFVOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiDFVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:12:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DC612AC6;
        Wed,  6 Apr 2022 12:56:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu29so6052407lfb.0;
        Wed, 06 Apr 2022 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEouFCYzQfQXD9Vp7v1Lh4VBFzxjwxpZamBS0BcRz2s=;
        b=RS1Z/i4bvNElABRS7GvZK6cYRJJaZESO/lKQKMxxrdvxOguma6aXn5Yk3yIT7vf0nb
         149Uv/ocqrRHnCOblJPpAlbjF3ty5oDOf93bPVKsbcHaa0k9JpWqiOpLfRotRSNjNwGo
         1P6OjEPAMdYwWqVCNqKNr6FbgfuvY8F6+X1dSuDpllSGsg2YOZ3q9/rSKdJKXjb2kKwu
         dIvQ0ym6R3QoyAK5zL9tNKO1/8t7nLWKnlH9ab2JWk1x+d8IMKebdM7feZnGdk6HA+gl
         DU3WOtbJ/UggKhVI9EaLoH6AXBIXqaL5jNPlgAG3VteHSApzRJR2E8a9E7f5QOVxsMS/
         SzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEouFCYzQfQXD9Vp7v1Lh4VBFzxjwxpZamBS0BcRz2s=;
        b=LRiAg9OrzoTzOggC3P1k+GSokf3fY+7n6yCpnCSKB2qqdRJRcRvsatZcTsdQFMClOz
         u4lMNpO7MGaBu/eFubW14Dbr0LUtwYaI6oed/rPbbD7zbiNHD4maAC2KWMLWy+9I/wly
         /Sgi/ojFgCyqYhTKFL0/4V9gtKxn9YlSZTTyeYfCE+idGwVUttzHaVuGdKPAXUrSrnoo
         x4zgEl56hbmkGsB5FUk/XZYsO9lImjyUTHzY64RMp6RPQZwqoh3aeyei3Z17twkWoxM9
         YmvCdanYYt2fvkTopdtOfliUPDXIfLazAKSCF/5acVBaYdEyMAES3AR9UeIUnLn3HTaG
         H2jw==
X-Gm-Message-State: AOAM530/fkrtVQbxE7wC9z0lIPu3aSYnYt7a2266eX+6omqA2+z1G/WU
        WD424nH8uADYOYMzUC9TI3Y=
X-Google-Smtp-Source: ABdhPJxh/MsUiI2cH4K5a+lX7WcGBxOf5RwphhWYcOmFap8qqnzmfuKkGM6nOYnGgSDoMjdr9G1oAA==
X-Received: by 2002:a05:6512:13a9:b0:448:9dd3:b84 with SMTP id p41-20020a05651213a900b004489dd30b84mr6937987lfa.556.1649274972281;
        Wed, 06 Apr 2022 12:56:12 -0700 (PDT)
Received: from vmu1804.lan ([2a09:bac0:87::815:6e3d])
        by smtp.googlemail.com with ESMTPSA id f18-20020ac25cd2000000b0044a34937c16sm1930685lfq.173.2022.04.06.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:56:11 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] dt-bindings: mtd: partitions: Add binding for Sercomm parser
Date:   Wed,  6 Apr 2022 19:55:57 +0000
Message-Id: <20220406195557.1956-1-csharper2005@gmail.com>
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

MTD partition parser for the Sercomm partition table that is used in some
Beeline, Netgear and Sercomm routers.

The Sercomm partition map table contains real partition offsets, which
may differ from device to device depending on the number and location of
bad blocks on NAND.

Changes since:
v1:
 - Add dt-binding in a separate patch
 - Remove redundant braces and logical NOT operator
 - Define pr_fmt
 - Replace kcalloc by kzalloc
 - Use of_get_child_count() and alloc big enough array before the
   for_each_child_of_node()

Mikhail Zhilkin (2):
  dt-bindings: mtd: partitions: Add binding for Sercomm parser
  mtd: parsers: add support for Sercomm partitions

 .../devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml          |  70 ++++++++++
 drivers/mtd/parsers/Kconfig                                                |   9 ++
 drivers/mtd/parsers/Makefile                                               |   1 +
 drivers/mtd/parsers/scpart.c                                               | 240 ++++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+)

-- 
2.25.1

