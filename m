Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141234EB360
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiC2Sfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiC2Sfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:35:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C21FCEE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so16050188qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYh17+m9ZvxB94QZOjFlGLEILR7t0nVp9Jw8tjfjzHg=;
        b=E5ysQicLK6/PS0w5N6+csC5X17whyf5UxpO207r5zL/7M3hWteMDQ/l6pb1KDMuysC
         3yXUAtvsTnUp5c2K5QXln/+wPnYu8ZCvqOEfibo5AQRGIsaJwq3CB1Y0oq8mAw2ay9FW
         Xdn9b8Sn9gdrJufk5JuWnn3Ejf2mWxVaY7H+0QL9UmDX5nhN0Iw4M14NwMrzdscHAak1
         BG/dJlUhpqDrgZROirne/j+jJU4h415Qc4Y1FA5X2RT6e6gbpklf4z9ZXISqNfPD6Wrk
         Qgrt020xavylPykNW6SqKP/VNGTEuuClxdoo/UN7hvo3OXN2CHhRgNdol1u+qFuIJVB+
         WlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pYh17+m9ZvxB94QZOjFlGLEILR7t0nVp9Jw8tjfjzHg=;
        b=MrZj0f6IkZvMYG0/cocssbLhgkfPBymlglyWTlj+U2yi2vUMPZ7mg1OqZ+1fwuNih+
         wUdI8rCokca4JWSoxfLSpoKKt1iPuXor7t+maLb1lNh5EEUcmWTADVu+7g1I+9PdbRkU
         1xNLY+CcZ1UDOGzUeAN2SUwac1j9YiGC1MrsHmZT4glhhNw6GCaUXh67HTqjhzHxz5r3
         m9wyyOAQMDhWVBnilXlJShHwHcMSu+cvQxfs3Df5N9Q82WUDenpsoefjbqHa1PdFwfxN
         PAlysaqPfxmyE2grXCQVCVkifEBQ3tQaJF8MMfD6rCtwLS0M1CRRFS8ZxVfe561Gh1EE
         3pNQ==
X-Gm-Message-State: AOAM5317FDirT0OqkZ5dXZOa/fnsY/9S0BrrMSIqh3ICZM5wnt1icMqC
        em6tVfAeIOWiFKPAIZncsQ==
X-Google-Smtp-Source: ABdhPJyDgABbA4NUgp4AHQ6yq/6JO6cXsfhVZOKL8n+20PmhywEH7JMbsKjEg6HsqlHMi4lnNpY5cg==
X-Received: by 2002:a05:622a:1894:b0:2e1:cbdb:8b74 with SMTP id v20-20020a05622a189400b002e1cbdb8b74mr28825846qtc.643.1648578830008;
        Tue, 29 Mar 2022 11:33:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id h14-20020a05622a170e00b002e1a65754d8sm16175490qtk.91.2022.03.29.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:33:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by serve.minyard.net (Postfix) with ESMTPA id 23FC21817C0;
        Tue, 29 Mar 2022 18:33:48 +0000 (UTC)
From:   minyard@acm.org
To:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 3/4] ipmi: Add a sysfs interface to view the number of users
Date:   Tue, 29 Mar 2022 13:33:39 -0500
Message-Id: <20220329183340.471474-4-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329183340.471474-1-minyard@acm.org>
References: <20220329183340.471474-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

A count of users is kept for each interface, allow it to be viewed.

Based on work by Chen Guanqiao <chen.chenchacha@foxmail.com>

Cc: Chen Guanqiao <chen.chenchacha@foxmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2a05199e8224..3ba188e05ca6 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -457,6 +457,8 @@ struct ipmi_smi {
 	struct list_head users;
 	struct srcu_struct users_srcu;
 	atomic_t nr_users;
+	struct device_attribute nr_users_devattr;
+
 
 	/* Used for wake ups at startup. */
 	wait_queue_head_t waitq;
@@ -3506,6 +3508,17 @@ void ipmi_poll_interface(struct ipmi_user *user)
 }
 EXPORT_SYMBOL(ipmi_poll_interface);
 
+static ssize_t nr_users_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct ipmi_smi *intf = container_of(attr,
+			 struct ipmi_smi, nr_users_devattr);
+
+	return sysfs_emit(buf, "%d\n", atomic_read(&intf->nr_users));
+}
+static DEVICE_ATTR_RO(nr_users);
+
 static void redo_bmc_reg(struct work_struct *work)
 {
 	struct ipmi_smi *intf = container_of(work, struct ipmi_smi,
@@ -3628,6 +3641,12 @@ int ipmi_add_smi(struct module         *owner,
 	if (rv)
 		goto out_err_bmc_reg;
 
+	intf->nr_users_devattr = dev_attr_nr_users;
+	sysfs_attr_init(&intf->nr_users_devattr.attr);
+	rv = device_create_file(intf->si_dev, &intf->nr_users_devattr);
+	if (rv)
+		goto out_err_bmc_reg;
+
 	/*
 	 * Keep memory order straight for RCU readers.  Make
 	 * sure everything else is committed to memory before
@@ -3724,6 +3743,8 @@ void ipmi_unregister_smi(struct ipmi_smi *intf)
 
 	/* At this point no users can be added to the interface. */
 
+	device_remove_file(intf->si_dev, &intf->nr_users_devattr);
+
 	/*
 	 * Call all the watcher interfaces to tell them that
 	 * an interface is going away.
-- 
2.25.1

