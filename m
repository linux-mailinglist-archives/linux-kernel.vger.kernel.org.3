Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF824DD1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiCRAMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiCRAMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:12:49 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296114144A;
        Thu, 17 Mar 2022 17:11:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A77A9DFEB2;
        Thu, 17 Mar 2022 17:11:02 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2At0dQUtSkzc; Thu, 17 Mar 2022 17:11:02 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] MAX17055 model configuration via DT
Date:   Fri, 18 Mar 2022 01:10:44 +0100
Message-Id: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there's no way to supply battery characteristics to max17042
driver on device tree platforms. This series changes that in a way that's
sufficient to configure MAX17055's m5 EZ algorithm, by using a standard
"monitored-battery" phandle.

Sebastian Krzyszkowiak (4):
  power: supply: max17042_battery: Add unit conversion macros
  power: supply: max17042_battery: use ModelCfg refresh on max17055
  dt-bindings: power: supply: max17042: Add monitored-battery phandle
  power: supply: max17042_battery: read battery properties from device
    tree

 .../bindings/power/supply/maxim,max17042.yaml |   4 +
 drivers/power/supply/max17042_battery.c       | 163 ++++++++++++------
 include/linux/power/max17042_battery.h        |   4 +
 3 files changed, 116 insertions(+), 55 deletions(-)

-- 
2.35.1

