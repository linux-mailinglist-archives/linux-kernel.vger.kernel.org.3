Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D58509C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387900AbiDUJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387889AbiDUJse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:48:34 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 02:45:44 PDT
Received: from ZXBJCAS.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD224BFF;
        Thu, 21 Apr 2022 02:45:44 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXBJCAS.zhaoxin.com
 (10.29.252.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Apr
 2022 17:43:37 +0800
Received: from zx-HX001EM1.zhaoxin.com (10.29.8.9) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Apr
 2022 17:43:37 +0800
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
To:     <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ahci: Add some controls on actual LPM capability
Date:   Thu, 21 Apr 2022 17:43:35 +0800
Message-ID: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platform, when OS enables LPM by default (eg, min_power),
then, PhyRdy Change cannot be detected if ahci supports no LPM;
DIPM Slumber request cannot be disallowed if ahci's CAP.PSC is
set to '1' and CAP.SSC is cleared to '0', which may cause ahci
to be an uncertain state (same for Partial).

In ahci spec, PhyRdy Change cannot coexist with LPM;
when CAP.PSC/SSC is cleared to '0', the PxSCTL.IPM
field must be programmed to disallow device initiated
Partial/Slumber request.

Adds suports to control these cases on actual LPM capability.

Runa Guo-oc (2):
  ahci: Add PhyRdy Change control on actual LPM capability
  ahci: Add PxSCTL.IPM control on actual LPM capability

 drivers/ata/ahci.c        |  9 +++++++++
 drivers/ata/libata-eh.c   |  4 ++++
 drivers/ata/libata-sata.c | 12 +++++++++++-
 include/linux/libata.h    |  4 ++++
 4 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.7.4

