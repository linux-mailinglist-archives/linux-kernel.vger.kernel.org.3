Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0451E757
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446451AbiEGNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiEGNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:16:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22B4666F
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:12:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so9250781pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WP+c3tP53jdxX94xMH6hjoK9csnlPLc7TbrfzziGG5I=;
        b=Q59yYV0TbMOQjEAxwpK+zMF4NJ117Tm5LR5sv0jqsx6nnfqq6ypVa8iubvWGWEI/S3
         YmPLZMz6ykENMjGWFNsawf3FhLGkupu3JIawOsP3aW3NfElvT7UTXXUiW7VVxqKYnZRh
         IBggppCTyC+wl5/2PCDBErBDtpSzfKCM+7DBcP5tkIy+9mZi6Ro5UxcuLiAHguWRD+/z
         qgmiEeltyIHTT8EFHpVRDgKvCaPAYjPwOFS8iSbCnABV5tugLJ0mAnYC34xUCpYhHeAZ
         Z2GwXVoj6BhP+PSZtExLnbMcOo5T1ZzBNTvJCpApVP34+Be+Dqf0ut8F/8orjq5jLPWN
         ervw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WP+c3tP53jdxX94xMH6hjoK9csnlPLc7TbrfzziGG5I=;
        b=dw/C3Ai3kvyBSZk8onST/EfAUTuAnrfhGHW6H1KN9mLHsR5il8N3OgDfr/9//ivDZi
         TfS4amymk0jqJ7fG7jH+VxWPsLT7FlL1GBtZOYjbW9zuzoSbkqXWtES7LK/5CnH8V9IW
         q4n7iZWT27QqFWglw8Gp6yW8K4X3DSmSoHPBRWzlZZVEj3M3rFPX9KaTOClk05OGSoOu
         BcASRjgt/GoQmyZTnPfcM6OUA4hiqErRJu5Lls+IpXOV2ftWO2t8rJYxpjiJmlN6CxAd
         iS0DX5tvevQM/ytbu8tT3Sb4ivGLAAcTs3TUls4vlBdYZ1wNyImzILYTMIvHVD3XFIfC
         183g==
X-Gm-Message-State: AOAM5309QwPAKkkm/6e9C2MIU0TlsLLj1qroxv1R9l3aXlAQtJtzG7I8
        2Q3iMtzVvn7kyRkIf4YnsBw=
X-Google-Smtp-Source: ABdhPJzwMbSb8aqir6y9x7SKJv9cGHKyXPKhQ6JeHcL1iCvwVfpiW00gRW2JmhHLwNjoTVDPVjFWiQ==
X-Received: by 2002:a17:902:e808:b0:15e:b27b:9302 with SMTP id u8-20020a170902e80800b0015eb27b9302mr8328149plg.54.1651929175964;
        Sat, 07 May 2022 06:12:55 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i191-20020a639dc8000000b003c14af50620sm571418pgd.56.2022.05.07.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:12:55 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v2 1/2] check-atomiscs: stop build if CONFIG_WERROR=y
Date:   Sat,  7 May 2022 22:11:44 +0900
Message-Id: <20220507131146.834810-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
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

If CONFIG_WERROR=y, stop the build if one of the generated atomics
header in include/linux/atomic/* is modified by returning an error
instead of a warning.

If CONFIG_WERROR is not set, behavior is unchanged (let the build
continue).

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 scripts/atomic/check-atomics.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 0e7bab3eb0d1..56f9e753bc74 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -26,8 +26,13 @@ while read header; do
 	NEWSUM="${NEWSUM%% *}"
 
 	if [ "${OLDSUM}" != "${NEWSUM}" ]; then
-		printf "warning: generated include/${header} has been modified.\n"
+		if grep -q CONFIG_WERROR=y .config; then
+			printf "error: generated include/${header} has been modified.\n"
+			exit 1
+		else
+			printf "warning: generated include/${header} has been modified.\n"
+		fi
 	fi
 done
 
-exit 0
+exit $?
-- 
2.35.1

