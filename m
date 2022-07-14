Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0428574256
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiGNEX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiGNEWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:22:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11A27FD6;
        Wed, 13 Jul 2022 21:22:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3nC8E031560;
        Thu, 14 Jul 2022 04:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=oc7DODaeMYfYgN8sRoftnKbUEW5IoAXyOTF7b89UI8Y=;
 b=gXEtEJJXmVKSN/La/mLjd2HoivD5OLkcnO9Sd+bJ3RUBXOUZizZXiwpOb55IfoC/hSfL
 JAwUezS2Lsy2tRG+j4TL5iWcufiC2UEMzP3veCgClDY8FWyIfk6u1K95JfO5jtldFZXg
 nAXKYh0CbHshqtQXQT+vISImHjnJ/xXj5xbGym+DHCV086F8nFuvvvKlExzFvXIz9U0C
 1/LFXKq8PenokpTVniEZu/ssQGmbPbMB5nLNxqICriry3tF/9slqciYzOAkxu0N32NFm
 +JiTxStAp+cWOt6ALH7iBBADpAPI/vKYqf/orHPOROMx41LitDZ53W7wBp7dlj4jI3kg Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1bje8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E4ApYm040463;
        Thu, 14 Jul 2022 04:22:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70451jpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26E4MWBl023864;
        Thu, 14 Jul 2022 04:22:34 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70451jnc-4;
        Thu, 14 Jul 2022 04:22:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Enable WriteBooster capability on ADL
Date:   Thu, 14 Jul 2022 00:22:24 -0400
Message-Id: <165777182484.7272.12896788838326615430.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
References: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DwV263lcnkIDVk_bpc2GLkc5PSevAd9j
X-Proofpoint-GUID: DwV263lcnkIDVk_bpc2GLkc5PSevAd9j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 16:53:26 +1000, Daniil Lunev wrote:

> Sets the WriteBooster capability flag when ADL's UFS controller is used.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-pci: Enable WriteBooster capability on ADL
      https://git.kernel.org/mkp/scsi/c/1466b3bc456a

-- 
Martin K. Petersen	Oracle Linux Engineering
