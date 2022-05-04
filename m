Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB978519C29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbiEDJsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiEDJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:48:40 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E913A27B29;
        Wed,  4 May 2022 02:45:04 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,197,1647270000"; 
   d="scan'208";a="118702209"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2022 18:45:04 +0900
Received: from localhost.localdomain (unknown [10.226.93.27])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7C5B94009679;
        Wed,  4 May 2022 18:44:59 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: [PATCH v4 0/2] Add new Renesas RZ/V2M SoC and Renesas RZ/V2M EVK support
Date:   Wed,  4 May 2022 10:44:54 +0100
Message-Id: <20220504094456.24386-1-phil.edworthy@renesas.com>
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

v4:
 * Removed arm,arch_timer optional clock and reset
 * Removed "optional" from description of renesas,em-uart clock.

v3:
 * Feedback addressed
 * Added patch [0001] for renesas,em-uart dt-bindings RZ/V2M clock for the regs
 * Added patch [0004] for arm,arch_timer dt-bindings optional clock and reset
 * Added patch [0005] for rzg2l clk to move the DEF_MUX array size calc into the macro
 * Added patch [0006] for rzg2l clk to add read-only versions of the macros

v2:
 * Removed SYS dt-bindings patch and corresponding SoC identification
   as we only used the LSI version register. This can be dealt with
   later on.
 * Fixed em-uart dt-bindings.
 * Included reviewed-by tags.

Thanks
Phil
