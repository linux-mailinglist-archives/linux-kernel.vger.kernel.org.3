Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67FA4AF67C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiBIQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiBIQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:25:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37AC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:25:15 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D2FA3F1F0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644423911;
        bh=/xekYk/q8PDd5X+mZnZ/+eb+Bf0iUFVR8K4RtVmP8o4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=U+gjmSlolYuUisQo0EDYIhK5RHaPwDdDvXikHufLFgBTfai88FvWmsUUsnmhJkFXu
         R1eAHAPiBgJByKS9ryg1Awn2zOSnG+ECzbMxHsjEbDAvJlm+CN5MDCa0+xQyFzlcnK
         uemSpDXlqnZJGjXjw//W36FVYRMPGixvZM/TSPmvlnVpw6dfdyU1X6SoE7Zs4H2wfz
         QtPpJgZTmot60G5y3+dbxJFnmRkLEIHcqv567Vg1P8CVsx+m/almcfdvbZiEnedGiP
         /sMcrk9f2Rxi/jHF2XaEnCp5+9RvlC2ht1p1/BSYnPt3GbXXK6ce1c+OiInk3wEqVy
         KXIJ5qCGMXjUQ==
Received: by mail-ej1-f71.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so1415357ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xekYk/q8PDd5X+mZnZ/+eb+Bf0iUFVR8K4RtVmP8o4=;
        b=3lGRXbCo+SJYl8dcSFaYgQsnyQ/YiEsyadhh/VMByIfC4wj0KP6iELlqgLhFPN1ejA
         0JYL0Yx4h3h0BqR0VdbLUrb7Tot35+ZN6yNASgHaNRnUvhy66epbwy89+TNe2x47xRLt
         CJhuVG57J8twANyUskPlmOHmtV+Id5AxGfMjxdYeklCCgKz3b8tNRhXU2HUesLgVzKAT
         nTgkKpnF66BVkFnLNmI7t9yxJJGkEL9pvMsnvZ7jR6koyswTKdsqEq1trvK6Wm2pTwtp
         BqpHS+h3Ys+xWfj3FtRPn80uW0Otte2hQtnt0Rz9YSc5jKSxcsycVdna8P2pxLvadwuS
         r3Ow==
X-Gm-Message-State: AOAM532tL69mrk3Fkw3KO3kC8rhoeCYNxmCDMZ7gqJLrsdPcos8qEPPf
        qrjHZrcBt3xlAHmrW5sMSM10MVvvz6vMETBu4oIwHt11de3dVWjGwINEWnEJx7oz0wdcOwl669I
        CYlEbGndOSq7zJyu9iwV/JeOeLKJL8Cdi3SO/DciEOQ==
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr2642421ejc.219.1644423910884;
        Wed, 09 Feb 2022 08:25:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKvtjCZePVTEi6+XanNHWx67xsb5RlaQqVAD+8Rt87SKNwj0aCwZWrYYo6ZHiUBiw21MJl1A==
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr2642412ejc.219.1644423910718;
        Wed, 09 Feb 2022 08:25:10 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d23sm6687575edv.79.2022.02.09.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:25:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
Subject: [PATCH] selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT
Date:   Wed,  9 Feb 2022 17:24:30 +0100
Message-Id: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
do_softirq fails for such kernel:

  echo do_softirq
  ftracetest: 81: echo: echo: I/O error

Choose some other externally visible function for the test.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

I understand that the failure does not exist on mainline kernel (only
with PREEMPT_RT patchset) but the change does not harm it.

If it is not suitable alone, please consider it for RT patchset.
---
 .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index e96e279e0533..1d0c7601865f 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="do_softirq"
+FUNC2="_printk"
 
 ALL_FUNCS="#### all functions enabled ####"
 
-- 
2.32.0

