Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF84C9500
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiCATud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiCATuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C56D4C0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:48:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu29so28808025lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMJzp8NGcAaMrW/Z1qKYk6Oa39jb7cXUzQ69+SC6rYw=;
        b=WjJSyFGVENfQiC0MmIIfvy1CLy5n12Oo4AUwHCGNF5uL3WVwVKvlNMjBbp44NzCS0D
         n7whOR6+F1DXu0rQ1BL+VAWoKCeysr500guTaZ4T3hmJfqyK2woz5VYKzh2wjlakAcw5
         v0+6oDyQzrvdgVA6nuJmQG0xwPtvYXG+TCP12ByRiaCk2JbP6GUroOumOPukWLzsBqVi
         ORpsBhQJToxG38dPJmseOq42nEH3s/uHzeszDm+0Z+1G+oE6a81n24eRmSZyX0Sp0fYU
         qW8gIpvl7zSWSkdAVQeT8psWGqusSWnNL7SlV4aNuOvtjPqXciMb+L5iAxAW7N6McOD0
         7hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMJzp8NGcAaMrW/Z1qKYk6Oa39jb7cXUzQ69+SC6rYw=;
        b=yNfGAVfjBUgcHT9ycG6IjNJubSLObq5U6mvicVtkId55NkGyyIvHvvYR8hw4oqTPmK
         Pgnum9zBEn3yWzSGZylCUbSTcsIMJH+Vc7FNnUijs16Nv1M5Ckaw8qNTgw36osf09iy/
         qFGWybIKF7h4bsQ+0zRuvAjMoX2lj/ZULILUV8fshT4I4VyQ0wZZUbuHDzjiBuvD9Kkl
         uNyYc58RcCrLw7rpYbB9icx+RFhSRgo2XJl+gHbOY2K2xEsM9teuFGcVqO8FxthH9+FX
         pY/XO5zVBLhsLSJTehOhT7qohf0GYG+GGaFiFxSCnclVnzTJTUbXLv+cxEGuUuCarmB0
         Satw==
X-Gm-Message-State: AOAM533+UsaD+Bt1y3lQqX4SxV3d7pA8vXCm6zPBwn7/ix1fWNcKcHop
        xxtwV1OeIjNbchzkH3mMsGQPi8krkMmGIQ==
X-Google-Smtp-Source: ABdhPJz+SujTG8BnYtzJdCdHZsTc46VeiLCDOgemJ4BLAtZtG79nc+TKHx4xsymVx2Zllxns7+bJFQ==
X-Received: by 2002:a05:6512:3f9:b0:443:3c86:31f1 with SMTP id n25-20020a05651203f900b004433c8631f1mr15744272lfq.532.1646164113494;
        Tue, 01 Mar 2022 11:48:33 -0800 (PST)
Received: from jade.urgonet (h-176-10-238-36.A175.priv.bahnhof.se. [176.10.238.36])
        by smtp.gmail.com with ESMTPSA id m2-20020a196142000000b00443d65ea163sm1635891lfk.248.2022.03.01.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:33 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/3] OP-TEE RPC argument cache
Date:   Tue,  1 Mar 2022 20:48:27 +0100
Message-Id: <20220301194830.3557578-1-jens.wiklander@linaro.org>
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

This patchset optimizes handling of the argument struction passed to
call_with_arg when doing a yielding call to OP-TEE.

Prior to this was this structure allocated before the yielding call and
then freed after it had returned. In case many calls are made in succession
this results in quite a bit of unncesary allocte/free and possibly also
switching back and forth to secure work in order to register if needed.

Another optimization handles the way the argument struct needed to do RPC
is passed. Please see the patch "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG"
for details.

This patchset is based the next branch [1] in my kernel to avoid conflict
with other recent patches.

Thanks,
Jens

[1] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=next

Jens Wiklander (3):
  optee: add OPTEE_SMC_CALL_WITH_RPC_ARG
  optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
  optee: cache argument shared memory structs

 drivers/tee/optee/call.c          | 238 ++++++++++++++++++++++++------
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  36 +++--
 drivers/tee/optee/optee_ffa.h     |  12 +-
 drivers/tee/optee/optee_private.h |  31 +++-
 drivers/tee/optee/optee_smc.h     |  47 +++++-
 drivers/tee/optee/smc_abi.c       | 151 +++++++++++++++----
 7 files changed, 419 insertions(+), 97 deletions(-)

-- 
2.31.1

