Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE77250DC16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiDYJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiDYJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B53C9B42
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650877728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=TLzOFxrCyIJbhlu+u0HaJdK1jxgP3dZke3ZSME34BGwB6xljt2UyoWE9OykJy6OQfnKDCX
        AGdJQz0wjJxgwOkQKhCOoUehk+69iT7Ybv9DDsS+R0pLSRpB67E3dPlt45Ce2eVS+daOZV
        VfajNNOaGkNW1b+kzvbTVTKScy5tny4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-lpPR1EEjNBWss4cbapp8Xw-1; Mon, 25 Apr 2022 05:08:46 -0400
X-MC-Unique: lpPR1EEjNBWss4cbapp8Xw-1
Received: by mail-wr1-f71.google.com with SMTP id l11-20020adfc78b000000b0020abc1ce7e4so2472440wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=A/65omiuzJEhMCG9RtriTh18DTjwZIjTnr043wjrjyiUaxJmrA+K9D9Ui/lxRTJoXE
         5c9RAiTgsJsiT7nEzDRNWzDPT8XkBxAnSPbzwb5FBfuyO6LIhaGfyVOuCRGqkfnZ8b5A
         Bq2pzW9QBiLgUqA369Uz9BSs+C5pRpPMOFmY6EcnflAo/G/Q2YiUOfG/OsZ2Piyf1POO
         ZuSM2+TvzgeCgSqrwGMyKlNt5uCYowYmB71g7WWd1b0+Zq+T+/1J6Lbl4S/rkxfwnwR8
         oDHEuAAMGnG+YITpVjq27nwhFVtWFXWTCSETxHwJDZg341wm6euhFP+AAYTGpNBqNztr
         DZ3g==
X-Gm-Message-State: AOAM532NYoBlHjq3nG7Mh9ySKMxnpCvR5yUk41igpFnTxxqoKbo98OB4
        Ik8V5MmoR3zfzT+hxXc+4SOgyC+qn5QH06EbZcP3jA3DfI1YqrHCM3CEF4kvqZ7BfeezV6ep5s4
        0Hex1L9AF534TxA5r/FHUI7I=
X-Received: by 2002:a05:6000:1688:b0:20a:7ef8:d201 with SMTP id y8-20020a056000168800b0020a7ef8d201mr13074695wrd.515.1650877725689;
        Mon, 25 Apr 2022 02:08:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBIGCZEjVe+1qUV6bT0oqZ48+b2HWORGmlt2TRSmJ3JWWIeHAHjdQ+xhgzv4kVTWYHbggEiQ==
X-Received: by 2002:a05:6000:1688:b0:20a:7ef8:d201 with SMTP id y8-20020a056000168800b0020a7ef8d201mr13074684wrd.515.1650877725518;
        Mon, 25 Apr 2022 02:08:45 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600002aa00b0020a7cc29000sm9324984wry.75.2022.04.25.02.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:08:44 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v4 1/2] module: Make module_flags_taint() accept a module's taints bitmap directly
Date:   Mon, 25 Apr 2022 10:08:40 +0100
Message-Id: <20220425090841.3958494-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425090841.3958494-1-atomlin@redhat.com>
References: <20220425090841.3958494-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

The purpose of this patch is to modify module_flags_taint() to accept a
module's taints bitmap as a parameter and modifies all users accordingly.
This is in preparation for module unload taint tracking support.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 05a42d8fcd7a..ea78cec316dd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -890,13 +890,13 @@ static inline int module_unload_init(struct module *mod)
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
-static size_t module_flags_taint(struct module *mod, char *buf)
+static size_t module_flags_taint(unsigned long taints, char *buf)
 {
 	size_t l = 0;
 	int i;
 
 	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		if (taint_flags[i].module && test_bit(i, &mod->taints))
+		if (taint_flags[i].module && test_bit(i, &taints))
 			buf[l++] = taint_flags[i].c_true;
 	}
 
@@ -974,7 +974,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
 {
 	size_t l;
 
-	l = module_flags_taint(mk->mod, buffer);
+	l = module_flags_taint(mk->mod->taints, buffer);
 	buffer[l++] = '\n';
 	return l;
 }
@@ -2993,7 +2993,7 @@ char *module_flags(struct module *mod, char *buf)
 	    mod->state == MODULE_STATE_GOING ||
 	    mod->state == MODULE_STATE_COMING) {
 		buf[bx++] = '(';
-		bx += module_flags_taint(mod, buf + bx);
+		bx += module_flags_taint(mod->taints, buf + bx);
 		/* Show a - for module-is-being-unloaded */
 		if (mod->state == MODULE_STATE_GOING)
 			buf[bx++] = '-';
-- 
2.34.1

