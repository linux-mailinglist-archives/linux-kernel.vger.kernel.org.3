Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC74C4D3B61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiCIUwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiCIUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:52:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C079D06E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:51:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so4793993pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7ahohIKmaArLsCJPY4+ge/uAdlyV8nk9IujiHAfW4A=;
        b=dmx141/GaSwrAzPKb7RZU3g4+h4hKWDiNc1E0s+U+jcE0N6ksCS04dQ4rlmPxIO/5V
         dhPm7Ko+x7UwH1dbWIS3/MQ4bjp3VSbbLXLcrtlqzK4oDVRS17inl4YICiXfqhtEogkz
         HNyqE8epSgs4VOc7m94SD+Nt5Z355lfRy37SmyRP4vD9NlQ0ydqFOtUpzS9cbPfkfrP5
         2BZs2OagDmRI3Z6UKxlcanEozUTh1NFL5a/ZrUoP+4coOECMJpriRgak2n6dGbyEj8+5
         zl+RcctSjyCRXP4ghxcdqRV2v/KIUSuwk/QyH2JrMf9ZZHAOWmOPnpvD9Kh82Uezbjtr
         JcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7ahohIKmaArLsCJPY4+ge/uAdlyV8nk9IujiHAfW4A=;
        b=oq4w+o8Bl0gDSfESOGxp/4S5E1e9D2INPPhk19NND2/GF1tl/Kwb28FOY4k5yYbP+E
         pVYKa1TpR1WA7WDPEr0eZt1T91fKAAsYGv/QQbI7udg46tskTKUu067qyNOAlILUDNmG
         AbCoFizFsRCZP9SX+VOpmsGWAxmwrqfCuvUmvgnF1X1G0y4VsvlrGYhFOshGxqremOKx
         shxRRX3+qv6dyzm/GuGMMlusdH1KJTGYOTUJT5YtU2Y+5Vtjmw5mp9maK6oVvR3BW3Q1
         MAp2Yv88O5FlSjVep8Zb52I0McM1/i1MEIixFJms9vXJEHoxtPQaWL1o4LcKVRDU23cY
         nECA==
X-Gm-Message-State: AOAM530bSZtrwE+TlUfguGPn5gw8yp14FI1S/kqW0wJnnSyXkWagWn25
        xmiwtTX8ij9h1MyQ6FEVf9s=
X-Google-Smtp-Source: ABdhPJxNHGW2frv7Ctlan/UqdkPA6LgkKpiJhjlVqQ3Iu2VvRAVjHopVA8TeYtmM1J3GzY23ya9lHQ==
X-Received: by 2002:a17:902:f549:b0:151:fd3b:247 with SMTP id h9-20020a170902f54900b00151fd3b0247mr1389320plf.11.1646859065371;
        Wed, 09 Mar 2022 12:51:05 -0800 (PST)
Received: from localhost.localdomain ([103.85.9.4])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7259674pjc.56.2022.03.09.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:51:05 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: call _cancel_timer_ex from _rtw_free_recv_priv
Date:   Thu, 10 Mar 2022 02:20:46 +0530
Message-Id: <20220309205047.45981-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309205047.45981-1-makvihas@gmail.com>
References: <20220309205047.45981-1-makvihas@gmail.com>
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

The _rtw_init_recv_priv() initializes precvpriv->signal_stat_timer and
sets it's timeout interval to 1000 ms. But _rtw_free_recv_priv()
doesn't cancel the timer and we need to explicitly call
_cancel_timer_ex() after we call _rtw_free_recv_priv() to cancel the
timer.
Call _cancel_timer_ex() from inside _rtw_free_recv_priv() as every init
function needs a matching free function.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index d77d98351..61308eb39 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -103,6 +103,7 @@ void _rtw_free_recv_priv(struct recv_priv *precvpriv)
 	vfree(precvpriv->pallocated_frame_buf);
 
 	rtl8188eu_free_recv_priv(padapter);
+	_cancel_timer_ex(&precvpriv->signal_stat_timer);
 }
 
 struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
-- 
2.30.2

