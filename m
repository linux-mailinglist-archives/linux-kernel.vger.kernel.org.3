Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6250F28E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbiDZHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiDZHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:36:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D531331AD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w19so30352497lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2M3AFFRXGIjVg9YgN64DKDu9UT6YDi/Vu7ZKeR1p1g=;
        b=nHbVbpe7jyEaJcV58Q8DwP2P7BGucA+RLuPCGnQUUMagEBBL1yOzG8tRJCBRMN2I31
         iZnc6C7XlaPJkaEotwmjWzokK++tqDXBK1P7557R+LsqleEUa2NwLy81iXgioVms7o+j
         Llsz0SMS4jwQeN5bB7S0J1+ekNq/ZtmSJ1Yh1Gl8N9oPXf8WvJ9L9SuYKDulk3E01k+D
         DakMfxstdonk/amI7b0tc4Zq0jHOSO5Qibk6jZFerOmMkq6b2S7S1yj7NUD6Ozwax/Wg
         uUov3jWSKCvMB2Qs6XrSZ6CKmJ35seZIk52JFtVBZM8HkeKsY7oO51r4VNVWaEz6NgGD
         0jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2M3AFFRXGIjVg9YgN64DKDu9UT6YDi/Vu7ZKeR1p1g=;
        b=wclkHSxlVHJzoYQsfqtS04Zyrjtw4Nl9mvWWo055mOvZ2sK9uUsSpwuR6jFkf0MfKO
         ON1wSRBtMv/RxcVo+Wj6NPJAQsP5qWDYdX33lld7Z2MlulRcceWbAWs30rQOPHhEjOCH
         rtHnl0s2oRyROS4xpS/AOPj0Zdoz8Sp0Pl0L/H2i/XgJmru9XD/CijvhbAZHhZQE0YTW
         oJ14JjZ1s1WgF1SEOGufcc+y9Z/hcmK6D6lFh+cegTEwIQ5nobSBxXpgf7xnDD0hM7GB
         Eqo06AFGaDrQTADZ6YTMjbtTkkFmmvD7wBtduAKmhKma3Bt2/hNrggUP353bqnlTRNkC
         fe3A==
X-Gm-Message-State: AOAM530SMuMpyZWZEEfmyWyUkd3jLw7/xrqlY9GY2GJL2i7Yc4Ol5jTO
        Uwp7JMTvc+uMFU+BEosRIDILHK9+Zc4CJw==
X-Google-Smtp-Source: ABdhPJyF1S/BFvtlZxYOU6b0R4o8Ayv2M5NzKphNZBPI6YLr9H9DKpmOvKxNkCfdAEevgPOVwYsYug==
X-Received: by 2002:ac2:4a85:0:b0:472:1f8a:ae24 with SMTP id l5-20020ac24a85000000b004721f8aae24mr665618lfp.370.1650958421179;
        Tue, 26 Apr 2022 00:33:41 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm1430491lji.116.2022.04.26.00.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:33:40 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 0/4] OP-TEE RPC argument cache
Date:   Tue, 26 Apr 2022 09:33:34 +0200
Message-Id: <20220426073338.3048192-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v3->v4:
* Updated "optee: cache argument shared memory structs" to work with older
  versions of the SMC-ABI when using dynamic shared memory.

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
 drivers/tee/optee/smc_abi.c       | 197 ++++++++++++++++++++-----
 7 files changed, 461 insertions(+), 102 deletions(-)

-- 
2.31.1

