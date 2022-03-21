Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF904E272A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiCUNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbiCUNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:05:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6811164
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q14so6424543ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlA9o1B3cAEKjsPw4UZfHpkn62rMesKmX8Xaat/DqJw=;
        b=Yy4T/tBKzEJawIoH/P6xKcBUGGvKwFoIf6ZiFasZ5D9A16By9VHgjnm3o9auvohKUk
         /VtHnY03OpgbU5544PsSaz/ola+itereRmWey7wpbprlgY6J9EAzUWPJHv4XklJWCpAp
         SugwrKfynpSNdCYYp9eGHG+/S6vlIdLt6usjmn+yMpI0mPoH+0NW3Yn3QHJMZNbxJaXP
         UC7XrLraWSyb+imdjRGQxrgQVr/AZZbx9bvIJsSAQYG92yL4Us4T+NeLykj3S2UBCHU2
         nKgjaupGEoQno4eLufw5TPUyGGlBf456KI4eLRMXuNZsmGz60aPNbxhcKyQLbzbyDSqp
         74lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlA9o1B3cAEKjsPw4UZfHpkn62rMesKmX8Xaat/DqJw=;
        b=NT3koh3nCTFPbGQhTnXOMZrPEaKvzgp5dlpuxZrncHMBc2xLd5pm1NPXeqm/Ryhd0s
         51QrSin/AtQ2mwCXRbW4k/wv+8Bu4+Ao5aQ/RYyfqpv4+mMBdzYZfEEkYCjqY2fLaY0F
         fkcdHEyk9RTJTmd7zZbQTRGL0aflcflMvDZUigBuhMMdWyq0xWk4gGOWfZCaV6HhnxXF
         WowtqUvjDnmzMoJs+tI6Eo2tNmZZSJKG7Qh6YSN0xl3AgzfHQ/OQRV3ACgNxdjJZWmuH
         iY2zMFPkKIvKjg/26c8wonjlo688SlHgpNa8jXorx7fEw6aP9mE4/RHwbkD6MKsiLN4y
         rqLA==
X-Gm-Message-State: AOAM5305/hwbPMRsc+hbYm5XtemvprM/TZLf56wbj4wIPGEs6NutexOQ
        Ezg8lc/j7CVdtjqf5ph9/3jWADL6qE0kUQ==
X-Google-Smtp-Source: ABdhPJzY0lTYbzt1vECx3UTcOkmwVlgwRYGbNbIzMSstLyr5PDsnRHnLyqrlMT5D4xqdN56p9c1FMg==
X-Received: by 2002:a2e:9692:0:b0:247:e508:714e with SMTP id q18-20020a2e9692000000b00247e508714emr15546606lji.375.1647867831205;
        Mon, 21 Mar 2022 06:03:51 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b00247f32b572asm2067738ljk.19.2022.03.21.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:03:50 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 0/4]  OP-TEE RPC argument cache
Date:   Mon, 21 Mar 2022 14:03:37 +0100
Message-Id: <20220321130341.935535-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset optimizes handling of the argument struct passed to
call_with_arg when doing a yielding call to OP-TEE.

Prior to this was this struct allocated before the yielding call and
then freed after it had returned. In case many calls are made in succession
this results in quite a bit of unnecessary allocte/free and possibly also
switching back and forth to secure work in order to register if needed.

Another optimization handles the way the argument struct needed to do RPC
is passed. Please see the patch "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
OPTEE_SMC_CALL_WITH_REGD_ARG" for details.

This patchset is based the next branch [1] in my kernel to avoid conflict
with other recent patches.

Thanks,
Jens

[1] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=next

v1->v2:
* Split out a separate commit "optee: rename rpc_arg_count to
  rpc_param_count"
* Check optee->rpc_param_count before calling optee_disable_shm_cache().
* Mention OPTEE_SMC_CALL_WITH_REGD_ARG in commit message.


Jens Wiklander (4):
  optee: rename rpc_arg_count to rpc_param_count
  optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
    OPTEE_SMC_CALL_WITH_REGD_ARG
  optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
  optee: cache argument shared memory structs

 drivers/tee/optee/call.c          | 238 ++++++++++++++++++++++++------
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  36 +++--
 drivers/tee/optee/optee_ffa.h     |  12 +-
 drivers/tee/optee/optee_private.h |  31 +++-
 drivers/tee/optee/optee_smc.h     |  47 +++++-
 drivers/tee/optee/smc_abi.c       | 162 +++++++++++++++-----
 7 files changed, 427 insertions(+), 100 deletions(-)

-- 
2.31.1

