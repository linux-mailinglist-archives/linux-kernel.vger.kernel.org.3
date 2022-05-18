Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D499452B047
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiERB4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiERBzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:55:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D50F07;
        Tue, 17 May 2022 18:55:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKgGIQ031659;
        Wed, 18 May 2022 01:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=WINoPMnV95p+ub5aBvEYZWMBEM7WAa67hzS2CHcAaio=;
 b=dwHYrkVDO/TpiP0jM/grCR0oLAW2moLDg/VdNtXeW60TeX+Ctc+/q0SsrcRS002PI0Y8
 H6P9hEhtGBhjWg2ZqfCPOP1c0DbnvGE21+SEp12uUVc2ZYGae4NCmRb4iiVKqQsh2GOX
 dsKus5IQNi790E2d8zKfEL+RFYTTUysKFUYIy1I33CcntPDxkDgRyMcS9Rxxuglfnrf0
 BUgTHllwN9rl2J3DWDIYBVIYoaMsHnKZc6l/rouh5LqS1bmvcR1NoObcCr8PNC5om9z5
 RPWGQSwcZfZycYzkE4IwGxptMEBu80n+2+VBLUi1+iN8xEbaYmi79cnZJgXWs2UwCXlU Sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aaftv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:55:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I1j166022553;
        Wed, 18 May 2022 01:55:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v3r69s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:55:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24I1tdCY004454;
        Wed, 18 May 2022 01:55:39 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v3r69m-1;
        Wed, 18 May 2022 01:55:39 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     mingzhe.zou@easystack.cn, michael.christie@oracle.com,
        torvalds@linux-foundation.org, zgrieee@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.yang@easystack.cn, zoumingzhe@qq.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: target: fixup incorrect use of 'cpumask_t'
Date:   Tue, 17 May 2022 21:55:38 -0400
Message-Id: <165283883037.1328.16838345221393341169.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220516054721.1548-1-mingzhe.zou@easystack.cn>
References: <20220516054721.1548-1-mingzhe.zou@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gep8iAr9P7wUo-80x8z-rdTt17I37yM_
X-Proofpoint-GUID: gep8iAr9P7wUo-80x8z-rdTt17I37yM_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 13:47:21 +0800, mingzhe.zou@easystack.cn wrote:

> From: mingzhe <mingzhe.zou@easystack.cn>
> 
> In commit d72d827f2f26, I used 'cpumask_t' incorrectly.
> ```
> void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
> {
>         int ord, cpu;
>         cpumask_t conn_allowed_cpumask;
>         ......
> }
> 
> [...]

Applied to 5.18/scsi-fixes, thanks!

[1/1] scsi: target: fixup incorrect use of 'cpumask_t'
      https://git.kernel.org/mkp/scsi/c/525f447f88b1

-- 
Martin K. Petersen	Oracle Linux Engineering
