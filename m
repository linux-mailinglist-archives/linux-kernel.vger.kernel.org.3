Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA94875A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbiAGKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346708AbiAGKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2679C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z9so20372264edm.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pSW3hRcrV+Z6wh6HvDd1CC/dQnx1u7CDbyFU+eKxg8=;
        b=cG8EPtNJR3zq9Q5ac5occ4Sj0VhjDWietYW0eAveMd9pcTiOiLLyVdusPifc7lfSGK
         pMksCycMoebv/254W4Hmc7QGNxDAZhZBw6NFjr85VpmliTkr+hzy3cAciFDmQClneJhB
         hVdmIJSalshJTe7+OpsMHJEmzQn1ua0UUvQYfwCWk7x+agkvIsaUfhq1ZEJOZ3DjmpwS
         Y6cVDboQRw+1nBrwBTWufAWu0t5vfzfniz+ROLRM7kazRW7IL74zR6Tha3R5sHaap/iZ
         fad89LrfUqEUups957JHSOI2ohQe1WCTuBGVYSGeDBQ/+dr7/0fybkVsnIyQrtJPTtaC
         xaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pSW3hRcrV+Z6wh6HvDd1CC/dQnx1u7CDbyFU+eKxg8=;
        b=384mgg5awhdv7F6/fjImWQxlZjtfTS6aMEEIAF2ZUkitpcHfhm/DYUmR9+5Fub0lML
         5btohFDr9aCm5n86iUycEtcsBTmcHwakNwophVd5PbQi8EuepTiL6hRV+KyhrD/1POCP
         9Arsihvna7svYqv0XGjBa2HWu1KvwmDWrm1CVGYm3BTakKZyOS3iraLGB21TrLdMawHt
         4RV3uMkVpdsXT58sVMTlyp6TgqDWGbWslZxc8A33B4PfVMEBsYo3SFfs7STrRoNmbqwp
         EdjA2xYBnSGoaR59dkFhkce+yXzmWb6LFyBQJ97Pd1HdtI2MjKTRyL18kGQmDf7WgUa2
         Mm3Q==
X-Gm-Message-State: AOAM533iTDJJMnkYSxNrsr6tSgd0AMc3bgYSZEIZUQPBZG4QDHCT57ke
        8qcZpcAYujcClKZrMa59MX4=
X-Google-Smtp-Source: ABdhPJysidbNQdigLEzlx5bk5+x0+6fMl9r6hSyG/83UMW5DDTXR5S12lPkmbu/PfQGyRVNOSv+8ZQ==
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr62340897edb.177.1641551790607;
        Fri, 07 Jan 2022 02:36:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:30 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/19] staging: r8188eu: release_firmware is not called if allocation fails
Date:   Fri,  7 Jan 2022 11:36:04 +0100
Message-Id: <20220107103620.15648-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function load_firmware() release_firmware() is not called if the
allocation of pFirmware->szFwBuffer fails or if fw->size is greater
than FW_8188E_SIZE.

Move the call to release_firmware() to the exit label at the end of
the function to fix this.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index dc41682fd8d6..cfafbb6c42f7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -538,10 +538,10 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 	}
 	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
 	pFirmware->ulFwLength = fw->size;
-	release_firmware(fw);
 	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", pFirmware->ulFwLength);
 
 Exit:
+	release_firmware(fw);
 	return rtStatus;
 }
 
-- 
2.34.1

