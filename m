Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7E448EC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiANPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242233AbiANPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:41 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37448C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o12so14499345lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqInyZq8VYW10zqqw28bZOXS/aHab7hJ3edzoV6jxDs=;
        b=BObzpq9JbE2OvElVupvr8QgOXajqE8zlPfxC2d5G9a4n6YlRUX8CjrswkT0bqgflnS
         NFdwYSuzhg4qfgn16XNrP0Ikz38A0bbYXPkJ7OIMzHeyHnUow6darfxzewkqqO27n/Q5
         VxbxbWqZGo19pQYwsywLlPqKLqZ15MIN611yAqrky1VVsy0oZeeuT0DMa+kF5c9mvUry
         jHPPkP/micUrUUPMkDWgPrXVL0d0VKBaYDsLwWDaLr8vrLmFd5I3s+uFA+bSVC07kPXU
         h/SLZbxtEvF9YstuQkpUpb4SDDYqhvvpdg+GUBKHN8fD7z0SoNARu4sVoZue8fsWg/mM
         mjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqInyZq8VYW10zqqw28bZOXS/aHab7hJ3edzoV6jxDs=;
        b=CNH7qkG+YxTsaPfXQoyOB6gzTEOvT+w1dOl7E3YIgXAm7Y5UpbUG3kdLcJObIBkUE4
         7POjnt4WzEjNwcquUp5/3vycrSKS6QparzJEUrEiFeEMEsTfbk9rbhyF9VlwGFV3lgKC
         TfB80Kj/bDE9TUP+kEDnpKwSzCkarYZkva0Q/4UdaoEpljrKkVNWpcxVKy16Uz1/A4tI
         jLIYM0eUl/F02VfFbBTju+DOvnRk62Pe7kJrk8c/Iy7UkYTx6Yn+JmRW5krkZZCTtEa0
         ANctkYVSam09ZK0AEL8tm1zrvxYf1XQsZ+qS55kerBi2Tb/4vekzd5uuUDFiVOESlizp
         sstw==
X-Gm-Message-State: AOAM5311TRbZbANGePio+P0DBU8iJ5HOgv9wPgOb8IZkZKiI7Io+RAMo
        esqM+snd34OoaMF+9gmMYe+H7cdk8IBcgw==
X-Google-Smtp-Source: ABdhPJy5LI986NPHy7cjah7mr/iQ/3nouIR8Wxn5k5uAiVCBRhkgyuo00DfRryXMD8cFioI9tHnnxg==
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr7137244lfv.651.1642172919348;
        Fri, 14 Jan 2022 07:08:39 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:39 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 00/12] tee: shared memory updates
Date:   Fri, 14 Jan 2022 16:08:12 +0100
Message-Id: <20220114150824.3578829-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset is a general cleanup of shared memory handling in the TEE
subsystem.

Until now has the in-kernel tee clients used tee_shm_alloc() and
tee_shm_register() to share memory with secure world. These two function
exposes via a flags parameter a bit more of the internals of the TEE
subsystem than one would like. So in order to make things easier are those
two functions replaced by few functions which should provide better
abstraction.

Two in-kernel tee clients are updated to use these new functions.

The shared memory pool handling is simplified, an internal matter for the
two TEE drivers OP-TEE and AMDTEE.

An OP-TEE driver internal tee_context is added to handle shared memory
allocations received via RPC, for instance the argument structure needed
to make more complex RPC requests. The tee_context used when doing such a
memory allocation must be kept until the memory is freed. With this we can
avoid keeping a tee_context of a client around for longer than necessary.

In the v1 review it was suggested [1] to allow physically non-contiguous
memory allocations by the drivers. It turned out to be harder than
anticipated so I'll save that for a separate patch.

This patchset is also available at [2] and is based on the asynchronous
notification patches [3] which was just merged during this merge window.

Thanks,
Jens

[1] https://lore.kernel.org/linux-arm-kernel/20210609145811.GJ4910@sequoia/
[2] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=tee_shm_v2
[3] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=async_notif

v1->v2:
* The commits three "tee: add tee_shm_alloc_kernel_buf()",
  "tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()" and
  "firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()" has been merged some
  time ago as part of another patchset.
* Another in-kernel tee client is updated with the commit
  "KEYS: trusted: tee: use tee_shm_register_kernel_buf()"
* tee_shm_alloc_anon_kernel_buf() is replaced with an easier to use function
  tee_shm_alloc_priv_kernel_buf() and tee_shm_free_anon_kernel_buf() has
  been dropped.
* A driver internal struct tee_context is used to when doing driver internal
  calls to secure world.
* Adds patches to replace tee_shm_register() in a similar way as how
  tee_shm_alloc() is replaced.
* A patch is added to clean up the TEE_SHM_* flags
* Fixed a warning reported by kernel test robot <lkp@intel.com>

Jens Wiklander (12):
  hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
  tee: remove unused tee_shm_pool_alloc_res_mem()
  tee: add tee_shm_alloc_user_buf()
  tee: simplify shm pool handling
  tee: replace tee_shm_alloc()
  optee: add driver private tee_context
  optee: use driver internal tee_contex for some rpc
  optee: add optee_pool_op_free_helper()
  tee: add tee_shm_register_{user,kernel}_buf()
  KEYS: trusted: tee: use tee_shm_register_kernel_buf()
  tee: replace tee_shm_register()
  tee: refactor TEE_SHM_* flags

 drivers/char/hw_random/optee-rng.c       |   6 +-
 drivers/tee/amdtee/shm_pool.c            |  55 ++--
 drivers/tee/optee/Kconfig                |   8 -
 drivers/tee/optee/call.c                 |   2 +-
 drivers/tee/optee/core.c                 |  22 +-
 drivers/tee/optee/device.c               |   5 +-
 drivers/tee/optee/ffa_abi.c              | 136 ++++------
 drivers/tee/optee/optee_private.h        |  12 +-
 drivers/tee/optee/smc_abi.c              | 155 +++--------
 drivers/tee/tee_core.c                   |   5 +-
 drivers/tee/tee_private.h                |  11 -
 drivers/tee/tee_shm.c                    | 322 +++++++++++++++--------
 drivers/tee/tee_shm_pool.c               | 162 +++---------
 include/linux/tee_drv.h                  | 133 +++-------
 security/keys/trusted-keys/trusted_tee.c |  23 +-
 15 files changed, 434 insertions(+), 623 deletions(-)

-- 
2.31.1

