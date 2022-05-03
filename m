Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7A51D522
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiEFKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiEFKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:07:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45255A2D5;
        Fri,  6 May 2022 03:03:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MkbAf018676;
        Tue, 3 May 2022 00:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=0C11CsAnW4P/5rKgNjIeUGF+r6Ukzxc/zDr4VSM6xbw=;
 b=Azi0nxGPJ/lhtYTgEqO0MVtrhnzBtHd57PI+x2/UIvEKjujA+yaLm9ptEARPpCRrwB2Y
 6YO/hwu5jcv6aRxl7qWxnlE6gdwEXjBsespamKwaVJKLQzlHd3P55I2gd8VN48KvaacF
 xZV1K7Gv7P2ey+udSe2bF2rFJoZDMbvpvJl4K8P0Q0Hli0IMxT750Cy2Zu1wDjeFnwEC
 EXRVkFFGHw7pkA2Z/8gvw09Fj4dWstpT3DpAIBS/qQnsf1CNQiD++A39yVLDFGfbJONA
 CgZIs+DpWR6zdPwBJDuKeDoGqyXe+QW3y3yqTMVB3pA863odXncvE79UfYYxvFnHWdFp xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt4kx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oowt008899;
        Tue, 3 May 2022 00:52:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljs010389;
        Tue, 3 May 2022 00:52:03 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-29;
        Tue, 03 May 2022 00:52:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     vkumar.1997@samsung.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        beanhuo@micron.com, cang@codeaurora.org, bhoon95.kim@samsung.com,
        sh425.lee@samsung.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [RESEND PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
Date:   Mon,  2 May 2022 20:51:39 -0400
Message-Id: <165153836362.24053.16346946896226280421.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1648689845-33521-1-git-send-email-kwmad.kim@samsung.com>
References: <CGME20220331012539epcas2p180d804d9562b6e0fb968ffd181d64605@epcas2p1.samsung.com> <1648689845-33521-1-git-send-email-kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0VwwRJBFilOQDQMt6MiZM326Cl2Y3HAk
X-Proofpoint-GUID: 0VwwRJBFilOQDQMt6MiZM326Cl2Y3HAk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 10:24:05 +0900, Kiwoong Kim wrote:

> v2 -> v3: add fixes
> v1 -> v2: does skipping only for zero offset
> 
> These are ROC type things that means their values
> are cleared when the SFRs are read.
> They are usually read in ISR when an UIC error occur.
> Thus, their values would be zero at many cases. And
> there might be a little bit risky when they are read to
> be cleared before the ISR reads them, e.g. the case that
> a command is timed-out, ufshcd_dump_regs is called in
> ufshcd_abort and an UIC error occurs at the nearly
> same time. In this case, ISR will be called but UFS error handler
> will not be scheduled.
> This patch is to make UFS driver not read those SFRs in the
> dump function, i.e. ufshcd_dump_regs.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: ufs: exclude UECxx from SFR dump list
      https://git.kernel.org/mkp/scsi/c/ef60031022eb

-- 
Martin K. Petersen	Oracle Linux Engineering
