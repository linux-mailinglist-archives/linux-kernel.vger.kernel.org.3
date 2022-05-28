Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092C536E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiE1UHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiE1UHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:07:08 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DDB64D0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:07:07 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-f2a4c51c45so9677494fac.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cSQ+SEIcUBU7rmbSt6IE6Qo8uMpj6YyOcQBfZFc6tEI=;
        b=HTtI75n63FC2j1GPFUsm9wmgurB7pCt72HdWrv4Ou98D/0gUuIkWC0O7zsyk7trgkS
         cp9+vZ+Rq7RIeOaf0YuNFDlCuKwsCs7g7V4IfuDcOMcvwqKblavU9D3qcE6ZcoxzuQNI
         fTPDMzKcDXnUz+lNvZ4piOLbLKE6AnKMJXR0namKFnIbW4GFxvmEKGjtYlzI0y5ki3Z/
         MwDC+IY2uk8M5iBHHeXEaKjuG9F2WeJT9cBnlzCWwyeLFQsvOYw9if/ECwj3PML/H4w9
         iTcwcPYXRuKskcAWB/1qUSufQ8FHG+qXEQ7uWymQVGKwLvLw3FznggxaZnUI1Ty0jiM8
         gFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cSQ+SEIcUBU7rmbSt6IE6Qo8uMpj6YyOcQBfZFc6tEI=;
        b=Ab1YhOViWHCjzK/18IP0AbLSyKlm926bhtaalcrL7xBb56Sm3re1w5Z3npy0zXpvbw
         JjEjo1LHG2Hw8leOBvYOIEiKWZU8BpQKb4GqwtekN67Jw2bFngUG+oT7QWGFn5hVcyZb
         iP7/mSd0QmKwprL3fDi5l3PmTDG6ygm1v2rA77ApDK/eznqU+pOw+2NhS3n6EjLf+G6Q
         o6ywhEU/7Gz3BDf7mTz/rQGjhrdN91jbyAW6dLcHmw6EWopTDuWfylb42xpMs8bUrras
         wSR6OxPyoZWhzboJF5djAlsIyQovb8KN5bqD2WLN/FKQZdbXGQEB0xwCOSpfrc16IeK1
         szbw==
X-Gm-Message-State: AOAM533shvBrSVkR91rt12T5IdvnhfKyA41le8piOxh2Qoa/gdQhCHew
        IuMEciuOkhfygWx81iLMy/f1Z43uqow=
X-Google-Smtp-Source: ABdhPJz+gfi+44qFhPYHIYPi514clhxCyr/rtiFRgbbUwZhDD6ElQxBI1g7frEeJ63eA8VLxXQ8ajQ==
X-Received: by 2002:a05:6870:d203:b0:f2:3e9f:283a with SMTP id g3-20020a056870d20300b000f23e9f283amr7246809oac.105.1653768426478;
        Sat, 28 May 2022 13:07:06 -0700 (PDT)
Received: from geday ([2804:7f2:8006:5ec0:8108:8ab5:1f16:73fe])
        by smtp.gmail.com with ESMTPSA id o25-20020a9d7199000000b0060affecb2a5sm3194513otj.17.2022.05.28.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 13:07:06 -0700 (PDT)
Date:   Sat, 28 May 2022 17:07:00 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] workqueue: missing NOT while checking if Workqueue is offline
Message-ID: <YpKA5Bdk1Cm6KgKU@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is a one-character patch but very important as the kernel workqueue
__cancel_work_timer will cancel active work without the NOT operator
added.

During early boot wq_online is false so with the NOT added it will evaluate
to true. Conversely, after boot is done, workqueue is now true and we want
it to evaluate to false because otherwise it will cancel important work.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

--- workqueue.c	2022-05-28 16:54:12.024176123 -0300
+++ workqueue.c	2022-05-28 16:54:37.698176135 -0300
@@ -3158,7 +3158,7 @@ static bool __cancel_work_timer(struct w
 	 * This allows canceling during early boot.  We know that @work
 	 * isn't executing.
 	 */
-	if (wq_online)
+	if (!wq_online)
 		__flush_work(work, true);
 
 	clear_work_data(work);
