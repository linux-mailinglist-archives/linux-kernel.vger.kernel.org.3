Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1036248803F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiAHA4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiAHAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:55:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBDC061746
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:55:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l4so5010766wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhdUIKOelQ4Vu/0/WwUEHpfJsqt6KgCAL5rNAB9ZbGs=;
        b=TtU0vQwj0Aak7+xW4tdgZMK/Cmxp8CTX0PPrt/4LOQEaVjAHULIl5y/S6lsi9kLpxs
         j9X2UC7HVysEzblufozOE3BNziHrAvFKUw3EuCRVpbK7uO67HFO3R+8DJkixLQQ5pE06
         3GErffwIsHmBuaO9CFAbrGRhrgC0KL0zIViMRPXqWiWBxz+h9Q05MKCWTTj8hcMrGO8a
         YQbSwbepEUYHzgAXjVvvaV7rQZPjP7R/mqz1BVXdo4Fx/1wSXRbHu5OFf+q9LWIIW1EL
         dvzgmDFucSHnOxnZYDPtmGQJ8zHmdzutPZEIR3NKZ9iEErblTTZ7tBVvzDrBJIJp9m/a
         B46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhdUIKOelQ4Vu/0/WwUEHpfJsqt6KgCAL5rNAB9ZbGs=;
        b=QfrrFqRTivyYAHXeNBVTCwByfY4b+JUfB4skoskOlAHW3y1cWMn4wYGAlYkUOBRKBT
         5S8b4/Ep+GXQIVJe3LFcBRhd4rC73d4m06pz4iCK+NF4SApfZdEVA5L/bLAld9vxntGN
         82AR1czIIhMVDVWpSWLrO8kOMeou/gLPIO7TqZRlAA9oPqGj7WKRS/PJPEY0/41rE1Cc
         fxLGPis9K7e/guQJbuwgyVYA/TD7tJkwpTKXUXmLNO53xOcFpYfDZ2kSSt/NSx9mQ+0s
         +buMAcYF0L/Kypy4ibZRk3irK7l3VuweQDUlccbd3bsWklVyyyP9lDdKoNyx5+yVjqOq
         FINQ==
X-Gm-Message-State: AOAM532DEM1a/9xxWh08wdJkKX5RAHhjdN/5Vid6HbHcamt2GReZnuMB
        CBU0dGbxm2fhzhzBoNGW2QvxKw==
X-Google-Smtp-Source: ABdhPJw2RJvXCLGS1zbuBReHGXSJ6r9IvYDDMdbpEfZZwDcAuBwkDj4ECkb0zrKe3Xqw7yxIB45VTg==
X-Received: by 2002:a05:600c:3224:: with SMTP id r36mr1434270wmp.13.1641603353556;
        Fri, 07 Jan 2022 16:55:53 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id c18sm238853wrn.81.2022.01.07.16.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:55:53 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: r8188eu: remove DBG_88E call from os_dep/osdep_service.c
Date:   Sat,  8 Jan 2022 00:55:48 +0000
Message-Id: <20220108005550.26264-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108005550.26264-1-phil@philpotter.co.uk>
References: <20220108005550.26264-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the single DBG_88E macro call from os_dep/osdep_service.c, as it
is unreachable anyway. This gets the driver closer to the eventual
removal of DBG_88E itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/osdep_service.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 59bdd0abea7e..7a6fcc96081a 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -236,8 +236,6 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
-	if (0)
-		DBG_88E("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
 	cbuf->read = (cbuf->read + 1) % cbuf->size;
 
-- 
2.33.1

