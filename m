Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3704149B8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379759AbiAYQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378908AbiAYQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862AC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t9so5842225lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ipuoyqs6LKu87V1xeL2irTyB52sbPLGiULkt4cIGcv8=;
        b=K/EeYmHtf2zXy04GygyQzuXICu8TbAcMPZFH2g29o5nyQ3gyLHRvP/hO6TED/+LCjZ
         hMgJ6bp1EZy87UUvqCGtmg3sIbm0WetJRNKgZTi/MwvtUSstbjVak9Zv2JDqadxLIqoL
         EJtvmxcbhFP5otb9cvIRJbj9q+avUMHGgu6yKXqCFRy8kvyZNpluuwDVYMX4sQ57nJco
         e7LNL0lJR2blxyZ7/XBGjcsniJdPq39Hy3mJKpLbHkN4zsNYbnI8oTm9yY4ywGmh8XzB
         uB6T8jPNJ4SLFkiQXexNv+9KsJ1AT1mfFHkdqE9o9w9NNXqwovJ2r8DvibMYPDSTQh/h
         NCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ipuoyqs6LKu87V1xeL2irTyB52sbPLGiULkt4cIGcv8=;
        b=LKWi2dRHYzpK3TiSmXcYtso/A6S1rjvCXPHjDGSN4ytt4vYo44oFDp4Ohe/zqJ47dA
         ECBm1SATDlJlW45GIgIHrtCy6pC/mTzclTGVDK/a3Fb5YLovl50rJUMEbn62Ue5t1b/u
         B6Ewa5UYil4ZX0vahVIx42u5095+O0kc2wuWeBLuv5ObkAAccuiwvpb6gP6yZsRHWLDH
         Sf2sMRppf3UxgEXRqI6eTzfG8UJQA8ROy7QnVBXSYwuEwyRzGWmBcsVJxi/O30b1I1Ir
         /tJ+mPKm0HKbiuLmX5Eq3Aqqj8xEb/g20hQo3/ecWIPC1+vlF4/v1U7G0PwLM2RHXb5M
         L+ng==
X-Gm-Message-State: AOAM533JSQAkG3xiQwzuJJExxcojusaCqsfmPp0ZIIVT5rgFUnFUS1+Q
        tlv3ptTj+ltkMFUjJ35L+IfFmHdxcw3Qww==
X-Google-Smtp-Source: ABdhPJy/6EgiNwJMXplkZHLseVu72L3nrnh6EzYKD3v8nPkIOWVYdo364P3HJcR+Blsm5heReIFOKw==
X-Received: by 2002:a05:651c:1047:: with SMTP id x7mr10406502ljm.164.1643128184805;
        Tue, 25 Jan 2022 08:29:44 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:44 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 00/12] tee: shared memory updates
Date:   Tue, 25 Jan 2022 17:29:26 +0100
Message-Id: <20220125162938.838382-1-jens.wiklander@linaro.org>
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

This patchset is also available at [2].

Thanks,
Jens

[1] https://lore.kernel.org/linux-arm-kernel/20210609145811.GJ4910@sequoia/
[2] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=tee_shm_v3

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
 drivers/tee/optee/smc_abi.c              | 159 +++--------
 drivers/tee/tee_core.c                   |   5 +-
 drivers/tee/tee_private.h                |  15 +-
 drivers/tee/tee_shm.c                    | 320 +++++++++++++++--------
 drivers/tee/tee_shm_pool.c               | 162 +++---------
 include/linux/tee_drv.h                  | 138 +++-------
 security/keys/trusted-keys/trusted_tee.c |  23 +-
 15 files changed, 438 insertions(+), 630 deletions(-)

-- 
2.31.1

