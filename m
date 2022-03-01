Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD54C8EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiCAPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiCAPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:28 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846C58A6EA;
        Tue,  1 Mar 2022 07:24:46 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 4F9195FD74;
        Tue,  1 Mar 2022 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646148284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EgKR4jh/nFy9Q8P9zxOcbItrMHn/g3ym5IeVT0hhCDk=;
        b=KwlTPSe7/z2GJh18srISs5N8k+W2fGP9DM2Opuvtf3bK7Av4gXC+VQB88Q3dY7aI01IAQd
        ckT6Nqc4KI8b08iKRH7jfrV/z5uYs3Fs4G7OCqrKjChCAynQeWRQ20NjWEiXz8f5vobSCu
        PO5Bv3Bj6FlZab/+KlgygDzL85M6G6U=
Received: from localhost.localdomain (fttx-pool-80.245.77.190.bambit.de [80.245.77.190])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id C46001005DD;
        Tue,  1 Mar 2022 15:24:42 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 0/5] Add sata nodes to rk356x
Date:   Tue,  1 Mar 2022 16:24:16 +0100
Message-Id: <20220301152421.57281-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 638c7878-d4fe-4eb7-bd79-5d758478ea67
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series converts the binding for ahci-platform to yaml and adds
sata nodes to rockchip rk356x device trees.

v4:
  YAML binding:
  - fix min vs. max
  - fix indention of examples
  - move up sata-common.yaml
  - reorder compatible
  - add descriptions/maxitems
  - fix compatible-structure
  - fix typo in example achi vs. ahci
  - add clock-names and reg-names
  DTS-Patches:
  - drop newline in dts
  - re-add clock-names
  - add soc specific compatible
  - fix sata nodename in arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
v3:
  - add conversion to sata-series
  - fix some errors in dt_binding_check and dtbs_check
  - move to unevaluated properties = false
  - add power-domain to yaml
  - move sata0 to rk3568.dtsi
  - drop clock-names and interrupt-names

Frank Wunderlich (5):
  dt-bindings: Convert ahci-platform DT bindings to yaml
  arm64: dts: broadcom: Fix sata nodename
  dt-bindings: Add power-domains property to ahci-platform
  dt-bindings: Add rk3568-dwc3-ahci compatible
  arm64: dts: rockchip: Add sata nodes to rk356x

 .../devicetree/bindings/ata/ahci-platform.txt |  79 --------
 .../bindings/ata/ahci-platform.yaml           | 169 ++++++++++++++++++
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |   2 +-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  14 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  28 +++
 5 files changed, 212 insertions(+), 80 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml

-- 
2.25.1

