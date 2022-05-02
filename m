Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C3516E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384571AbiEBKpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384787AbiEBKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:45:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6841D31B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:41:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d15so12152693plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6Rnw46tJ5c8TR1VH8c4HYYn4D03M2nHnAjzUXe5flU=;
        b=Pjh9MgqoFCWgam7pbQq637Hxn3x2ZC0hKooYXRjuuTbn5yQ7/kxKf8F24mJbZ3q/HM
         ukCCI6nYrzsGtJ5Ix6j6vsOKgG16OAzrD7H19+FAbI+D/wCakEuhDUaVLRB0c/ipLCpB
         M+qADP0jKkXABJzJhfldb5yS8XY7toT4iHKCUTdZhqXkJYPXUNls9NC9mLo+Xw8DGkV9
         z2sdCnW9v8kPNMa9EKnJQR+4JVZo11Fho3Lxqaei20V69OUFL3OhuoMMqNwePJ5cpqV4
         RUPfWfkI/V2Pyl+SJcR5Arhqdsg7R8AONJV4N4qr3TLak40Rl4NkxaHLehZ1K2bZcLG8
         wqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6Rnw46tJ5c8TR1VH8c4HYYn4D03M2nHnAjzUXe5flU=;
        b=bH2rF3KYRW0tTryVA9NrVH+OPNj4FQq/xej3USWd42iPNyApn3vvZcMdUa8jmzk0dt
         BxiqZTfC7WJgNm4fMlp82bIm18KmRuo+nrMELDlDFfoLqByf7FMMTVsydZgTnzvlSmVK
         sOKX18dtpFHYojnaVdMquaAJI1l7JENVm3QUJ2owt1/8Kc8+7MAj6rMBXBEK/r4FRkpi
         c1z68jVdyfVeqLUoQlD0vR4XAKQgrLN1lnMp8v+Hent+4GdPaqwvVQ1jTZ1qVmW8YpbU
         V1JMWTG7BZeonos8l65FBw2Z+VH/ihHh0ZYPL5eFBrZCPCIoma8rTJ8ebtHV0UKHDyqE
         iVaw==
X-Gm-Message-State: AOAM531LaveUmza7oGTUwvLGuqBniCAiN3EArZ9Wt5e1cmbgWJ4WHOLS
        vvrQdzn7PLB+1uxBp5C4ctFw2bENrVFE
X-Google-Smtp-Source: ABdhPJwAs8+H3r7smNJ+ixQ2yCIe61zHgAhL1t7EBRsXyLhMAbzuX4wAz4gQxsVHn/Tux9b0w9j4Dg==
X-Received: by 2002:a17:902:8d8e:b0:159:4f6:c4aa with SMTP id v14-20020a1709028d8e00b0015904f6c4aamr11199720plo.115.1651488111837;
        Mon, 02 May 2022 03:41:51 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b0015e8d4eb2ccsm4368434plv.278.2022.05.02.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:41:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] MHI host cleanups
Date:   Mon,  2 May 2022 16:11:39 +0530
Message-Id: <20220502104144.91806-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi,

This series has few cleanups to the MHI host stack. Apart from the cleanups,
patch (5/5) removes the redundant dma_wmb() from mhi_ring_chan_db() function.
I've provided the reasoning in the commit message, if my understanding is wrong
please let me know.

Thanks,
Mani

Manivannan Sadhasivam (5):
  bus: mhi: host: Rename process_db callback to ring_db
  bus: mhi: host: Rename mhi_db_brstmode() and mhi_db_brstmode_disable()
  bus: mhi: host: Use {READ/WITE}_ONCE macros for db_mode and db_val
  bus: mhi: host: Rename parse_{rsc/xfer}_event to
    process{rsc/xfer}_event
  bus: mhi: host: Remove redundant dma_wmb() before ctx wp update

 drivers/bus/mhi/host/init.c     | 12 +++++------
 drivers/bus/mhi/host/internal.h |  6 +++---
 drivers/bus/mhi/host/main.c     | 37 ++++++++++++++++-----------------
 3 files changed, 27 insertions(+), 28 deletions(-)

-- 
2.25.1

