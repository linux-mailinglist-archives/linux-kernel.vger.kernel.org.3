Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5459D295
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiHWHsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbiHWHsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:48:51 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE47812AB3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RGiGH
        p7oMEjT6uibunWe+zoBBBB1zHI0xeEhGOD4JUk=; b=lSpraQrDT1UgzBln6DywU
        RoaCAcReaVSM4EqcaVMcpHSkAbh44L9aIkAYlmCZ/wCbst65YtCAQS75sZLzu8xb
        2i+MAaB/NC/gdpT1uGXkLPqxSyUibjBa8r6Qiw9saYmYb1znCMaSByExu+o55kYZ
        J6zMVf4Bkp3p1jPHnGCj8c=
Received: from VM-0-11-ubuntu.. (unknown [49.235.41.28])
        by smtp2 (Coremail) with SMTP id GtxpCgC3L_L2hQRjVX0BXg--.9755S4;
        Tue, 23 Aug 2022 15:47:05 +0800 (CST)
From:   suhui_kernel@163.com
To:     mingo@kernel.org
Cc:     akpm@linux-foundation.org, bp@alien8.de, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mgorman@suse.de, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vincent.guittot@linaro.org, nhuck@google.com,
        ndesaulniers@google.com, lukas.bulwahn@gmail.com,
        masahiroy@kernel.org
Subject: Re: [PATCH 09/15] sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
Date:   Tue, 23 Aug 2022 15:47:02 +0800
Message-Id: <20220823074702.2900118-1-suhui_kernel@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220315084247.40783-10-mingo@kernel.org>
References: <20220315084247.40783-10-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3L_L2hQRjVX0BXg--.9755S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWkKF4fAF4xuF47KrWruFg_yoWDtwcEk3
        40kw47Ww13CFyvqF13tF4fZrWkta9rta4rJFn7W3y3GFWktFs5WanIqF1fua45ta1Fvrn7
        Krn3Xa4vyF129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjQB_UUUUUU==
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/xtbBsgJmbV75gIq+2wAAsz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Since commit f96eca432015ddc1b621632488ebc345bca06791 merged, the
scripts/clang-tools/gen_compile_commands.py can't work very well.
  In this patch the build_policy.c and build_utility.c include kernel/sched/xxx.c(
such as rt.c idle.c...), so it compile the build_utility.o build_policy.o directly,
and it won't generate kernel/sched/xxx.c(such as rt.o idle.o), so the gen_compile_commands.py
can't work.
  It will report "[8/23/2022, 3:24:06 PM] "rt.c" not found in "${workspaceFolder}/compile_commands.json".
'includePath' from c_cpp_properties.json in folder 'linux' will be used for this file instead.".
  And i test the kdump & crash tools, it can find the functions by line in kernel/sched/xxx.c(
such as rt.c idle.c), it works well.
  I can't solve this report error, so i want to get help.
  Maybe we change the gen_compile_commands.py code can solve this problem or
can we revert this change?(3.9% build wall time decrease really matter? it will
destory all tool's parse result which depends on the compiled file result).

