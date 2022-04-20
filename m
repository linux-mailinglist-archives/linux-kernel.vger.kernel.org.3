Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3D508AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379499AbiDTO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379523AbiDTOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A9F144744
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650464584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H5xScA/klqo/u2bg+Qb9rc2tvwNY2OP4Zj405m1vetA=;
        b=ifPI8ASZbFljsWeausZUTod3EkVVr2FqLksWj7zNbLHKVWZiSRR9UsmnZQbaXw5UW92v4S
        Z8FSQTkQORwfN6g1gSyqEqSwII/dz54oaQaFQ9amAOtdnBFzgT2METnsRZ6T9JIaITKT+J
        aY0MPvn90EIJuP8uDGSjd9cibD2LqM8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-d77FXXA6NlSe-sOeplm_Mw-1; Wed, 20 Apr 2022 10:23:01 -0400
X-MC-Unique: d77FXXA6NlSe-sOeplm_Mw-1
Received: by mail-qk1-f198.google.com with SMTP id v14-20020a05620a0f0e00b00699f4ea852cso1311483qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5xScA/klqo/u2bg+Qb9rc2tvwNY2OP4Zj405m1vetA=;
        b=jjmeLTBo0qN5BjsGRKdNnvrPkyZ4mhRc/qjWOtpXaeYqLZSuaN+llACzVxncyI1613
         wEBEKKBoQL9OCkYgd9uTN8rVVvhx2VFoFAUXBcOK7+vNGaLTNg1W5G933bzIfpzIIhRD
         EzoQ92sY3u9FaWVn14Vwo7FTBhCEdiofQZtzkoO9yHprWGGc1v4dxLKqlcXQ3mIgeLFJ
         sp9a6BXy//UrWxgXpX5XRvJbrF8oBssLGuaY91yVWXUerCbE+QrMdErE+mi4+oIgQdgD
         qiCm3OB2Tq5JpsxRU0zc3RuuAxHaQCAsJXNueBYIBeuc5UYLMWf93NSm9j2p8hKOOE1p
         U7aQ==
X-Gm-Message-State: AOAM533E6n4RvtID66RVkmI4ElDadNScD1xEbhT2OH08K2+y064mW6pr
        i/QIQSap0xIm2G2k9E2TtTc6IY2G4zJCX7PPrkAKxikAGZE+o52nq+UGW4XQOtA1vmBEA/1HSJQ
        Ta3tzHFdhFgMfNV+c1uZOOFMv
X-Received: by 2002:a05:620a:46a9:b0:69e:dbf1:8200 with SMTP id bq41-20020a05620a46a900b0069edbf18200mr1414625qkb.670.1650464579366;
        Wed, 20 Apr 2022 07:22:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPnhmx5uMU62htWmb7eF6KV5baHZL/w/x0SphhFaGsOOzt0id4ABiRpToBMijTlalYfJhhLQ==
X-Received: by 2002:a05:620a:46a9:b0:69e:dbf1:8200 with SMTP id bq41-20020a05620a46a900b0069edbf18200mr1414611qkb.670.1650464579164;
        Wed, 20 Apr 2022 07:22:59 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002f2017d5652sm1788170qtw.40.2022.04.20.07.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:22:58 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     basavaraj.natikar@amd.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, nehal-bakulchandra.shah@amd.com,
        Shyam-sundar.S-k@amd.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] HID: amd_sfh: change global variables to static
Date:   Wed, 20 Apr 2022 10:22:44 -0400
Message-Id: <20220420142244.556429-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this representative issue
amd_sfh_hid_report_desc.h:182:10: warning: symbol 'gyro3_report_descriptor' was not declared. Should it be static?
Similar issues for comp3_report_descriptor and als_report_descriptor.

Global variables should not be defined in header files.
This only works because amd_sfh_hid_report_desc.h in only included by
amd_sfh_hid_desc.c so change the storage-class specifiers to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index b07dc4bbb858..7a2b4e434e4f 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -179,7 +179,7 @@ static const u8 accel3_report_descriptor[] = {
 0xC0			/* HID end collection */
 };
 
-const u8 gyro3_report_descriptor[] = {
+static const u8 gyro3_report_descriptor[] = {
 0x05, 0x20,		/* Usage page */
 0x09, 0x76,		/* Motion type Gyro3D */
 0xA1, 0x00,		/* HID Collection (Physical) */
@@ -340,7 +340,7 @@ const u8 gyro3_report_descriptor[] = {
 0xC0,			/* HID end collection */
 };
 
-const u8 comp3_report_descriptor[] = {
+static const u8 comp3_report_descriptor[] = {
 0x05, 0x20,		/* Usage page */
 0x09, 0x83,		/* Motion type Orientation compass 3D */
 0xA1, 0x00,		/* HID Collection (Physical) */
@@ -512,7 +512,7 @@ const u8 comp3_report_descriptor[] = {
 0xC0				/* HID end collection */
 };
 
-const u8 als_report_descriptor[] = {
+static const u8 als_report_descriptor[] = {
 0x05, 0x20,	/* HID usage page sensor */
 0x09, 0x41,	/* HID usage sensor type Ambientlight  */
 0xA1, 0x00,	/* HID Collection (Physical) */
-- 
2.27.0

