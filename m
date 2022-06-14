Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8254B3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiFNOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiFNOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:44:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904A1AF38
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:44:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w21so8810426pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwGgBwQwc2E56vQ90K5yq3HYbjSBDzlXpuPZAgR/Nug=;
        b=qD6JNTjIZRmkihwkJpmimO7O/1Tf/hyid6BUSR7ejW2s5B+Sx0oz7eUIxWDPk4xTRJ
         5CcTyupaqV/Wt6eTbXkc9K1hCfyyFkTDGoa8GCnYDVWKy6/3Cz8cI51MkNaiqZKkMhn7
         FG8vQSTGKH3bSxVvhizUFXbB5J5ZceG0WX9xPWllonewFRPCzlrCrWGLCwZNYPltbcIP
         zlhWxxxRp/mKX69DRhjhNYO+fK9THN0Vl+tkMGW/0lGN1DmJ8yrzQPGpVqoITpHujeKD
         obp9C+9oqllT9+pU7sMUkG5OR/e1EoBWV0028UJ4ep40/ImsCusG/2JBkaLoREGYuf1F
         gnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwGgBwQwc2E56vQ90K5yq3HYbjSBDzlXpuPZAgR/Nug=;
        b=zJ4PMpwJSUxPhIJzgE+W1j78uEsUWN899XHkK6ONKdjUvdI1QJwj+CLjmRavNjW+Hy
         2rs82uDbMrkC/CPKF5j2K/iMCaJRq/6ZdjP3n34ZEIjADV4iOqjzNbuGZu+DjX+KqmAf
         QgGGqR4Jr3qMIWBaADjC+oVP8GJDsSEedrHixKQJ7odXp9XqLWZPaD6rnu3jItZQ82nC
         DsHweIMrMyDKH3er41WrDbAJ9z9LBMxuYuoa811Y1Kl4LGRCMpA7pX++PMpA7Xlom93I
         kpGcYNkLZ1a34uqpnVvfnCv50HaiS1WoU9qxaaTZPKpM4WSbJPUUFlU6uPxOm+qXiC2I
         sfYg==
X-Gm-Message-State: AJIora/ZSSnrhsulhZoO6FLXQITbYWPSSlW6Pt4jJrVJlbAfObiUe848
        WfssdGfA+vmJkFYy7G0vxTI=
X-Google-Smtp-Source: AGRyM1tm8XdE92faZpkGt+mDLuvOMpiFgMkxxiQT1QSdhvzngtvwb6XYpFvCxmRhVxONbrxEpFu4/Q==
X-Received: by 2002:a63:f24e:0:b0:408:a73f:4dc with SMTP id d14-20020a63f24e000000b00408a73f04dcmr3373167pgk.154.1655217888832;
        Tue, 14 Jun 2022 07:44:48 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b0015e8da1f9e8sm7318778plb.77.2022.06.14.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 07:44:48 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     alexios.zavras@intel.com, allison@lohutok.net, armijn@tjaldur.nl
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/klist: Remove mb() before wake_up_process
Date:   Tue, 14 Jun 2022 22:44:43 +0800
Message-Id: <20220614144443.6566-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

Function wake_up_process always executes a general memory barrier,
so remove the mb() before it.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/klist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/klist.c b/lib/klist.c
index 332a4fbf18ff..c44498e31d91 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -194,7 +194,6 @@ static void klist_release(struct kref *kref)
 
 		list_del(&waiter->list);
 		waiter->woken = 1;
-		mb();
 		wake_up_process(waiter->process);
 	}
 	spin_unlock(&klist_remove_lock);
-- 
2.20.1

