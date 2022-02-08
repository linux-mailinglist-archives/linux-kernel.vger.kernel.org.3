Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6C4AD0DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347246AbiBHFc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347070AbiBHEws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B253C0401DC;
        Mon,  7 Feb 2022 20:52:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2183uM12026751;
        Tue, 8 Feb 2022 04:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=ieZeezeI2TpWtYFPeoUUGHoiN6GxjmTjle+KL9elrEY=;
 b=OGQbCSDDnF21PyL0H7ha1LaPNx8lpwIHjQ4/J+o3+tFlIZ0584s1nyGfPEGWxyGZ42zj
 +craRHM1VKLLsMTaEnekUtNoI0DyrxxHgxSnDrblkMtg8Lw4H0nXx5lMkO7fj4mBbw3t
 X9atqYYAEDj6MRsEBis4Rkd9wxcPz02mehnbt8Qk11QaOemkA6t0MH2HyVQQUvoN4RAF
 URtLHxjyt1g5sPnAkXwKfwWLrA+FHlPhgvfJ+E2P7dL+QYlMyDtJ0+0ih4MlH0PLlMvL
 AxMOjG9dMWxZK94iX3bZ5k62GEXoiwstzs/kp0MkIZ61D5F45Ak5fHF3utPbWGIXt0iO xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28g3jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q1tO088293;
        Tue, 8 Feb 2022 04:52:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppss6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKi3089147;
        Tue, 8 Feb 2022 04:52:28 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-6;
        Tue, 08 Feb 2022 04:52:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>, avri.altman@wdc.com,
        jejb@linux.ibm.com, huobean@gmail.com, linux-scsi@vger.kernel.org,
        asutoshd@codeaurora.org, bvanassche@acm.org, cang@codeaurora.org,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH RESEND] scsi: ufs: Add checking lifetime attribute for WriteBooster
Date:   Mon,  7 Feb 2022 23:52:17 -0500
Message-Id: <164429583887.16454.1665824706209955136.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
References: <CGME20220126104125epcms2p50afb250190ffc3f2dc7b16df31757c94@epcms2p3> <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: z7d8cay8KKCFc4zJT6_QoUJjHZKfsCSN
X-Proofpoint-GUID: z7d8cay8KKCFc4zJT6_QoUJjHZKfsCSN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 12:00:25 +0900, Jinyoung CHOI wrote:

> Because WB performs write in SLC mode, it is difficult to use WB
> infinitely.
> 
> Vendors can set the Lifetime limit value to the device.
> If Lifetime exceeds the limit value, the device itself can disable the
> WB feature.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: ufs: Add checking lifetime attribute for WriteBooster
      https://git.kernel.org/mkp/scsi/c/f681d1078d45

-- 
Martin K. Petersen	Oracle Linux Engineering
