Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF234483785
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiACTYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiACTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:24:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345AC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:24:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u25so18254364edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PIrQPLzzYrXHWeVd5lSUKfGhD6kFJ1ANBJzthJuRKE=;
        b=pFyJ5F3YSvW17gT5flhVS1xG2IuU2rByEkK7eH7gwYLqQ0bFvr7lY1i4UFx5LLAlrw
         PaCkNnGH0ycEtSrz/r3LsWbjDhlAgOIsWz0NzYLF2vzKjO6fXdnNkndkk0iT8qxRHgWP
         akoqUv/ywhrV3DMxJrfN5yXExI8tuoq50JkXcHJIGIKabE5KirestuZMxB2IeRxyHq1Y
         jKb66ks3kgLraKOCYf6qYES/WjSr6WtmH4oIJieWE64zyLHzj4ILmFt3ZqqlA3kcI+3W
         RjRvj+y+okAfwO/B3QpgV/PBZc58/ubi6g5Nzg8UvkKX9e7GL6npCMIL1hTNiQaD7mc/
         Y2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PIrQPLzzYrXHWeVd5lSUKfGhD6kFJ1ANBJzthJuRKE=;
        b=WxYuiXwIt071e8uT04zSq7wqvtXqCNeR/kKYw09ZHIVEl0leEjjhpodW8heDj4/HwE
         G14YRZ3ULU2EPEeYWGFgy0VIEzE6O9et6bRx7ySbEzh+i1qoIOYHUMIIAeO/7auiQopE
         +993MCbodu7r63+CzNMaGv1tKP02Xmpn66vkMzUMzipFBoIR7U0M1oHGvRLHx0h0zHMd
         at9oeHaVXxuJ8xQYeZynlYn5g8/plPeT87nYozVEW/V9cTqNM0W3mNL9zqkEgkKVKHPI
         vPuOOtrldoERupzGOHrE32nd/0pum1FXjcJtb0/uzM4Gu22ctX+qMxHxNxzXDOkK2ink
         19Fw==
X-Gm-Message-State: AOAM531LtsPN5bQMmTXVQT8duAgY5BNC2joVQsPEotbTRmcqVb99K9rn
        G37kMIoG+AC8MbZjHW9MTgc=
X-Google-Smtp-Source: ABdhPJxg1ql5yWvyb5n4pZyLpfjqU2vahADqYrA3AX7cNblIOa5UDox8zogzbYwkDiPywt7lCPtx9A==
X-Received: by 2002:a50:e608:: with SMTP id y8mr45050974edm.39.1641237853525;
        Mon, 03 Jan 2022 11:24:13 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:24:13 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/56] staging: r8188eu: remove dead macro ClearPwrMgt
Date:   Mon,  3 Jan 2022 20:01:55 +0100
Message-Id: <20220103190326.363960-21-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro ClearPwrMgt.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 10f7c2b6e138..c6b9cd37219a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -190,9 +190,6 @@ enum WIFI_REG_DOMAIN {
 
 #define get_pwr_mgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
 
-#define ClearPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_))
-
 #define SetMData(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_)
 
-- 
2.25.1

