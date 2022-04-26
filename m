Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABE450EF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbiDZEEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiDZEEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:04:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B617051;
        Mon, 25 Apr 2022 21:01:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PL8t2i022267;
        Tue, 26 Apr 2022 04:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=VfaAkAPyUePRFxMzN4vqCs4A6PVXSAifuZPdHgE9/bI=;
 b=g30R3MYw16RtEFJoD/k/wG7apkc24EzrkocSqiTxKqOanPgiMm8TrNvPwmGPiSH2OPGn
 DtMVSx9bNUJNvK8eYhTyyPW2osoW4uN5Zyf6KNcL1upxZZCt0hwdTKC53CfyRpBp3wA5
 3fDnWX+G7TXLBoJAC7QiaX8XJwt8/A6JEvwYZs6W9OC4h0xqMnTu9B4Tot5rGAqlK11f
 4J8Yylg5ttBqSb+Ht7SwTsZds63CKPsNjZCZBCQ2ks/u67LsronCEAfYjqoeBYXjBdJO
 VNsnzqek+waFTQnrZIupbsCwpQNsJmb7Ey13B2X/9n2eGAXf1ibMM/2u1KbKdg7bRMnO PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4d0bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:00:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q40QVv029494;
        Tue, 26 Apr 2022 04:00:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj3v2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:00:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23Q40juV030030;
        Tue, 26 Apr 2022 04:00:47 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj3v10-4;
        Tue, 26 Apr 2022 04:00:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Po-Wen Kao <powen.kao@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Avri Altman <avri.altman@wdc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        chun-hung.wu@mediatek.com, chaotian.jing@mediatek.com,
        linux-scsi@vger.kernel.org, stanley.chu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, cc.chou@mediatek.com,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        alice.chao@mediatek.com, yohan.joung@sk.com,
        jiajie.hao@mediatek.com, linux-mediatek@lists.infradead.org,
        huobean@gmail.com, jason.li@sk.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
Date:   Tue, 26 Apr 2022 00:00:43 -0400
Message-Id: <165094528686.21993.15243100183282892659.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220412073131.10644-1-powen.kao@mediatek.com>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5ZG8fnjdj6FEVSC0UJ8zd_-U7Y1gxeCo
X-Proofpoint-ORIG-GUID: 5ZG8fnjdj6FEVSC0UJ8zd_-U7Y1gxeCo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 15:31:28 +0800, Po-Wen Kao wrote:

> Since the HPB mapping is already reset in ufshpb_init by setting
> flag QUERY_FLAG_IDN_HPB_RESET, there is no need doing so again in
> ufshpb_hpb_lu_prepared.
> 
> This would also resolve the issue where HPB WRTIE BUFFER is issued
> before UAC being cleared.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: ufs: remove redundant HPB unmap
      https://git.kernel.org/mkp/scsi/c/25a0bf213b8a

-- 
Martin K. Petersen	Oracle Linux Engineering
