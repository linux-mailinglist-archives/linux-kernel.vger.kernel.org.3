Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4884AB2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 00:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiBFW75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiBFW7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:59:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622FC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:59:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so7753245wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 14:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtVyQ9OIy3W70tzrc/QwpbNSPSmW2PK9iGxGNB2+tTg=;
        b=KRtfiJN2D4GP5yydji7nB7zqBvhBqjbIcYQEuTQz6Or/omSyf0Fe+YjEEYDi0YzC7n
         8phn+krhMrLfwS/X9mniksXur3a4QmvXpXNGQ1bj/JvJZ9rn1Mr7WAu2ESNvNutdzgN8
         uLmCEVtVudeqYl1+8nAC8XmzIKPemhDx4HcMNQHfRUSb40l3zi8Ri+6lEPMfla8v2kkh
         xuewyJjMt9PLytwIjMqvAF/nMTik/27PIb1rBc/KbZKyRqE4Cl3nqeUluWCzwleyu+Ma
         dLCvHGft9HYYdpuvfdxLXiXQDy5T1XXECMqnIM6OR5rKNjVAEfkeWkQ6fV9kB07YOVMI
         OsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtVyQ9OIy3W70tzrc/QwpbNSPSmW2PK9iGxGNB2+tTg=;
        b=1KP4PsMSMV8KNSDZyW//aQUdkli6gE5y7Bzj78UjR3KFqMTvqikUN4CegRNMiEvEHX
         muym5mMRnXO1w9Te43mFowl02YkR6/03SDwx86V18blUQteAxVa2W0I0pKVSEIHdm2Ws
         wkgq0J4frbk4eDmAU/I5l506OjHz8bST8n3BelzQ5McISgWL2bALYeqMe2/qPeRbrcpM
         Tmbo5ZeLBggIbnJxZC1D4qetiNSGUVSw8mcQKsietbvTIjn2TCuvGdI2pN+1WDkNh168
         iujr2v8PwSeJi2wZn5Qo6vqQSrl+A8uydRxx0+oWztr7lNOgLeElvia5+hsRWOQcuFx/
         SVjA==
X-Gm-Message-State: AOAM533khcsgSgsAyAkIccCvx0hDG34lUxWFjdf3L23kv8YGggHrXP7+
        ArpuMXNk9xBzRHJWAXL7fM6wZIct5xA=
X-Google-Smtp-Source: ABdhPJyzaTXFCeSv21+oGxPjW6XSMiy3B1J9oEUIlUz5u21K5Yy3zXd4MdZXDWana+2InS7ugB7IGw==
X-Received: by 2002:adf:eac5:: with SMTP id o5mr7914359wrn.655.1644188390463;
        Sun, 06 Feb 2022 14:59:50 -0800 (PST)
Received: from localhost.localdomain (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id t18sm8514637wri.34.2022.02.06.14.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:59:49 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Sun,  6 Feb 2022 23:59:43 +0100
Message-Id: <20220206225943.7848-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
rtw_set_key(). This function is called while holding spinlocks and with
disabled bottom halves, therefore it is not allowed to sleep. With the
GFP_ATOMIC type flag, the allocation is high priority and cannot sleep.

This issue is detected by Smatch which emits the following warning:
drivers/staging/r8188eu/core/rtw_pwrctrl.c:79 ips_leave() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_pwrctrl.c:81 ips_leave() warn: sleeping in atomic context

The calls chain (in reverse order) is the following:

rtw_set_key()
-> ips_leave()
-> -> rtw_pwr_wakeup()
-> -> -> rtw_set_802_11_disassociate()

The disabilitation of bottom halves and the acquisition of a spinlock is in
rtw_set_802_11_disassociate().

After the changes, the post-commit hook output the following messages:

CHECK: Prefer kzalloc(sizeof(*pcmd)...) over kzalloc(sizeof(struct cmd_obj)...)
+       pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);

CHECK: Prefer kzalloc(sizeof(*psetkeyparm)...) over kzalloc(sizeof(struct setkey_parm)...)
+       psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_ATOMIC).

According to the above "CHECK[S]", use the preferred style in the first
kzalloc().

Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 038bddc361c3..860835e29b79 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1600,12 +1600,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
 	int	res = _SUCCESS;
 
-	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
-	psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL);
+	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_ATOMIC);
 	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
-- 
2.34.1

