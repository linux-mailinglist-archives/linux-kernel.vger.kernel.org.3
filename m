Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A393B5B075F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIGOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIGOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:46:34 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8CE8002D;
        Wed,  7 Sep 2022 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561992; x=1694097992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oY821EVhwGzBAfuH2/kNtAGnG2qoILrZ7TWoDhAD9PI=;
  b=KHzY+CqiNixadWcqwnQz+aG5M9ffTZORwITgXMRFE3JFKqGkO8bni6D2
   zAk1vzgngMiR3rXdYcfaaF+v7Cfh0wdMX1Mc5QpL8avpc8fhW0eX4e1MO
   dYmYN8Tw+iNYALByfO+TepzyY00eL1m0m3MjBoTimvuYaQVILrnnjauzV
   9HlX6pE1HcVUVcaBqS/myhkpPag9DiNtmS7kTtBDJuKxe22OCDKxfF6fj
   Gs3yM1ruWYJI/nGs0HrJNKEL8UspmK9rWMImWzfROsgwuVnXmKADVmRjo
   boR4JKwl69iFXIjXCiq7umBZyuZnk5zyXijLuTFBo1D1mRWovU3nH/Pz1
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047482"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 16:46:30 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 16:46:30 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 16:46:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561990; x=1694097990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oY821EVhwGzBAfuH2/kNtAGnG2qoILrZ7TWoDhAD9PI=;
  b=R5QBc4ENTHa3HF9+oYnBjSoYaaRjzloQ7n78XVgsSVwQnRBKJkwg9qQK
   0WV/Qt0pxMMnZ75O1XCGbscRpaGF+04O+AEU0wCpge7oWKoWy4ypQ/JNM
   KcihscBAo/8WbeAK4S55jt6pAAklC0v3NHgBh6t6AnDXKvfLawbrTm3oa
   6lCUQhJvNpgKXaYE9X+8B1TvjyAzLdmM397Y7kOHTafvXJQ1XJiTtCsML
   XMZhPwOni6i3N9Le447wwbMeZQJswql/RceoN71ztrSFM5OuVoc27nftl
   o3vK0mkaQnIYDWqsO6hxNMUrqEz5QlfVc/R3ky9aqJu1zZ8bmkmADh21z
   g==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047481"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 16:46:30 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 30AB8280056;
        Wed,  7 Sep 2022 16:46:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Date:   Wed,  7 Sep 2022 16:46:20 +0200
Message-Id: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

this is a series based on the RFC at [1] for USB host support on TQMa8MPxL +
MBa8MPxL. The main difference is that USB DR support has already been added and
has been removed from this series.

The DT configuration itself (patch 4) is rather straight forward, but leads to
the following dmesg errors regarding superspeed ports:
> [    8.549243] hub 2-1:1.0: hub_ext_port_status failed (err = -110)
> [   22.885263] usb 2-1: Failed to suspend device, error -110

This hardware works fine using the downstream kernel, because for imx8mp this
ITP sync feature is enabled conditionally [2] & [3].
Hacking this into mainline resulted in a working superspeed setup as well. I
also noticed that on some android kernel [4] depending in IP core version either
GCTL.SOFTITPSYNC or GFLADJ.GFLADJ_REFCLK_LPM_SEL is enabled unconditionally.
So I opted for the latter one using some quirk (patch 1-3).

I have to admit I do not know what this is actually about, nor why my setup
does not work without this change or why this fixed my problem. So maybe
someone with more knowledge can say if this is the way to go or what this is
about.

I also added snps,dis_u3_susphy_quirk to the board level as for some reason
USB Superspeed U3 does not work. Detecting the onboard hub takes much longer
and once all devices are diconnected from the hub it is put into runtime
suspend (U3) and new attached devices are not detected at all. Until the cause
is known and fixed runtime suspend has to be disabled.

Thanks and best regards,
Alexander

[1] https://lore.kernel.org/all/20220622130440.955465-1-alexander.stein@ew.tq-group.com/
[2] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/usb/dwc3/dwc3-imx8mp.c?h=lf-5.10.y#n134
[3] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/usb/dwc3/core.c?h=lf-5.10.y#n333
[4] https://android.googlesource.com/kernel/msm/+/87a6b154766907020cc74c7726e8a68aaa9d7f6b%5E%21/#F0

Alexander Stein (4):
  dt-bindings: usb: dwc3: Add gfladj-refclk-lpm-sel-quirk
  usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
  arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes
  arm64: dts: tqma8mpql: add support for 2nd USB (host) interface

 .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 +++
 .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 42 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +
 drivers/usb/dwc3/core.c                       |  8 +++-
 drivers/usb/dwc3/core.h                       |  2 +
 5 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.25.1

