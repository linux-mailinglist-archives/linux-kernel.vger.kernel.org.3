Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16928520108
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiEIPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiEIPYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:24:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8735C28FE9D;
        Mon,  9 May 2022 08:20:13 -0700 (PDT)
Received: from localhost.localdomain (154.pool92-186-13.dynamic.orange.es [92.186.13.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7974620EC5AF;
        Mon,  9 May 2022 08:20:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7974620EC5AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652109613;
        bh=V8m3pMalZV2o68GnS/qNSir7EImgItaMWaFe/5bI2jw=;
        h=From:To:Cc:Subject:Date:From;
        b=UIjcOSb7HpLRo2MDEgBNBfLrupiHnP8HpcoxSmfEHm5OF30bDqsmX72i6GVxfmNHr
         M8mjaxRlDg5K0egs9cCdMVMwK40QbItuOjzXQSWdUAy6SmHMxmKWv0uXh2O36vZ3U2
         f8uuSSOrQRfLKcDVyi45co7jynQHzMgv+E+10VK4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-trace-devel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/1] Call forget_syscall() if different than execve*()
Date:   Mon,  9 May 2022 16:19:56 +0100
Message-Id: <20220509151958.441240-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


First, I hope you are fine and the same for your relatives.

With this contribution, I enabled using syscalls:sys_exit_execve and
syscalls:sys_exit_execveat as tracepoints on arm64.
Indeed, before this contribution, the above tracepoint would not print their
information as syscall number was set to -1 by calling forget_syscall().

Now, forget_syscall() is called only if previous syscall number was different
than __NR_execve and __NR_execveat.
I tested it by compiling a kernel for arm64 and running it within a VM:
# Perf was compiled with linux kernel source.
root@vm-arm64:~# perf record -ag -e 'syscalls:sys_exit_execve' -e 'syscalls:sys_enter_execve' &
[1] 263
root@vm-arm64:~# ls
perf.data  share
root@vm-arm64:~# fg
perf record -ag -e 'syscalls:sys_exit_execve' -e 'syscalls:sys_enter_execve'
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB perf.data (2 samples) ]
root@vm-arm64:~# perf script
bash   264 [000]    66.220187: syscalls:sys_enter_execve: filename: 0xaaab05d9d
...
# Below line does not appear with this patch.
ls   264 [000]    66.226848:  syscalls:sys_exit_execve: 0x0
...

Nonetheless, this contribution is not perfect, hence I marked it as RFC.
First, I am not really sure if this is safe to not call forget_syscall() all the
time, even though I did not have problem while testing it.
Then, by including <asm-generic/unistd.h> to the modified file I ended with
some warnings at compile time:

So, if you see any way to improve this contribution, feel free to share!

Francis Laniel (1):
  arm64: Forget syscall if different from execve*()

 arch/arm64/include/asm/processor.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


Best regards and thank you in advance.
-- 
2.25.1

