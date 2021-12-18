Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B21479CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhLRUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 15:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhLRUwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 15:52:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8DC061574;
        Sat, 18 Dec 2021 12:52:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id br40so9921377lfb.1;
        Sat, 18 Dec 2021 12:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpWnDkebbYNbsKX740q2/iT+lv5h0q6cn65ZZyjJ7dM=;
        b=PxKKTDENviWUpBiSzpJyrddL33wvxt/6ek9gcO0P1tvUxCmhgP2147ve7O4mJP0Z0j
         WazzwDa7y8NwfpiGEEvOFSug4Dj28pAxGbDgpj2SgfZZqZUzJ4uBt9FH6p9GY6wPMM3H
         rilPjlxYaAT1t7yAgbS8Cw10x8ZTmDefYsk7fnUe1TnPSnfiIL20pQKEmXeJ2RXi3vuH
         NRFRILZODSwfD/9qMd07NLffZPUnyZialRVSxQzdB5I01MBZEeSNKtZPNzYl4K29O0FQ
         OixG2aXqcb/jKSFyeTtTYSLnb0i8g7f6pjwpJVASCbhNT6u/sormVm7n7q02StyRsv37
         99HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpWnDkebbYNbsKX740q2/iT+lv5h0q6cn65ZZyjJ7dM=;
        b=S7TMR03PvDZfRqL+HFrtgfWlQGbZjpmVx606rfKHkHef3Wg+K5BF+zdXoha1FQ14vA
         LPuHxZf9ddHEru8QsbmECEwqpGuB0cQ1x7F1gO8cwr+kL1o5OPKxyMdrF1MeY8P5dWtW
         Y3uLADYbJjwB1d4FR255ARNo/qzDUBPVyDiJilI74rHTnEf0J5YuXPI7lzLKohkEGND0
         Ffp1GxNrk7NX9r2QdwxfpQN4vUQmYJDgArulSM8PGIdVx8vZoxdbugVbKzkMhcQVS1bs
         gHmy5YsTDX2bUqxxOpFDXOOPkndFQMkh/wGvyybyddGOsrXgya7kdpAtu9PjSpf9tdmq
         1Arg==
X-Gm-Message-State: AOAM532yABq/OS9lAIOetuPNeDjN3/dWi39LookS+FWHOEX5/tyD+L1u
        1kCSELozKQzFarW/vZPzmxc=
X-Google-Smtp-Source: ABdhPJyY95oIdrt0mY2/3033r9wtDrC6yoFGTk4gut8zC1Pc15HOq0twSIWTVniJTKrUgiv6t/su5w==
X-Received: by 2002:ac2:58e1:: with SMTP id v1mr8949095lfo.627.1639860741632;
        Sat, 18 Dec 2021 12:52:21 -0800 (PST)
Received: from localhost.localdomain ([94.179.28.1])
        by smtp.gmail.com with ESMTPSA id z3sm1239243lfd.258.2021.12.18.12.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:52:21 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (nct6775) Additional check for ChipID before ASUS WMI usage
Date:   Sat, 18 Dec 2021 22:52:06 +0200
Message-Id: <20211218205206.615865-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WMI monitoring methods can be changed or removed in new ASUS boards
BIOS versions. Such versions return zero instead of a real one as
Chip ID.

Commit adds additional validation for the result of Chip ID call
before enabling access by ASUS WMI methods.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
Changes in v2:
- Drop the continuation line.
---
 drivers/hwmon/nct6775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 57ce8633a725..831d5c8fe8cd 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5038,7 +5038,7 @@ static int __init sensors_nct6775_init(void)
 				   board_name);
 		if (err >= 0) {
 			/* if reading chip id via WMI succeeds, use WMI */
-			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
+			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
 				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
 				access = access_asuswmi;
 			} else {

base-commit: 2585cf9dfaaddf00b069673f27bb3f8530e2039c
-- 
2.34.1

