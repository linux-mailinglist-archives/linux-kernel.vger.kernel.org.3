Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C695E58584B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiG3Del (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbiG3Dec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:34:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104AC6D575
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:34:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r186so5367775pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=oUvqYsnCKAObMxNxAaIFanlsa80QzweW9pqDDzbQrVs=;
        b=kfOW+D31Pn7OedYvv/Sot9KuXUHCw02n10rSv9HFMVKbx4iRwxChWIYus1WDfLoddN
         qPOQmr3qizEo7uSGI86Y0iL6xZENeoEzZKhI+WcaLC5e03uuk8tu5JMUUz2d+S8yTkXk
         YGZM/Mg+Poqc8afODNOZVPh54zLW9Fnqwr4cx1gHj0S00HArL2rSadNb+Ma7LuoX1YCf
         ShEXPs5NIThUjT7OlTkPPfn7cBcRjkcwNTGedkZGnYBt8IH4hETlRpsAk1pYzGmCkUTA
         wMId5CUnYEp0O9pf7AA3VhPtLvp6MgFim/uzQySVII4Zxwl26uhr8N+NVZBxRJ9PR77o
         iCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=oUvqYsnCKAObMxNxAaIFanlsa80QzweW9pqDDzbQrVs=;
        b=bBLqUkVNG/xBBHy4ivm1zANTRXrfwCzH1kMaWvoGM36j8vsIohaahiInn8inLXYzcc
         h6RmZK3RUIkaZNBO2CMY9Rym8avltewu8SUV3183Vfptzvm+TB1ZLIvWVwY5r5jvNF72
         PO+orqBwEPVBmHJHkKpLu45zJskoyhWtvxsMi3k4ALQcE8YP97tjXKScOi/675VFOF8w
         yoyer0Qiq/iDuZAnf0U+VpboTJvDczaRw2A4NVXkC5zrd5yMVLPQH7+dJf1aqCUAkCxI
         K3rhc1xed/iogLKlX6ObzHEmlZS8Zzp+ARgazHj6scnS0dSAFtVHjAq1VsO/WwQ+/5+m
         Uepg==
X-Gm-Message-State: AJIora9a1NyRrVaLnKpXEzxvFJvK2YJKZfcTWBy/qyMQUplkTs/UPbYN
        7PWHwmcvVA4f8eneMPPHbsBcXac+hCEcaw==
X-Google-Smtp-Source: AGRyM1uwweumNEcoszwdAT6GJgqFwKPFuay28xWDobwiRhtieZ5DjrnnYUTmBpVmNKt5jLd3cRzr+w==
X-Received: by 2002:a63:1ce:0:b0:41a:f362:8708 with SMTP id 197-20020a6301ce000000b0041af3628708mr5244504pgb.571.1659152064413;
        Fri, 29 Jul 2022 20:34:24 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:f0d:9a23:40c8:9423])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170902f54300b0016a3248376esm4441555plf.181.2022.07.29.20.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 20:34:24 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v4 2/4] staging: rtl8192u: remove unnecessary cast
Date:   Fri, 29 Jul 2022 20:33:22 -0700
Message-Id: <20220730033335.74153-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YuOLybUZ8cBWntY/@kroah.com>
References: <YuOLybUZ8cBWntY/@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast is not needed when calling ieee80211_priv, so remove them.
No functional change in this commit.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_procfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_procfs.c b/drivers/staging/rtl8192u/r8192U_procfs.c
index 69cbafceecfe..d6f8401526c5 100644
--- a/drivers/staging/rtl8192u/r8192U_procfs.c
+++ b/drivers/staging/rtl8192u/r8192U_procfs.c
@@ -10,7 +10,7 @@ static struct proc_dir_entry *rtl8192_proc;
 static int __maybe_unused proc_get_stats_ap(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct r8192_priv *priv = ieee80211_priv(dev);
 	struct ieee80211_device *ieee = priv->ieee80211;
 	struct ieee80211_network *target;
 
@@ -70,7 +70,7 @@ static int __maybe_unused proc_get_registers(struct seq_file *m, void *v)
 static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	seq_printf(m,
 		   "TX VI priority ok int: %lu\n"
@@ -129,7 +129,7 @@ static int __maybe_unused proc_get_stats_tx(struct seq_file *m, void *v)
 static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
+	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	seq_printf(m,
 		   "RX packets: %lu\n"
-- 
2.25.1

