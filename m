Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FEB57D289
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiGUR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiGUR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183C8AEC7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:28:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3281205fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6LYDJ5GUZQ1KxKmuQvjM8e+PjJ6MYTVNoyEg+XMI5E=;
        b=F39o6zdL20qsFmVOEom+uZ7fZ1c6R3EBwJRsLcWhmxXYO27c6yuW+TxLtfux5NlgDH
         irmniKptcO3EquVJiLXT4swrivgKEjFsVwhHaOVwvQVf4TU8rP/Px4s8VIliE+DPGanH
         T7MHIVfNsMtTbYomDDw28omIpxiFgcqexK0jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6LYDJ5GUZQ1KxKmuQvjM8e+PjJ6MYTVNoyEg+XMI5E=;
        b=T2Xu7uknrZsXqN6jQgmMsyqOUsD+Rc/mI3rrYAFNFpTgqha92BEzU0W37ovJ+U/3v7
         s0pk12RFaQeCWiZ2lhCcIEWNv6C6X99KrDZb+4Jnous7+hzx0WQovWsMqv2pw6EllZ/h
         OwED3z0bwwNYHiVXsF3KTWAham0clP4rHH7lyU4Qoic6Pyqpn/z4wPZhEn63zcWXejKk
         ctQ1w7/qqeCS03ABW+eyYwRoQ+etg5H7zi0vDeUTbuTP4w3htOFbojBo9aAIyeZxyHDe
         b0A0aAd0VSj9Pne415BbCRqfIJx++I29jzOBPx5tylILl9hIN9GeB638vkHwbNSI8Mgb
         13fg==
X-Gm-Message-State: AJIora+vIYLwiNDqh5x9b9Dn+jjUfGRxGneYP/jmujPxLc84lGNti1jS
        IGFNSizf92UvSZYviIfxGRQ4Og==
X-Google-Smtp-Source: AGRyM1uMOCDd3dpPREZw9AxRpt6f809MJwj0HOOSGYMg4yruTLyaIlx1XyM20S/Pw+ozM4Rqwgc/dg==
X-Received: by 2002:a05:6870:b398:b0:10d:67e:c615 with SMTP id w24-20020a056870b39800b0010d067ec615mr5426833oap.203.1658424498275;
        Thu, 21 Jul 2022 10:28:18 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id du24-20020a0568703a1800b00101c83352c6sm1106207oab.34.2022.07.21.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:28:17 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
Date:   Thu, 21 Jul 2022 12:28:06 -0500
Message-Id: <20220721172808.585539-3-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721172808.585539-1-fred@cloudflare.com>
References: <20220721172808.585539-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users may want to audit calls to security_create_user_ns() and access
user space memory. Also create_user_ns() runs without
pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
for mandatory access control policies.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v2:
- Rename create_user_ns hook to userns_create
Changes since v1:
- None
---
 kernel/bpf/bpf_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c1351df9f7ee..4593437809cc 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -250,6 +250,7 @@ BTF_ID(func, bpf_lsm_task_getsecid_obj)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
+BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
-- 
2.30.2

