Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA3490A16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiAQON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:13:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54204 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiAQONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:13:20 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A02A020B9134;
        Mon, 17 Jan 2022 06:13:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A02A020B9134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642428799;
        bh=kRp9obQlr94SEe0AopnqHM1DyfG1O8JSr4kv+y1GnCk=;
        h=From:To:Cc:Subject:Date:From;
        b=o0pgi3TdERfvFhFTs2ffaSDuyI0RVhK881vfCqgae/k8fl1k+zqKfbHqlUEOyojFc
         HCUJd6PqxX3UoFfyyOqdA/VYISdvvyEZurrpvsa46s6jqbbD82B89QzLF042ceie+J
         d51+OG99mQsJnMLfg7B5e4kOiFRWOaJ/IxA/uFO0=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v2 0/2] Add capabilities file to sysfs
Date:   Mon, 17 Jan 2022 15:12:52 +0100
Message-Id: <20220117141254.46278-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


First, I hope you are fine and the same for your relatives.

Capabilities are used to check if a thread has the right to perform a given
action [1].
For example, a thread with CAP_BPF set can use the bpf() syscall.

Capabilities are used in the container world.
In terms of code, several projects related to container maintain code where the
capabilities are written alike include/uapi/linux/capability.h [2][3][4][5].
For these projects, their codebase should be updated when a new capability is
added to the kernel.
Some other projects rely on <sys/capability.h> [6].
In this case, this header file should reflect the capabilities offered by the
kernel.

So, in this series, I added a new file to sysfs: /sys/kernel/capabilities.
The goal of this file is to be used by "container world" software to know kernel
capabilities at run time instead of compile time.

The underlying kernel attribute is read-only and its content is the capability
number associated with the capability name:
root@vm-amd64:~# cat /sys/kernel/capabilities
0       CAP_CHOWN
1       CAP_DAC_OVERRIDE
...
39      CAP_BPF

The kernel already exposes the last capability number under:
/proc/sys/kernel/cap_last_cap
So, I think there should not be any issue exposing all the capabilities it
offers.
If there is any, please share it as I do not want to introduce issue with this
series.

Also, if you see any way to improve this series please share it as it would
increase this contribution quality.

Change since v1:
* Use quotes for cap_strings values instead of __stringify().

Francis Laniel (2):
  capability: Add cap_strings.
  kernel/ksysfs.c: Add capabilities attribute.

 include/uapi/linux/capability.h |  1 +
 kernel/capability.c             | 44 +++++++++++++++++++++++++++++++++
 kernel/ksysfs.c                 | 18 ++++++++++++++
 3 files changed, 63 insertions(+)


Best regards and thank you in advance for your reviews.
---
[1] man capabilities
[2] https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940a5664fab21d6f7d1e/pkg/cap/cap_linux.go#L135
[3] https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a902aabc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6f9c1
moby relies on containerd code.
[4] https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad35e0b7f94e3a0ffb/capability/enum.go#L47
[5] https://github.com/opencontainers/runc/blob/00f56786bb220b55b41748231880ba0e6380519a/libcontainer/capabilities/capabilities.go#L12
runc relies on syndtr package.
[6] https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff51856b880c089f1/src/libcrun/linux.c#L35
-- 
2.30.2

