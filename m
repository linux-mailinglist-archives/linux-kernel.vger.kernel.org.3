Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45B255DBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiF0QTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiF0QTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:19:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214F1164;
        Mon, 27 Jun 2022 09:19:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RGBtph008528;
        Mon, 27 Jun 2022 16:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=W0B/i2Y7BR/Muar1OIEMjEWG0aYzUrrG7nThEq4hGUU=;
 b=ZWoNGEMhXDrJuCsZ8oE0lv3uacSVF8Bj4w1EU4oON1Xpo2Dsguk39MPQoaYEzoQwq3V4
 5XIS8IwFjN4S3K2o7nF7dDZXeOJB1Npj92r0i8T7KueQuyj8ongNUtsVIChl/eZ23hwV
 SIGh59uicvodGMiqMo9sQ0JYK9xsfGN2GUeLPe0xMJqg7zRP4GqsqtMQPJhhQzIDQDQA
 4Tm4bK9WefIxB7w77WF7gVOz1zXASDh2XiaSfUvtlrNswOKXh98HuhFeFGfkQepje/rZ
 117IVQ+gn2rD4p6kQxDulwwMlsqGxm9ANiFlhfEVrCvj6yLe/zII4+c1NmFGPmVkwh+r NA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyfut86d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:19:38 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25RG78nr028323;
        Mon, 27 Jun 2022 16:19:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3gwsmhtfgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:19:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25RGJWCM22348068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 16:19:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AB74C04A;
        Mon, 27 Jun 2022 16:19:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E124C040;
        Mon, 27 Jun 2022 16:19:32 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.237])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Jun 2022 16:19:32 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.94.2)
        (envelope-from <bblock@linux.ibm.com>)
        id 1o5rSZ-001mnt-1x; Mon, 27 Jun 2022 18:19:35 +0200
Date:   Mon, 27 Jun 2022 16:19:34 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     maier@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: zfcp: drop unexpected word "the" in the comments
Message-ID: <YrnYlsI2PZvJN6Ez@t480-pf1aa2c2.fritz.box>
References: <20220621114207.106405-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220621114207.106405-1-jiangjian@cdjrlc.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lXcoYxQVasJsgb08JDp5bMUT33-iqVC4
X-Proofpoint-GUID: lXcoYxQVasJsgb08JDp5bMUT33-iqVC4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 07:42:07PM +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: ./drivers/s390/scsi/zfcp_diag.h
> line: 5
> * Definitions for handling diagnostics in the the zfcp device driver.
> changed to
> * Definitions for handling diagnostics in the zfcp device driver.
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/s390/scsi/zfcp_diag.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_diag.h b/drivers/s390/scsi/zfcp_diag.h
> index da55133da8fe..15c25fefe91a 100644
> --- a/drivers/s390/scsi/zfcp_diag.h
> +++ b/drivers/s390/scsi/zfcp_diag.h
> @@ -2,7 +2,7 @@
>  /*
>   * zfcp device driver
>   *
> - * Definitions for handling diagnostics in the the zfcp device driver.
> + * Definitions for handling diagnostics in the zfcp device driver.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

Thanks, I'll queue this, and will send it the next time we send patches
for scsi.

>   *
>   * Copyright IBM Corp. 2018, 2020
>   */
> -- 
> 2.17.1
> 

-- 
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Systems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/privacy
Vorsitz. AufsR.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294
