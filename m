Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2086522CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiEKHOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiEKHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:14:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94252197F6C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:14:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g8so1228059pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nb9VOTPefU04ZkWaBIc27j2TxwZGEgIDTFhjne1We7k=;
        b=NRf2yM722qnKh9mZGPSorWXO6zKi4XFNmvqg2E7czymLhFBvWQmc7fnHhY7TcE2+HX
         zKsp0jTJmGI9rqIQwFflS32GQmXqxitT3Yqj9U26KCOTv69fat121HcDKP8G+JCstpg6
         HF14zXrKDPfn1Qo+Yq+I3itwK7ASvgH9u4uglPkqwbT8qTeB9dGeWYFAENa435yzdpme
         v8b4WH1iO3a80yOq9g6WIt1IP+WlqB1VQjHMel5vhENaOUY+/Rh7dm741Rx/DpxHI/AO
         1FZUuQCn44p2Nq28Wmv5hbPBCX2+sJnufbcE38l3lKb55qiB9cxO30V4gY6Suoplz1Pe
         9+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nb9VOTPefU04ZkWaBIc27j2TxwZGEgIDTFhjne1We7k=;
        b=oApAcqZWiQQJ8c5k9jzroxiye6ChAqU52R7nQ5mjdUjqq3yZAqoPNIYXhnaRm4l3Wu
         wt5iDgSiV0A5LsgGa/JGPMHokCZnkqBCsJpYq8j97PqZaLkMvd3pSfu1s0OOW7asGH9b
         oX9bT0Dd/jqZEVgpJr323my0QwU3bHrBXrccA1nJEvyPChYKqzOQ8dJnJ/csE309wBFD
         0JmC5tyBNU+Ek6endyZDUbbTyV/++e+X8G6uOypC+4ujisbeZS+xV9pdx35j6QK6VnTm
         vIUbjt1eylBwK5fNm2oorTrbBXpOOZKgHbkO3tPmN2CTCQCAr1d8aeFCnqojTCWxdK7E
         vKtw==
X-Gm-Message-State: AOAM532ZlAawq6mIj7xTFzpLD6Vc0ibgFtHQUDyP9DGKZA6DSiUgp/to
        +WsjJjoaUvqZTyUqBpEIOwg=
X-Google-Smtp-Source: ABdhPJwMvmJ5ywQPZGxmf5Id/CgUeArECSdrmuUEnwfJpS/n3PCOxDtIOzC/ZdQXNUEjmY3bZoOjyQ==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr23615409pfh.70.1652253269139;
        Wed, 11 May 2022 00:14:29 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o6-20020a17090a420600b001cd498dc153sm1423840pjg.3.2022.05.11.00.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:14:28 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Waychison <mikew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle
Date:   Wed, 11 May 2022 11:14:19 +0400
Message-Id: <20220511071421.9769-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix this issue by calling kobject_put().

Fixes: 948af1f0bbc8 ("firmware: Basic dmi-sysfs support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/dmi-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 3a353776bd34..66727ad3361b 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -604,7 +604,7 @@ static void __init dmi_sysfs_register_handle(const struct dmi_header *dh,
 				    "%d-%d", dh->type, entry->instance);
 
 	if (*ret) {
-		kfree(entry);
+		kobject_put(&entry->kobj);
 		return;
 	}
 
-- 
2.25.1

