Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80A4AE95D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiBIFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:35:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiBIFZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:25:08 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DECC03544E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:25:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f24-20020aa782d8000000b004bc00caa4c0so1036596pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1uteCcqOHI/0uzMt0En4ebHH5gvzXxzw9MhZz5KXgD4=;
        b=IQmADCKRqBcDLWqGxwMOAV/ntlFvKBjJk8wBMDf2/VG5DCJCbge4vXYImJfFccc++A
         FCOIryAiTwqcPt2Ose0mF9PMjL9KBQ7/6PWrKYyj6UkAsqtHb+NZNf1XdL0X0NoThMpL
         ieO6Akmo3Mh60DeJ+NoUTjGFteZD8CATPm/I+5d/ydBFZGHCxfjMjHMtzHTk4VZEIy6h
         9n/ShJpAMFNJHtDIHkK/MEzbkec+aNII1ATfCq90CtiW6zk3EjxREHjJWmGlRo4zZuYb
         JilPpQ0FQpnOXEW+VQFDwIW5vWSALo2j8mWBZjnavFR74JID6XTPkkTdqoiHU6irUrtm
         gsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1uteCcqOHI/0uzMt0En4ebHH5gvzXxzw9MhZz5KXgD4=;
        b=uoKnBQLTo2Jog23YCzVAWGPQ2IuwQFHjN/mOpPyHwVJhfhVVmL2+DCB/ZRHOqB3clc
         dfxEWgC0jbL1OY72gg3j1PudMgeRyOTgp0tcFDpORAwTQaY7pXgQ4sX/xlodBEjIXgsK
         Dmb/QGTlCnY7JJaVNivVTKa8iJirL8I9hZ3mc0KfrWRJAipHfBn2H4u2xSRhksVslyeH
         7y39M4B+/wX7BDUXUKsinHcI/CVungF20i8f4eIPDKN5xXE7JHR3pbetWLqvJf2B5LXi
         psFcsJ9UAuVtUGwc2omMYNZVbB9c25V9BNIGRHJOKI9ObLkVDqvijXJu5sLx0Qt/4Uua
         BRNQ==
X-Gm-Message-State: AOAM530Jebxa5ZYP+Dkr4WMNtQn4CnxIMVoSjEye4NV243tRDe/raqR0
        AVviQvF+9IX0p2H7yiMcPAzB9S+7u+uT
X-Google-Smtp-Source: ABdhPJzglferL7rdNcij5KHw2MyxXfeQS6wr03V//WCG/OaB8ZKXVTKSopF3i4fEW93Gs1qNs/mGYQwMkeNJ
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a05:6a00:1a8d:: with SMTP id
 e13mr600902pfv.82.1644384311846; Tue, 08 Feb 2022 21:25:11 -0800 (PST)
Date:   Wed,  9 Feb 2022 05:21:40 +0000
Message-Id: <20220209052141.140063-1-connoro@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH bpf-next] lib/Kconfig.debug: add prompt for kernel module BTF
From:   "Connor O'Brien" <connoro@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Connor O'Brien" <connoro@google.com>
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

With DEBUG_INFO_BTF_MODULES enabled, a BTF mismatch between vmlinux
and a separately-built module prevents the module from loading, even
if the ABI is otherwise compatible and the module would otherwise load
without issues. Currently this can be avoided only by disabling BTF
entirely; disabling just module BTF would be sufficient but is not
possible with the current Kconfig.

Add a prompt for DEBUG_INFO_BTF_MODULES to allow it to be disabled
independently.

Signed-off-by: Connor O'Brien <connoro@google.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1555da672275..a6bbd4bb2bde 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -334,7 +334,7 @@ config PAHOLE_HAS_BTF_TAG
 	  these attributes, so make the config depend on CC_IS_CLANG.
 
 config DEBUG_INFO_BTF_MODULES
-	def_bool y
+	bool "Generate BTF typeinfo for modules"
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
 	help
 	  Generate compact split BTF type information for kernel modules.
-- 
2.35.0.263.gb82422642f-goog

