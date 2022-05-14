Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46096527424
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiENVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiENVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:15:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D382558D
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x8so7215674pgr.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJelr6XDvO4AfkGbdbA8Y7Zx3lre1EHsyNEOn4pLeLU=;
        b=OGUdMpgjlBgy7v6jB35voX+Z4PH9UheaSl/oL8e6co97wmxzZKUofJtexjXamGiOpr
         i2+X3QOdWHWZaxlsOoWHS7CUnEgna/03I/WJa14mwjTy5Qo42TyBk6RK2h1os/KJqtGp
         Aiir1H43xL+RxWgOxze88ANgsr2i8Q49ls3ylxpKCc1sgRC6Pn8JSb/Bfy1rGd3sfNIX
         r9Qr1CG2ExyFULcq4xyE0PbQYKQB6Py65bqTgEYgiw56vtYuWSWblJKEmczPetbL/lA6
         Ai1jlOS9wOpY/VzW1H40M2ELBZ4y5ZBbe4GbLiFqRUvo0SJv18ANN0s7pFw6DWQmxGM4
         suQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJelr6XDvO4AfkGbdbA8Y7Zx3lre1EHsyNEOn4pLeLU=;
        b=BTsWtYnnOVBaejQQnpWEJ/l2iPMDXIUwhr/34a2qIlF9aRBDJPwYySdi7QuA9al8vr
         IySUWaSax0HfYS04VYe7l9oTpCgSoIFLlOQsqxHJSzmmoJrHIHEXcJUDYzS1nmiFlXLW
         J/gnZoia0LUcuyeEPEJgS3k3uBkGYCLXBeeamtYwHFRRsYMWy4yyEmSy3p9HkEQ54SF3
         sMaJo37jhVlj7R2NXzvastZd0/og4fR2+OZ3WMfVjpTfX8ABM6e+8KQdGeXhH5EtgMBi
         jaFo8rbPsVkpM7/0AnmVwbvvfouNK6g8011pvX44a9B9JuQ+cNezmBnwuDDoWN8zeKvt
         ywZg==
X-Gm-Message-State: AOAM532mMJkNMh1cGO7V8SSyACM29UQWMk9Qy82YAb077+aGXh7vvL7x
        KRQ3hw6cOANJAK/x8c3mobo=
X-Google-Smtp-Source: ABdhPJzBCRSbfTahTJctvLOdUPn+sjf+y+xgMS/nNJHGd5ElaeH1wFlzitlLHOMl7bwoRBwJzao7kQ==
X-Received: by 2002:a05:6a00:1582:b0:510:4e67:31d7 with SMTP id u2-20020a056a00158200b005104e6731d7mr10806792pfk.80.1652562929330;
        Sat, 14 May 2022 14:15:29 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id e35-20020a635023000000b003db141a5f26sm3826825pgb.1.2022.05.14.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:15:29 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, paul@paul-moore.com,
        eparis@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        yesshedi@gmail.com, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 4/5] audit: remove redundant data_len check
Date:   Sun, 15 May 2022 02:44:54 +0530
Message-Id: <20220514211455.284782-4-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514211455.284782-1-sshedi@vmware.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 7690c29d4ee4..0749211d5552 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1390,7 +1390,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 						 str);
 			} else {
 				audit_log_format(ab, " data=");
-				if (data_len > 0 && str[data_len - 1] == '\0')
+				if (str[data_len - 1] == '\0')
 					data_len--;
 				audit_log_n_untrustedstring(ab, str, data_len);
 			}
-- 
2.36.1

