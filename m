Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C820F50E05B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiDYMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiDYMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:35:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0464BF8;
        Mon, 25 Apr 2022 05:32:33 -0700 (PDT)
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BDF171F43529;
        Mon, 25 Apr 2022 13:32:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650889952;
        bh=0RLY0AvODmXKcFUYfeALdqinoBMAga8pPmBnDWL/Q9c=;
        h=From:To:Cc:Subject:Date:From;
        b=Tq6rlV8r1JqEu97gVwaJB9UdEYlq9wCw7JiKFMPpSz3vLyPVfX2bH+HJ0csLD6Yvs
         xmSAhkXuKNC0NRr+5mltd+e7npsSqR3SltJBnwE5gemWwzFx4Drf+FMkJMMAspeD3g
         Yji0Boiq1TNqd61WAoT0XXJRMJpMyN7kr7uJdL/xgOWe9n/G4tuTwBPmV3XmXk1gpF
         pNc7MwhxzWKNsd4OI0VEpduju95YZkR0SzSRwmZumTub8gBd4cdQTLcHbwSXgiW9p4
         Q6p1HU4imNOgVDYhLW2BvP2GP3iiAcjlcez13DNfLVfhS5DwUP8ZunRJsrjrUABYv0
         35p7J+rtMJhKQ==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2 0/3] Rockchip RK3328 VDEC support
Date:   Mon, 25 Apr 2022 13:32:12 +0100
Message-Id: <20220425123215.1055251-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds VDEC support for the Rockchip RK3328 SoC which
uses the staging rkvdec driver.

Testing was performed using both v4l-compliance and (mainline) gstreamer
using the fluster framework:

    $ v4l2-compliance -m0
    v4l2-compliance 1.22.1, 64 bits, 64-bit time_t
    ...
    Grand Total for rkvdec device /dev/media0: 54, Succeeded: 54, Failed: 0, Warnings: 0


    $ python3 fluster.py run -j1 -ts JVT-AVC_V1 -d GStreamer-H.264-V4L2SL-Gst1.0
    ...
    Ran 111/135 tests successfully               in 392.885 secs


    $ python3 fluster.py run -j1 -ts VP9-TEST-VECTORS -d GStreamer-VP9-V4L2SL-Gst1.0
    ...
    Ran 206/303 tests successfully               in 1170.120 secs


Changes in v2:
 - Fix mistake in dt-binding compatible documentation
 - Remove unused reset nodes from devicetree
 - Improve some commit messages
 - Check all dts files against dtbs_check
 - Collect review tags on unchanged patches

Christopher Obbard (3):
  media: dt-bindings: media: rockchip-vdec: Add RK3328 compatible
  arm64: dts: rockchip: Rename vdec_mmu node for RK3328
  arm64: dts: rockchip: Add vdec support for RK3328

 .../bindings/media/rockchip,vdec.yaml         |  3 +++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      | 22 +++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.34.1

