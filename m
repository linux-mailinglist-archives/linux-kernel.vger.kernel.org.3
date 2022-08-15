Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE02593395
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiHOQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHOQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:54:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A1255A6;
        Mon, 15 Aug 2022 09:54:08 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FGlplv019299;
        Mon, 15 Aug 2022 16:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EwrRiFrSU8LeFB56OUDRDDRbkXfFHbIwJFmOXCKnbUI=;
 b=Z03mNdRg3K7OnbTafsuwpZ8FUE+7MX+EPHB7MCboqUzsaaX6HGfGJ/H51RfhJ75bfOjv
 xFldL4za/cSbntrgGrZYAQBJ2+QmdyiYUI5uK8Cxfnhh1z/qIYWa0831QD/tvhFwwiKv
 /t/mmGH4qIqKoMu2BaRGGTLKVRXuYfNNfQdHAu6PNWD7Hjzxo9Rfqg9HuocQOzV2oS+u
 bwMlS5R3s9IzcQJBgvTECL9c77vHu81piIOqudVmpUxLddcICEusHpu0/s1bn1CW2++E
 IU4O2ac9GINIz5HgKwZA3buvMLSSpEworFzOpmhw93s3CfHVQtcclJXlHQUGjE9ZmYpz 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyraakmat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 16:53:51 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27FFUO6W018836;
        Mon, 15 Aug 2022 16:53:51 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyraakm9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 16:53:51 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27FGpBwl015946;
        Mon, 15 Aug 2022 16:53:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3hyp8sg4yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 16:53:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27FGp4dc31392028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 16:51:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B062A404D;
        Mon, 15 Aug 2022 16:53:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6894A4040;
        Mon, 15 Aug 2022 16:53:45 +0000 (GMT)
Received: from [9.145.14.35] (unknown [9.145.14.35])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Aug 2022 16:53:45 +0000 (GMT)
Message-ID: <3ed022dd-3026-542a-c3b0-e4f4005208aa@linux.ibm.com>
Date:   Mon, 15 Aug 2022 18:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] scsi: increase scsi device's iodone_cnt in scsi_timeout()
Content-Language: en-US
To:     Wenchao Hao <haowenchao22@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenchao Hao <haowenchao@huawei.com>
References: <20220815164324.645550-1-haowenchao@huawei.com>
From:   Steffen Maier <maier@linux.ibm.com>
In-Reply-To: <20220815164324.645550-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fAB8yWfhos8R4Ni3kqVDQpVgCRlA43O2
X-Proofpoint-GUID: greW_b_5pyZ0byvvGkKUmPFUyuXgBEK1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 18:43, Wenchao Hao wrote:
> The iodone_cnt might be less than iorequest_cnt because
> we did not increase the iodone_cnt when a command is done
> from timeout.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>   drivers/scsi/scsi_error.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 448748e3fba5..d21ae0090166 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -355,6 +355,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
>   		 */
>   		if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
>   			return BLK_EH_RESET_TIMER;
> +		atomic_inc(&scmd->device->iodone_cnt);
>   		if (scsi_abort_command(scmd) != SUCCESS) {
>   			set_host_byte(scmd, DID_TIME_OUT);
>   			scsi_eh_scmd_add(scmd);

Not sure, but can't we still get a (late) regular completion even after the 
timeout happened (double accounting) and before we successfully aborted the 
command?


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z and LinuxONE

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschaeftsfuehrung: David Faller
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
