Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9558DD82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbiHIRxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbiHIRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:53:42 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A58325C57;
        Tue,  9 Aug 2022 10:53:38 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3AE283FF07;
        Tue,  9 Aug 2022 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660067616;
        bh=/Vhd8TdfzMQNLDQ5lUjG5jPSyEGcCPbhTBvMfdqlLas=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
        b=YUKo5SshosO+HK2y4gkXr19LHcaqArfmBeGhw4TIgw5OZnB2btsvrDULhYSsyqCIW
         Y02YHZ4mRN6D01LYdTJfImawaOT7VxWtwVoMzQZKgc93Ifl7587esyX/jMUgNrfR/i
         0dxWBviAqRiUzNwJvdCGvi4PprBW5F5YBpeBeSghrZEL/1EN7AZH4+SiIHSS/mWaAc
         wKdJJh51SHzEo0eCVg7euBUnIWz/zAy+2SlipIqXWuHZ6s82gzv8+3w0038baCHmv4
         6TmIbTrrGblbZXiEmNdtcN5d1cjo5v9X0z1cdXy6J29UUO13F8C5nNpJkAqxg2PpU5
         +ZA5rgY6Zm3VA==
Message-ID: <8009201e-be46-a237-c6b1-e133dbc84137@canonical.com>
Date:   Tue, 9 Aug 2022 10:53:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor changes for v5.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Language: en-US
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


This is mostly cleanups and bug fixes with the one bigger change
being Mathew Wilcox's patch to use XArrays instead of the IDR
from the "Linux 5.18-rc4" thread around the locking weirdness.

thanks
- john


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-08-08

for you to fetch changes up to c269fca7b37a08b7eec6f6b79a0abf1d0a245acb:

   apparmor: Update MAINTAINERS file with new email address (2022-08-06 12:08:39 -0700)

----------------------------------------------------------------
+ Features
   - Convert secid mapping to XArrays instead of IDR
   - Add a kernel label to use on kernel objects
   - Extend policydb permission set by making use of the xbits
   - Make export of raw binary profile to userspace optional
   - Enable tuning of policy paranoid load for embedded systems
   - Don't create raw_sha1 symlink if sha1 hashing is disabled
   - Allow labels to carry debug flags

+ Cleanups
   - Update MAINTAINERS file
   - Use struct_size() helper in kmalloc()
   - Move ptrace mediation to more logical task.{h,c}
   - Resolve uninitialized symbol warnings
   - Remove redundant ret variable
   - Mark alloc_unconfined() as static
   - Update help description of policy hash for introspection
   - Remove some casts which are no-longer required

+ Bug Fixes
   - Fix aa_label_asxprint return check
   - Fix reference count leak in aa_pivotroot()
   - Fix memleak in aa_simple_write_to_buffer()
   - Fix kernel doc comments
   - Fix absroot causing audited secids to begin with =
   - Fix quiet_denied for file rules
   - Fix failed mount permission check error message
   - Disable showing the mode as part of a secid to secctx
   - Fix setting unconfined mode on a loaded profile
   - Fix overlapping attachment computation
   - Fix undefined reference to `zlib_deflate_workspacesize'

----------------------------------------------------------------
David Gow (1):
       apparmor: test: Remove some casts which are no-longer required

Gustavo A. R. Silva (1):
       apparmor: Use struct_size() helper in kmalloc()

John Johansen (17):
       apparmor: fix absroot causing audited secids to begin with =
       apparmor: Update help description of policy hash for introspection
       apparmor: make export of raw binary profile to userspace optional
       apparmor: Enable tuning of policy paranoid load for embedded systems
       apparmor: don't create raw_sha1 symlink if sha1 hashing is disabled
       apparmor: Update MAINTAINERS file with the lastest information
       apparmor: fix quiet_denied for file rules
       apparmor: Fix failed mount permission check error message
       apparmor: Fix undefined reference to `zlib_deflate_workspacesize'
       apparmor: add a kernel label to use on kernel objects
       apparmor: disable showing the mode as part of a secid to secctx
       apparmor: fix setting unconfined mode on a loaded profile
       apparmor: fix overlapping attachment computation
       apparmor: allow label to carry debug flags
       apparmor: extend policydb permission set by making use of the xbits
       apparmor: move ptrace mediation to more logical task.{h,c}
       apparmor: Update MAINTAINERS file with new email address

Lukas Bulwahn (1):
       apparmor: correct config reference to intended one

Matthew Wilcox (1):
       apparmor: Convert secid mapping to XArrays instead of IDR

Mike Salvatore (1):
       apparmor: resolve uninitialized symbol warnings in policy_unpack_test.c

Minghao Chi (1):
       security/apparmor: remove redundant ret variable

Souptick Joarder (HPE) (1):
       apparmor: Mark alloc_unconfined() as static

Tom Rix (1):
       apparmor: fix aa_label_asxprint return check

Xin Xiong (1):
       apparmor: fix reference count leak in aa_pivotroot()

Xiu Jianfeng (1):
       apparmor: Fix memleak in aa_simple_write_to_buffer()

Yang Li (7):
       apparmor: Fix kernel-doc
       lsm: Fix kernel-doc
       apparmor: Fix match_mnt_path_str() and match_mnt() kernel-doc comment
       apparmor: Fix some kernel-doc comments
       apparmor: Fix some kernel-doc comments
       apparmor: Fix some kernel-doc comments
       apparmor: Fix some kernel-doc comments

  MAINTAINERS                               |   8 ++-
  security/apparmor/Kconfig                 |  86 +++++++++++++++-------
  security/apparmor/apparmorfs.c            | 103 +++++++++++++++------------
  security/apparmor/audit.c                 |   2 +-
  security/apparmor/domain.c                |   5 +-
  security/apparmor/include/apparmor.h      |   1 +
  security/apparmor/include/apparmorfs.h    |  14 ++++
  security/apparmor/include/file.h          |   3 +
  security/apparmor/include/ipc.h           |  18 -----
  security/apparmor/include/label.h         |   2 +
  security/apparmor/include/lib.h           |   5 ++
  security/apparmor/include/path.h          |   4 +-
  security/apparmor/include/policy.h        |   6 +-
  security/apparmor/include/policy_ns.h     |   1 +
  security/apparmor/include/policy_unpack.h |   2 +
  security/apparmor/include/secid.h         |   5 +-
  security/apparmor/include/task.h          |  18 +++++
  security/apparmor/ipc.c                   | 110 ----------------------------
  security/apparmor/label.c                 |  29 ++++----
  security/apparmor/lib.c                   |  27 +++++--
  security/apparmor/lsm.c                   |  38 +++++-----
  security/apparmor/mount.c                 |  13 ++--
  security/apparmor/net.c                   |   3 +-
  security/apparmor/policy.c                |  35 +++++----
  security/apparmor/policy_ns.c             |  53 ++++++++++----
  security/apparmor/policy_unpack.c         |  53 +++++++++-----
  security/apparmor/policy_unpack_test.c    |  28 ++++----
  security/apparmor/procattr.c              |   2 +-
  security/apparmor/secid.c                 |  56 ++++++---------
  security/apparmor/task.c                  | 114 ++++++++++++++++++++++++++++++
  30 files changed, 498 insertions(+), 346 deletions(-)

