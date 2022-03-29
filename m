Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D24EABC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiC2K7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiC2K7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:59:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A164163E;
        Tue, 29 Mar 2022 03:57:17 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T9PV7P015314;
        Tue, 29 Mar 2022 10:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vnho1kjcIqFMs7uj46yrkczmSaGT+MjRNdo6SaVRPF8=;
 b=HjH0UeygIxrL5THIERiMuk4Rucbo75L2LM+sqzFgz63rMYuBpE1isDL3uxp9MJn78K3I
 /mPvGCPgm1bmc6Q8ym0jtc+oBu8t0b+yRqLF3bt5KeZAWheXl8qiCNh7SR6byngw1ktu
 vKAvhh1vESGuV5sYRTWuHzJzHrzwOtioHqZYfo9kTX17fa22//E8eWJp7Sm8stQjOrEQ
 0IAjrJfEKINIQrSkA5eJUxiDLEKc7H1fxwn1cT+Lf0dGHzHHHTAcIh20h6lSdCtKaA8W
 NQdJai3IJbMnrk6K9GH7l4Z2apOPYYCO7vwWqXnB6ZAK1Y2s7k/RGdbxZChcF1qI3acG PA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f3yfhsrg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 10:56:59 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22TAroeI010188;
        Tue, 29 Mar 2022 10:56:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3f1tf8w3en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 10:56:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22TAusq846924284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 10:56:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62B99A4040;
        Tue, 29 Mar 2022 10:56:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1DF5A4051;
        Tue, 29 Mar 2022 10:56:53 +0000 (GMT)
Received: from [9.145.75.242] (unknown [9.145.75.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Mar 2022 10:56:53 +0000 (GMT)
Message-ID: <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
Date:   Tue, 29 Mar 2022 12:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
From:   Steffen Maier <maier@linux.ibm.com>
In-Reply-To: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UCVVi_bNzduRFKb0XfZmzrYvZzimAw4l
X-Proofpoint-GUID: UCVVi_bNzduRFKb0XfZmzrYvZzimAw4l
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_02,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 11:06, Wenchao Hao wrote:
> SCSI timeout would call scsi_eh_scmd_add() on some conditions, host would be set
> to SHOST_RECOVERY state. Once host enter SHOST_RECOVERY, IOs submitted to all
> devices in this host would not succeed until the scsi_error_handler() finished.
> The scsi_error_handler() might takes long time to be done, it's unbearable when
> host has massive devices.
> 
> I want to ask is anyone applying another error handler flow to address this
> phenomenon?
> 
> I think we can move some operations(like scsi get sense, scsi send startunit
> and scsi device reset) out of scsi_unjam_host(), to perform these operations
> without setting host to SHOST_RECOVERY? It would reduce the time of block the
> whole host.
> 
> Waiting for your discussion.

We already have "async" aborts before even entering scsi_eh. So your use case 
seems to imply that those aborts fail and we enter scsi_eh?

There's eh_deadline for limiting the time spent in escalation of scsi_eh, and 
instead directly go to host reset. Would this help?


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
