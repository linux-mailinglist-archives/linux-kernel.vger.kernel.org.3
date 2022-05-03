Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69030518D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbiECTmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiECTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:42:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F429812;
        Tue,  3 May 2022 12:39:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242N6sYP018740;
        Tue, 3 May 2022 00:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=GDwmhui71kBGYpJFLTpLpsg/uJyruGStrtZbHv68bZU=;
 b=kdzSD4YBWC3VTG2Nmk8tZenewvhx1VhlmL39Fv2/Kjgg96YpvTgRETXUVz/Jv9CJ+tHv
 vnISp6o4ABX398sMXckmqUrF6hHPN1b5jMetMXH8pdrk+E3yIohJYceQjryZyZcxkHpy
 WoZR774pmHFns7dteSTr7bQY+fzdvniTn5Msgwn8tjpwBKBS+LCFmXwtnlRPUFsvp9R/
 Q4l0D0n1MCZIYVp9mkqbZS9yfC30DBG0zEZf0XqdMix5GEpqTFf1X6AgfzpZ930zImya
 pUveYlAhLnzWQvdiLQWj0MiEhczauzTJVxmCcj6N6zSFbSp6CMIT3sWtM1TNBiDpN7pf CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt4kwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oows008899;
        Tue, 3 May 2022 00:51:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljW010389;
        Tue, 3 May 2022 00:51:57 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-18;
        Tue, 03 May 2022 00:51:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     alim.akhtar@samsung.com, cgel.zte@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] scsi: ufs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon,  2 May 2022 20:51:28 -0400
Message-Id: <165153836363.24053.9079302597637883038.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220420090353.2588804-1-chi.minghao@zte.com.cn>
References: <20220420090353.2588804-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 821uxx0Y43ZbGMH6V2obdTmChDCvpSKo
X-Proofpoint-GUID: 821uxx0Y43ZbGMH6V2obdTmChDCvpSKo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 09:03:52 +0000, cgel.zte@gmail.com wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: ufs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      https://git.kernel.org/mkp/scsi/c/75b8715e20a2

-- 
Martin K. Petersen	Oracle Linux Engineering
