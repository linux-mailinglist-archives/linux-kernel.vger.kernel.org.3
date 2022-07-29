Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352CA58498A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiG2CF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG2CFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:05:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596DA11821
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:05:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w63-20020a17090a6bc500b001f3160a6011so5120312pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrPTwHjfC5QxsVG3vayD8eV3MqvBjr0U91L8fruvcYg=;
        b=aJhskqxfHu9Y2ZpoWFbtIeFpB4Imk6JZOVzW4D8S2y6DMUoufx0RE3fq/be6nFU2au
         wb6GvuodPNYVan8O0B3whcvlFn4/n8AhT2jZkHIEoTkVg7fSan0w+KAxcqCGumWgdZKq
         Y8yHiqpMBrxaF5Xp6vWy4dcZrEmkbsuJo0bbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrPTwHjfC5QxsVG3vayD8eV3MqvBjr0U91L8fruvcYg=;
        b=JsD+eo5mqIrSS8winSDj6kNfrlItHaem3eyrcYkXbS78lkFKbimCzG5hhvUmexysGl
         PxWqAsTbVSFoQa6eHkObaqXbznNcy5VYqyN5AbZywgij0hvxs7ShfVCLXTZNpSClSpGT
         qRPpZ5PTk7Ltnf8/VCpWifTPmijRQmF0ft4wFg3MpstMflwbv6qJgK6fToUK2g+LFVKJ
         EgM14R2AjFH86kqcp4zQchGrLT28QiNHtOVlPnzc+dVbDzCO2P4IxMg6Hh2o4Hcx/vUO
         pztF763Ut5wK4EMIf8aaR3yHBffNtUCAj9KWFK7PzwazMmI2LAET+tizCjoQ6mJubPCL
         6jwQ==
X-Gm-Message-State: ACgBeo1GeA8E/YGRQv43bfckFhK/a70STATdufVKtZPnZZlUv+a0RO6g
        T46JSwwVARDj8SNNskfjr3Di1Q==
X-Google-Smtp-Source: AA6agR4yg+hJT2sTUv6xIxgwqftaALBJ1dWWW39BU5Dsu1TjnAGWtGgfMYa2Uq/BoKZakwmgeNMCPw==
X-Received: by 2002:a17:90b:3e8a:b0:1f0:4157:daf8 with SMTP id rj10-20020a17090b3e8a00b001f04157daf8mr1583417pjb.222.1659060320809;
        Thu, 28 Jul 2022 19:05:20 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id y124-20020a62ce82000000b005258df7615bsm1571901pfg.0.2022.07.28.19.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 19:05:20 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: [PATCH v3 0/2] Expose UFSHCD capabilities in sysfs.
Date:   Fri, 29 Jul 2022 12:05:06 +1000
Message-Id: <20220729020508.4147751-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset introduces new sysfs nodes, which userspace can check to
determine support for certain capabilities. Specifically the patchset
exposes Clock Scaling, Write Booster, and Inline Crypto Engine
capabilities.

Changes in v3:
* Expose each capability as an individual node
* Add preleminary CL to align checking for capabilities
* Modify documentation to represent new scheme

Changes in v2:
* Add documentation entry for the new sysfs node.

Daniil Lunev (2):
  ufs: add function to check CRYPTO capability
  ufs: core: print UFSHCD capabilities in controller's sysfs node

 Documentation/ABI/testing/sysfs-driver-ufs | 39 ++++++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 41 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd-crypto.c           |  8 ++---
 drivers/ufs/host/ufs-mediatek.c            |  2 +-
 drivers/ufs/host/ufs-qcom-ice.c            |  4 +--
 drivers/ufs/host/ufshcd-pci.c              |  2 +-
 include/ufs/ufshcd.h                       |  5 +++
 7 files changed, 93 insertions(+), 8 deletions(-)

-- 
2.31.0

