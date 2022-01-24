Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32BE49A9A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350261AbiAYDZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1321241AbiAYDQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:16:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C275AC058CAF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u15so16382532wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7znmcaDRDi4XBN93/6yXaX6uBsi3TKnQRGE8o8aEMJU=;
        b=6DO4nXHchhCvgjCRpbkrgSp5frcqUELpkRUUQsgnkesj5Wmqc9SuhnN+yGaZlTvbXJ
         IlmQPqnVrAeCOjSEUbNAfMVXlmHM7MHipn7XYaJB2+go68HCCdToD786bdr5uMAJOBz8
         XKD2D6aqSLDPg5VwsDb5k8xartnO5rpZ9ytw3JdRtYdja208Fbifdd+sbYH5c0Y166IG
         /BcvcWK0HlJ523qKCf/iW6Cn62PAFFk/jocuJFJf8QcHg9ZQG4bGeCPcstHeX0ydzs3q
         hdUCH3dP53D2sQG7Sk3HFA9Tk+CM5+Uiw5YzF/VYc1SNUVPBmJyvAnoCme6ULGYxLF1Z
         kF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7znmcaDRDi4XBN93/6yXaX6uBsi3TKnQRGE8o8aEMJU=;
        b=1l48tyPq/I3YWodqYlhgXjlz2lABsj42CkmRYHgGYXWX7P4wkSXembXVYCV2hooW5E
         3c8ZIeEPrQDS+IBh1n0GgmeCkKZdqA88LrWbuT8QSs7zVmldd2sQXgxG8sFgQ7XXIIZn
         c/KVj7XkSjO2at6KIy3WUGT3MHeJ319l/tsDW+NG5NatCt6M5h0EkMlXlKDk5SszLp25
         DvMsUrNNMzlCHBsd5KMvQuphOL2TXYflQNFHuw53Vd/IcflPzBySZGRu6JfOe2D6CEIP
         ctqfWKXvcaObfncP5sKJ9aClLDkvu/BTpHg2+SC5f2oX6Fva8Y50DQoB37wzdzSCv3wO
         fuHQ==
X-Gm-Message-State: AOAM533T6IN1/x+UojuchgtfDjn/aMO3STAz4Dyzq+de3zdzjH3b6FPm
        tJ9WSVy2rb+0vtEl4CL7Thagv8qzzRpjEA==
X-Google-Smtp-Source: ABdhPJyOG+c8hVdoltTy1ChegKNUZg/YNx5nJQ+YtRVp4Be9O4ytvSSxKYeEXuMFzy6I6Un5lsvvaw==
X-Received: by 2002:adf:dec1:: with SMTP id i1mr15005227wrn.69.1643064658384;
        Mon, 24 Jan 2022 14:50:58 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id g189sm624742wme.18.2022.01.24.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:50:57 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 07/10] staging: r8188eu: remove DBG_88E call from include/usb_ops.h
Date:   Mon, 24 Jan 2022 22:50:29 +0000
Message-Id: <20220124225032.860-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124225032.860-1-phil@philpotter.co.uk>
References: <20220124225032.860-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DBG_88E call from include/usb_ops.h, as it does not conform to
kernel coding standards and is superfluous. This will allow the eventual
removal of the DBG_88E macro itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/usb_ops.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 0a1155bbc7b8..2b1d50d2b2f2 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -30,11 +30,8 @@ static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 	int ret = false;
 	int value;
 	value = atomic_inc_return(&dvobj->continual_urb_error);
-	if (value > MAX_CONTINUAL_URB_ERR) {
-		DBG_88E("[dvobj:%p][ERROR] continual_urb_error:%d > %d\n",
-			dvobj, value, MAX_CONTINUAL_URB_ERR);
+	if (value > MAX_CONTINUAL_URB_ERR)
 		ret = true;
-	}
 	return ret;
 }
 
-- 
2.34.1

