Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C44CC423
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiCCRki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiCCRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F31A01A06D9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646329187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZQctFjnLH/g6bQ03AOVIzIbebLoxrEWUq6Eo5y0QFs=;
        b=TUARYq3RNVTdEQzj6VPxykdgnol97czyQQHXgGvbdHHviR44zqRdsOTKqt60HzL1QR8Tqm
        fQ/CEFPfG+oML6gXjhuAhFqk3ddU7RjNv9Qa6UVZpR8bWgFdGtRI4YHwqYeT1dLkd7Afen
        2BH+U4xC6YgLCA0RVxw1kW1G/VLoJLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-1uZJ9gMdMQ-J93JNPBxmtg-1; Thu, 03 Mar 2022 12:39:44 -0500
X-MC-Unique: 1uZJ9gMdMQ-J93JNPBxmtg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A85E1091DA3;
        Thu,  3 Mar 2022 17:39:42 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DCDB804F2;
        Thu,  3 Mar 2022 17:39:41 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Lee Jones <lee.jones@linaro.org>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v7 1/6] drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
Date:   Thu,  3 Mar 2022 12:39:30 -0500
Message-Id: <20220303173935.100622-2-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-1-cmirabil@redhat.com>
References: <20220303173935.100622-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the compatible string for the Sense HAT device to
the list of compatible strings in the simple_mfd_i2c driver so that
it can match against the device and load its children and their drivers.

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/mfd/simple-mfd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 51536691ad9d..f916a9c84563 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -64,6 +64,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "raspberrypi,sensehat" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.31.1

