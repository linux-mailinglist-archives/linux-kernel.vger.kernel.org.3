Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD04D9572
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiCOHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbiCOHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:40:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32014B427
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so18281892pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNL6t5lwu7FCHObLJDj3kpok06MyY7kYsdfPJh4pywU=;
        b=hstT9zAftdIPC5pYGMSL7Y2WtiyiwooMIijoCRCV1UUsCoyWP0LVsGmT8Y4ajqKtf3
         9joK6+jWLV9GINxEGRBMKwEFChVeulxZX5CcdQ0dQmq3la5oCcZWgHQ9MlHzbLe93GAv
         oVdMB4vd0qiLXr68pG4pzJIlAUZai5Fp73tZqPI/4Kjv8lSeHH+Y3FwRNtdD2rttvDMg
         HuwptlKnOvJvdMNodaq7VQSRypNoJXfaW6rT+Kqs8PxV3PvXkVSjZPNrew4g8cKYUXC+
         zRJvkQuoIKupNMnEWGLE0Zk/RGdhr6Nv4cNNFIDk63kybVDHnp3s5sTi3WlhFInCoKXI
         LQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNL6t5lwu7FCHObLJDj3kpok06MyY7kYsdfPJh4pywU=;
        b=7105pOYEc0nlMQqGJf5tSPM1J3k8lo1l3eNW5SvyJm8MOH/GjM7HKt44MyOxgewvc2
         ZY1D6UzfHsfl9jQDMTY3wJMXeepxfwIeU05Rf7i0l7dx0EF6xTQOGHdxAhitKakJ2ZU7
         CAjz4d2GysDN9bMYH11/CZt09llFXcNYtc/itFIdxD6bn72PcHgLp3XgbqkTka6Yri3M
         GpViNVp6grrKrHZEjvJZmgo3kHsa3T5jcj/VaIKArRei0wFpJm8PzJ7r2rk2cixd8iKV
         fxQmBl2Fqeqyb9IC2ZU0LkCxXo0FJHDEO6rILJq+C/21QnIDc9WcgBYpbxZ7Loy2sPmC
         MNtQ==
X-Gm-Message-State: AOAM533iWXyWdYAz8rrcF99I7Y1kITNHR+Fyn5Kji4CzKm50p4eEwl8g
        qvSlGc/vd5PGgCWgfOZTABHmArOLKxw=
X-Google-Smtp-Source: ABdhPJwVQ0onuw3jsYfZDZyp6MG6Fav/xGeAj/UA9hOFNTk1uTnNby4WS3T24WTRI3XvIEwjV27j7Q==
X-Received: by 2002:aa7:8896:0:b0:4f7:b8f7:772e with SMTP id z22-20020aa78896000000b004f7b8f7772emr12425950pfe.62.1647329948114;
        Tue, 15 Mar 2022 00:39:08 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id j7-20020a637a47000000b003803fbcc005sm19116279pgn.59.2022.03.15.00.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V3 0/7] x86/entry: Clean up entry code
Date:   Tue, 15 Mar 2022 15:39:42 +0800
Message-Id: <20220315073949.7541-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

This patchset moves the stack-switch code to the place where
error_entry() return, unravels error_entry() from XENpv and makes
entry_INT80_compat use idtentry macro.

This patchset is highly related to XENpv, because it does the extra
cleanup to convert SWAPGS to swapgs after major cleanup is done.

The patches are the third try to pick patches from the patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which converts ASM code to C code.  These patches are prepared for that
purpose.  But this patchset has it own value: it simplifies the stack
switch, avoids leaving the old stack inside a function call, and
separates XENpv code with native code without adding new code.

Changed from V2:
	Make the patch of folding int80 thing as the first patch
	Add more changelog in "Switch the stack after error_entry() returns"

Changed from V1
	Squash cleanup patches converting SWAPGS to swapgs into one patch

	Use my official email address (Ant Group).  The work is backed
	by my company and I was incorrectly misunderstood that
	XXX@linux.alibaba.com is the only portal for opensource work
	in the corporate group.

[V2]: https://lore.kernel.org/lkml/20220303035434.20471-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gmail.com/

Lai Jiangshan (7):
  x86/entry: Use idtentry macro for entry_INT80_compat
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
  x86/entry: Move cld to the start of idtentry
  x86/entry: Don't call error_entry for XENPV
  x86/entry: Convert SWAPGS to swapgs and remove the definition of
    SWAPGS

 arch/x86/entry/entry_64.S        |  61 +++++++++++++-----
 arch/x86/entry/entry_64_compat.S | 105 +------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/irqflags.h  |   8 ---
 arch/x86/include/asm/proto.h     |   4 --
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  17 ++---
 7 files changed, 100 insertions(+), 144 deletions(-)

-- 
2.19.1.6.gb485710b

