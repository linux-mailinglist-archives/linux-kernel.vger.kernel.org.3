Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9E507151
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353540AbiDSPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351517AbiDSPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1269038D90
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650380624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=IkAKuWkF/n7ovfA1WUdXvqIPoMzDts9mLu2GvGRIQpYrPIOSUt6MChJzNlbqEjNZWqkcsG
        ymjRPkOBfyEPllZjXk7kfntw4vTZsdxPS3rZksViS7S5f65HN4oGDKWi1FZ1mLriWilnLP
        BpYmQM/rXYw+41LrVoWFpQCgmepZsKw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-bSMGIzksMYeqdlI7MVbSxQ-1; Tue, 19 Apr 2022 11:03:42 -0400
X-MC-Unique: bSMGIzksMYeqdlI7MVbSxQ-1
Received: by mail-wr1-f70.google.com with SMTP id l14-20020adf9f0e000000b002079eeec6b6so1995331wrf.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=Z86sEx6Xe0pXdb85LIteGmHks1T1zf7J9fSBQ80a5ACwFqWWXR58yAhktWT+2ej7R3
         ScY/23hZI7o92wmU49nvo+C/wEDzV0CRVIAhnPAnksp4ZmfYdQDM14ykTdMxs9qnsfBS
         xIDfXNtFQff8mv99KjZVRiCA3nZg0+zfPfCCwjsNH47D7T1jkHUEhLoci62GzgkaYkGz
         ZhVRSWaIzFLOCZCX2KasQE7O+j5genhzfcu3ax2qIcKzfb9YPHWW1syRQ6UUctrpRve4
         vFYXIJRvdqGLOlFY+XtlmDYVsi5e/TWNZeCCnnq/O6RtPGuzPnJrY89tmBeY4NCZzQKb
         f60A==
X-Gm-Message-State: AOAM53243eelfJY+aN/pXQGU00qqqri6E6XQoIFzASdFt+qn8sVtylHZ
        Bw+lqumhzUHRgEA0fBS0tDvpX6W6N2u/cKGK6PmTCcu6fOCuOwIHFTcOvHkP9KwulEVv1UVizom
        LohhFTq1xCfKPusjLR2mRqsY=
X-Received: by 2002:a5d:5889:0:b0:20a:9707:39c with SMTP id n9-20020a5d5889000000b0020a9707039cmr6711101wrf.54.1650380620187;
        Tue, 19 Apr 2022 08:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwChCgPohVPs2SQ2ry6VMkMu0eI/8iyTTO/0+EEMeH5AS5oHEakyqxkr6fAIHOwQVsuPFGbsg==
X-Received: by 2002:a5d:5889:0:b0:20a:9707:39c with SMTP id n9-20020a5d5889000000b0020a9707039cmr6711089wrf.54.1650380619968;
        Tue, 19 Apr 2022 08:03:39 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b0038e6a025d05sm17017899wmr.18.2022.04.19.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:03:38 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH v2 1/2] module: Make module_flags_taint() accept a module's taints bitmap directly
Date:   Tue, 19 Apr 2022 16:03:33 +0100
Message-Id: <20220419150334.3395019-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419150334.3395019-1-atomlin@redhat.com>
References: <20220419150334.3395019-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

