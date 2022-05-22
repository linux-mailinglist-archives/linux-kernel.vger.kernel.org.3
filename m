Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2B530007
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347937AbiEVAcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiEVAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:32:28 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4640A24
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:32:27 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s23so12088897iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByK1Pxr8l6D3d0/+gXXWA151WGHTkEu3PWsI8o0VKgA=;
        b=ihgnBslObTa5etz9FgEODeZKM+kAqR7zd+SW+7Ut6+pkdWgRVU7kDWmGvK08b5Tesy
         rwz940kYMo9zRKhts0kuNelWeAB14chvU5HMnEmFPy4LT9p5ymX3Jh/uOfiq/JbmblY9
         XwYsguGWHXMWvHNTSTySDEyL6rdIMh7VS7dnUQblJTzJTB6qH79LXBTS8ZoKC2rHfrml
         sDUvqexFsWwb7mx01TnUAcWaCG/oKp0wEIq2Y+wioWoCS/Ww2Tnauagu9SOvcQ3Cfh+z
         787Mp6H/B/dTtYQ/sMoMgK6uzX/hysuX2ZALxbuNNsz0oPwzHzlSGNc47SbM/SqsBFY9
         MCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByK1Pxr8l6D3d0/+gXXWA151WGHTkEu3PWsI8o0VKgA=;
        b=G4Wfh7YeQpVzzWkNNoxqQ20dlm8hah3tTOiJdLI/1lhZSWUdb4tM4orT298rp4iS9X
         3ROXtJSxpbLIEvshTdV2D1sSoX0tsAwNh0mXla2CgnMLkqPPBG59UDgl9+4rAMS0b7qY
         Nae1zji4BQlU3ewBeZkAKPC4PpS/jbV7jgT6MWN4pSpxNREF8NAM8kZPPVXMzCF8+OXg
         xvF5uLxdaqBtQobliImMwdhWmiEWE7kFyvPxfseBFY9iQXSstbLN+np7OZmQZ5O2Ucql
         kudkGk3Z1OhmopFwLTU4CMP4yFvaEuEehdqVXNF2NhteZehyNhhH/VB+gXr/MfS9SWJI
         puPQ==
X-Gm-Message-State: AOAM533oOp9z86s24Ka0cqKogGdb0h/tKLfJRWi9sjHpKwZ1JK7YP1Mz
        lxD6uQE/o2R5jYB23YS353syjw==
X-Google-Smtp-Source: ABdhPJywnmGJmTHJyo0JotLBTKpiLYe8yqACQpBOpXdnQsgHKemBSi3NrO52AKKmnMWT+HSmSM9HfA==
X-Received: by 2002:a05:6638:22c1:b0:32b:8e38:bff4 with SMTP id j1-20020a05663822c100b0032b8e38bff4mr8325521jat.151.1653179546920;
        Sat, 21 May 2022 17:32:26 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g8-20020a02c548000000b0032b5e78bfcbsm1757115jaj.135.2022.05.21.17.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 17:32:26 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/9] net: ipa: a few more small items
Date:   Sat, 21 May 2022 19:32:14 -0500
Message-Id: <20220522003223.1123705-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
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

This series consists of three small sets of changes.  Version 2 adds
a patch that avoids a warning that occurs when handling a modem
crash (I unfortunately didn't notice it earlier).  All other patches
are the same--just rebased.

The first three patches allow a few endpoint features to be
specified.  At this time, currently-defined endpoints retain the
same configuration, but when the monitor functionality is added in
the next cycle these options will be required.

The fourth patch simply removes an unused function, explaining also
why it would likely never be used.

The fifth patch is new.  It counts the number of modem TX endpoints
and uses it to determine how many TREs a transaction needs when
when handling a modem crash.  It is needed to avoid exceeding the
limited number of commands imposed by the last four patches.

And the last four patches refactor code related to IPA immediate
commands, eliminating an unused field and then simplifying and
removing some unneeded code.

					-Alex

Alex Elder (9):
  net: ipa: make endpoint HOLB drop configurable
  net: ipa: support hard aggregation limits
  net: ipa: specify RX aggregation time limit in config data
  net: ipa: kill gsi_trans_commit_wait_timeout()
  net: ipa: count the number of modem TX endpoints
  net: ipa: get rid of ipa_cmd_info->direction
  net: ipa: remove command direction argument
  net: ipa: remove command info pool
  net: ipa: use data space for command opcodes

 drivers/net/ipa/gsi.h             |   1 -
 drivers/net/ipa/gsi_trans.c       |  38 ++-------
 drivers/net/ipa/gsi_trans.h       |  24 +++---
 drivers/net/ipa/ipa.h             |   2 +
 drivers/net/ipa/ipa_cmd.c         |  78 +++++-------------
 drivers/net/ipa/ipa_cmd.h         |  11 ---
 drivers/net/ipa/ipa_data-v3.1.c   |   2 +
 drivers/net/ipa/ipa_data-v3.5.1.c |   2 +
 drivers/net/ipa/ipa_data-v4.11.c  |   2 +
 drivers/net/ipa/ipa_data-v4.2.c   |   2 +
 drivers/net/ipa/ipa_data-v4.5.c   |   2 +
 drivers/net/ipa/ipa_data-v4.9.c   |   2 +
 drivers/net/ipa/ipa_endpoint.c    | 129 +++++++++++++++++++-----------
 drivers/net/ipa/ipa_endpoint.h    |  23 +++++-
 14 files changed, 156 insertions(+), 162 deletions(-)

-- 
2.32.0

