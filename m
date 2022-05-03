Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23051930E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiEDA5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiEDA5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:57:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3F41311;
        Tue,  3 May 2022 17:53:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2430TJqf004092;
        Tue, 3 May 2022 00:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=wGPwHFOuOMksl22q2e5/lQBbzLvpT1VTH3Q5N00n7y0=;
 b=vDar8Q+O6tSVr1tdAcZv3smoox0GW0NwZAF50e2EAiOeLKGIsdzZ1QkybO3imZVA3H6t
 ycMw4tW++zZB+r5vY14lPk50sPb09+vMqS5d7YL4KuFe+SNe8KyUa6UtPr/sI0WGIUF8
 1eriDwj6lCGfmQKtNCbTZA2UgH7y68/oxjJbr7Xq4Dc32DjhPRqa9YnDYdNYfQta1Urb
 zPu1UX1ib1B16d0onxrrdraaoU5C+/n6qFNteT3cuxFchCN6Qjqhst5oFWm7Jtqh3EUy
 rbHKWq4fa4PJXyO0EaHUbHHfRPt5qQ1LhYSFFdVqSJiqm10rqsSqgpalQjP2Hzqlo/il Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430orC5009030;
        Tue, 3 May 2022 00:51:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljQ010389;
        Tue, 3 May 2022 00:51:55 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-15;
        Tue, 03 May 2022 00:51:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cgel.zte@gmail.com, satishkh@cisco.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        ran jianping <ran.jianping@zte.com.cn>,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        sebaddel@cisco.com, Zeal Robot <zealci@zte.com.cn>,
        kartilak@cisco.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi:fnic: remove unneeded flush_workqueue
Date:   Mon,  2 May 2022 20:51:25 -0400
Message-Id: <165153836361.24053.14382998267717469278.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220424065406.3228528-1-ran.jianping@zte.com.cn>
References: <20220424065406.3228528-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vpW7iZTdvALMR9FDI0opJ6JsqCa_KD6H
X-Proofpoint-ORIG-GUID: vpW7iZTdvALMR9FDI0opJ6JsqCa_KD6H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 06:54:06 +0000, cgel.zte@gmail.com wrote:

> From: ran jianping <ran.jianping@zte.com.cn>
> 
> All work currently pending will be done first by calling destroy_workqueue,
> so there is no need to flush it explicitly.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi:fnic: remove unneeded flush_workqueue
      https://git.kernel.org/mkp/scsi/c/671a52f2aeaf

-- 
Martin K. Petersen	Oracle Linux Engineering
