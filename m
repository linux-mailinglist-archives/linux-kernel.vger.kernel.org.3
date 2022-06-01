Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B35539A93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348879AbiFABAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFABA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:00:29 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858698B09E
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:00:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l2-20020a17090a72c200b001e325e14e3eso269906pjk.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n2ROgmsu4sIvgkjrddl1E7EJwGsloeHvNDXhQjUkZ4U=;
        b=XGHLvIpS34e04S1KN4cIKYRw35l6Jfpp0jA6UjVtY2HHQfj/yo5wuSjEMMm2i6ejiu
         cyi0SjeWU2AnA4kLJ0iGOg2U3F/5PR2Dyvt2j17vsD53g97auTKFtec/6QiF4ElXE606
         ogk6gyFgJRcG4g5rZC2XZkGm7LX9CTTvBcpoxi6jB6njXOEh2HFUn4elUBSMoKItKwWM
         Ltb4wxYG1lriSorcNG7kH9UnCpQhJOWyyl0W/JereQhUe1RDcu6t2Ev0QvIAmLoXCJEe
         iT8bDpLO31/bXfaS0a+2VI5sJW1f1ntTBfF/2Id9C5N32Pzv72uHv1vPchlCYBXBwvq0
         SmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n2ROgmsu4sIvgkjrddl1E7EJwGsloeHvNDXhQjUkZ4U=;
        b=QVUwmtM7do3Aw+YQ2yP3ijVRLcEdDvg3sTgYm9DRUGNguNQJNV1UFwkc0QCI41XP7h
         /87CQAJXB0kvXCkb8WJ7afnc1aFkkfisBpHbMFH9zrccG1lr/dAWU60QxHfbPYIQTqtW
         mx6nWywzeZCCsXgQSeysxQfEIAOeYUK8rkTGTQSkUBJS7AFQPL7m4qE4kXwW+42CNhwq
         pbTXT0bOr5v+gZXE0tek6d83p4TZgBX3s9YvwsPF+yJ5BS7A3Q+1tqMPa8mdxTt0dxD8
         C/gbOG7P6n+KKS68wMIl+zvpb1M9HajuFCD8XRbecc5RLzKvhfZBHZZwS5DYN+M3JyAF
         AsXg==
X-Gm-Message-State: AOAM533Xt60s89YTvTjWICPappnrsDBU+vHei3jhhcMXVT8a4x/xZ3Ew
        UsO2CENmoSNhnzGeyb/O/hL6z503YgkLSg==
X-Google-Smtp-Source: ABdhPJyVDyQF8isw1ApHd7NfPfV01kkNd9ziwWgAUoUFNx6OKHIhxgLoWzHJhX0tG3k88Fze6RfyPnLAdQz2XA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:d4ca:b0:164:1971:1504 with SMTP
 id o10-20020a170902d4ca00b0016419711504mr2900163plg.138.1654045227984; Tue,
 31 May 2022 18:00:27 -0700 (PDT)
Date:   Wed,  1 Jun 2022 01:00:17 +0000
Message-Id: <20220601010017.2639048-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] binder: fix sender_euid type in uapi header
From:   Carlos Llamas <cmllamas@google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>,
        Christopher Ferris <cferris@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The {pid,uid}_t fields of struct binder_transaction were recently
replaced to use kernel types in commit 169adc2b6b3c ("android/binder.h:
add linux/android/binder(fs).h to UAPI compile-test coverage").

However, using __kernel_uid_t here breaks backwards compatibility in
architectures using 16-bits for this type, since glibc and some others
still expect a 32-bit uid_t. Instead, let's use __kernel_uid32_t which
avoids this compatibility problem.

Fixes: 169adc2b6b3c ("android/binder.h: add linux/android/binder(fs).h to UAPI compile-test coverage")
Reported-by: Christopher Ferris <cferris@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/uapi/linux/android/binder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 11157fae8a8e..688bcdaeed53 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -289,7 +289,7 @@ struct binder_transaction_data {
 	/* General information about the transaction. */
 	__u32	        flags;
 	__kernel_pid_t	sender_pid;
-	__kernel_uid_t	sender_euid;
+	__kernel_uid32_t	sender_euid;
 	binder_size_t	data_size;	/* number of bytes of data */
 	binder_size_t	offsets_size;	/* number of bytes of offsets */
 
-- 
2.36.1.255.ge46751e96f-goog

