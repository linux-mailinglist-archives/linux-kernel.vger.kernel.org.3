Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11F4EC87B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiC3PmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiC3PmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:42:17 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5DA933E0A;
        Wed, 30 Mar 2022 08:40:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200"; 
   d="scan'208";a="115200171"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 00:40:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.121])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 031EB4009A89;
        Thu, 31 Mar 2022 00:40:27 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] Add new Renesas RZ/V2M SoC and Renesas RZ/V2M EVK support
Date:   Wed, 30 Mar 2022 16:40:11 +0100
Message-Id: <20220330154024.112270-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

RZ/V2M has a dual-core Cortex-A53 (1.0 GHz) CPU and built-in AI
accelerator "DRP-AI" for vision, which is Renesas' original technology.
It also has a 32-bit LPDDR4 interface and video codec (H.264).

The RZ/V2M is used with ISP firmware that runs on one of the Cortex-A53
cores. The firmware is an integral part of the SoC such that the HW
User's Manual documents which of the peripheral modules are used by the
firmware.

Initial patches enables minimal peripherals on Renesas RZ/V2M EVK board
and booted via nfs. Ethernet is broadly compatible with the
etheravb-rcar-gen3 driver, but interrupts need some work so it's not
been included in this patch set.

Below blocks are enabled on Renesas RZ/V2M EVK board:
- memory
- External input clock
- CPG
- UART

Links for SoC and EVK:
[*] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-cortex-a-mpus/rzv2m-dual-cortex-a53-lpddr4x32bit-ai-accelerator-isp-4k-video-codec-4k-camera-input-fhd-display-output


Sorry for cross posting the patches to multiple subsystems, as these are
just the dt-binding patches included as part of initial bringup patches.

v2:
 * Removed SYS dt-bindings patch and corresponding SoC identification
   as we only used the LSI version register. This can be dealt with
   later on.
 * Fixed em-uart dt-bindings.
 * Included reviewed-by tags.

Thanks
Phil
