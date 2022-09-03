Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0545ABD6F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiICGZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:25:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD625F9B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:25:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so4018610pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=2aBg7pOkFNE7VKGxuLLp1g4emrck3wu0cGWeIb1Nuyg=;
        b=e9NyOGCVOoHERqtP9FWbaLvdnL45HR9KJdZ6n+WU3RMhAAGCvxMOKrV5DdPrftiY0l
         LqXv8VvH95AeYr3F5gCSXsK0PtXb1D4TgvkmgHuvrCNbpGCQXT5GxGpeWi2eYdhGQ4JS
         eLrHIirNkkBnGsWiSi2IoOE1qCNiV+NA1sUjZ2VRbgXQV+Cp9bfbbYxVG5KjRJ/DnBvh
         piCbB2scIySf2FVMPl3/B2gwdWPvrHgeuUa+c1dv9eX/TmmLAp3rm7JU/w+cxyOpH+qi
         gtwWYbC0pcA6dFQGjGVubnIIW2FA75rUDsj4+TRLQfalT9XH8xplhL8d05HpbIzzwFzZ
         JwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2aBg7pOkFNE7VKGxuLLp1g4emrck3wu0cGWeIb1Nuyg=;
        b=6LDLmJ7pLGEizt7rtFg+XT0g+ZqNhQfWhKhH/bhWleYmklG4OJRzD5phoRV4SlWwVS
         7Gd6d1oRys2aLcb/DZyKG4SQ3sgNNMBl3nyUH1Vsk8NgUa5GNGn0kbXL09mulY7wVQrO
         NXE9bPl+hG9t/hREOoOxg+lIEokX16iKbX8fmH34jbTSBjygEppZxxzpbzBJtinEma5r
         jIGGV6n2zutP56p7uYPQspOfI1QIVHMFnsr68tffQAzXLZ8M1p2fZPMh3IqajJxk+KvW
         DveCWhIdR5JdaE0zBaM843w6atlcG/v15EkKiYvXjsWC9iLdQ5zhN9gcA+P0NUbci0cR
         8q2g==
X-Gm-Message-State: ACgBeo0bDO8OzjhVP7mxhZmYhP2mZ22yDivBYownEaJIta6xBKe6OmLn
        aFqGczFXHhCNGqrm/rCvetyYv1QfuuXq3+Y7JhmnSXTlDkM=
X-Google-Smtp-Source: AA6agR6sr4jNEq4k453W+zKpgGKqeDKMhvTASI0vrm279pLGh9U0TKPHnHYlraohiO7CBfX44Uq0dP6PnlIie7lH+UI=
X-Received: by 2002:a17:90a:9f96:b0:1fa:b4fb:6297 with SMTP id
 o22-20020a17090a9f9600b001fab4fb6297mr8578755pjp.80.1662186342139; Fri, 02
 Sep 2022 23:25:42 -0700 (PDT)
MIME-Version: 1.0
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Fri, 2 Sep 2022 23:25:31 -0700
Message-ID: <CAMEuxRrg0nSroVGXwaCM1579Ddb822mY0hkSX5_Kcz1YqF_9sg@mail.gmail.com>
Subject: [PATCH v1] drivers/base/auxiliary: check return value of strrchr()
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhong <floridsleeves@gmail.com>

The return value of strrchr() could be NULL, which will cause invalid
offset in (int)(p - name). So we check it here.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/base/auxiliary.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 8c5e65930617..7ac23be47e1f 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -191,7 +191,8 @@ static int auxiliary_uevent(struct device *dev,
struct kobj_uevent_env *env)

  name = dev_name(dev);
  p = strrchr(name, '.');
-
+ if (!p)
+ return -EINVAL;
  return add_uevent_var(env, "MODALIAS=%s%.*s", AUXILIARY_MODULE_PREFIX,
        (int)(p - name), name);
 }
-- 
2.25.1
