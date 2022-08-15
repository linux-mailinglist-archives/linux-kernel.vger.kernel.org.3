Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1D5932F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiHOQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiHOQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:41 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F11759F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-116c7286aaaso8640522fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=BSoTNICrMj7u/TGLx7cm1e33DdNye1p3mIhcbsI607s=;
        b=KInnq098LCWs5kg+cX63AWfFPPNfgicW4dz+z/PeD/+DN4q0G1c4WxPhxdS0HovuP6
         Gw20+HN0SO+KQ+dpOPTgZ40IlusbkswAnwxW4ppuftQgEHziJp1APc6lf78h5nLctEqK
         jJBxZ2sv/gFyKvOO4233k+8J81NsYuEOlODUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=BSoTNICrMj7u/TGLx7cm1e33DdNye1p3mIhcbsI607s=;
        b=QRDNCHNOv6TPgNNNWlEWpR5thPapX0z3CNoBeGWDRm5EaxZiSd81ZfQCKzh6+KMUQz
         +uIHcmbuuZo/DjKFYWgkgTX/iqMrFlqJ4ZngTAb0mfDAjUyQDZFOwpmDHRLIy+vjnLgF
         3gB1YaDkn37+jYVWGymVclUUzlyX82iYbCyTJlT5Lz3vpUSHowoQLEhPgykrJOPiVp/W
         G4Jk99C6k7mQF1m79x/JT4j+anPCHQ/+9EqBP6YGNdzR65x9QC1YcuGILyyIEGDwqlL4
         jiZoFV49Qkvthd+K07+3LLE3jcXrgm5aRBQslQSAnP65x1IaYjJ+Hcso5J+lkDwdBSj5
         QP0A==
X-Gm-Message-State: ACgBeo3vq4tHFfNKc4EvLo43hft6RPDH/iCKIvHE1WBT2Pu4I7WRCS+/
        HcBcbbNmhBPJOBNYe9ZKzdBaLQ==
X-Google-Smtp-Source: AA6agR78nAzd1nRQswnX5CWOif43etOxtDbBfDmKa4nzMrWkz8NAms1Thrx+XPtPcVl4miGYXiqyuQ==
X-Received: by 2002:a05:6870:d60a:b0:10e:4333:d773 with SMTP id a10-20020a056870d60a00b0010e4333d773mr7168256oaq.78.1660580435563;
        Mon, 15 Aug 2022 09:20:35 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id x91-20020a9d37e4000000b00636ee04e7aesm2163371otb.67.2022.08.15.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:20:35 -0700 (PDT)
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
        karl@bigbadwolfsecurity.com, tixxdz@gmail.com,
        Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v5 0/4] Introduce security_create_user_ns()
Date:   Mon, 15 Aug 2022 11:20:24 -0500
Message-Id: <20220815162028.926858-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While user namespaces do not make the kernel more vulnerable, they are however
used to initiate exploits. Some users do not want to block namespace creation
for the entirety of the system, which some distributions provide. Instead, we
needed a way to have some applications be blocked, and others allowed. This is
not possible with those tools. Managing hierarchies also did not fit our case
because we're determining which tasks are allowed based on their attributes.

While exploring a solution, we first leveraged the LSM cred_prepare hook
because that is the closest hook to prevent a call to create_user_ns().

The calls look something like this:

    cred = prepare_creds()
        security_prepare_creds()
            call_int_hook(cred_prepare, ...
    if (cred)
        create_user_ns(cred)

We noticed that error codes were not propagated from this hook and
introduced a patch [1] to propagate those errors.

The discussion notes that security_prepare_creds() is not appropriate for
MAC policies, and instead the hook is meant for LSM authors to prepare
credentials for mutation. [2]

Additionally, cred_prepare hook is not without problems. Handling the clone3
case is a bit more tricky due to the user space pointer passed to it. This
makes checking the syscall subject to a possible TOCTTOU attack.

Ultimately, we concluded that a better course of action is to introduce
a new security hook for LSM authors. [3]

This patch set first introduces a new security_create_user_ns() function
and userns_create LSM hook, then marks the hook as sleepable in BPF. The
following patches after include a BPF test and a patch for an SELinux
implementation.

We want to encourage use of user namespaces, and also cater the needs
of users/administrators to observe and/or control access. There is no
expectation of an impact on user space applications because access control 
is opt-in, and users wishing to observe within a LSM context 


Links:
1. https://lore.kernel.org/all/20220608150942.776446-1-fred@cloudflare.com/
2. https://lore.kernel.org/all/87y1xzyhub.fsf@email.froward.int.ebiederm.org/
3. https://lore.kernel.org/all/9fe9cd9f-1ded-a179-8ded-5fde8960a586@cloudflare.com/

Past discussions:
V4: https://lore.kernel.org/all/20220801180146.1157914-1-fred@cloudflare.com/
V3: https://lore.kernel.org/all/20220721172808.585539-1-fred@cloudflare.com/
V2: https://lore.kernel.org/all/20220707223228.1940249-1-fred@cloudflare.com/
V1: https://lore.kernel.org/all/20220621233939.993579-1-fred@cloudflare.com/

Changes since v4:
- Update commit description
- Update cover letter
Changes since v3:
- Explicitly set CAP_SYS_ADMIN to test namespace is created given
  permission
- Simplify BPF test to use sleepable hook only
- Prefer unshare() over clone() for tests
Changes since v2:
- Rename create_user_ns hook to userns_create
- Use user_namespace as an object opposed to a generic namespace object
- s/domB_t/domA_t in commit message
Changes since v1:
- Add selftests/bpf: Add tests verifying bpf lsm create_user_ns hook patch
- Add selinux: Implement create_user_ns hook patch
- Change function signature of security_create_user_ns() to only take
  struct cred
- Move security_create_user_ns() call after id mapping check in
  create_user_ns()
- Update documentation to reflect changes

Frederick Lawler (4):
  security, lsm: Introduce security_create_user_ns()
  bpf-lsm: Make bpf_lsm_userns_create() sleepable
  selftests/bpf: Add tests verifying bpf lsm userns_create hook
  selinux: Implement userns_create hook

 include/linux/lsm_hook_defs.h                 |   1 +
 include/linux/lsm_hooks.h                     |   4 +
 include/linux/security.h                      |   6 ++
 kernel/bpf/bpf_lsm.c                          |   1 +
 kernel/user_namespace.c                       |   5 +
 security/security.c                           |   5 +
 security/selinux/hooks.c                      |   9 ++
 security/selinux/include/classmap.h           |   2 +
 .../selftests/bpf/prog_tests/deny_namespace.c | 102 ++++++++++++++++++
 .../selftests/bpf/progs/test_deny_namespace.c |  33 ++++++
 10 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/deny_namespace.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_deny_namespace.c

-- 
2.30.2

