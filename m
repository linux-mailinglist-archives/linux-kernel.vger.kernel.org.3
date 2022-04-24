Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0635A50D384
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiDXQey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiDXQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:34:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F16DEB2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s14so21870688plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uy/XTK3cCUSKBVerxj0yPudKYc/tlTQNYmvWtLlsHwk=;
        b=FN38e1a+uNwImTZJFr6s0ukNm7MTnw0jfRRkKU5389Iq3g//kH22kt9l+uTzD1TJ4Q
         JbpNiurLx4MqiuQnGbanx2zkVqdVbzDzeoDDWTLOTAvswMQNNhPd7wI9U7Q48//ay2IU
         hFQSutPaAHXMy3MGZbf42wiQ4XvevJj4pgvuSRxLbTnHeWdraNDobq78L0OsTGBxopoN
         jSZQFwFUrDpT2nSyeKh06iq7GEy5z8CJAZCHbpx6UEJHUjjxQndPVXiiozlLozPI4MS4
         84GjijpD9A5n38Ilq/mv3GwfFll2P7H1kETDPasH3+UC7U4ZnY0qHfAKllg3NIb3/RbH
         sJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uy/XTK3cCUSKBVerxj0yPudKYc/tlTQNYmvWtLlsHwk=;
        b=RYePgZISvx1jMVN3+VGECjBq6NpCIuZ1U/ruZBapn+tHvb+Ae4mwBP2PEBdN56tbag
         OBWt5XzOVWMZF3Rj5WOVt/nMfMQERK5qsHN9DOdf8Q0r9t4fkiJbWiXuLr7IusGQJBjJ
         wJIJEcd//zO3/f8TO3dTLqQ/zP9HfczHDLDEqTz98ZFphSLwrauX+nOAn49kaun1vfMI
         H66xOyqYwrM/aUNql+yyZBpyVrVBd7MRUUb2MJ8uBvdrI7+9xojR62DrygfGQ31MOwFP
         +uo2drRPDo1ozChSynat2NkH1GaP7BtHawbI0jZZvecQOS+XGDZUHg/4gOgPkD8mhP0l
         g/kw==
X-Gm-Message-State: AOAM532gqBXKILsnUcpRhqOAD5d32VmLDLBIZltD50Qz9HVR2y+d/vEs
        S+9QSJLbId/11dQiI/dP+wc=
X-Google-Smtp-Source: ABdhPJxjLZtLdKdipoJGzc5MlN8NUr2IKmZNCK+PBk41Cb+FWPII6DE3H7c1kvaViXRhexs/VJajiQ==
X-Received: by 2002:a17:90a:fd85:b0:1d9:6281:d158 with SMTP id cx5-20020a17090afd8500b001d96281d158mr2832154pjb.187.1650817906822;
        Sun, 24 Apr 2022 09:31:46 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:b82e:45af:4bb0:4014])
        by smtp.gmail.com with ESMTPSA id i5-20020a635845000000b003aaba2d78c2sm7113472pgm.71.2022.04.24.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:31:46 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: fix null check in rtw_free_recvframe
Date:   Sun, 24 Apr 2022 22:01:30 +0530
Message-Id: <20220424163132.37007-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220424163132.37007-1-makvihas@gmail.com>
References: <20220424163132.37007-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a NULL check on padapter in rtw_recv.c:170 which makes no sense as
rtw_recv.c:152 dereferences it unconditionally and it would have already
crashed at this point.
Fix this by moving the dereference line inside the check.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index c1005ddaa..4cf9b4b8f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -154,7 +154,6 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 	if (!precvframe)
 		return _FAIL;
 	padapter = precvframe->adapter;
-	precvpriv = &padapter->recvpriv;
 	if (precvframe->pkt) {
 		dev_kfree_skb_any(precvframe->pkt);/* free skb by driver */
 		precvframe->pkt = NULL;
@@ -169,6 +168,7 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
 
 	if (padapter) {
+		precvpriv = &padapter->recvpriv;
 		if (pfree_recv_queue == &precvpriv->free_recv_queue)
 				precvpriv->free_recvframe_cnt++;
 	}
-- 
2.30.2

