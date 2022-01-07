Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E3487E86
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiAGVu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiAGVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E0C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l25so2655782wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ep42MnLkFZlrJ74AAV9uWHzBCOpHXZvB1eY1I6VZcA=;
        b=eiJW1xFSgYimTpYHbuZMyHZkNTPU8Swy4orSrOqottjTnPVlC3u96iSHevzBZ4K6Oy
         80fk7UhPLDPH9VyEeh7+HRiGRTL37Xxs8ZTrTct25l4CdUK+9MKufVQCYDN8vYk2hMAc
         8AiTu4P1gCsv4w55Dj/ZteE2FQ7MTseIDMcEN/Ipjj7paQBnfc6AB5Au0hLnbDhIa61c
         jFRNC5x7mCcy6l2FdhSNgV4YOrokSaQUYTwX0a2qSt9+jeTxAVWgSgTTalr4o3syiYkO
         NpuROKuTlujJevJxqewO08IwI+PsEaE7pT31tazccsIZr2zDGcrEZRB+Nxeqn5ifWgXb
         /h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ep42MnLkFZlrJ74AAV9uWHzBCOpHXZvB1eY1I6VZcA=;
        b=xtIJoACp3i0eBKFb+AOcG7hFNe/G0caxbYXpjmYFeE28D8eWQPjITptY8Tv1trr8cF
         66jpXjR9OtdICgtjbhN2aT8n6dKokHdLt9qtpZ6qGoziS9XBQBsY6C5Zq0BcM2HdSJmD
         8m8AFNFLbFRyPmZl/aIUTOc2P2WRKNuDPNErCjYJSl+4JBf9VRJ5MrqeEXq4tObZ8qSl
         WwWSpnpI9STcpyJhh7AxemoEatKr/Bpi+2QQEDW26rM/qUxA6fEVHmeA7HRXjBQji4fP
         6aS3beu8NtHHY85C/EQyisYMKKKn7KHQOSWsslVfSI8i9ZeQlQcWn+4yXImRlnpueX2M
         J77w==
X-Gm-Message-State: AOAM530tz7Vx63NzuY57axIg4G0rJPmM5gMU9UuZpJaEp6RfyJFTjvqF
        7OEhGmkNAg9+INL6eDQu4Lk=
X-Google-Smtp-Source: ABdhPJzQZNvgEuxGSnAUVjNxYEivHw1oWGioiYTl+nKKA9jiH8QB6Zjdyfw+kt6JOKdvHq7JXFAkKQ==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr2893987wrx.638.1641592248395;
        Fri, 07 Jan 2022 13:50:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: remove HW_VAR_EFUSE_BYTES from GetHwReg8188EU()
Date:   Fri,  7 Jan 2022 22:50:31 +0100
Message-Id: <20220107215033.12257-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215033.12257-1-straube.linux@gmail.com>
References: <20220107215033.12257-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GetHwReg8188EU() is never called with HW_VAR_EFUSE_BYTES. Remove that
case from the function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 33523ca90ee5..c1129c83ebf7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1614,9 +1614,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_EFUSE_BYTES: /*  To get EFUE total used bytes, added by Roger, 2008.12.22. */
-		*((u16 *)(val)) = haldata->EfuseUsedBytes;
-		break;
 	case HW_VAR_APFM_ON_MAC:
 		*val = haldata->bMacPwrCtrlOn;
 		break;
-- 
2.34.1

