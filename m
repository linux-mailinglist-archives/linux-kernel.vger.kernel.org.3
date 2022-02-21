Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05E24BEC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiBUVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiBUVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5C12763
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r13so13415827ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nVDTTWQgHFeL3Z4LBBVvYUyauggJWpdgcasV3J7UgOs=;
        b=KBwq2co572wFjFwOjkiuBKxrbk513P2a3q1cyMsPdcrqS6PsiDNt+uVR6I+wUY9hot
         hWnDpvPCMasCAnC/C4Sn7dkUE8h/3WeAxvW66DdxZxW3hJf1xeI/Yf3hECujD/yzPf/y
         jYzr1kIwUpD0qWMJIz55divIHmfuFW8CjoRtFoXoeP/aNIxFxRwezEbTqAyKquTw7XSi
         mOQ9EkWbyqjyGGDv/+QKz55Lr883LLq07zPnR8bKTRy7atB67i40hThv+LPMZQkOU14i
         +J6nQwXaJ0S+FXuAgYO0BMCnzP3roxImoFzPlAfDchd4JI73KUn4hFwqaHU0ZRJCSKnp
         i/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVDTTWQgHFeL3Z4LBBVvYUyauggJWpdgcasV3J7UgOs=;
        b=Rw9IY2n9L6yEOVNteFUglvzYrWirNb9emrSEMJUG5wsAqYiFYbGr2yPyzfU4Csd94T
         0edAXYJQDCWi1AoAEkr01ZNb5opqUaUDD6ACIsgXZibrs6GIM8j49fPSO3p/dqq75P4Q
         N+QJh4yiUgpy8TPPwoQ1Y4KgI+3Joib3fyuw8A9ZjHNGHwKwWvrKj/hAMEi+4qepWFLi
         r4CAzvsy25l5sLpq672XmVb4IHBD9lqb/tHFCKnd17hkpuL+LF6QJ68SOotXdC1s2T9z
         Seg4CdVpjK/ld4pYZpha942F4fDU1D4/xdopIwBP1MfqwA5W6z6B1JGkrjCsVfib+MXb
         lEFw==
X-Gm-Message-State: AOAM531WwyReRxWB5b7He74cw0v1ent8VCVnfjrKl/yItoYM1uCHDJIw
        w3QvvhX/HRqNVYF9Grl41f4=
X-Google-Smtp-Source: ABdhPJzD96yGsJKvfZ8rYVMlWsj0ov6XbqTZOXDzvInq0ZEs5lzhYB+XiB5nQQDuhVo+vKa/sQhAJw==
X-Received: by 2002:a17:907:205a:b0:6cf:ced7:4e73 with SMTP id pg26-20020a170907205a00b006cfced74e73mr17397238ejb.536.1645478725413;
        Mon, 21 Feb 2022 13:25:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id 2sm5631226ejl.2.2022.02.21.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:25:25 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:25:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] staging: vt6656: Remove ftrace-like logging
Message-ID: <084064a5c94aad940600ae62d6c21bb26629cb2c.1645477326.git.philipp.g.hortmann@gmail.com>
References: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning like:
WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Devided patch into two
---
 drivers/staging/vt6656/rxtx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index a31947f2620d..5839b34b2e93 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -58,8 +58,6 @@ static struct vnt_usb_send_context
 	struct vnt_usb_send_context *context = NULL;
 	int ii;
 
-	dev_dbg(&priv->usb->dev, "%s\n", __func__);
-
 	for (ii = 0; ii < priv->num_tx_context; ii++) {
 		if (!priv->tx_context[ii])
 			return NULL;
-- 
2.25.1

