Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0D4EB368
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiC2Sfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbiC2Sff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:35:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36223158
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 10so16063499qtz.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjza6K+AY/cPZQnOFPJJVhFu3gZWdgR4+p6QcBpzTy0=;
        b=JPam0pwniV7W7pfXJ0KUPB7FsNfYvcpKufKyDRuc8w2/nhluZvybl8Xl4GxkU6Xl4J
         tkz8Tz7sxWzqQOzY1YdZ8hkXE+oRBhI4qBDKicL3fLc7cFH4ZecY1Dp4OY4lDmYSXbNq
         W4Fw2HFh95UlQpvGAt68H8/Hie51PP/TIPeqzc66F0QuhEUrXS18/tDNiQQOg1WNhRy1
         G6YSkoy6wOlxOobjYo2ifZkl7cafxY2SXAACXmbYfNf9o0fMolEBQ7NoFLeHgZJUkEsM
         lw7g94ng0ve5foXBMpirk3r4XNmrNIGjQJ3I6pAJfwVWQ4XTEa9x8YqOk3a1b1hdxWF0
         bQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bjza6K+AY/cPZQnOFPJJVhFu3gZWdgR4+p6QcBpzTy0=;
        b=hG5WzfHjQrj0MSUcgqqp+CcDZbyfNnuglV0mLcYyOuOvaSdykk/ivem9VynGKcq4PI
         Uwg3lepSEdNOZBXoEzma8zY3daY0+OrDIMJ3Qa3djtNwk3dQL/Ovx+XmEN1az57qEmBa
         yvmJQPhc4cthkvuAn6VFwsI2mmWQThDdFl25HL2VWkUgr+vuBC7cHiFVDXMT06+ZwyG5
         G8Gwgcw1elh/j+b3M0x4CnEm7mXaYBMekemJ6L0AgxUlYeZqLYLiK/pY38F+q1iSMyxK
         T9bO3RCDt8ax7VqKqVm13f9W1EQewaj3IhG52cR77vbyB4sZTjrDiv7WwJULQ6phH4bT
         GEsw==
X-Gm-Message-State: AOAM5332EZJaK+tAUD0/KNsIf9Hb5DmAmxQCLA655UvFeLt6AcYdJNkO
        X30pBiwkAs7i5N5PnSGqZwWbCJTnJQ==
X-Google-Smtp-Source: ABdhPJzgswxUhX3CVNKadJI6lHxhDQSuNlqb2woYu+H3DNLh7JPt8Kog1vdWOnQfKSECZTLJLQ+Z1g==
X-Received: by 2002:ac8:5892:0:b0:2e1:c997:a5f6 with SMTP id t18-20020ac85892000000b002e1c997a5f6mr29886327qta.357.1648578831700;
        Tue, 29 Mar 2022 11:33:51 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm15326134qta.13.2022.03.29.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:33:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by serve.minyard.net (Postfix) with ESMTPA id 39F981817C1;
        Tue, 29 Mar 2022 18:33:48 +0000 (UTC)
From:   minyard@acm.org
To:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4/4] ipmi: Add a sysfs count of total outstanding messages for an interface
Date:   Tue, 29 Mar 2022 13:33:40 -0500
Message-Id: <20220329183340.471474-5-minyard@acm.org>
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

Go through each user and add its message count to a total and print the
total.

It would be nice to have a per-user file, but there's no user sysfs
entity at this point to hang it off of.  Probably not worth the effort.

Based on work by Chen Guanqiao <chen.chenchacha@foxmail.com>

Cc: Chen Guanqiao <chen.chenchacha@foxmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 3ba188e05ca6..e30223763a2a 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -458,6 +458,7 @@ struct ipmi_smi {
 	struct srcu_struct users_srcu;
 	atomic_t nr_users;
 	struct device_attribute nr_users_devattr;
+	struct device_attribute nr_msgs_devattr;
 
 
 	/* Used for wake ups at startup. */
@@ -3519,6 +3520,25 @@ static ssize_t nr_users_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(nr_users);
 
+static ssize_t nr_msgs_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct ipmi_smi *intf = container_of(attr,
+			 struct ipmi_smi, nr_msgs_devattr);
+	struct ipmi_user *user;
+	int index;
+	unsigned int count = 0;
+
+	index = srcu_read_lock(&intf->users_srcu);
+	list_for_each_entry_rcu(user, &intf->users, link)
+		count += atomic_read(&user->nr_msgs);
+	srcu_read_unlock(&intf->users_srcu, index);
+
+	return sysfs_emit(buf, "%u\n", count);
+}
+static DEVICE_ATTR_RO(nr_msgs);
+
 static void redo_bmc_reg(struct work_struct *work)
 {
 	struct ipmi_smi *intf = container_of(work, struct ipmi_smi,
@@ -3647,6 +3667,14 @@ int ipmi_add_smi(struct module         *owner,
 	if (rv)
 		goto out_err_bmc_reg;
 
+	intf->nr_msgs_devattr = dev_attr_nr_msgs;
+	sysfs_attr_init(&intf->nr_msgs_devattr.attr);
+	rv = device_create_file(intf->si_dev, &intf->nr_msgs_devattr);
+	if (rv) {
+		device_remove_file(intf->si_dev, &intf->nr_users_devattr);
+		goto out_err_bmc_reg;
+	}
+
 	/*
 	 * Keep memory order straight for RCU readers.  Make
 	 * sure everything else is committed to memory before
@@ -3743,6 +3771,7 @@ void ipmi_unregister_smi(struct ipmi_smi *intf)
 
 	/* At this point no users can be added to the interface. */
 
+	device_remove_file(intf->si_dev, &intf->nr_msgs_devattr);
 	device_remove_file(intf->si_dev, &intf->nr_users_devattr);
 
 	/*
-- 
2.25.1

