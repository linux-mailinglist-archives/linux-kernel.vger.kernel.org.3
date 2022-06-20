Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B256655188D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiFTMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbiFTMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:12:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030C19000
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:12:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f39so1307849lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uab/2HO4VZKS1xT506icMdtE4fNwoDlTTwoN0m1b7PY=;
        b=ey0kfhCEuOTLZdukxlfLw+Ij23qOFjvay6zcA4VgG0LK9+f5awx4v7C9VlCJHHRmff
         lBc164wfYx7L0R8ofjF1dNEQlPk83qSSTLKt6FjsAEfI+eCETWwTlpTxlynkdIC1vZB4
         39/WCMsqUvT3rdlJ61p6oNURhAyVl9DrD+9qCWslTaYzSuPcqQB/83DmVrZbK1gRFqwB
         eKRTsQHEHHIlLrB9xf47kqMxkllUv7q/ol//3V3b8+E7WR/pavpV7ErnRmxFqd4ckpaS
         rN8cKeNZ4B9vwGTMvgFIggrsb5OJrTvr0+KZLMrNI/ItCGiZqQ0Pq6BshfbiZ5Pn35QQ
         hDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uab/2HO4VZKS1xT506icMdtE4fNwoDlTTwoN0m1b7PY=;
        b=mSx8R8+cYDlO3UgWafIHlxhWCy5PbJmxIK9XSGIKDCWXJBa/cq5QTThzx1tqhtgqDZ
         Dd3DhZIC0nE4iVzru+h3Ea7rD7UHKPUpLDXqAKn9wMLo/ob4WNVMM9djQfhxv4G55pep
         YsXaQhBfQXq/Dt5YolQolSUFJu6HJVsbJEdx+Iq5B44NS7nlqrIweHLevTtX29wOg19N
         o2bcslk7SmI1XCPdQSKry9NLKzKUfSQBJAtrShdZAGI1xUrGvdYNJIlNSfrVIPLEtpru
         DQGvo0FSWdPxO5PzeqARuVB1mDmT0UUevZvEidNaGFMB8vYiNv6IaXPS658/60AJYbTX
         83rw==
X-Gm-Message-State: AJIora9Gh4VCVGv+ihzxuUe+FG80/3Dvd0cbroJpahpm6AazDv9/jp+7
        MWWnhMIU8iaUrQMXKP34AjswQIcEIe2HPA==
X-Google-Smtp-Source: AGRyM1tBYuf4F4p5cA9ECpQSeqMK+UoNTzDgMsHfYvx/ecuvA836+ueq/saRrTHwBRN3ZPPxa7mbCw==
X-Received: by 2002:ac2:442d:0:b0:478:ed89:927f with SMTP id w13-20020ac2442d000000b00478ed89927fmr13898482lfl.545.1655727128462;
        Mon, 20 Jun 2022 05:12:08 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id v13-20020a05651203ad00b00478f3ecd062sm1745074lfp.167.2022.06.20.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:12:07 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, miquel.raynal@bootlin.com, mw@semihalf.com,
        jaz@semihalf.com, upstream@semihalf.com,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] serial: 8250: dw: enable using pdata with ACPI
Date:   Mon, 20 Jun 2022 14:10:46 +0200
Message-Id: <20220620121046.1307412-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ffd381445eac ("serial: 8250: dw: Move the USR register to pdata")
caused NULL-pointer dereference when booting with ACPI by unconditional
usage of the recently added pdata.

In order to fix that and prevent similar issues in future, hook the
default version of this structure in dw8250_acpi_match table.
While at it, sort all entries alphabetically.

Fixes: ffd381445eac ("serial: 8250: dw: Move the USR register to pdata")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changelog v1->v2
* Sort all dw8250_acpi_match entries alphabetically,
* fix commit id in the log,
* Add R-B of Ilpo and Andy


 drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..b1ab088fbe6e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -773,18 +773,18 @@ static const struct of_device_id dw8250_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
 static const struct acpi_device_id dw8250_acpi_match[] = {
-	{ "INT33C4", 0 },
-	{ "INT33C5", 0 },
-	{ "INT3434", 0 },
-	{ "INT3435", 0 },
-	{ "80860F0A", 0 },
-	{ "8086228A", 0 },
-	{ "APMC0D08", 0},
-	{ "AMD0020", 0 },
-	{ "AMDI0020", 0 },
-	{ "AMDI0022", 0 },
-	{ "BRCM2032", 0 },
-	{ "HISI0031", 0 },
+	{ "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
+	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.29.0

