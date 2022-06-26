Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5755B02E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiFZINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiFZINx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:13:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0E311C0C;
        Sun, 26 Jun 2022 01:13:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so5638034plc.8;
        Sun, 26 Jun 2022 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3IVi1gGed/R88Z/LVYp9rC+q2YufqkGtl4pm7/wvUk=;
        b=DGDJZaNMh7J8bD7fSo10nVpE7S2Ee0QaVYiBYuaSBfMGIfuuzdH8p8NDGE2WVFbsAx
         nbu84rRuuwhWa5DBI5kC6QMWADyqqvbWXCiVYrHdex9n/J2pxztbsSKmi3eL1XpQnDr1
         xOTVPD1jDJ2zRH6iffw0yBRvIoIQG/tX1XKvcOwckHROioWrwNGNf3gP6VReXg5Pr9Tr
         m3x9ulk3XJDtMaqanWqS7veuDtiAZ+YWxIbGH69ymk7DSgGA6NLxkolC777l/BdAgXuA
         6g1vZ0ALADVbJIXX8RF8Uf/QRpw3Tuh77ed+WmIjQyo+slDese3HZz44nD/sLUQNhsaP
         lJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3IVi1gGed/R88Z/LVYp9rC+q2YufqkGtl4pm7/wvUk=;
        b=U9SF3/dIk3ap45PO0KNfkZndY/xnzFBN1XjrLBWmPECrGkDg6Bwd7E2LJ16Zb57gYE
         H8ve217S6ovzJD7kvoebaCzvkF21LBJCXJ5cfN/UGuNSjKBJPecnIHZyMUX3bM6m43SB
         CdjRYfAslNDUyD9R16SA07sbZ+TWFPHqHUCrkpVFBb+1Gv+iWpaWNYXj+DuAUWbxAzW+
         Vu/+ogG4gunZelgjj0PcJkTiQlQPN46JATR3wEJcNgbY1+iEoCZm5727wwZ9ztwAMmWe
         E8a55STqPYuTwnH5t3WyTlzr5yMpQv0EpckvCOebn1EwvfBuGCsxiNOWENEii6FM8NZm
         Ldiw==
X-Gm-Message-State: AJIora+Xjief3cUPHKnUEBuy4wjnD+PLI+dgIRT+rsHl/ORrXcwCvIXp
        w6GtdOoqioAFkovgtBWZpPY=
X-Google-Smtp-Source: AGRyM1uLk5j36B5dFxYDuSCPU0II8Bq6Pvw/RV7rl0qOg+3jbLWNr98NzCWz2H14ojTgRuvGCc+9Ng==
X-Received: by 2002:a17:90b:3842:b0:1ed:16aa:def6 with SMTP id nl2-20020a17090b384200b001ed16aadef6mr14295820pjb.130.1656231232697;
        Sun, 26 Jun 2022 01:13:52 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id q26-20020aa7983a000000b0051b95c76752sm4768433pfl.153.2022.06.26.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 01:13:52 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] HID: amd_sfh: Ignore uninitialized device
Date:   Sun, 26 Jun 2022 17:13:39 +0900
Message-Id: <20220626081339.7243-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo ThinkPad C13 Yoga has AMD Sensor Fusion Hub, but it is not used
because Chrome OS EC Sensor Hub is used instead. The system therefore
never loads the firmware for MP2 and MP2 does not work. It results in
AMD_P2C_MSG3 register to have -1 as its value.

Without this change, the driver interprets the value as it supports all
sensor types and exposes them, which confuses a userspace program,
iio-sensor-proxy, and makes it to use the non-functioning sensors
instead of functioning sensors exposed via Chrome OS EC Sensor Hub.

Check the version bits included in AMD_P2C_MSG3 register and ignore the
device if all of the bits are set.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index dadc491bbf6b..4137e5da77ad 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -271,6 +271,8 @@ static void mp2_select_ops(struct amd_mp2_dev *privdata)
 	case V2_STATUS:
 		privdata->mp2_ops = &amd_sfh_ops_v2;
 		break;
+	case 15:
+		break;
 	default:
 		privdata->mp2_ops = &amd_sfh_ops;
 		break;
@@ -317,6 +319,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		return -ENOMEM;
 
 	mp2_select_ops(privdata);
+	if (!privdata->mp2_ops)
+		return -ENODEV;
 
 	rc = amd_sfh_irq_init(privdata);
 	if (rc) {
-- 
2.36.1

