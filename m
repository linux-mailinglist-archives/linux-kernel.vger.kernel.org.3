Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087EB5AF988
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIGByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:54:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C799857DC;
        Tue,  6 Sep 2022 18:54:09 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1278a61bd57so14119097fac.7;
        Tue, 06 Sep 2022 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jVnY+sAtZdtI73W4NSl8psXjsIOtUOBLLwv7kj5Ujwk=;
        b=L14RaCAezD3gMsc3elJ9RNT52eDx9jL6GVvIYwUl3xHrwJOyfuhRDi3ldGdG8kaFyy
         gq6HYWLxAjGyT0pVGM2BbouuRWDdOPYb87Tu6PKilJVj/cLkFRTjjnhiF/CjtiJmgMlX
         sR704z+/irfukNRdeUezxpzqb+ZZVwXmDDSwsju2WacXjdSjHIhNvH9j57Ar5VcFAdNg
         NQBHgDg7hL2zAkDM4sfPApABSkYm80haEPRmg/ayFlqwEDxtznKSpnDsl/iLfX4mjFzV
         /hzdv87SF5PXw1zqhSy6X9bbTeie04+N8OdcjY9UbGW5BNFzSD5Wb09dt2cj9Qy3D2lC
         4lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jVnY+sAtZdtI73W4NSl8psXjsIOtUOBLLwv7kj5Ujwk=;
        b=YzTykLJ8LIkYINV4gjTEwkvuXqtOpx6kPczeftdWBpyFxMirCCmuwVsD9/TSUcGiKd
         B9nghQvImYw0isRxxMFBfiEIcoWbZkZ3AyzxYgNPVsUSOFS3xokN0zyxkPT9BMJHp5Jc
         k+6F5/5Xerzf4plu2kx1pUOG7DWNNOpEZgOJoKchk5d2rYbQ+zB7NqGorPZwxB5bnfyy
         E/nxqB4KMxaE30Qokm6GYv43TbGv0H+GbEwBbS2K+FDGO/Q/Y9XVEOYMOlnE1gzb2VjB
         eaetKeonM7zE7Iuc66b/IU30v6TDd9aBbXwCm2j/ykx2NMau89B9vQC3ObTgm6M5H5ST
         /LUw==
X-Gm-Message-State: ACgBeo3lj6tF+2IUcEbLizB15MLOI47GY2DvlbfMU8o5S/X4541rvg0X
        ykdcVleq5AtQMOpgiQcu/Tk=
X-Google-Smtp-Source: AA6agR7/yEocoGA24REen/UbCCNPK0yzKLYfRXwS+/3vyBWyh5ZSRVnZi4s9CJtsbUFQczOkmwtwuQ==
X-Received: by 2002:a05:6870:1601:b0:101:5e61:d8ee with SMTP id b1-20020a056870160100b001015e61d8eemr600533oae.244.1662515648090;
        Tue, 06 Sep 2022 18:54:08 -0700 (PDT)
Received: from nuclearis3.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870e24800b0011e4c574dfcsm7951595oac.40.2022.09.06.18.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 18:54:07 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, jdelvare@suse.com,
        dev@aboehler.at, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v2 3/3] hwmon: (tps23861) create unique debugfs directory per device
Date:   Tue,  6 Sep 2022 20:54:05 -0500
Message-Id: <20220907015405.16547-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220907015405.16547-1-mr.nuke.me@gmail.com>
References: <20220907015405.16547-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with more than one tps23861, creating the debugfs directory
for additional devices fails with

    debugfs: Directory 'tps23861' with parent '/' already present!

To resolve this, include the hwmon device name in the directory name.
Since the name is unique, this guarantees that the debugfs directory
is unique.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tps23861.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 019009b71a90..a3d7d6b75a26 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -503,9 +503,17 @@ static int tps23861_port_status_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(tps23861_port_status);
 
-static void tps23861_init_debugfs(struct tps23861_data *data)
+static void tps23861_init_debugfs(struct tps23861_data *data,
+				  struct device *hwmon_dev)
 {
-	data->debugfs_dir = debugfs_create_dir(data->client->name, NULL);
+	const char *debugfs_name;
+
+	debugfs_name = devm_kasprintf(&data->client->dev, GFP_KERNEL, "%s-%s",
+				      data->client->name, dev_name(hwmon_dev));
+	if (!debugfs_name)
+		return;
+
+	data->debugfs_dir = debugfs_create_dir(debugfs_name, NULL);
 
 	debugfs_create_file("port_status",
 			    0400,
@@ -554,7 +562,7 @@ static int tps23861_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
-	tps23861_init_debugfs(data);
+	tps23861_init_debugfs(data, hwmon_dev);
 
 	return 0;
 }
-- 
2.34.3

