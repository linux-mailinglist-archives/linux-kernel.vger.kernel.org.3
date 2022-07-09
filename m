Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF056C900
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGIK3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:29:40 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582782B251;
        Sat,  9 Jul 2022 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l8Sjh
        h/ajXiO3k0wRoZh6m+Gbm4m3upjBKizi7FLLKw=; b=V2mWCaJwuSP2gsunVwZYK
        dbxHpHE1URf//dqC9YoLYsa2qAYL9uaehBW+tCNWiZ/7pjke8A4+RrXrxDbqbHOl
        Dd4Pbu3zUbNlJyqjLwfqcfRT8Sdfjae8P5WgAva+xW5cqhLE5R+uRa8mjR5ktQ41
        92OkFNCq3hfCpQXn02t2tc=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp3 (Coremail) with SMTP id G9xpCgDnVndwWMliAnvfOA--.503S2;
        Sat, 09 Jul 2022 18:29:08 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 0/3] Add support for rk3399 based eaidk-610
Date:   Sat,  9 Jul 2022 18:29:02 +0800
Message-Id: <20220709102902.2753851-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDnVndwWMliAnvfOA--.503S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw43Jr1kuF1rJFykZw1DWrg_yoWDuwcE9w
        4xCr98JF48Z3Z5Ga98tr1xGrWrAwsrC3ZxWa4rtF4qyF98X347JFn5J3s3Z3WfJFW29Fn3
        ArZ7CFy0q3Z3KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREpnQ5UUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBsh05Xl75fWYasAAAse
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


EAIDK-610 is from OPEN AI LAB and popularly used by university
students.

Specification:
- Rockchip RK3399
- LPDDR3 4GB
- TF sd scard slot
- eMMC
- AP6255 for WiFi + BT
- Gigabit ethernet
- HDMI out
- 40 pin header
- USB 2.0 x 2
- USB 3.0 x 1
- USB 3.0 Type-C x 1
- 12V DC Power supply

This patch is test on Armbain and Glodroid with
HDMI/GPU/USB HOST/Type-C ADB/WIFI/BT.

Changes in v2:
- split bindings to a seperate patch
- address Rob's review about power-key and auido codec
- drop status property of fusb302
- enable bluetooth and typec otg

Andy Yan (3):
  dt-bindings: vendor-prefixes: Add OPEN AI LAB
  dt-bindings: arm: rockchip: Add EAIDK-610
  arm64: dts: rockchip: Add dts for a rk3399 based board EAIDK-610

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-eaidk-610.dts    | 939 ++++++++++++++++++
 4 files changed, 947 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts

-- 
2.34.1

