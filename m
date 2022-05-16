Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8744F52947D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350007AbiEPW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349951AbiEPW50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9E42EF8;
        Mon, 16 May 2022 15:57:14 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o16so3061316ilq.8;
        Mon, 16 May 2022 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcTCD0gjQirPulppRUPJolVEvdGl8HWNF457l2/VCpM=;
        b=Q9CmR/OAi4f1fJoHiSq/A4+KKe+6D/bRcwzXAN4CXFUDU9W2e/2rDFlaPtn9DFL3UZ
         0OP+IoKCCh6jybN/4qKugRJr9T7OMuUWB4WPcOmePoEDyIWmnOH/Ox90OJPiIk7Uj2Ay
         X08/tZRG4GW7glyZeaVHPS0481a3PaSmacbBlv0ZZESoKc5evx9H5So0ulM0I63j44yN
         SP5T0u614Gkgwz78lPA4m5oH9zHG8D7tq0xAtxEPiBhUov/810saX6SSHCROypTyuHX/
         Hi1iw+N+BFIEL+BpwjFUjSZL5bIvVsgrCFPtwfR3vAntRQZrHwooDLmOROaOb3jpAut/
         oK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcTCD0gjQirPulppRUPJolVEvdGl8HWNF457l2/VCpM=;
        b=nWfDHlZ3legAB7OZmOA8kC4zmsFIXnpkQ8wjiGOeQjk/S5X76NtZr1wwq1oQismvxq
         gJ9nK/nOtAqDzr26G0HNN9PWWdigJrZ+rbeFtzd3cGzGAkoKAncYJZcvEWK03mXyi9JX
         sxQrr2CZu1rhmwJxtp/n2Q0kbgdqdKsmx+fvLBWUdEjjwGd+V0XOtNs+iExQFBxMYZYl
         KMCOqsPeuOB7tpR/JZnRWuTlD31s+OV1UbEyT10t/j2q6aA0/jP+wg+EPG81RAEWfGPc
         5T9JtmwfYm+gDGAat7W404wkUbqVj8XPS4q2KP8XVaXXDiTI08azBbIPI7HGz27SABqU
         73EQ==
X-Gm-Message-State: AOAM532qmZCP8scZoKTImy4cPmc1WawTcRww8H64dpQtwlG4uT7IoYwc
        Ewhk8HOVrM/M0eRib6bUqoM=
X-Google-Smtp-Source: ABdhPJx/jSyAjp7ehDTr/MAgCBe4VOWPaEYbecT5v2lmg6AJpeafbX8FKEwrz5Q30LOOcV3+TCIIVg==
X-Received: by 2002:a05:6e02:158c:b0:2cf:db51:f69b with SMTP id m12-20020a056e02158c00b002cfdb51f69bmr9710970ilu.263.1652741834203;
        Mon, 16 May 2022 15:57:14 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 11/27] dyndbg: support symbolic class-names in bitmap
Date:   Mon, 16 May 2022 16:56:24 -0600
Message-Id: <20220516225640.3102269-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

Extend the sysfs-node bitmap support to accept class-names
registered by the module, allowing:

   #> echo DRM_UT_CORE,-DRM_UT_ATOMIC,+DRM_UT_KMS \
    	 > /sys/module/drm/parameters/debug

Do this in param_set_dyndbg_class_strings(), which is called from
param_set_dyndbg_classes() when the input string isn't a integer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---
. continue/skip on unknown class, so following symbols are processed.
. better loadable module handling, no more KP_MOD_NAME
. add do_callback_changes
---
 lib/dynamic_debug.c | 63 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 42dce2e76014..8e1b9159e881 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -618,6 +618,61 @@ static int do_callback_changes(const struct ddebug_classes_bitmap_param *dcp,
 	return matches;
 }
 
+/* support for [+-] symbolic-name boolean list */
+static int param_set_dyndbg_class_strings(const char *instr, const struct kernel_param *kp)
+{
+	const struct ddebug_classes_bitmap_param *dcp = kp->arg;
+	unsigned long inbits;
+	int idx_rc, totct = 0;
+	bool wanted;
+	char *cls, *p;
+
+	if (!dcp || !dcp->map) {
+		pr_err("set_dyndbg_classes: no bits=>queries map\n");
+		return -EINVAL;
+	}
+
+	cls = kstrdup(instr, GFP_KERNEL);
+	p = strchr(cls, '\n');
+	if (p)
+		*p = '\0';
+
+	inbits = *dcp->bits;
+	vpr_info("set_dyndbg_class_strings: %s on 0x%lx\n", cls, inbits);
+
+	for (; cls; cls = p) {
+		p = strchr(cls, ',');
+		if (p)
+			*p++ = '\0';
+
+		if (*cls == '-') {
+			wanted = false;
+			cls++;
+		} else {
+			wanted = true;
+			if (*cls == '+')
+				cls++;
+		}
+		idx_rc = match_string(dcp->map->classes, dcp->map->length, cls);
+		if (idx_rc < 0) {
+			pr_err("%s not found for module: %s\n", cls, dcp->map->mod_name);
+			continue;
+		}
+		if (test_bit(idx_rc, &inbits) == wanted) {
+			v3pr_info("no change on %s\n", cls);
+			continue;
+		}
+
+		vpr_info("set_dyndbg_classes: bit %d: %s\n", idx_rc, dcp->map->classes[idx_rc]);
+		inbits ^= BIT(idx_rc);
+		totct += do_callback_changes(dcp, idx_rc, &inbits);
+	}
+	kfree(cls);
+	*dcp->bits = inbits;
+	vpr_info("total matches: %d\n", totct);
+	return 0;
+}
+
 /**
  * param_set_dyndbg_classes - bits => categories >control setter
  * @instr: string echo>d to sysfs
@@ -639,10 +694,9 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		return -EINVAL;
 	}
 	rc = kstrtoul(instr, 0, &inbits);
-	if (rc) {
-		pr_err("set_dyndbg_classes: expecting bits/integer\n");
-		return -EINVAL;
-	}
+	if (rc)
+		return param_set_dyndbg_class_strings(instr, kp);
+
 	vpr_info("set_dyndbg_classes: new 0x%lx current 0x%lx\n", inbits, *dcp->bits);
 
 	for (i = 0; i < dcp->map->length; i++) {
@@ -650,6 +704,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		if (test_bit(i, &inbits) == test_bit(i, dcp->bits))
 			continue;
 
+		vpr_info("set_dyndbg_classes: bit %d: %s\n", i, dcp->map->classes[i]);
 		totct += do_callback_changes(dcp, i, &inbits);
 	}
 	*dcp->bits = inbits;
-- 
2.35.3

