Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600714EB361
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiC2Sfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiC2Sff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:35:35 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77973201A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:51 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k7so15073725qvc.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKX8MOuc+fqfFqc9o7xUeIg2s3MACXL989nTaOCsTRg=;
        b=SmSkru7LcPKK7uB+F3Ng+PLbgy5CFKKdgPnhrrwvhYcn6rT+OE7nyok8aWPmQx5Po4
         6AzY5DOhNYTKzXvOnw/7F3hd475ovWAgr9Xv+ezfjwOrMfkNmQ9VnK7qSES/hjLOj8Xh
         M3dX2//opJKIsuIuFMXDiIkupgWq4SoVWdwT4hMIBQ596Q5h5xqsu7YyUx5pg310X+dg
         bPuqGDn/AS1GZsHrGvR7Sw+MrDn8WVUXfF9kOSVJODneDjadSlusA1lN7EWbgEW6JWRi
         kkF7xR9zHtrU2/5/bLZYQ+ld/mVp40dTK/ZIGgYnTU7W7eS3pdZzFi8+Wo3Bs4rgtxJA
         rtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eKX8MOuc+fqfFqc9o7xUeIg2s3MACXL989nTaOCsTRg=;
        b=yPnEBLRdFvGA0aar5rOqkuILVxXqfv0vneIw3aCZ0Daf+ziQphLvdbH7xfaHAnXbsq
         lvMysZlXxFT6RDnu8/fvQhym1L/DoA1dNv+gOAjq+FMShyy0OAkZ/48uQWxsCn86BeAf
         FZRiohM6SwWlq7KczZs6PAIyTUD0VSUyvdp7mMDt+GSJVbrtoJ+bBlkDPqgBPvajRuxh
         Q6yJ+kskNZYuoD0QdQxP9FhyPsHAGxql42RRCc39ecDq2xACbRf+i8YBh1MWwZFJuciV
         9VmGQZpYbGl6y8rdFDVWpe3vjtjcXkiEfPEBN8xsk2JbS5AySOiSEF1tt4dyuVyUmBrL
         HOhQ==
X-Gm-Message-State: AOAM533k5YZMVZzVBxJm92ieQKLbqB7kIFFIW88Ua4KG/8ooJ98bdFHi
        7ZYhcanqQESkT+GmXYWGIVhG4KA1MA==
X-Google-Smtp-Source: ABdhPJxbQ4wBVitVjiXj6qY7npw5KQhZI9PmVVTOrduX/2N2bPbSJvyLDIC2B3HF3BMXeRDVf5LQRg==
X-Received: by 2002:a05:6214:20a1:b0:42d:6f51:46e2 with SMTP id 1-20020a05621420a100b0042d6f5146e2mr28075705qvd.67.1648578830339;
        Tue, 29 Mar 2022 11:33:50 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm9542179qki.33.2022.03.29.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:33:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by serve.minyard.net (Postfix) with ESMTPA id EC2C61817BE;
        Tue, 29 Mar 2022 18:33:47 +0000 (UTC)
From:   minyard@acm.org
To:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 1/4] ipmi: Add a limit on the number of users that may use IPMI
Date:   Tue, 29 Mar 2022 13:33:37 -0500
Message-Id: <20220329183340.471474-2-minyard@acm.org>
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

Each user uses memory, we need limits to avoid a rogue program from
running the system out of memory.

Based on work by Chen Guanqiao <chen.chenchacha@foxmail.com>

Cc: Chen Guanqiao <chen.chenchacha@foxmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index c59265146e9c..de80bf4c4e4c 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -145,6 +145,12 @@ module_param(default_max_retries, uint, 0644);
 MODULE_PARM_DESC(default_max_retries,
 		 "The time (milliseconds) between retry sends in maintenance mode");
 
+/* The default maximum number of users that may register. */
+static unsigned int max_users = 30;
+module_param(max_users, uint, 0644);
+MODULE_PARM_DESC(max_users,
+		 "The most users that may use the IPMI stack at one time.");
+
 /* Call every ~1000 ms. */
 #define IPMI_TIMEOUT_TIME	1000
 
@@ -442,6 +448,7 @@ struct ipmi_smi {
 	 */
 	struct list_head users;
 	struct srcu_struct users_srcu;
+	atomic_t nr_users;
 
 	/* Used for wake ups at startup. */
 	wait_queue_head_t waitq;
@@ -1230,6 +1237,11 @@ int ipmi_create_user(unsigned int          if_num,
 	goto out_kfree;
 
  found:
+	if (atomic_add_return(1, &intf->nr_users) > max_users) {
+		rv = -EBUSY;
+		goto out_kfree;
+	}
+
 	INIT_WORK(&new_user->remove_work, free_user_work);
 
 	rv = init_srcu_struct(&new_user->release_barrier);
@@ -1262,6 +1274,7 @@ int ipmi_create_user(unsigned int          if_num,
 	return 0;
 
 out_kfree:
+	atomic_sub(1, &intf->nr_users);
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	vfree(new_user);
 	return rv;
@@ -1336,6 +1349,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 	/* Remove the user from the interface's sequence table. */
 	spin_lock_irqsave(&intf->seq_lock, flags);
 	list_del_rcu(&user->link);
+	atomic_dec(&intf->nr_users);
 
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
 		if (intf->seq_table[i].inuse
@@ -3529,6 +3543,7 @@ int ipmi_add_smi(struct module         *owner,
 	if (slave_addr != 0)
 		intf->addrinfo[0].address = slave_addr;
 	INIT_LIST_HEAD(&intf->users);
+	atomic_set(&intf->nr_users, 0);
 	intf->handlers = handlers;
 	intf->send_info = send_info;
 	spin_lock_init(&intf->seq_lock);
-- 
2.25.1

