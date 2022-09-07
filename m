Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3785B054C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiIGNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIGNhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:37:37 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56C8A1F2;
        Wed,  7 Sep 2022 06:37:31 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id h32f9i0171sv; Wed, 7 Sep 2022 15:22:23 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=OqaZw7zjlXrQeq7ikHAPb
        zoTS/Lgjf6PPIgnfweh7ZE=; b=i2pXBO22g5+yLi6lYlfcKDHZ4ZhGPOUeasjTd
        2m36Dl6TDeVNyDjOEDDK04wXkvi10xEE/lqVnVqoRv+h8Ed4bRi/CftIH3exbfUz
        qv9AEjmLgOyn69dKsUSlscCgNrjEMnPoGTu3KBI1kgljDkcw20ar4GERpYfLFrvN
        byMoZg=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322230212547-8; Wed, 07 Sep 2022 15:22:23 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:22 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v7 04/14] iio: add modifers for pitch, yaw, roll
Date:   Wed, 7 Sep 2022 15:21:55 +0200
Message-ID: <20220907132205.28021-5-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907132205.28021-1-andrea.merello@iit.it>
References: <20220907132205.28021-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.20.64]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6948
X-Mlf-Rules-Version: s20220810181453; ds20200715013501;
        di20220831211829; ri20160318003319; fs20220901203539
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202209071322230212547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add modifiers for reporting rotations as euler angles (i.e. yaw, pitch and
roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 37f7e231fce2..9e661efb6f47 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -137,6 +137,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 0993f6b697fc..4853701ba70d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -98,6 +98,9 @@ enum iio_modifier {
 	IIO_MOD_LINEAR_X,
 	IIO_MOD_LINEAR_Y,
 	IIO_MOD_LINEAR_Z,
+	IIO_MOD_PITCH,
+	IIO_MOD_YAW,
+	IIO_MOD_ROLL,
 };
 
 enum iio_event_type {
-- 
2.17.1

