Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4435254B0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiFNM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiFNM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:27:56 -0400
X-Greylist: delayed 86441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 05:27:50 PDT
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5220F6B;
        Tue, 14 Jun 2022 05:27:50 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id hl1vc40171s9; Mon, 13 Jun 2022 14:05:52 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=VDpU4D9uUr5JKnbMKELSC
        WTPqu8RUcBIC6AuCDYxWTI=; b=TQzgaQ1Y61H5R4hMdeMiARrszKYxDXoos62Vl
        9k3yX3R3Ur5XM/W/TkKfP6JGMb+9Qjpttdaezb+Cr4GcY4KYbMyQ7ZM/DNAAvOxi
        1scFugbECbaGehxEhok1e1kXjm5jf+HMUtPVGAlPUMW8hJDVv5SuPg3VgU+OHWHY
        EVMHOY=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205520231022-8; Mon, 13 Jun 2022 14:05:52 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:51 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 05/14] iio: document pitch, yaw, roll modifiers
Date:   Mon, 13 Jun 2022 14:05:25 +0200
Message-ID: <20220613120534.36991-6-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613120534.36991-1-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [90.147.26.235]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6873
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220610180234; ri20160318003319; fs20220610211824
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206131205520231022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Introduce ABI documentation for new modifiers used for reporting rotations
expressed as euler angles (i.e. yaw, pitch, roll).

It looks like we have some unit inconsistency along various IIO modifiers:
it seems that incli is in deg, angl is in radians and rot isn't documented,
but at least the adis16209 driver has rot in deg.

Here we use deg (so angl is the only one using radians).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 88d012bbfe79..2f54f26d9e59 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2044,3 +2044,12 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) euler angles readings. Units after
+		application of scale are deg.
-- 
2.17.1

