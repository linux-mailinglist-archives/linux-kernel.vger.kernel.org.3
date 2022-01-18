Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1449209B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiARHyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiARHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:53:59 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE33C061574;
        Mon, 17 Jan 2022 23:53:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a21so7489183qkn.0;
        Mon, 17 Jan 2022 23:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/V4lEbBAcAR5fcQnG+RzysQfpcULUErJrgq8Kr91tTU=;
        b=ccheU2FUDwLcpBtRyNrmmvkUs4y7FotKRe9a7x7iUDPgBWDgRefvbweJo7wj+R6n/R
         maMNa1K3bLde/Qh45jY/Y+fLaI4Tu27ykvAJd9nSsiXRSmVBjEOEHkqwsKsf/p6SCvNl
         cdper/q1jWZME059w6hzCxeNvIO84g+E2mYDs3w2VmpHJzHlFHpSWIlpfaNmhth8IJUZ
         LFOD83gKmW5zPHNfAXU9XuISj0J+W88azOchCHiQkKyZJMZd0MaC1cBgI7FhQ2NCawFi
         GWGneV9FpQ2T9J+4kziCF+YZRxyCW8hMEQtZB2bGrRmg3k8PhlzMwy++iniiEanL6rX9
         KJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/V4lEbBAcAR5fcQnG+RzysQfpcULUErJrgq8Kr91tTU=;
        b=fPCIMcqa6CcyiGnti6K9Q048wdXZgcuQ4xcn0eHiW/s1XBn00MfliuFSXxQIgDcPzL
         Ee43JhoMp5z9WhN/WNJuFNcVszGop2d6XS53a5eK6I47lBqtpU+EWXNkAVFRyBIvYwAj
         DAGq62lc99L77u+nVNkywxGaRvs1GWD/Rkg0K7z5CxrCdKUEszbINsznj4mG9+xnbjuk
         ErlTWKU58/7TZ5RKFyBLixDybhOD7Ox1DunKmauvHso0v2uqi+eaH6ZDLjN9I+o47Eb6
         3DgZYq58roTHUZ9AsTIOkQJnpC60d+XoComhuOgDXxObfb9nOPaKLbvi5itTK/3Mu4Fz
         n9Vw==
X-Gm-Message-State: AOAM530+o0l/KOGQ12M6lkkQqpnNo4vS3EQ3V6gMNPaMVYpjbPmRHVR/
        OnBCopCTxWsNlZLv7pKfoAw=
X-Google-Smtp-Source: ABdhPJygc9nU+a9M/8q+xjg0xzBBWJ8Yu7wn0GtZIzk+qIwIWWPC20lenQEWcQ+HFb8Cxpk/vhEDmQ==
X-Received: by 2002:a05:620a:2847:: with SMTP id h7mr16220431qkp.295.1642492438478;
        Mon, 17 Jan 2022 23:53:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w63sm9673311qkd.88.2022.01.17.23.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:53:58 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     keescook@chromium.org
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/acpi/apei/erst: remove unneeded rc variable
Date:   Tue, 18 Jan 2022 07:53:49 +0000
Message-Id: <20220118075349.925694-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from erst_get_record_id_begin() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/acpi/apei/erst.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 242f3c2d5533..d9cf07b2a90b 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -952,14 +952,10 @@ static int reader_pos;
 
 static int erst_open_pstore(struct pstore_info *psi)
 {
-	int rc;
-
 	if (erst_disable)
 		return -ENODEV;
 
-	rc = erst_get_record_id_begin(&reader_pos);
-
-	return rc;
+	return erst_get_record_id_begin(&reader_pos);
 }
 
 static int erst_close_pstore(struct pstore_info *psi)
-- 
2.25.1

