Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E92554068
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356226AbiFVCKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356136AbiFVCKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:10:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10245338AE;
        Tue, 21 Jun 2022 19:10:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0IiLt002242;
        Wed, 22 Jun 2022 02:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Uh2KVX83UjniT/X3eBrQjsKFrVSNSOBjSj6MbRV+RM8=;
 b=d2HrjYXPPj6DSaai5niGRZw6POBnEcuy0OU1ED0W4wV3Kz3QeRxPDS5BWRipxLt76giS
 7KjzVwQnV0qbbmf6J9eXUHdIRw+X9Zny1H0kkLCBKgKJJlBqC4mnS0dkDsfE9mv3A3y4
 1/CyPY+Vy+2JMxI4KUXAxsju79wtRY9ZNVGm61T+gybdcH1vngNpj49syiVATkXOHisx
 Sxlty68FGNPqsoOhlQJKsZSShHOv6+QF2bJT7eKD35z1Rf3bdSIMbyvoLTzo6CfMnSVC
 orkLdd6UhVrEVBtOi33jM2OWww3hFeOIXIZ6JWEthj5Ardww54bkUxE3irK02UsL4XSi KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0f6wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 02:10:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M26bgV038209;
        Wed, 22 Jun 2022 02:10:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9usx4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 02:10:21 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25M29Biw002724;
        Wed, 22 Jun 2022 02:10:21 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9usx36-6;
        Wed, 22 Jun 2022 02:10:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     bvanassche@acm.org, jejb@linux.ibm.com,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-scsi@vger.kernel.org, avri.altman@wdc.com,
        alim.akhtar@samsung.com, linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        cc.chou@mediatek.com, chun-hung.wu@mediatek.com,
        qilin.tan@mediatek.com, chaotian.jing@mediatek.com,
        lin.gui@mediatek.com, jiajie.hao@mediatek.com,
        eddie.huang@mediatek.com, powen.kao@mediatek.com,
        peter.wang@mediatek.com, alice.chao@mediatek.com,
        tun-yu.yu@mediatek.com, mason.zhang@mediatek.com
Subject: Re: [PATCH v5 00/11] scsi: ufs: Fix PMC and low-power mode on MediaTek UFS platforms
Date:   Tue, 21 Jun 2022 22:10:16 -0400
Message-Id: <165586371838.21830.10837067016201802350.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220616053725.5681-1-stanley.chu@mediatek.com>
References: <20220616053725.5681-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GWhTys5xcKuFfbQu_U5O6KuMkUa_kQM8
X-Proofpoint-GUID: GWhTys5xcKuFfbQu_U5O6KuMkUa_kQM8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 13:37:14 +0800, Stanley Chu wrote:

> This series provides some fixes on MediaTek UFS platforms, please consider this patch series for kernel v5.20.
> 
> - Provide workaround for power mode change for HS-G5
> - Fix and provide regulator features
> 
> Changes compared to v4:
> - Add one patch to disable unused VCCQx
> - Fix the invoking location of ufs_mtk_vreg_fix_vccqx()
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[01/11] scsi: ufs: Export ufshcd_uic_change_pwr_mode()
        https://git.kernel.org/mkp/scsi/c/fc53683b45b0
[02/11] scsi: ufs: Fix ADAPT logic for HS-G5
        https://git.kernel.org/mkp/scsi/c/d81c4c6f7170
[03/11] scsi: ufs-mediatek: Introduce workaround for power mode change
        https://git.kernel.org/mkp/scsi/c/3f9b6cec12e2
[04/11] scsi: ufs-mediatek: Fix the timing of configuring device regulators
        https://git.kernel.org/mkp/scsi/c/3fd23b8dfb54
[05/11] scsi: ufs-mediatek: Prevent device regulators setting as LPM incorrectly
        https://git.kernel.org/mkp/scsi/c/005ffdf09cd3
[06/11] scsi: ufs-mediatek: Support low-power mode for VCCQ
        https://git.kernel.org/mkp/scsi/c/0836cc252a52
[07/11] scsi: ufs-mediatek: Support flexible parameters for smc calls
        https://git.kernel.org/mkp/scsi/c/bc602ae977f3
[08/11] scsi: ufs-mediatek: Support low-power mode for parents of VCCQx
        https://git.kernel.org/mkp/scsi/c/42b1928360a3
[09/11] scsi: ufs: Export regulator functions
        https://git.kernel.org/mkp/scsi/c/1d6f9decb60a
[10/11] scsi: ufs-mediatek: Support multiple VCC sources
        https://git.kernel.org/mkp/scsi/c/ece418d02911
[11/11] scsi: ufs-mediatek: Disable unused VCCQx power rails
        https://git.kernel.org/mkp/scsi/c/cb142b6d2f60

-- 
Martin K. Petersen	Oracle Linux Engineering
