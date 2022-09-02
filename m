Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273B5AB547
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiIBPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiIBPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:32:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F9F656E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:15:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso3539566wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ppnIzcD1Lvog5KH9Fyfxjv2BYJnZPxI6mOxm9069x0Q=;
        b=Fvsdo4X7t20LzXiT5gHh6YEPAklYxulIy6hd9e1+71rOqYERWz3mUY8QIpce1YWs5c
         T4GxcW+az/HLD9HYS7mo1WII36FmPQ62/cGEAJtSHd4mhVyFpkXKXjTmAPX2rHvb9Yjl
         Wqc40omyd0iKDDLJkDYsYX1UUrW1NYCPYzx04NkdrKpDmvNTUK+atIJDatnxUJVTIaz3
         R8GCtkFGKGeMd5D+tqYAvs2oChSOTCBt9HUJDvR+iJzpcZFrBlyA72C7ZuMddbEhzxMw
         A8TXhu5Zpw2yscF2sKZ8r07wchn6YlROakTcdPXQ15+/Q4SU9f2bcjlVF3nZWT5YWHjq
         3lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ppnIzcD1Lvog5KH9Fyfxjv2BYJnZPxI6mOxm9069x0Q=;
        b=NNP6ihMXlhC0Ys4SFUia+KwLEpt/puoDwoV4oPb0flCGRl8OHixIWXBDG76mwVOMjC
         Do9DreXh523dEJ+LOtss7Gp66+6jia5QtZrp+X7yZluxd35Uz2ibMYTJ/1iz01VBjOdZ
         OlKx25wJcvDOp9CxKjIDKVqhRqlldlV2hIfr9qZ/gt+XhBbIrRTivpe728BsJOvrFZBM
         RJM4jMcj+SpBMe9HXo77jECIxPhUovaBfDdXHXCABtLabKgvVnYWJrT2ba6HtJ/h7oOq
         L7O0IGFHPo1cGC3paHAX9is99mC0Fx9J3TsgbcEjPBrbsxuxyqVoJwAt+TeKWLY4MHPW
         5+lw==
X-Gm-Message-State: ACgBeo2WiZE9AUq9c0vcAAJeD0nqdkn1hLxxnAWF4pB3yez7v1Ay6aoK
        0xtW6rDwuPm3HMIUQVne1Z1wQA==
X-Google-Smtp-Source: AA6agR7FlLcf18Fay4hYuE/8S7Rn5LcJExIwtFG5sZbJLUHX9IIteBZnXfpei+us/9OKzgyeQZXOyg==
X-Received: by 2002:a05:600c:2311:b0:3a6:84e5:bcad with SMTP id 17-20020a05600c231100b003a684e5bcadmr3239020wmo.72.1662131702350;
        Fri, 02 Sep 2022 08:15:02 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c014a00b003a4efb794d7sm2361493wmm.36.2022.09.02.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:15:01 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ola Jeppsson <ola@snap.com>
Subject: [PATCH 3/3] misc: fastrpc: Fix use-after-free race condition for maps
Date:   Fri,  2 Sep 2022 18:14:23 +0300
Message-Id: <20220902151423.3351414-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902151423.3351414-1-abel.vesa@linaro.org>
References: <20220902151423.3351414-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ola Jeppsson <ola@snap.com>

It is possible that in between calling fastrpc_map_get() until
map->fl->lock is taken in fastrpc_free_map(), another thread can call
fastrpc_map_lookup() and get a reference to a map that is about to be
deleted.

Rewrite fastrpc_map_get() to only increase the reference count of a map
if it's non-zero. Propagate this to callers so they can know if a map is
about to be deleted.

Fixes this warning:
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 5 PID: 10100 at lib/refcount.c:25 refcount_warn_saturate
...
Call trace:
 refcount_warn_saturate
 [fastrpc_map_get inlined]
 [fastrpc_map_lookup inlined]
 fastrpc_map_create
 fastrpc_internal_invoke
 fastrpc_device_ioctl
 __arm64_sys_ioctl
 invoke_syscall

Fixes: c68cfb718c8f9 ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 50c17f5da3a8..58654d394d17 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -332,10 +332,12 @@ static void fastrpc_map_put(struct fastrpc_map *map)
 		kref_put(&map->refcount, fastrpc_free_map);
 }
 
-static void fastrpc_map_get(struct fastrpc_map *map)
+static int fastrpc_map_get(struct fastrpc_map *map)
 {
-	if (map)
-		kref_get(&map->refcount);
+	if (!map)
+		return -ENOENT;
+
+	return kref_get_unless_zero(&map->refcount) ? 0 : -ENOENT;
 }
 
 
-- 
2.34.1

