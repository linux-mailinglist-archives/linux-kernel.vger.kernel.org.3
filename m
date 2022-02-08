Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2274AD0D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiBHFcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347055AbiBHEw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3CC0401DC;
        Mon,  7 Feb 2022 20:52:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2183uKrx026741;
        Tue, 8 Feb 2022 04:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=7kSqNLwKatMwcHKTyR/vqyUBGGAXfKKzJX9D4uaFx6Y=;
 b=xgqIbQ06kQWps0QWfxH1VA2jyCvsI3HJj3nh8h5A29IANegcWMvq2RICeuViJg34Iwcs
 647QpsNsroSLXqChWWzsVmTnlqhmkqPEmonl7nmXt9fa7K6U/LSFmg2MdXzd/Tgw3MHA
 7ze7QBFtW5yLcElaTv74iFg4a9xpGOAuua/MhlnRD/lB4gnHMOoUALwvf+SqYzyyiWoE
 epwbZ81ZN06jgAGWF1IiQsbrv/RuI6TIv3xxpwVOGIsxhIYyfq6NNCNvadlRKEl2dGnJ
 3y4XsyePalPKHhnrx7Jo8+vgEOgU4xHzflgP9hYWJ/+J29DmiBBJ4f3CpeozBT1IFhUF kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28g3j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q13x088254;
        Tue, 8 Feb 2022 04:52:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppss02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:22 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKht089147;
        Tue, 8 Feb 2022 04:52:21 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-2;
        Tue, 08 Feb 2022 04:52:21 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     james.smart@broadcom.com, cgel.zte@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, Zeal Robot <zealci@zte.com.cn>,
        linux-scsi@vger.kernel.org, dick.kennedy@broadcom.com,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lpfc: Remove redundant 'flush_workqueue()' calls
Date:   Mon,  7 Feb 2022 23:52:13 -0500
Message-Id: <164429583888.16454.5086207565106248383.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127014330.1185114-1-chi.minghao@zte.com.cn>
References: <20220127014330.1185114-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X-LeHlGe0RRXue8DFoQVHLhPtHpYm89f
X-Proofpoint-GUID: X-LeHlGe0RRXue8DFoQVHLhPtHpYm89f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 01:43:30 +0000, cgel.zte@gmail.com wrote:

> From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
> 
> 'destroy_workqueue()' already drains the queue before destroying it,
> so there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] lpfc: Remove redundant 'flush_workqueue()' calls
      https://git.kernel.org/mkp/scsi/c/d1d87c33f47d

-- 
Martin K. Petersen	Oracle Linux Engineering
