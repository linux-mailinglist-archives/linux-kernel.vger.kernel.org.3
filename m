Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D74FEEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiDMFq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiDMFqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:46:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE32317F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:44:33 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q189so841851ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNRZZtX1skqqmcukEzSXbvuMVM7LhhiW1Q87eJDB3CE=;
        b=wa96ESDyEWm4GigkhtA/79HY7+TKR4BOYfnPn9c2SLhkszHUKq2JIazy3cWFzsULou
         qPsN5Aqa5Jab32cZ4XEGHzpokZZGlmtOCYcVH97NMBl+ipHTsFtKcPeBf4eQp/gJHyka
         tbu4tHuPQvYF4TCr8cPRR61VooRErOV739wnkVPtEcPA2QgzcIaSNAP5hgB8OtEWibxF
         YcFyJ8tylESdNB/X9Km5B/FcAvd5ZExdYG5/xD7g4xJYS6XrFJRjPYf53KAQLd0Pqyzg
         bdlX/v0oP5S95fTOkcyeAc4+IjVFRFU/kmchwg97xReOcHkYFswjS/WwEkkVz3jWrbNO
         dQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNRZZtX1skqqmcukEzSXbvuMVM7LhhiW1Q87eJDB3CE=;
        b=dhSlMBy0TfxwEH8QnBuGV1BhQCaEYB9JR4kv81s/EMoFx5NXH/PsNoJXfW63YQaJK6
         8QaDYMeG76mEZkFuxiwvXodJy1m399I0XFy+i9O7rjYIzwzGYUX0zq3zMyFm672gpzSh
         ztyFbR93xSWH7spNCXEGh2hHxxs23RoqeEammPbNN98tl+GDqSI+60PVqqRW2iGsko0u
         dzpixs9Nh3SCkRYi+6KQ3lx78pf/qM1+kq0kmtwM2CjhSixjYyEj889K+Z7Jxy8lc+fc
         nsDE/Uo/wrKfYI4CFKy4VkenrAVeZjUeC5GocAlFmWVneBDVN7QDvN9Z11Q6xvg9pqPn
         Bpng==
X-Gm-Message-State: AOAM533t81YtOHioss/m/70ux7A9H5cSUyDNdeOxn5akEyhlEAPzNsyL
        sEmxUQPmCM0CqgotNpIwm2xk8GK8braIWw==
X-Google-Smtp-Source: ABdhPJwldDmwqOqnQUIQPsQB5X0nT3MeMWDRvC4QBMdEa2myHcgNHH19bxE+3CgPIjfXtQewdqBIgQ==
X-Received: by 2002:a05:651c:198b:b0:24c:805b:bcb8 with SMTP id bx11-20020a05651c198b00b0024c805bbcb8mr1964503ljb.228.1649828671304;
        Tue, 12 Apr 2022 22:44:31 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24357000000b0044adb34b68csm3919835lfl.32.2022.04.12.22.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:44:30 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 0/4] OP-TEE RPC argument cache
Date:   Wed, 13 Apr 2022 07:44:14 +0200
Message-Id: <20220413054418.71996-1-jens.wiklander@linaro.org>
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

Thanks,
Jens

v1->v2:
* Split out a separate commit "optee: rename rpc_arg_count to
  rpc_param_count"
* Check optee->rpc_param_count before calling optee_disable_shm_cache().
* Mention OPTEE_SMC_CALL_WITH_REGD_ARG in commit message.

v2->v3:
* Applied Sumit's R-B to "optee: rename rpc_arg_count to rpc_param_count"
  and "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG"
* Fixed some review comments to "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
  OPTEE_SMC_CALL_WITH_REGD_ARG"
* Rebased on v5.18-rc1


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
 drivers/tee/optee/optee_smc.h     |  48 +++++-
 drivers/tee/optee/smc_abi.c       | 162 +++++++++++++++-----
 7 files changed, 428 insertions(+), 100 deletions(-)

-- 
2.31.1

