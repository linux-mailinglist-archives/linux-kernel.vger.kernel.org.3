Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A99E58AB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbiHEM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiHEMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:55:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536BBF4A;
        Fri,  5 Aug 2022 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659704157; x=1691240157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/4/f+QmTKxnEWDI54MXjjktDAKqUKFkKTc9gwTjtlg=;
  b=ebgJKwUsq9b7Vfn8E4SEngnApUIos1Skf6ceDt+a63a5H6hgY4JvhPkJ
   g4J5PVCxTwPtkougbHo8WDp9C6tuozroWEWriCgilobGUbA950nK7ZX7N
   4D5cEl9jH9P4S07PO+svk3+bpGcGSL5Dvokrt1ZBSiJQ5WC+U3XAQvVIA
   cE6J5BvPer8Y35iKarkN7FClfpDOBbIjKzkS6xw0Xf+xnWI2AGBwoKbPd
   1hnDpi21RxNnhzZdWlcXnNrJ8BU3JOotL1qxErJYunjN0mixjoSpESFJd
   +E5SkcZ1tVffiRugojW2IkF01pmZP6pX0VhUJCE2U1RH9dQLCqd75Ln1v
   g==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="175067540"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 05:55:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 5 Aug 2022 05:55:51 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 5 Aug 2022 05:55:50 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 0/3] MPFS mailbox fixes
Date:   Fri, 5 Aug 2022 13:56:16 +0100
Message-ID: <20220805125618.733628-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I spotted a couple of bugs in my mailbox driver while developing some
new features. None of the features these bugs relate to were in use so
they've gone unnoticed until now. The binding screwup is unfortunate
and I don't really know how I misread the register map so badly.

Jassi:
Not sure if you prefer developers to add a CC: stable or not to patches
so I have left them out, but I would like to see them backported.

Thanks,
Conor.

Conor Dooley (3):
  dt-bindings: mailbox: fix the mpfs' reg property
  mailbox: mpfs: fix handling of the reg property
  mailbox: mpfs: account for mbox offsets while sending

 .../mailbox/microchip,mpfs-mailbox.yaml       | 15 ++++++++---
 drivers/mailbox/mailbox-mpfs.c                | 25 +++++++++++--------
 2 files changed, 25 insertions(+), 15 deletions(-)

-- 
2.36.1

