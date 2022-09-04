Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DC5AC1EA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 02:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiIDAwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 20:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIDAwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 20:52:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83A4F641
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 17:52:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso8969273pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 17:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=d7TwUMwpKfksv1HmDLzcAuiuddmTauyaNwScYWWTVvI=;
        b=fDIlMBSjhEsohttATFpiCbNFEVXF1RLwhBT46KynGLzv7L6uje7VepxK9c8kVLcxn/
         NxqTu5i6K3U+oOJZHr4K5ns+QSgxrEt/MXqhD8rKzVAZEuaPRSFWEUcdpdjYZkBbvt/i
         zrvzWbLwlVn6PuPVPvzg+qC773e74Lj5+5+yZhAIfolOWlw/xdZqsLr+CBCuMYSI58Op
         Gdnz6KWGJjBKmDvvgeHESxSdr0Sc4Fl9tDW5NFUaTibjX8PACNna1jYQJmVD+zle/E6Y
         NwpvrmrpvARoIccdBU9jqi/QjaEsnY2fqu4X5a8maxl1p/eHgRu9aB3wUKeifvLSi/E/
         U5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=d7TwUMwpKfksv1HmDLzcAuiuddmTauyaNwScYWWTVvI=;
        b=srOvSyFc+xS/OG28Hp7XQMOEDW4MNFKFrl2wrePthSmyNNwHuaZYZ30gl8wGepXhO4
         6DylgOnI461UBbUPBRBYJuWl1Ihp7A8AKJONvg4O4C0z5gBbtYtMl1fUJV03/c2erGkw
         atri3+ai+ujk22trfMLl86UwIOq8FZrWbqX41Oi0vl3UIcDJBW+d9UZ7tj+XwzWUbFhv
         uZjXRVs1E1UOBYR37DflG8SAtHJfUbiXCVbGuphQWygm8L68pHN+MToVnfcx5hlqXZTg
         TYNseLJI6UC+E9ymL6AEhJZfehs5wUz9ZE/kSqflsBrCAl38tK0iu1XNTDXmeI2QkqS1
         m4Og==
X-Gm-Message-State: ACgBeo1+fwXp4hWXwztLe8iOpCmgp5ckocrZuQ7mDgqgSlpbXjn5t5zo
        gPZQGCrBSD29jRmR2NJlqIvjadHLHuHNhg==
X-Google-Smtp-Source: AA6agR5zs3r6yIt05V4BVvU38powQ9tkaos7G76neEpXctq9AYPQ8gTS0zGKZ63DTStFGarWL2WHVg==
X-Received: by 2002:a17:90b:1c01:b0:1f3:2f26:e7b2 with SMTP id oc1-20020a17090b1c0100b001f32f26e7b2mr12563852pjb.111.1662252732010;
        Sat, 03 Sep 2022 17:52:12 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id a19-20020a63cd53000000b0042a3d9a1275sm3778071pgj.16.2022.09.03.17.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 17:52:11 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] drivers/base/auxiliary: check return value of strrchr()
Date:   Sat,  3 Sep 2022 17:51:56 -0700
Message-Id: <20220904005156.2281982-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The return value of strrchr() could be NULL, which will cause invalid
offset in (int)(p - name). So we check it here.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/base/auxiliary.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 8c5e65930617..2ec0306bfba3 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -191,6 +191,8 @@ static int auxiliary_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	name = dev_name(dev);
 	p = strrchr(name, '.');
+	if (!p)
+		return -EINVAL;
 
 	return add_uevent_var(env, "MODALIAS=%s%.*s", AUXILIARY_MODULE_PREFIX,
 			      (int)(p - name), name);
-- 
2.25.1

