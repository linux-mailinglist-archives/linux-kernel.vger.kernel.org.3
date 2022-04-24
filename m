Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6EE50D590
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiDXWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiDXWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:10:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC95DE62;
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k23so26304390ejd.3;
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2H2AXfbxWA68zIMMHvshnAviY4sNEeUJxPTpEO454U=;
        b=Reqt7zM2oA9PAEE2BBONidRzZFkUdNQYho8+ZFTISMdcer7rs+dhC7xI3Zk5Klx+Za
         PF/RymujObQubtGq4jBcPPiBUj9vaHWmpoNu2lMvF9JOSqEbC+IulAqhxHOnJ7Bjg2se
         B4LrFJvg5Gn7IIYEaCd65Q1TYbWLQ1HY1msXOsxzfsO4zohvlkGws5FM4tlJH8/zo54H
         +pljmXjyxzzY/wj698rRyNyLnSMJeVhBHl3bSbXJfgKpu7DQZ27tlbXgfJEuPay2DRKB
         GOrRn+UQntlddnegC+xw6aOMvtka7JDuO0JsKxp+OUvnbyNmUXhE9M2fNWNp4nb+i5VL
         k/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2H2AXfbxWA68zIMMHvshnAviY4sNEeUJxPTpEO454U=;
        b=jE/aR6bMXe77NYxmPOiZzyr1io2bojM+oW1hzzMOAt8fm6mx7hdw1iWjUh7CenPcQ/
         ZnsosVbienmhWechWTW6wK7Xu+fEzICJ5YmKaRuR7ef/VwemG4dkgA99Wu3CE3E+SJVW
         z1R6s0y4NhQXDL/c4bjaw0kpKOHfi8fsuius/wJXPAmY4Gx3zlVRvxLMvx5WT0/kw2+u
         XAAjExM0mRzBQgESQp7gK8JT5oXB6VMqivBzAkkQcC5fw+GcgKtPrr9n6PVpUXKeU/wH
         BDfPBi489ix3IpYjtUBE0g/qwplEJJ/zvao9w0+HQ8ojPIdMSfxsPbzF78aXxZnMaOC/
         A8FQ==
X-Gm-Message-State: AOAM532k5O80i4vLQyW9/9KP/9uPaTFmEBbXjv8f4RthaShg318FYW1H
        mEK08X4WRxEZobtm7XedHTQ=
X-Google-Smtp-Source: ABdhPJw+zTpyfjvpvbQMR+uVauh16U0TMxN3EsJWKMn3KY+NU8jQysjkylXXNuPFOzNlIqjUFhoCPg==
X-Received: by 2002:a17:906:dc89:b0:6e8:73e0:ef9a with SMTP id cs9-20020a170906dc8900b006e873e0ef9amr13683078ejc.638.1650838041647;
        Sun, 24 Apr 2022 15:07:21 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3672948edt.92.2022.04.24.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:07:21 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, keosung.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Several changes for UFSHPB
Date:   Mon, 25 Apr 2022 00:07:07 +0200
Message-Id: <20220424220713.1253049-1-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

