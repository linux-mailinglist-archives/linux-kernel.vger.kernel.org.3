Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0150793A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357399AbiDSSjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357614AbiDSShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B176D3EF30;
        Tue, 19 Apr 2022 11:30:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g13so6952773ejb.4;
        Tue, 19 Apr 2022 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srz+sEmD2ucHfb+YcY6XdjVFPqcuVkBR4P0HSOGGTk0=;
        b=LL1PK8N4+Lxjt4RjWlJmPEPvV7sMbCQ5r/xafRZu+MxJE4OQQ6t+Bbw5atL8z8P2e5
         CcMyhd7Sg9EKe5PsphMiFTZugHfl7IhV5uYrgiw0GBKujiuM1KmKqr5AMh01xYuN+7uZ
         onxGFw2IsvO9SmxS28zkRaNySs9n7j0+0c3IONZOVMbUyWuewYdEZqEHVbIRKCI8IZV5
         sEOxgZIO2QdLu/WI8SJBQg7Xv0iL/V1hV4huHb/50DDsT7Tiyr404uZjwGMCfwtz9LWW
         nnlmrYyfjH7orK5OTUCcMF58VFFfhapPZgDPm9IotkdEu2xmM9JWEA00tkWxGe21xJ6u
         W/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srz+sEmD2ucHfb+YcY6XdjVFPqcuVkBR4P0HSOGGTk0=;
        b=zdrJC7lBIUIOwDsNWiD5FRaempqp3qoHcLJ0qubKi3/dXyaUQgwsYY5W2Tfst/Dz77
         hElZ2s4Wjtee0uEGDdKLr7NPb8KSzLLGCNh3vmh+9yCkYX6A812tPTHLmJitbc0SvtxI
         RGWFpL1h/9n0u2ueK2TBmwEhPHEG22m/bvQt22XT/q0ctNczK2wTesVK53JK13sdL7ba
         sEHZvJz6KCe0Z5LL7eXaEJKb8iW7jRaD+y5XeMMJReuGttM0huL91EkDkI2RS+NfmQPF
         6YRV7d5BCRntvPh8jniBykrOG0Pg5k5jkKo5Ya8faPGt7Nm+MrQr6Da7a0jgCStmnr1/
         Ckng==
X-Gm-Message-State: AOAM533hI//Y+rOiZDaEZWt19siBxPXn2Y3LBMafhtA/KP+FxgV+yPyv
        AFH7H4QcuKRnIhn6N4CaADM=
X-Google-Smtp-Source: ABdhPJwDdEx22MzR+TbmibXMCUDZfFf8J7htm9zynudBpdoXlgSwnAxFL5zsupe+thKOdzEMYZTrKw==
X-Received: by 2002:a17:906:58c7:b0:6da:955b:d300 with SMTP id e7-20020a17090658c700b006da955bd300mr14690005ejs.481.1650393054109;
        Tue, 19 Apr 2022 11:30:54 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm8799915edb.23.2022.04.19.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:30:53 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        powen.kao@mediatek.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Several changes for UFSHPB
Date:   Tue, 19 Apr 2022 20:30:39 +0200
Message-Id: <20220419183044.789065-1-huobean@gmail.com>
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

v1--v2:
     1. Increase the submission information of the cover letter.
     2. Fix coding style issues in patch 4/5
     3. Add new patch 5/5.

Bean Huo (5):
  scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
  scsi: ufshpb: Remove 0 assignment for enum value
  scsi: ufshpb: Cleanup the handler when device reset HPB information
  scsi: ufshpb: Add handing of device reset HPB regions Infos in HPB
    device mode
  scsi: ufshpb: Cleanup ufshpb_suspend/resume

 drivers/scsi/ufs/ufshcd.c |   4 +-
 drivers/scsi/ufs/ufshpb.c | 157 ++++++++++++++++++++++----------------
 drivers/scsi/ufs/ufshpb.h |  10 +--
 3 files changed, 98 insertions(+), 73 deletions(-)

-- 
2.34.1

