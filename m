Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A84F0D82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376892AbiDDCZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiDDCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:25:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE03E13F66
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:23:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kk12so6445927qvb.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAtjPlLfx0VmmOYMr4in9Xxivmt6Fjx5bb2eZBpD2ww=;
        b=MWxXisTJx+T6LFXDGkwE7UgOUWeBbSxo/kfl3wBUyOrXCbV/Iaf/H3Lgl85+4rVD/7
         2ZrkAE/4VQTHatdGAJGj9z/oWwwqKA72yf1jYbdpFhEjrrDSj740LP6PPRJ4qtEwJjIR
         hPjjM1L0nJ44h+qgUoqzF7KeYnDz2x8g+PEIJ1pAxxY6Ue9EzfZjN9D7I0sf3rb3/efz
         T1MRNegqU8Em8xtfbTw+Wpjaa6bETlV6CXfbZSwSsgW4vLC05FA+U3D+WLt25NYEsSG7
         MVh7E/FX1117QSdS4wBNDeZoyxuWMxwZo6+nz04SksIHrrFX97QdOV8IUDg1HMAhwJVf
         kInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAtjPlLfx0VmmOYMr4in9Xxivmt6Fjx5bb2eZBpD2ww=;
        b=g2HBipq4dKoflBuNQWL3K4tznaOQZbnF1KfEAql523TZF1aAmCTV4fLHtHIUg3+GsL
         q7P+M3KvlPrpYJcl+LKxpL9pnw3A+fFvp8TQ1k50fpNmncNBUoRG3pOII8rOYiBJATNg
         Ra2O3OsDkIsj9FQQSP2JmbSN6ABFyzBvDCqzoT52JKaFV4oXzwMxjiX0kC4vhL+PLxU7
         SKfhf1jR+tK6VD3gzG1EHY/dTImB5oziU0H8M4SDj8LrwGX5fB/v5xEsuYLsTmSjWu7M
         bnbBqbznOITe2Lk2ZA1yXabn3jaKfEfdiOQ9IgtvZk3Lt9ww4bF/VSaeJWpHwyQDH7lA
         D7Tg==
X-Gm-Message-State: AOAM532DdpEY0noPdvBmaU1qBoYj7CpwqebyQMy86WGuDd4VokOwk9cP
        LsSfKSuQWA8bs1TR9LFdMu2Vm568XXQ=
X-Google-Smtp-Source: ABdhPJyE7F81Nxr9CSVNVi1tARUdLCpfDYZHYZaua3YoeeNrUtYtnwR01UJ5HmgQ8br4Ush4DOKHkw==
X-Received: by 2002:ad4:5de4:0:b0:441:5fdf:ddae with SMTP id jn4-20020ad45de4000000b004415fdfddaemr48302739qvb.100.1649039036241;
        Sun, 03 Apr 2022 19:23:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002eb871fbdf8sm7461166qtw.18.2022.04.03.19.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 19:23:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        rth@twiddle.net, sgrubb@redhat.com
Cc:     linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] audit: do a quick exit when syscall number is less than 0
Date:   Mon,  4 Apr 2022 02:23:18 +0000
Message-Id: <20220404022317.2449865-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Userspace may use syscall with syscall number less than 0 by calling
syscall(syscall_num,..). This kind of syscall could never be audited,
because auditctl requires rule with syscall number >=0. Therefore we
better do a quick handle no need to gohead with this situation.

Note that auditctl may set rules auditing invalid syscall with syscall
number bigger than NR_syscalls, to keep this mechanism working, we do
no more check(context->major bigger than NR_syscalls or not).

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
---
v2:
- cancel checking against NR_syscalls
---
 kernel/auditsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..79118c811853 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2077,7 +2077,8 @@ void __audit_syscall_exit(int success, long return_code)
 	struct audit_context *context = audit_context();
 
 	if (!context || context->dummy ||
-	    context->context != AUDIT_CTX_SYSCALL)
+	    context->context != AUDIT_CTX_SYSCALL ||
+	    unlikely(context->major < 0))
 		goto out;
 
 	/* this may generate CONFIG_CHANGE records */
-- 
2.25.1

