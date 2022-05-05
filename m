Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4A51C137
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354985AbiEENvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiEENu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:50:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D056C10;
        Thu,  5 May 2022 06:47:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a21so5293152edb.1;
        Thu, 05 May 2022 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/trA3Oc5ZJjjWeUtSzI0YLjZPKi5e/fgHowkWR3Mlc=;
        b=j7Y4XFZm9dhjMpG7Aco3FEqLLNB1CncJb2j9JG5yxkDcWgH1X74snTGh6T2eWu9TPW
         pQytCejT1gZuf27VYmj5jFoIzCrhx8m39Ot+OvGULHZ9C43fZDICWj6p71T92otD9F8c
         dVJ1oztBkRxGUcuU2y1QzfTHHW7M08dx+bQ2gMiw/Yj4x6LH0lKz9XpFPFwcgErlDqnm
         i/Yz9rVqz6hn1J1FMhISVIxchKjpXMwDUXv08MuAiGPYpuSxc7IVBRnjDYYbaWb5rwkV
         p6eyb4G8vC3Ejr5lm+EO1qSDN7BLEw1Wl+fzTTdIBiZ5yZQATSv2ZgjRug6114ftV/3O
         1K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/trA3Oc5ZJjjWeUtSzI0YLjZPKi5e/fgHowkWR3Mlc=;
        b=MsgCATD6iOlcPtRL3hJ/OjSMt9ixRWdlsT9HsO+tGAAuQv9pPTB/2PXY4IqJwTHO1g
         k/TgcLDxYMn3jN+43boZh+pGK1qDz4wal5b4X0YlCpcEIsL4fcLtIMgvpJl9cmfaCkpH
         oNoC27nzt5isUBi9XpR3/myk5b+XGb1GJRRfdDoJxkPWF+TiuFRQuWGEKzVyrih71V5d
         6nTFTy2wfC6NB9kT9qqbeunzGIdHNUhED2yH6I0eJcbrvrVMrzhHQHG2DL9saCw5S+Yc
         LbdYeNynqT37NzYcZbd0ujH12GjwSQYwI26Sw6mhOHjv/m+UjqHMDmW5Nnzg5/MXiiiY
         J8Yg==
X-Gm-Message-State: AOAM5329VhLHOvtSqSLNKj8XPqqtKx3Xc+Zw99dvLfCCS5RnM+b0/txz
        0NjyrX2aR0Z+Y77Ya8c2/ZM=
X-Google-Smtp-Source: ABdhPJyrZppZzBjV8l9ffTi1W15Pq6ec40vnH/F/RHUBRUuF89npRMBMtw9Tyhj8mBg3cIEMEZCing==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr30205933edd.239.1651758437165;
        Thu, 05 May 2022 06:47:17 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006f3ef214e69sm728324ejz.207.2022.05.05.06.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:47:16 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        keosung.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] Several changes for UFSHPB
Date:   Thu,  5 May 2022 15:47:01 +0200
Message-Id: <20220505134707.35929-1-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Hi UFS driver developers/reviewers

Here are some changes to the UFS HPB driver. They are all based on Martin's Git repo
5.18/scsi-staging branch. Please refer to the patch submission information for the
specific purpose of each patch. I tested them on my own platform. Please have a review
and any comments and suggestions are welcome.

v3-v4:
     1. Fix coding style issues in patch
v2--v3:
     1. Fix two comment issues in patch 5/6
     2. change function ufshpb_toggle_state() in patch 1/6
     3. Add new pach 4/6
v1--v2:
     1. Increase the submission information of the cover letter.
     2. Fix coding style issues in patch 4/5
     3. Add new patch 5/5.

Bean Huo (6):
  scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
  scsi: ufshpb: Remove 0 assignment for enum value
  scsi: ufshpb: Cleanup the handler when device reset HPB information
  scsi: ufshpb: Change sysfs node hpb_stats/rb_* prefix to start with
    rcmd_*
  scsi: ufshpb: Add handing of device reset HPB regions Infos in HPB
    device mode
  scsi: ufshpb: Cleanup ufshpb_suspend/resume

 Documentation/ABI/testing/sysfs-driver-ufs |  18 +-
 drivers/scsi/ufs/ufshcd.c                  |   4 +-
 drivers/scsi/ufs/ufshpb.c                  | 182 ++++++++++++---------
 drivers/scsi/ufs/ufshpb.h                  |  16 +-
 4 files changed, 125 insertions(+), 95 deletions(-)

-- 
2.34.1

