Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059FE4BA2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbiBQOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:20:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiBQOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:20:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B16B2AB503;
        Thu, 17 Feb 2022 06:19:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s24so3501995edr.5;
        Thu, 17 Feb 2022 06:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34fL4NqlAoLJua8M+pFULEjbvr6GeWNUkJkrsk+jKBE=;
        b=WEpbwfgk88PUuTO+VlH1Ttupl14jX0yjVBtnMDjdk3nG3qIzviLn102+ejYHpkbnCM
         OxKBeaB288ju/lJ+BB/N/hd0uymKdvZVsHmKJ+a/WF9WJhniZT7vs0/i0coVdtVf99Dd
         KCe3xbyUPJrBGMhs9bNqoHplDLCX/j2u1E0Zw4YoMCjZtZtMZK5vqxxLc95NYZlRhc2V
         0waB0O8OvN7GDtYPF/9gTQSdJUqokcBd+UCrdk8qfS5YxQIJ3aqMZxhaXAigvv8n+GMU
         /XMSiBMXbTWvXxe9DdRgbD1DSK7BsnRJieLBowca9UGif/2LcBWOLGWnv7ia/zyZIRPn
         H8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34fL4NqlAoLJua8M+pFULEjbvr6GeWNUkJkrsk+jKBE=;
        b=TH0ueaCb4Rw0bgtAVt0yb0rmS1nWU6A/+F1h9zCro+Csghay85uaA7Hogc2PbbapTZ
         7TGrlpsllJPWS83QChcVv2Z1FWfBSRH7vsjAuTAqOOjufyvA+cq6OEOvNGuJo0tFB5Al
         c/cTfCrfgdj6EuB57GXpmHvg27rdPBB3sbiexWBoL7pGzXCQXm8lLMw3uno3dV/vvpvR
         rimzbQsZSV2KLu2Iz2ynloibirqIXKX08GsOPPg67SU5PjMxD2rTBum00T+D2cLtlCvb
         5BN69ImsNI7vg4aQaL19vOnA7eysMOHoEO3mUrUHGOrZ8jcEMufyDDPr+JYbDHgiwdSW
         RB9Q==
X-Gm-Message-State: AOAM533j810idDrgrm6TaYFvakxv9WmQ2e86ORUKY7diwUcZbxVwwIJG
        GkN1jnK0TrxZRGtYFbjnRPoeW8siFtg1jQ==
X-Google-Smtp-Source: ABdhPJwdR01rqPlAyrTDX19Dd12YuovmEsjKXjZvtfUhRWdLiVzt3EqKqmwf+CesVHtx9HHLmJu8+A==
X-Received: by 2002:a50:e187:0:b0:406:fb92:80ce with SMTP id k7-20020a50e187000000b00406fb9280cemr2784993edl.164.1645107588798;
        Thu, 17 Feb 2022 06:19:48 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id hh13sm1254971ejb.89.2022.02.17.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:19:48 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Todd Kjos <tkjos@google.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] security: declare member holding string literal const
Date:   Thu, 17 Feb 2022 15:18:57 +0100
Message-Id: <20220217141858.71281-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The struct security_hook_list member lsm is assigned in
security_add_hooks() with string literals passed from the individual
security modules.  Declare the function parameter and the struct member
const to signal their immutability.

Reported by Clang [-Wwrite-strings]:

    security/selinux/hooks.c:7388:63: error: passing 'const char [8]' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
            security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), selinux);
                                                                         ^~~~~~~~~
    ./include/linux/lsm_hooks.h:1629:11: note: passing argument to parameter 'lsm' here
                                    char *lsm);
                                          ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/lsm_hooks.h | 4 ++--
 security/security.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 419b5febc3ca..47cdf3fbecef 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1595,7 +1595,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	const char			*lsm;
 } __randomize_layout;
 
 /*
@@ -1630,7 +1630,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+				const char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/security/security.c b/security/security.c
index 9663ffcca4b0..a48eb3badfdd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -478,7 +478,7 @@ static int lsm_append(const char *new, char **result)
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+				const char *lsm)
 {
 	int i;
 
-- 
2.35.1

