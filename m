Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E09519801
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbiEDHZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiEDHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:25:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8896167F1;
        Wed,  4 May 2022 00:21:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MCRCj030007;
        Tue, 3 May 2022 00:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=g9paThm+Fsnp2BWLsmTw8WxlestNVGXIq3xS3NKyV2I=;
 b=rEwDYggF5Wl2D1qSGwK6g1jUEdauuI2RYg4idRmm2NitjNsFCpUkwhbd6AVeLd25lFt4
 09hlxaXCPVPkDjreqs6/XFDQZd+YZlwm/Cv4O4U49c7yCgb/SRoax25PHT0kOBu4bCLQ
 Sr2GdAT1jrA9S73RdU7pA+/nMXvD3RtJzOgkn08M5bJ9AMIh22UJHdfbTBDLA5yqfsvj
 EbAL+n3yHWj5X+088IblmI/7fz9uVin5chS6l/6s6Hvpyk/AlQh25wsKlxdvitSwn/Lk
 P6Zef9YOozAZpCp8wUFPvgF4vyaz9l22S6tlJFOfRaSFygT6VI3he30iOZCYlWGVCC8o ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0cp5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430op0L008940;
        Tue, 3 May 2022 00:51:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljM010389;
        Tue, 3 May 2022 00:51:54 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-13;
        Tue, 03 May 2022 00:51:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cgel.zte@gmail.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, Zeal Robot <zealci@zte.com.cn>,
        shivasharan.srikanteshwara@broadcom.com,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] megaraid: fix error check return value of register_chrdev()
Date:   Mon,  2 May 2022 20:51:23 -0400
Message-Id: <165153836363.24053.6805660896758836737.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220418105755.2558828-1-lv.ruyi@zte.com.cn>
References: <20220418105755.2558828-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WgBq_sepvIPlWDiVpNmgjWGvceU0XsUy
X-Proofpoint-GUID: WgBq_sepvIPlWDiVpNmgjWGvceU0XsUy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 10:57:55 +0000, cgel.zte@gmail.com wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> If major equal 0, register_chrdev() returns error code when it fails.
> This function dynamically allocate a major and return its number on
> success, so we should use "< 0" to check it instead of "!".
> 
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] megaraid: fix error check return value of register_chrdev()
      https://git.kernel.org/mkp/scsi/c/c5acd61dbb32

-- 
Martin K. Petersen	Oracle Linux Engineering
