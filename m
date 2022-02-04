Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454174A96DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiBDJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiBDJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B6BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so11395617lfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rl0tcjWchwpcASYYm9VTUQSccDujPcei62XX5bfOWDU=;
        b=Jk0YZfmLwN1pnxSDgLZmNrFh/jtrBBy23TAHFw/S6eYYUVfBeDjEu4b7kNwjWJDLBC
         T3ZKF0lFqN9xLo/fmaxGMrZAiGZtd2Qbpi9tOVXPF7LiZfaZR4LXkgfB8tGZ8dPeLmBt
         LOq6pc/jxh1GZLComkS8IW/UeN1YfrGfizMTlwrNNlESqKJPUUCX+ruitT+ETxenMSHM
         CFREralEmayyK4SRWYfI5AC2qp5NjSTaKy0nbBOOVNU9XKfGhille7uIpRxMpoXUc05F
         LyhcTXiAD/JatDT/lLIYrT60MokUXlLVYXDPd9V/cpXUJUfIdFlIOoqRiYBm8nVCD0o4
         txQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rl0tcjWchwpcASYYm9VTUQSccDujPcei62XX5bfOWDU=;
        b=CSj2amVXjw2MD1oofCkjuPHRHq6Pl3k8qMC7wt5beGTHg8+EMI/17MSsKG0LcCaK3L
         q985677JaN4sKDKExP+c53LAohHHJbQfHOAaBOHRLIb9QgeLSblneWYDCXfAiriJ+jhX
         YIzbl3V4JmSs7J38yTB1+qUWC5iKucZ6cAIQeFGOfDryzwrTuhEEyZyqfeJfhzHEG2rh
         ft/Zb+YUZRI2OtLBBWwfT4jrhtQV5dfUhW+ZEBtx24RDWqlLmdtCYGJzy/5FfLZTSnDE
         ylAoaiYFlfM0xX4kY5kLcMf0HYE4L0V3GLcqBZgJXnw/lhrPAAzUlwyPeYce2pRsc6EE
         x7zg==
X-Gm-Message-State: AOAM5322vmOR9kgp4lpa7QgVjlEmbkpyYMutafk4H1za6eErRwcBH9Td
        ivEXmu+TkBx0j5ha822tlj+AilE3IVN0Cg==
X-Google-Smtp-Source: ABdhPJzUi4EzAndx67GBwRkuwxJMdFwVKoV/98zO723JzSRxAdIi4C8BOgywD/LpRIegbWztrRjJ+Q==
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr1733562lfr.127.1643967249299;
        Fri, 04 Feb 2022 01:34:09 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:08 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 00/10] tee: shared memory updates
Date:   Fri,  4 Feb 2022 10:33:49 +0100
Message-Id: <20220204093359.359059-1-jens.wiklander@linaro.org>
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

In the v3 review it was suggested [1] to break out "optee: add driver
private tee_context" and "optee: use driver internal tee_contex for some
rpc" into a separate patch to fix to allow those a faster path upstream as
they fix reported problems. So this patchset is now rebased on top of those
patches separated.

This patchset is based on [2] and is also available at [3].

Thanks,
Jens

[1] https://lore.kernel.org/lkml/20220125162938.838382-1-jens.wiklander@linaro.org/T/#m9e38c5788b49ed3929276df69fe856b6cbe14dfb
[2] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=fixes
[3] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=tee_shm_v4

v3->v4:
* Broke out "optee: add driver private tee_context" and "optee: use driver
  internal tee_contex for some rpc" into a separate patch as that fixes
  earlier reported issues and deserves a to go into v5.17 and stable
  trees.
* Rebased on the recent fixes for the OP-TEE driver on top of v5.17-rc2
* All patches are now reviewed by Sumit Garg + some small fixes from the
  last review

v2->v3:
* Make tee_shm_alloc_user_buf() and tee_shm_register_user_buf() internal
  and don't export them to the drivers.
* Rename tee_shm_alloc_priv_kernel_buf() to tee_shm_alloc_priv_buf()
* Adressing comments on variable names and choice of types in "tee: replace
  tee_shm_register()"
* Adding detailed explaination on alignment in "tee: simplify shm pool handling"
* Added Sumits R-B on a few of the patches

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

Jens Wiklander (10):
  hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
  tee: remove unused tee_shm_pool_alloc_res_mem()
  tee: add tee_shm_alloc_user_buf()
  tee: simplify shm pool handling
  tee: replace tee_shm_alloc()
  optee: add optee_pool_op_free_helper()
  tee: add tee_shm_register_{user,kernel}_buf()
  KEYS: trusted: tee: use tee_shm_register_kernel_buf()
  tee: replace tee_shm_register()
  tee: refactor TEE_SHM_* flags

 drivers/char/hw_random/optee-rng.c       |   6 +-
 drivers/tee/amdtee/shm_pool.c            |  55 ++--
 drivers/tee/optee/Kconfig                |   8 -
 drivers/tee/optee/call.c                 |   2 +-
 drivers/tee/optee/core.c                 |  21 +-
 drivers/tee/optee/device.c               |   5 +-
 drivers/tee/optee/ffa_abi.c              |  63 ++---
 drivers/tee/optee/optee_private.h        |   7 +-
 drivers/tee/optee/smc_abi.c              | 125 +++------
 drivers/tee/tee_core.c                   |   5 +-
 drivers/tee/tee_private.h                |  15 +-
 drivers/tee/tee_shm.c                    | 320 +++++++++++++++--------
 drivers/tee/tee_shm_pool.c               | 162 +++---------
 include/linux/tee_drv.h                  | 138 +++-------
 security/keys/trusted-keys/trusted_tee.c |  23 +-
 15 files changed, 388 insertions(+), 567 deletions(-)

-- 
2.31.1

