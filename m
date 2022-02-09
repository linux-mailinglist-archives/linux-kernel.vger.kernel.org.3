Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1D4B0296
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiBJB7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:59:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiBJB6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:58:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80A2B6A8;
        Wed,  9 Feb 2022 17:44:09 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KbNAI017565;
        Wed, 9 Feb 2022 23:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TWrJe7V8b7P4SgEJomUdsQa1XDxtIcBfokIBJf6ebF8=;
 b=VM+lN6lRz2vPrMVqeI9dIH5KgC4x5nxqXV+bKPScNx/ONJAFWkimM793DglI9Et7F0eo
 vUJf6JGrTk5EvOCdNTK11TwoAdDa0rdUdXiJwpdWTH3Zuh0BDAb+yK/HXEhWJH3HAzF0
 C2YmXgNzxdmU/ATEGxdAFC7Hkg1je3uCcKqScAAq9VOPgS3/2pG0oeM8mfrDveE5GXBA
 jpF5WywAKvhHXw5mBUgRobUR8maZocY2pVl8NfQHlXOnComC/yGA7W2AWJ3pGVTPdNwe
 RrEGnAConRTS2AkUNErsZuyEqV7VY63a2Ect/4l6uWFP6e1/ikjxii+S/m6N0MiOE4jY 9g== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4kt24gx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 23:53:25 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 219NXeML016792;
        Wed, 9 Feb 2022 23:53:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 3e2btb8q4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 23:53:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 219NrNDP31326682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 23:53:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76D85BE054;
        Wed,  9 Feb 2022 23:53:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 198E9BE051;
        Wed,  9 Feb 2022 23:53:22 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.68.97])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 23:53:21 +0000 (GMT)
Subject: Re: [PATCH] scsi: ibmvscsis: Silence -Warray-bounds warning
To:     Kees Cook <keescook@chromium.org>,
        Michael Cyr <mikecyr@linux.ibm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220208061231.3429486-1-keescook@chromium.org>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <53b3e9c5-23c1-3825-8286-b4a65b69067b@linux.ibm.com>
Date:   Wed, 9 Feb 2022 15:53:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20220208061231.3429486-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FZYcKikhTuyVu6wCuSbwt--0m9GwQwIc
X-Proofpoint-ORIG-GUID: FZYcKikhTuyVu6wCuSbwt--0m9GwQwIc
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 10:12 PM, Kees Cook wrote:
> Instead of doing a cast to storage that is too small, add a union for
> the high 64 bits. Silences the warnings under -Warray-bounds:
> 
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_send_messages':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1934:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
>  1934 |                                         crq->valid = VALID_CMD_RESP_EL;
>       |                                            ^~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
>  1875 |         u64 msg_hi = 0;
>       |             ^~~~~~
> 
> There is no change to the resulting binary instructions.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/lkml/20220125142430.75c3160e@canb.auug.org.au
> Cc: Michael Cyr <mikecyr@linux.ibm.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: target-devel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |  9 +++------

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
