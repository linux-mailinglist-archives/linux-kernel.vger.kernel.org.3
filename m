Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72959AF87
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiHTSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiHTSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171331ECA
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y13so14212233ejp.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ASeCfCa+tsT6FZmVxdA2dZywHETG+qUcSgANszr5T+c=;
        b=ItXLh/FKjWL3zvhF3x5irPSa03abQC7PAZVqmbYfXX/Hr/sEb3kthYuOWyVf3e0mna
         hDiJOUE3kWfza8aeZxhJ7p5mf9UyFpD0VPqQYZq/g6QG3ArIWwHrYzn5JNwXFsw1Ya8X
         pYY3bjUXbV240mYrRVplrSMdVl0dub9q+PyUTo6kPCDyqDARma05xsJXGyPmBowlR4u0
         NS7oz5izMD/q2vdp7+4Ho4c/EFQIxVeezxJktG7SnujSf0hIIUfXEMWeZJZw2AIIYYZc
         dYssj66iZbkJE5xauj8dfg30M+EBXEbt7kjaWkpYczFHkiCgji4QCLBPo+CcvtI1lR6Z
         C2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ASeCfCa+tsT6FZmVxdA2dZywHETG+qUcSgANszr5T+c=;
        b=ChyK4P9xgkNU+xK0cVpt1f8R65XiM6qyKDlgQzcWRy6KddyYXTJaVJIIO2shbnz/23
         FnJNMF4NNBMwkKbN4extBa4g8io2tIDPO4oGJrJY1tAsJqTsyTsyd0ATItSjmJGLICnT
         elbqTTqjRnB1qdfI+oKS6ME+uVQS/nUhcW+V0EcV5j3lHleDO6bpK8bj1LMGwfcrv2YB
         OBX3lQy8eXojdCqh3Iy4+Gbvt2LTvxwSLnnlTvmE7G1BKNN38d7Y+ne3ujTqoiAB7Dw5
         rjLcDQumjMsYS9BHrq+MQ1/lpnQOGvNlQ8yWharqRj/wEJOiN74Bp+2SWXqGzkYkY5O1
         ssmw==
X-Gm-Message-State: ACgBeo1dB6tuvU/s7HNHIYfYVxT4ROIOMVosHaxys9iqRKsV0TJ/WX5B
        YO8bgO4IUYTPHCyY2dj0BrQ=
X-Google-Smtp-Source: AA6agR5S7xcNBdgyJebBooKqOm7QPNQNFF8xIBP1835Xq8l8ipZmklfEefRcIk2Ag1J8VPjicvNBsg==
X-Received: by 2002:a17:906:b2d4:b0:731:4594:8ba1 with SMTP id cf20-20020a170906b2d400b0073145948ba1mr8461682ejb.288.1661019408032;
        Sat, 20 Aug 2022 11:16:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/19] staging: r8188eu: rename rtw_os_pkt_complete()
Date:   Sat, 20 Aug 2022 20:16:21 +0200
Message-Id: <20220820181623.12497-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_os_pkt_complete() was moved from the os_dep
directory. It looks like the driver was originaly written to support
different operating systems. Obviously we do not need an extra 'os'
in the function name that indicates that the function is operating
system specific. Rename it to rtw_pkt_complete().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index c324dada4f5b..f8d6f458b83e 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -229,7 +229,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	return res;
 }
 
-static void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
+static void rtw_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 {
 	u16 queue;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -250,7 +250,7 @@ static void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 void rtw_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe)
 {
 	if (pxframe->pkt)
-		rtw_os_pkt_complete(padapter, pxframe->pkt);
+		rtw_pkt_complete(padapter, pxframe->pkt);
 	pxframe->pkt = NULL;
 }
 
@@ -1376,7 +1376,7 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	spin_unlock_bh(&pfree_xmit_queue->lock);
 
 	if (pndis_pkt)
-		rtw_os_pkt_complete(padapter, pndis_pkt);
+		rtw_pkt_complete(padapter, pndis_pkt);
 
 exit:
 
-- 
2.37.2

