Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2934EAB74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiC2KkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiC2Kjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:39:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F23151F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h4so12400083edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeYLey+K7jnrJjLXpJq4vuRTho2PLYRKv2z0lAK2TlM=;
        b=KKPUj2Qex5+/EasmmIfkwgmWYeCayDcWgB7zvVAVk+GrA8sqbVwMB/5UPpISy4LTkZ
         8ZXQkqT+D0/nnIfu8bxuJvzKDd26LLhLMnoXwM5xulk60HptX7kp3h3nRQaS1JLXQ3Yw
         kKuKeQkV2A0+TrM5laPRK22AHk1EeFq1kvZLqZMR542V7t1bck/qdC4+YPpKFxyzEueC
         dXUC2Hl/DDL1NqdiAkgQ233cz1zFIwuAdgoxIyFzLw4EsCRkaVwAgEgJLlgyf4m4aSoe
         pmWhhmZFfba6cDSpGwAMogelbI8Rt4QckEXJTfyg4JrT/5yqkRdND4v9K8haf8NGWwfM
         vneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeYLey+K7jnrJjLXpJq4vuRTho2PLYRKv2z0lAK2TlM=;
        b=Kgbb97PVSzoN0I/eNXaTtFptIkcNW72SrcuDaVlUl2snGkqbc9CpUu+pmoP6sAQ0VC
         WNaKANxpU88uX3N8r1WQ4/4ihQKzQie6tfmSdMkNqaeZfBp6zI6uffGfKw3kPmxj+Llq
         P+ufz59tdFuvm5+z6bN/5Z0eUlkXnTuEWz6Lrdyi7iiIYQIy5Q3q3DRV3KOtzoOgxUqw
         6KPpLUne6IUbAGF0a1ylfY/+V6H3ZOeTcbKfxRRkt15CDsQaqZD3/VdXZ5J5VHcR1qZJ
         ZXdisOuvfej3wXCYNJ4u+MPHz1mrcb9DkkZ8Z0n8qeT2V5oQf/rknIEKBNNshWWLGJB1
         Nn+A==
X-Gm-Message-State: AOAM532CsarakzYZaZRVwosM3dt8gaERBP4cTJfqS/pQKU5abJ3M2ZXv
        9r4xxzDnmsOupbqd/1paMYw=
X-Google-Smtp-Source: ABdhPJzfvZ2a4hk9t2SroRmjvkPR/HE3ANBkLeh0MRSS0XuNqK+QDggW6tLP9PgFsG8/ysw9BcVVSA==
X-Received: by 2002:a05:6402:2747:b0:419:4817:ba22 with SMTP id z7-20020a056402274700b004194817ba22mr3575366edd.253.1648550289542;
        Tue, 29 Mar 2022 03:38:09 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006e03017d60csm7058151ejc.54.2022.03.29.03.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:38:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: convert rtw_inc_and_chk_continual_urb_error() to bool
Date:   Tue, 29 Mar 2022 12:37:56 +0200
Message-Id: <20220329103756.6740-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329103756.6740-1-straube.linux@gmail.com>
References: <20220329103756.6740-1-straube.linux@gmail.com>
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

Function rtw_inc_and_chk_continual_urb_error() returns boolean values.
Change its return type from int to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 5ee1c8c7940d..ddc46cb44358 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -25,7 +25,7 @@
  * @return true:
  * @return false:
  */
-static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
+static inline bool rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 {
 	int value = atomic_inc_return(&dvobj->continual_urb_error);
 
-- 
2.35.1

