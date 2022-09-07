Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB675B056C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIGNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiIGNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:38:30 -0400
Received: from es400ra01.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DA91D02;
        Wed,  7 Sep 2022 06:38:13 -0700 (PDT)
Received: from es400ra01.iit.it (127.0.0.1) id h32fbk0171sr; Wed, 7 Sep 2022 15:22:25 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=wjMyCxHogxTJRf4VqZl2M
        9y4tCMxTxgMPNWcNyMdzI8=; b=FIhVJ3VWQLUZYPi6zMYkzX2hceVyMAp0IJ7zJ
        EhQlhpj488sMtWY6XgaD+nwa80yjyqiJ2mrtKWc4JrmL1qkBFLxN1UBZON+zmTDS
        bNOICnB+9WnbqT/ytrA2ZsyfIovaij1Krwv2PjCiuriaVQ3neJoAf4CEYHRhK9n/
        IFOmGc=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra01.iit.it ([172.31.0.241]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322240176971-11; Wed, 07 Sep 2022 15:22:24 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:23 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v7 05/14] iio: document pitch, yaw, roll modifiers
Date:   Wed, 7 Sep 2022 15:21:56 +0200
Message-ID: <20220907132205.28021-6-andrea.merello@iit.it>
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
X-Mlf-UniqueId: o202209071322240176971
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
index cc1fe672580f..f694a3653245 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2077,3 +2077,12 @@ Description:
 		individual channels. If multiple channels are enabled in a scan,
 		then the sampling_frequency of the scan may be computed from the
 		per channel sampling frequencies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) euler angles readings. Units after
+		application of scale are deg.
-- 
2.17.1

