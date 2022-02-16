Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2224B7C39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbiBPBHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiBPBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D2F5419
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n8so279390wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzQCy/MScj+BTuPjhtqug3TSbF4CNKXkcyvV0JhfwZc=;
        b=sqhGtmBlziqPD1tj7I2PX56c4g/RoEL5vCbgrFg0DPE2HaYyd2ZXJf4cBYA5Z5JwbB
         aJ/TOkzkqojw7KiIcvJQOG+XMaWEsbGNufK1XmbBgHt5PjeKj5ZV5gmGY3KqeLoYe8D6
         16f1zrS/OgsoE4cExkWRnyMa3nx7x2HQlyqnGkz/STp5zKu6llAXXUc2OXXbC2wXqj0o
         NOwS27Nw8Xqu8xc73KF7CrCwdEIkgK+hDr2zbpgoeF9TICHmF0h7AL0nhpH/TK6AqBql
         EYvsIrU0BtDGJoQRqyjI7JYPU52ZUbOOa/vwgyPiSwp8A34UAC/iOJwWt9mJLJuVxWLq
         fLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzQCy/MScj+BTuPjhtqug3TSbF4CNKXkcyvV0JhfwZc=;
        b=hTq3oQGrUxDSQHX8K8D2SQ+XU1/OXJbzdvdlkBDS3dOfxVbkjT8hzEPfGDZElflJWH
         1surNzpLjEoHHZwyVy/Ldu3GMFW0OnxH0j7stU+DtCyXsLLGWydqaxU9Mm8JSDVDVzj+
         wx94cY2/UloIl9Xq/IxWCpvK5qUcZGoYz7xE6JAaK6qkvw/ryQ06XLRj2s1Z03hnxLGR
         TVjxq7Vq6v2iXzc0ov2tvdwvUySSUALYPxip2idPg3waknR4UvC9Cyfdepwxrr2ouO+t
         YP8Ybs/Ty6HN9l5YyjW27r3nwZIGEZxn4xCkwljqEU3IQvWK3LKFz8rct9fNiOEnB8oR
         GZvQ==
X-Gm-Message-State: AOAM531c4oTsJvjvBpiI3Ux0F5KZ6QVdulQmnOTuLHPsjofNeKGxw1w7
        cO7S3vbE4+N1R6G/7nEZ8xejpw==
X-Google-Smtp-Source: ABdhPJzDEi7e/QTeHgAKRG/LE4zW9YE81YXknKB2ghGP2WKspBHwBJjp4If9F8ErjFF08+O1ttR22g==
X-Received: by 2002:a7b:cb98:0:b0:37b:dd98:f87c with SMTP id m24-20020a7bcb98000000b0037bdd98f87cmr5092364wmi.59.1644973638069;
        Tue, 15 Feb 2022 17:07:18 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:17 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 08/15] staging: r8188eu: remove remaining DBG_88E call from include/usb_ops.h
Date:   Wed, 16 Feb 2022 01:07:02 +0000
Message-Id: <20220216010709.791-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the one remaining DBG_88E call from include/usb_ops.h. After
some thought, it makes more sense to just entirely strip all of these
calls, so that debugging code in the driver can be more consistent and
useful going forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/usb_ops.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 62e4706c0497..edef3ad1ccd9 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -31,8 +31,6 @@ static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 	int value;
 	value = atomic_inc_return(&dvobj->continual_urb_error);
 	if (value > MAX_CONTINUAL_URB_ERR) {
-		DBG_88E("[dvobj:%p][ERROR] continual_urb_error:%d > %d\n",
-			dvobj, value, MAX_CONTINUAL_URB_ERR);
 		ret = true;
 	}
 	return ret;
-- 
2.34.1

