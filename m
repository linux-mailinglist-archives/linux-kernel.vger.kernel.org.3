Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C3F54B0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiFNM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFNM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:27:56 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5721255;
        Tue, 14 Jun 2022 05:27:50 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id hl1vc40171s9; Mon, 13 Jun 2022 14:05:51 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=K9Fy5fKWro7reHKbWmYSX
        6nrk2Ev6jsAgQyCS4B798k=; b=AwuORbjUpwxMupWXdoakQvUIYhT6LPu/ZP2td
        czffxOGgzZ4SfE9ZGtfsezgMvUK9YLxfWi426EP9rmNlbQbRqdgeLOnW0LrXtNg8
        sXMgoKLewhhSs2C0U5dYucOALAW4vOHOaSW3GR62bS580ebGtSipoa5AOBIeH7sA
        Xeupp8=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205510231021-8; Mon, 13 Jun 2022 14:05:51 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:50 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 03/14] iio: event_monitor: add linear acceleration modifiers
Date:   Mon, 13 Jun 2022 14:05:23 +0200
Message-ID: <20220613120534.36991-4-andrea.merello@iit.it>
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
X-Mlf-UniqueId: o202206131205510231021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Following the introduction of IIO linear acceleration modifiers, update the
event_monitor tool accordingly.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2f4581658859..1fee44abb836 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -122,6 +122,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_LINEAR_X] = "linear_x",
+	[IIO_MOD_LINEAR_Y] = "linear_y",
+	[IIO_MOD_LINEAR_Z] = "linear_z",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

