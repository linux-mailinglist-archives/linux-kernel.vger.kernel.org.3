Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1D5AF5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIFUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiIFUT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C810C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662495469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qi5VEGQWfKLp//Fd7xb1fflntdhdcsWG0zpFAAbob8g=;
        b=jFaiPZ58srM2G7U8EAxcPoMLG91urHtwPjl+buqrvQMpq6TCMtGrrAFo4YrhvfVkqMz461
        KcBjRZtfdhTuFSeHYTKhPMVrS48KM0bjEjTufZqUbzCwkO5r3i1UrbEt2ZotWL64QZx7Xg
        UL/0lBPCjdVvw1cgJIvB6Z+fBC4zhwo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-on3yJhknNt-DnFac5HdN1Q-1; Tue, 06 Sep 2022 16:17:46 -0400
X-MC-Unique: on3yJhknNt-DnFac5HdN1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8A353800C2C;
        Tue,  6 Sep 2022 20:17:45 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 369472026D4C;
        Tue,  6 Sep 2022 20:17:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it is not supported
Date:   Tue,  6 Sep 2022 22:17:43 +0200
Message-Id: <20220906201743.436091-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an Intel Atom N2600 (and presumable other Cedar Trail models)
MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
by msr_build_context().

This causes restore_processor_state() to try and restore it, but writing
this MSR is not allowed on the Intel Atom N2600 leading to:

[   99.955141] unchecked MSR access error: WRMSR to 0x122 (tried to write 0x0000000000000002) at rIP: 0xffffffff8b07a574 (native_write_msr+0x4/0x20)
[   99.955176] Call Trace:
[   99.955186]  <TASK>
[   99.955195]  restore_processor_state+0x275/0x2c0
[   99.955246]  x86_acpi_suspend_lowlevel+0x10e/0x140
[   99.955273]  acpi_suspend_enter+0xd3/0x100
[   99.955297]  suspend_devices_and_enter+0x7e2/0x830
[   99.955341]  pm_suspend.cold+0x2d2/0x35e
[   99.955368]  state_store+0x68/0xd0
[   99.955402]  kernfs_fop_write_iter+0x15e/0x210
[   99.955442]  vfs_write+0x225/0x4b0
[   99.955523]  ksys_write+0x59/0xd0
[   99.955557]  do_syscall_64+0x58/0x80
[   99.955579]  ? do_syscall_64+0x67/0x80
[   99.955600]  ? up_read+0x17/0x20
[   99.955631]  ? lock_is_held_type+0xe3/0x140
[   99.955670]  ? asm_exc_page_fault+0x22/0x30
[   99.955688]  ? lockdep_hardirqs_on+0x7d/0x100
[   99.955710]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   99.955723] RIP: 0033:0x7f7d0fb018f7
[   99.955741] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   99.955753] RSP: 002b:00007ffd03292ee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   99.955771] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d0fb018f7
[   99.955781] RDX: 0000000000000004 RSI: 00007ffd03292fd0 RDI: 0000000000000004
[   99.955790] RBP: 00007ffd03292fd0 R08: 000000000000c0fe R09: 0000000000000000
[   99.955799] R10: 00007f7d0fb85fb0 R11: 0000000000000246 R12: 0000000000000004
[   99.955808] R13: 000055df564173e0 R14: 0000000000000004 R15: 00007f7d0fbf49e0
[   99.955910]  </TASK>

Extend the valid check in msr_build_context() to also do a test write of
the read value to avoid marking MSR-s which may not be written as valid.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/power/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index bb176c72891c..94b41bfd0769 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -433,10 +433,11 @@ static int msr_build_context(const u32 *msr_id, const int num)
 	}
 
 	for (i = saved_msrs->num, j = 0; i < total_num; i++, j++) {
-		u64 dummy;
+		u64 value;
 
 		msr_array[i].info.msr_no	= msr_id[j];
-		msr_array[i].valid		= !rdmsrl_safe(msr_id[j], &dummy);
+		msr_array[i].valid		= !rdmsrl_safe(msr_id[j], &value) &&
+						  !wrmsrl_safe(msr_id[j], value);
 		msr_array[i].info.reg.q		= 0;
 	}
 	saved_msrs->num   = total_num;
-- 
2.37.2

