Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF044EB367
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiC2Sfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbiC2Sff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:35:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7285323140
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 1so14825016qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWA7HcHxRpWtEbVOYRkc14CrV3xH0f9ykow83uQI6Oc=;
        b=TGAfGZeUItf+EdBmKHvq/2lKgRAqtSOyPTJ3cIwzNwRXU6NEbCqLYag1qggqY920kV
         cLpNhwg8PEBGMVp+7YAlNt2AZec4QPKGCGxm8GAYJjlZOIjJyc4pdCjSIBiV68cQREzj
         RpezyPsr0Zc6OgGORxiIZ1uy2+dWR2GmnjtpwpY+t/eoSp+XqqRleYDRXMAfcj9/vndG
         IC6FAoCJgJ45lmGcaVEFqFp4WI6vIN4OpkuRVDrJdXY8/OutwXgLzrlHQoX+D05G/whr
         otQ0Q5eD/J/839YermdMlOdL6AyKoKD5EaKYUKknuWkrJMP0gJNvvc5rgqWaJ9yW3IqZ
         41oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vWA7HcHxRpWtEbVOYRkc14CrV3xH0f9ykow83uQI6Oc=;
        b=O9Z3TOFOO+POSpGpBI0Qef6L/nVJst72JxLm+ftdp6o765y3Nba+ubxCgujrpvcpXb
         S1q2NubVfUqfXHW6ZPeT4TlOBocgXiK2pGFA1vVRXmR41SOdJcKUQqsRHJjmiGl2N9TI
         hp919CjZlMF6A0XzhVohf8guriXkOLLq219pDmkFIOGlqGrsbd9WgX7ZG/iZdUOFRCo7
         +/h5q8G1i1AHHaxfFVyjedrNwqr8AiKSNdxWLiCuWTQOzqld+5g9A3/t6S7j1UC0ch4m
         vNK3aTSgPR5y+9Mn/tkZrCrf1nleEQHyu56aETMei6IPVbzqBWC3G7OKiYquPh3PZ/5t
         Rmtw==
X-Gm-Message-State: AOAM530yZBKOBT84a1OwRIE8YE2WNg+4MDnPFLtn2lP0DgF33hWlTEdm
        lNf8YxM3Jm1g1/RAxNhI9w==
X-Google-Smtp-Source: ABdhPJy9SCF44CcQJbSUiXgEkc9BHr7eeymXyPLB3zmBh4ucrhwiiARaLqeXVN83k3mcw0qJHmiSsg==
X-Received: by 2002:a37:a3d2:0:b0:67b:30b2:732f with SMTP id m201-20020a37a3d2000000b0067b30b2732fmr21033089qke.719.1648578831377;
        Tue, 29 Mar 2022 11:33:51 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm15054133qtw.7.2022.03.29.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:33:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by serve.minyard.net (Postfix) with ESMTPA id 0FA5D1817BF;
        Tue, 29 Mar 2022 18:33:48 +0000 (UTC)
From:   minyard@acm.org
To:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 2/4] ipmi: Limit the number of message a user may have outstanding
Date:   Tue, 29 Mar 2022 13:33:38 -0500
Message-Id: <20220329183340.471474-3-minyard@acm.org>
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

This way a rogue application can't use up a bunch of memory.

Based on work by Chen Guanqiao <chen.chenchacha@foxmail.com>

Cc: Chen Guanqiao <chen.chenchacha@foxmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index de80bf4c4e4c..2a05199e8224 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -151,6 +151,12 @@ module_param(max_users, uint, 0644);
 MODULE_PARM_DESC(max_users,
 		 "The most users that may use the IPMI stack at one time.");
 
+/* The default maximum number of message a user may have outstanding. */
+static unsigned int max_msgs_per_user = 100;
+module_param(max_msgs_per_user, uint, 0644);
+MODULE_PARM_DESC(max_msgs_per_user,
+		 "The most message a user may have outstanding.");
+
 /* Call every ~1000 ms. */
 #define IPMI_TIMEOUT_TIME	1000
 
@@ -193,6 +199,8 @@ struct ipmi_user {
 	/* Does this interface receive IPMI events? */
 	bool gets_events;
 
+	atomic_t nr_msgs;
+
 	/* Free must run in process context for RCU cleanup. */
 	struct work_struct remove_work;
 };
@@ -934,11 +942,13 @@ static int deliver_response(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 		 * risk.  At this moment, simply skip it in that case.
 		 */
 		ipmi_free_recv_msg(msg);
+		atomic_dec(&msg->user->nr_msgs);
 	} else {
 		int index;
 		struct ipmi_user *user = acquire_ipmi_user(msg->user, &index);
 
 		if (user) {
+			atomic_dec(&user->nr_msgs);
 			user->handler->ipmi_recv_hndl(msg, user->handler_data);
 			release_ipmi_user(user, index);
 		} else {
@@ -1256,6 +1266,7 @@ int ipmi_create_user(unsigned int          if_num,
 	/* Note that each existing user holds a refcount to the interface. */
 	kref_get(&intf->refcount);
 
+	atomic_set(&new_user->nr_msgs, 0);
 	kref_init(&new_user->refcount);
 	new_user->handler = handler;
 	new_user->handler_data = handler_data;
@@ -2298,6 +2309,14 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	struct ipmi_recv_msg *recv_msg;
 	int rv = 0;
 
+	if (user) {
+		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
+			atomic_dec(&user->nr_msgs);
+			rv = -EBUSY;
+			goto out;
+		}
+	}
+
 	if (supplied_recv)
 		recv_msg = supplied_recv;
 	else {
@@ -2369,6 +2388,8 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	rcu_read_unlock();
 
 out:
+	if (rv && user)
+		atomic_dec(&user->nr_msgs);
 	return rv;
 }
 
-- 
2.25.1

