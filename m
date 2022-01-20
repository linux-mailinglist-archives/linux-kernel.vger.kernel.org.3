Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EFE4953CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiATSCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:02:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56204 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiATSB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:01:59 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9771020B6C61;
        Thu, 20 Jan 2022 10:01:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9771020B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642701718;
        bh=a5fVWGlzwUBqYrtxpw1SkQ2TEhRIbUpc2aCbvXgA0vc=;
        h=From:To:Cc:Subject:Date:From;
        b=FLe3Rgw3w3pOq64l+izGov9JOcfZvEFA1tD9y9/ZAdw/49HNyCkUKhlwKW3WqBoDn
         cjHVf2h7BJ+sMXVxQPMTrL4A2pYYsoW2W6ytf6v4+vLKQaD2LP110tJD0IxaBTkwRb
         sTj1gAN3mhFwTsbAbzzI5wnRTCO9eGE1L5Hi8kq4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v3 0/2] Add capabilities file to sysfs
Date:   Thu, 20 Jan 2022 19:01:14 +0100
Message-Id: <20220120180116.167702-1-flaniel@linux.microsoft.com>
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

So, in this series, I added a new file to sysfs:
/sys/kernel/security/capabilities.
The goal of this file is to be used by "container world" software to know kernel
capabilities at run time instead of compile time.

The "file" is read-only and its content is the capability number associated with
the capability name:
root@vm-amd64:~# cat /sys/kernel/security/capabilities
0       CAP_CHOWN
1       CAP_DAC_OVERRIDE
...
40      CAP_CHECKPOINT_RESTORE

The kernel already exposes the last capability number under:
/proc/sys/kernel/cap_last_cap
So, I think there should not be any issue exposing all the capabilities it
offers.
If there is any, please share it as I do not want to introduce issue with this
series.

Also, if you see any way to improve this series please share it as it would
increase this contribution quality.

Change since v2:
* Use a char * for cap_string instead of an array, each line of this char *
contains the capability number and its name.
* Move the file under /sys/kernel/security instead of /sys/kernel.

Francis Laniel (2):
  capability: Add cap_string.
  security/inode.c: Add capabilities file.

 include/uapi/linux/capability.h |  1 +
 kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
 security/inode.c                | 16 ++++++++++++
 3 files changed, 62 insertions(+)


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

