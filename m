Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E664AFE24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiBIUUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:20:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBIUU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:20:29 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6C4E0385D3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:20:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id ay7so3702039oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLbUj1+WmHsBpRePIsYDuUfH8mf0cZbbbnuejmwzm9M=;
        b=qYk3kQgpb35yf4/lPoDS2vVGGv5guIlpIz/GvFpVTdQFiUDDzSnIOVGIacsyDWIV05
         MGMTDDH+KrGWFyzekXoO0Vx8m6cN2Q/rzm0smw9EY+5hFQJ6kgvt/RQMyDiWru8XhK/R
         nQ80LHUozomMdgUi0V8RbLsKASJl530bP6YZgsTmVu/e31/NWpdAV7XJlY94uYr18QQm
         avbzxDx3yaL3v/6L+1qcCku4cCckaxJ6I5UnohgxhUn5+CgVdEAV7/LvAf9ieSi/+Vsi
         E04P5eekYUG6RPzsDRyNDOMb3Ex+BPkTaQ8erl8jCVwqd2S507T5VsDCAU3GysTkvV2D
         mM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLbUj1+WmHsBpRePIsYDuUfH8mf0cZbbbnuejmwzm9M=;
        b=NHH8tCK32KiXW5jf/CfVi8kdnmkz3i5+ghBKJ0iBma8lgnfc3bpvSUWCpILdefPnIO
         qgZM3toDqN3ZelwcJt9pvglJu5dk8ZACWaFwHHP8RpeNQAtLtRph6jStKG9SNjtbxG40
         EOYR1q50cF2YHWd4pr3yN+vrr1GE7tWpXwkUBry3w9mc9aXJGXNm4uQEXr1KgJqTyCYE
         W1bIGp2AvArZQ9DC24REzrzeYgBdgRf3z+uthxnM/osQUsMqFt4bQsjryJi/nDfpODXq
         veBF7pOaaTeYkNdYdwNZpcK0tGLlSPRFXXjWeqODvwB9NKpAlFwd37WORA0XCNYYAEXX
         MuOw==
X-Gm-Message-State: AOAM531wsUF2FAQxdUDpYnEcXPhUxO1+ZyenoqlbB7qVaU1u+/NJwIQu
        PQQ6L+SlxYTQwy2zMKpX2TQ=
X-Google-Smtp-Source: ABdhPJx4gwWxXgyRsdL7daKlnXfpkyBdayhaoW6BvIlwKsm00olzFU6iKZ/jXm3RnzNCDkjuzyVJRw==
X-Received: by 2002:a05:6808:1890:: with SMTP id bi16mr1701247oib.1.1644438027901;
        Wed, 09 Feb 2022 12:20:27 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:758b:9a0d:6e95:934f])
        by smtp.gmail.com with ESMTPSA id l22sm7104120otj.44.2022.02.09.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:20:27 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Comparisons should place the constant on the right side of the test
Date:   Wed,  9 Feb 2022 17:20:15 -0300
Message-Id: <20220209202015.29156-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c7e8602d2097..a9a5453aa1cc 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -188,7 +188,7 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	cmd_obj->padapter = padapter;
 
 	res = rtw_cmd_filter(pcmdpriv, cmd_obj);
-	if (_FAIL == res) {
+	if (res == _FAIL) {
 		rtw_free_cmd_obj(cmd_obj);
 		goto exit;
 	}
-- 
2.29.0

