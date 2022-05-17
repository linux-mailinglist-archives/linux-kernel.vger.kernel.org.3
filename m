Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140D529F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiEQKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbiEQKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:34:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8AF25EA2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:33:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g17so5963551wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YOMQmW9gaEYOhufzv8k7dSqvHEGL6JRyKnu3FkUIHQ=;
        b=D97OZNqnw0aTaI7G3kJw3C0LUVZgUjsSxt31TsraDae0M3thFfTtmzuN+bYp5Pw5Z7
         /nT7kMq0KHY0iDbJQA3cT2qPKbT0jtaEq8KFbKPf6dmSDs8yQmLELO4C0EOMenSggSJ6
         Wi13U/OTe1hRQAVH2loV5MlwFphsJeBjp/KbQ0qffR7JEBmKbfXvGjVXqpkikT0hT7Tw
         EhqAyX8mxqB4fMHeCb/m3qS5o6dHJxqjW0LYtrtGZn3yVyR376uWLpMhnBJHE1GmtZR+
         dGSkmYZINI0LvdEeS2JlSpULSYnocjnNTpIygZI0eZkRMGMiQqpDDJP3x+uvZSLsEZwG
         Wphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YOMQmW9gaEYOhufzv8k7dSqvHEGL6JRyKnu3FkUIHQ=;
        b=GSPbgFZo8/5f4rwtj8RCChwnOg/yGZtFhj0SNrj9k9gIRJnIDGy8Jjgr6mwrdrjytS
         6crE/4ZWdZiTavGT6z5Zs+ajez95tXTt5/hoVgaGzl4vKlphIKtJDReS4CJ77gEEtVYu
         kLRKP8o90+bWb3hpwMbXBHmjyjPr6gDfruw/wPs85MG2lYF5nrykqT6BSxoZp706N6M0
         sb/5BdRcRzoVUIy1p8v21OTB3k+y7HLXWSKyTQloouJ/UwyGssGNcrQejkhd0TSqSzyQ
         3xUo6fgu1Anf+1ZhCvzIy6ITJpI1qXSnPuMYlAM3WdUKc7pBWGwsgT8o6Ciw4cslGcjZ
         nfrw==
X-Gm-Message-State: AOAM530BlcAjInUYExcY6fRziqIelt9a9JIWtIUJ4rBrNKVmQcZETvcP
        Qmf9DzpmrGJuWqPXp0NafHA=
X-Google-Smtp-Source: ABdhPJxCTZ3DDAI+762W3zpAgiK3LoMdi3+NoabQfQP9vuzWT/Y7nlEJXAYxpOh6x5GLaPZ2TCS+ig==
X-Received: by 2002:adf:fb86:0:b0:20c:de22:79f2 with SMTP id a6-20020adffb86000000b0020cde2279f2mr18839378wrr.171.1652783627446;
        Tue, 17 May 2022 03:33:47 -0700 (PDT)
Received: from desk.. (p200300c55f3c02010000000000000003.dip0.t-ipconnect.de. [2003:c5:5f3c:201::3])
        by smtp.gmail.com with ESMTPSA id u28-20020adfa19c000000b0020d10a249eesm3296988wru.13.2022.05.17.03.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:33:46 -0700 (PDT)
From:   Julian Orth <ju.orth@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     ju.orth@gmail.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/1] audit,io_uring,io-wq: call __audit_uring_exit for dummy contexts
Date:   Tue, 17 May 2022 12:32:52 +0200
Message-Id: <20220517103253.22601-1-ju.orth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

After porting my wayland compositor to io_uring, I noticed that my logs
were getting spammed with the following messages (tested with 5.17.7 and
5.18.0-rc7):

    WARNING: CPU: 10 PID: 983 at kernel/auditsc.c:2041 __audit_syscall_entry+0x1>
    Modules linked in: vrf wireguard curve25519_x86_64 libchacha20poly1305 chach>
     ipmi_msghandler crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mb>
    CPU: 10 PID: 983 Comm: jay Tainted: G        W         5.18.0-rc7-dirty #5 1>
    Hardware name: Gigabyte Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS >
    RIP: 0010:__audit_syscall_entry+0x111/0x140
    Code: e8 24 69 ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 4>
    RSP: 0018:ffffa6e480887de8 EFLAGS: 00010202
    RAX: 0000000000000000 RBX: ffff969c92f22400 RCX: 0000000000000001
    RDX: 0000000000000001 RSI: 0000000000000007 RDI: ffff969c8fa4c080
    RBP: 00000000000001aa R08: 0000000000000001 R09: 0000000000000000
    R10: 0000000000000002 R11: 0000000000000001 R12: 00000000000001aa
    R13: ffffa6e480887f58 R14: 00000000000001aa R15: 0000000000000000
    FS:  00007fefe020f040(0000) GS:ffff96a39ea80000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fefac429000 CR3: 0000000103674000 CR4: 00000000003506e0
    Call Trace:
     <TASK>
     ? get_signal+0x8d/0x990
     syscall_trace_enter.constprop.0+0x121/0x1a0
     do_syscall_64+0x36/0x80
     ? arch_do_signal_or_restart+0x44/0x750
     ? syscall_exit_to_user_mode+0x22/0x40
     ? exit_to_user_mode_prepare+0xd3/0x140
     entry_SYSCALL_64_after_hwframe+0x44/0xae
    RIP: 0033:0x7fefe0d0b67d
    Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 4>
    RSP: 002b:00007fff383a6c58 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
    RAX: ffffffffffffffda RBX: 00005595f1c25e00 RCX: 00007fefe0d0b67d
    RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000007
    RBP: 00005595f1c1b700 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
    R13: 0000000000000005 R14: 00005595f1c21f60 R15: 0000000000000001
     </TASK>
    ---[ end trace 0000000000000000 ]---
    audit: unrecoverable error in audit_syscall_entry()

I traced this to the context not being reset after audit_uring_entry if
the created context was a dummy context. I am surprised that I would be
the first one to find this problem but maybe io_uring is rarely used on
systems where auditing is enabled or a recent kernel change elsewhere
caused this problem to surface.

Julian Orth (1):
  audit,io_uring,io-wq: call __audit_uring_exit for dummy contexts

 include/linux/audit.h | 2 +-
 kernel/auditsc.c      | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.36.1

