Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629150CAFB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiDWOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiDWOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:05:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D2A13D21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:02:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so17023243plh.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEjazlko42eSNmnFMsfNKIUK4vM64jjnmcAEak7jHi0=;
        b=iP9m10e793inlZ2ZLBtIFPZHMWtI5P//T8Xff/vqtRCW7j7MAYOviwwi1DCNvIrMfl
         eSHPprXTt0oI59HEy39Qb5eMsQ+JSR79yD+C/RjiKScG83UoQ/pxqdyo7HXx7K/4ynpG
         Ad5HvdD7u1flATXoWas0ch6pXnrnVHw0STu72l4OLViFqc1D++9rilTq9UV+D98bbqjz
         U89Ck/DaGj26Kh8BPIYpjbXMtvTxa10H/AoudlrxRFSn5DhmyEzDqi3TIqLTKzGjhf0u
         a7K/5N9Et1jKuwEnfX/0ouvMHKN4mRrZ6i53mbRlJaEtcUqN9Cp1lNXD/bxUsihOvfgK
         pwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEjazlko42eSNmnFMsfNKIUK4vM64jjnmcAEak7jHi0=;
        b=6f4ik8T1EfUq6ksKYM4qqveonTCOWfl1GTGqLUx1J8tOm2G75bhCj3mE7/jJVTS6AG
         gKIURyLaahio21uE4T8ijIPGHDF3VXKVJHjzbUPrKTVl+QFmkvP8CHTt8Syy0xzKWI8t
         WnrEXPl5ITp5Un0uguenJ1tpu+jI1N2Ukv0JlRyLvqg4t7t6IvAMoXwRcnnRHAvySjco
         gr6KmYlOmHNpzO8Gf+dtxarJsJwRqCaI34cxWQ1Ve5uku+ZibeNAElp3dPs85pavnh7B
         x1xFaCvqzhzSEBdzsGRM/dCqRoZ7Jj+NdntDAVlgCfVtRP6e710cRnp/KRgI7NsEEsZ2
         2aQw==
X-Gm-Message-State: AOAM5329tqSB1ZA4zNGTtvAlJ/EYUOGJMR9MmWAZZle5apt7b4qYVzXG
        l1zi9IpakRyEpT7bHO5ql6h/
X-Google-Smtp-Source: ABdhPJx1CdrSbre0YGZ3YHo3FGaMSmsHAG681BKNraCo512Pprq5EID44zMPrLsNu9TVMZ0r/BwAHg==
X-Received: by 2002:a17:90a:b10c:b0:1d9:49de:81c5 with SMTP id z12-20020a17090ab10c00b001d949de81c5mr1103994pjq.120.1650722575789;
        Sat, 23 Apr 2022 07:02:55 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a390500b001cd4989ff50sm9452728pjb.23.2022.04.23.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 07:02:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/5] Qcom UFS driver updates
Date:   Sat, 23 Apr 2022 19:32:40 +0530
Message-Id: <20220423140245.394092-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series has some cleanups and updates to the Qcom UFS driver. There
is also a patch that removes the redundant wmb() from
ufshcd_send_command() in ufshcd driver.

All these patches are tested on Qualcomm Robotics RB3 platform.

Thanks,
Mani

Changes in v2:

* Used dev_err_probe() instead of dev_err().
* Removed the wmb() from ufs_qcom_dev_ref_clk_ctrl() as that is not required.
* Added Reviewed-by tag from Bart for patch 4/5.

Manivannan Sadhasivam (5):
  scsi: ufs: qcom: Fix acquiring the optional reset control line
  scsi: ufs: qcom: Simplify handling of devm_phy_get()
  scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled
  scsi: ufs: core: Remove redundant wmb() in ufshcd_send_command()
  scsi: ufs: qcom: Enable RPM_AUTOSUSPEND for runtime PM

 drivers/scsi/ufs/ufs-qcom.c | 44 ++++++++++++++-----------------------
 drivers/scsi/ufs/ufshcd.c   |  3 ---
 2 files changed, 16 insertions(+), 31 deletions(-)

-- 
2.25.1

