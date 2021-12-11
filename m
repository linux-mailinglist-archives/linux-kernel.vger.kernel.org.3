Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBE471541
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhLKSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhLKSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:01:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8186BC061A32;
        Sat, 11 Dec 2021 10:01:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so38694339eda.12;
        Sat, 11 Dec 2021 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9R8K3miqhXvXlJiG1vL3PmKdSgpdU9lAqSqAOUQnj4=;
        b=UJl++pAKNsr6zwC/Dgul9gYxsuwQgfJK3m9Pm2f/aVQNey0o/YljEvcwujCDN6UaNd
         Vhh8MDiyDGxqODFXz/OY3m+rLuLq8xWViUh1WOTOakgRVodWMRQNaVIMi4LHEx2XsAKt
         3wdm5z59tmTcR200uIns9026koBIu9F5u435OpHsJ/VaBjTnUtUOVxnSLsUPTAljsk1o
         sC1mvZ9GPLXU+XA/de6EXk1RoRzZZg+BTbupZnYlXvruQfJWHz/8CTpU/0bwU1Wf9c8X
         uAfT4J91jiC0G0ARVqQ44016+StQAsmQpJklpkH4PM8fVOxkxt7zblS0vbS/oB0nxYb4
         yxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9R8K3miqhXvXlJiG1vL3PmKdSgpdU9lAqSqAOUQnj4=;
        b=ylXZki4tsa1/keE11cVZax6R4nP38MJTZfi+rYoH5dK81Ce/zDsZHlprvVpSn6EBZH
         gjkzUkT3yuhcGu34dBEOlB03MMEevU0GufsE3YlCD0bTH4sMbB8iqNn4nWNLO5KfhwYS
         4RKFQgCNeRQoXY5tKyJRKS+fKEUGwFQtgJi87CbldXqGs1CQ8z3ykA9sQ8xpFAkJRVKc
         +KoeRxenEJx/BsgO/MjX/gz86HNqzBuUHKp6I4rg0W4WLgLU43hI9sVocideo8o6bgAh
         XBwIZILpk69rWZku0gMkt60bycvnxNVABB9VCiuiZXu804yul2tlEBiHT8cW7M0PA7HL
         2mSA==
X-Gm-Message-State: AOAM5312qMWeA+Ulzn0tbzV1zJMwqGycm4IADtXpu1RrWwCkGPlGm4Lp
        nl/y565rj8Ja0cFIAN9S5Wzqo5tCvHQ=
X-Google-Smtp-Source: ABdhPJwLz2QoTnF7chmJIKhVWiIPhlsbmR9u8x0g3MTo9PczNHpZEX9oNxOXDfRKQEr2taDO3gEYNA==
X-Received: by 2002:a17:907:7f9e:: with SMTP id qk30mr32405805ejc.313.1639245661439;
        Sat, 11 Dec 2021 10:01:01 -0800 (PST)
Received: from localhost.localdomain ([178.94.9.252])
        by smtp.gmail.com with ESMTPSA id sg17sm3337909ejc.72.2021.12.11.10.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:01:00 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Daniel Gibson <metalcaedes@gmail.com>,
        Michael Altizer <michael@theoddone.net>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (nct6775) add ROG STRIX B550-A/X570-I GAMING
Date:   Sat, 11 Dec 2021 20:00:36 +0200
Message-Id: <20211211180037.367062-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS ROG STRIX B550-A/X570-I GAMING boards have got an nct6775 chip, but
by default there's no use of it because of resource conflict with WMI 
method.

This commit adds "ROG STRIX B550-A GAMING" and "ROG STRIX X570-I GAMING" to
the list of boards that can be monitored using ASUS WMI.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Daniel Gibson <metalcaedes@gmail.com>
Tested-by: Michael Altizer <michael@theoddone.net>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/hwmon/nct6775.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 93dca471972e..e3edb1a72654 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4995,11 +4995,13 @@ static const char * const asus_wmi_boards[] = {
 	"ROG CROSSHAIR VIII FORMULA",
 	"ROG CROSSHAIR VIII HERO",
 	"ROG CROSSHAIR VIII IMPACT",
+	"ROG STRIX B550-A GAMING",
 	"ROG STRIX B550-E GAMING",
 	"ROG STRIX B550-F GAMING",
 	"ROG STRIX B550-F GAMING (WI-FI)",
 	"ROG STRIX B550-I GAMING",
 	"ROG STRIX X570-F GAMING",
+	"ROG STRIX X570-I GAMING",
 	"ROG STRIX Z390-E GAMING",
 	"ROG STRIX Z490-I GAMING",
 	"TUF GAMING B550M-PLUS",

base-commit: c741e49150dbb0c0aebe234389f4aa8b47958fa8
-- 
2.33.0

