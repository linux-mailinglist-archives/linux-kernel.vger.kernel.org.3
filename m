Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5C4C9C40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiCBDnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCBDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:43:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADD6379
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:42:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t14so536638pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 19:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
        b=6X/CY4lNepwwVJNUDyNOonW19GKWf+tC3IyggXv/pky/jIaRmNZDBA1oKtPdr5LooP
         NGKqfG9ER+nV+6wWmuaG6ySWeo7M5knP7WrIGGd2gx14VY+Iaxk5v9+l8E5qM0DdoUp0
         vfj1L9gkh9aiHq/N7YF85pE3JixdLvTgg3U7I2H2OE1y13flWwd7HQPns9rC0ThP53Yc
         f8wpusgP0LijX6NczuERy/uccnIF3GYvAK2g4bYqfI7ckZYnu3OXNGw07ag8YRp6UJVX
         8V4QZli5H4TukHaZfnaVDOau/z8mzd6q2iEarVdi9tbpMEqHOlT+0VfLWl0pLw8oMqB6
         0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
        b=acFY68Y1UouLtx9Dxcm/nIwygVKjQvOopP3G7GjlAkDkpjh4ODHDwUL0Os4Prg+NbS
         +bCOXl0hOHYub7i0vB6DMCU7tXarMaVekww63Nj91vUg3wEExUF/9wS1OOFZXaPZ6q3s
         3IbIKOVku/TyTdY5MyzgGuNNzrNm5mNpLq+2gl6HkbiZc4wjWufiSSxiN5nWR21DY4iY
         WL5Kan0wfH1DAqPvcgp2+EHGdyvHMgQAQNmtGqHE1PMowApbxrFoekd41i3AQjSHBgz0
         tK6ExsDz6ZoT+tKJYIrjJwio18EvT6UzfFfbZotF5cZykwrV5tDTkz583mItjCCKb6zD
         xEXg==
X-Gm-Message-State: AOAM532laACLhZ40yP9iJid++CpDGCTH7dQ26/pVJeuBeXmOt6uVcjdH
        Aqry1ijpB6bVmR1RtYDu9MT/Gw==
X-Google-Smtp-Source: ABdhPJwl5Q2jW1szWOQogqphganVUFqOGKeFGAU8EWWsKPkzsqFsqV0VASjPli3B/Buj3saDZ2lEow==
X-Received: by 2002:a63:eb0c:0:b0:373:334d:c32f with SMTP id t12-20020a63eb0c000000b00373334dc32fmr24326767pgh.358.1646192544523;
        Tue, 01 Mar 2022 19:42:24 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id gz13-20020a17090b0ecd00b001bc5defa657sm3358585pjb.11.2022.03.01.19.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 19:42:23 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 1/4] virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
Date:   Wed,  2 Mar 2022 11:39:14 +0800
Message-Id: <20220302033917.1295334-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base on the lastest virtio crypto spec, define VIRTIO_CRYPTO_NOSPC.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index a03932f10565..1166a49084b0 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -408,6 +408,7 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-- 
2.20.1

