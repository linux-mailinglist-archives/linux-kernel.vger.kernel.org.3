Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015352DE41
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiESUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiESUWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:22:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F625AEFF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:22:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q18so5715542pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikC7s8FLRXJFc1LdsVuepwYga4To/xbr9UiroOMnwlE=;
        b=VMA1UEkrpWsGAEdk+YJdxwzY/cT10CGh42g+oGDMCn73r8d9uau8akVuwvpFL3M3Qc
         ufpJae9aH2VoMOsDMYlCrD1D01xVNnG9Rg9YvBoBCsUDCPyZOTuOSMY+lWvkGmMn3Fax
         kZAr+6BOhrSRSxzUhXafoJbpmXxMM1cRIbqGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikC7s8FLRXJFc1LdsVuepwYga4To/xbr9UiroOMnwlE=;
        b=w6/NQvDCGMeZOOiDStAuIc03xC/JnA8wIwlpfJdhKq88llYeDFpxCO39p8GhMOydn3
         hwi1ZIIVUlcanKpe1Pj5YwU+dW7BlT2dGC/pL63cmJWA93YL4nDJbAAEUJqueRvWHuDV
         zFcpRjK+/vkqlOQdwtARZk9Cp58kXsBzso12PVwPv7Kf8SxVqkbQy16J4Qjainv7gnYx
         H/AcgFvMbOHXwPVBWXMpfdh98h1+kS73e95+WffZfD2rlESdxnvP6KYPIJoKQe4uPAcP
         K5Bn87tzSZ0euM3u4Us+0O5vjX0sSE6yPDTQFHbhnWF5zfIHWKEuzSqmhS5uhbUTYzcW
         +vBg==
X-Gm-Message-State: AOAM531eXJjn0gKbcJlfNL3wR5agMAi6MdZtf0hRZjrmkZ1B6ZZKyDvT
        qUebeIlut5NYCTfJsHICl3kPSH7jeoB3FA==
X-Google-Smtp-Source: ABdhPJyuyroQFkEHApH6ZtW60SRNeIl8ztFC4B7AmueG52xlJk1NKqOhR79ConbdqjJv+VwA2GdlHA==
X-Received: by 2002:a17:902:9308:b0:15f:12dc:7c7c with SMTP id bc8-20020a170902930800b0015f12dc7c7cmr6297934plb.141.1652991722924;
        Thu, 19 May 2022 13:22:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:8377:9713:b193:7dde])
        by smtp.gmail.com with ESMTPSA id ru13-20020a17090b2bcd00b001df4a0e9357sm243395pjb.12.2022.05.19.13.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:22:02 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] debugobjects: Print object pointer in debug_print_object()
Date:   Thu, 19 May 2022 13:22:01 -0700
Message-Id: <20220519202201.2348343-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delayed kobject debugging (CONFIG_DEBUG_KOBJECT_RELEASE) prints the
kobject pointer that's being released in kobject_release() before
scheduling a randomly delayed work to do the actual release work. If the
caller of kobject_put() frees the kobject upon return then we'll
typically see a debugobject warning about freeing an active timer.
Usually the release function is the function that does the kfree() of
the struct containing the kobject.

For example the following print is seen

 kobject: 'queue' (ffff888114236190): kobject_release, parent 0000000000000000 (delayed 1000)
 ------------[ cut here ]------------
 ODEBUG: free active (active state 0) object type: timer_list hint: kobject_delayed_cleanup+0x0/0x390

but we can't match up the kobject printk with the debug object printk
because it could be any number of kobjects that was released around that
time. The random delay for the work doesn't help either.

Print the address of the object being tracked to help us figure out
which kobject is the problem here. Note that we don't use %px here to
match the other %p usage in debugobject debugging. Due to %p usage we'll
have to disable pointer hashing to correlate the two pointer printks.

Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6946f8e204e3..a1c987e967e0 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -503,9 +503,9 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 			descr->debug_hint(obj->object) : NULL;
 		limit++;
 		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
-				 "object type: %s hint: %pS\n",
+				 "object: %p object type: %s hint: %pS\n",
 			msg, obj_states[obj->state], obj->astate,
-			descr->name, hint);
+			obj->object, descr->name, hint);
 	}
 	debug_objects_warnings++;
 }

base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
https://chromeos.dev

