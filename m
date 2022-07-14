Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00267574267
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiGNEY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiGNEXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:23:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FF82871D;
        Wed, 13 Jul 2022 21:22:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3mrT7014116;
        Thu, 14 Jul 2022 04:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Us2UrJm+CrAchXldrlfTY1vJzYEZtEywPP3HPE+EGck=;
 b=E/d/2hNl95kwCT5CNGmYE5uNhW+ZO5hz5mVsvdB+BSlhmh94b/dW5a6oPNr6JSG+8TWs
 VLP2eNM7rgDMCJn7nmqhehIWF1xuPwJMKQUI2KemUKXlm7qdIKk8VydJe8k8nSDSiji2
 RmhPAxCcf3EwXYsKvYufqi7hhDSIRJLLkXx6SEWCfb9HndhGz921KTp1e3aJMoPSsofC
 rmqnXTgzH6dFsQ4biBEtnJZCt0yVGaJR5f62qrB8OKs+X6KvxMxt5+Y0YLb8H+iLiimr
 JtP4LqDmQyUYIeHreCoLYWLooemMo3+ZIKittqQEW4AeLmuWIB+MrtapyeRHYHEmu1hP pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scc27q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E4Assk000991;
        Thu, 14 Jul 2022 04:22:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045au2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26E4MD5L024736;
        Thu, 14 Jul 2022 04:22:16 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045au20-5;
        Thu, 14 Jul 2022 04:22:16 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     asutoshd@codeaurora.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        cc.chou@mediatek.com, alice.chao@mediatek.com,
        mason.zhang@mediatek.com, stanley.chu@mediatek.com,
        peter.wang@mediatek.com, jiajie.hao@mediatek.com,
        linux-mediatek@lists.infradead.org, chaotian.jing@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        chun-hung.wu@mediatek.com
Subject: Re: [PATCH 1/1] scsi: ufs: fix missing clk change notification on host reset
Date:   Thu, 14 Jul 2022 00:22:12 -0400
Message-Id: <165777180153.4401.9576790792487987073.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711144224.17916-2-powen.kao@mediatek.com>
References: <20220711144224.17916-1-powen.kao@mediatek.com> <20220711144224.17916-2-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U0wZjmrQuW-CRIib8J2KKEbveJx9i5pB
X-Proofpoint-ORIG-GUID: U0wZjmrQuW-CRIib8J2KKEbveJx9i5pB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 22:42:23 +0800, Po-Wen Kao wrote:

> In ufshcd_host_reset_and_restore(), ufshcd_set_clk_freq() is called
> to scale clk rate. However, this did not call vops->clk_scale_notify()
> to inform platform driver of clk change.
> 
> We propose to call on ufshcd_scale_clks() instead so that clk change
> can be properly handled.
> 
> [...]

Applied to 5.19/scsi-fixes, thanks!

[1/1] scsi: ufs: fix missing clk change notification on host reset
      https://git.kernel.org/mkp/scsi/c/52a518019ca1

-- 
Martin K. Petersen	Oracle Linux Engineering
