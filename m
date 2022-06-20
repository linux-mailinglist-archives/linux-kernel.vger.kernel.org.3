Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2471551374
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiFTIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiFTIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77290B1F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tK/eeW1pWNOA//wEcdfUutwvJ2rc5cXMd97zpjA0M+4=;
        b=a+3zTTr6MTrKJoD1H4I4OxqVShpSV1uz+MNbNIrfSrvjjmsBuGPU+hM47RX+7af8U3VIUc
        5mqlQZJ6nPoBVQcgUG45hN/blWoT6w2fV4gB6eRyPt08rcYzmzkbnFWzMe5h4h6fCJ/CGX
        biwI17IPF85NDOvDnkrb4W//HKAJjlM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-_ftH40seO0WtuyAGUR1exA-1; Mon, 20 Jun 2022 04:54:39 -0400
X-MC-Unique: _ftH40seO0WtuyAGUR1exA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A08929ABA38;
        Mon, 20 Jun 2022 08:54:39 +0000 (UTC)
Received: from fedora-t480.redhat.com (unknown [10.67.24.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8DC19D5F;
        Mon, 20 Jun 2022 08:54:33 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v1] staging: r8188eu: an incorrect return value made the function always return fail
Date:   Mon, 20 Jun 2022 16:54:13 +0800
Message-Id: <20220620085413.948265-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since _SUCCESS (1) and _FAIL (0) are used to indicate the status of the
functions. The previous commit 8ae7bf782eacad803f752c83a183393b0a67127b
fixed and prevented dereferencing a NULL pointer through checking the
return pointer. The NULL pointer check work properly but the return
values (-ENOMEM on fail and 0 on success). This work fixed the return
values to make sure the caller function will return the correct status.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2097526
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f4e9f6102539..2f8720db21d9 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -180,10 +180,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
 	res = rtw_alloc_hwxmits(padapter);
-	if (res) {
-		res = _FAIL;
+	if (res == _FAIL)
 		goto exit;
-	}
 
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
@@ -1510,7 +1508,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
 	if (!pxmitpriv->hwxmits)
-		return -ENOMEM;
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1528,7 +1526,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 	} else {
 	}
 
-	return 0;
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
-- 
2.36.1

