Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5F481EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbhL3SBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:01:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236001AbhL3SBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:01:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BUF2lPi012182;
        Thu, 30 Dec 2021 17:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vrTuNqV4RMc/ilGTXtm+S+xQwgoz5G0GI0AWVkAp9Ec=;
 b=ewVVpXxVXR/JEYjQvdwjjfPj0ru0nBKVfq72fcOfYYZ8jAS9tePlhEaQ9kMLr0h/CgTK
 y68TNmd+C8q/n9qzIk2vtqpBhLeY8Jdx+FO151AnHmPwN5WS6JBGICvwBZO9iZ4NLU9b
 8H1cyT36697NPoMluCoqBv4glwi4oYldBx20Da49/rGFo/So1L0FiHzLQ9ZkQB/ud3zf
 aZXUjAvq8JC5sOygoC6AotRRm0heA9B9JXfglwv1wrgHuWwx1cjERBt6rS6B3mmilpiB
 /stLix6hyhyxTo4Fa0gDTqQslPIK37UGYO/j8YMRpPpyXvFofo49jjMMLtsvQflBq8Op 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d9f2m2jpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 17:55:47 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BUHhHaO019662;
        Thu, 30 Dec 2021 17:55:47 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d9f2m2jpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 17:55:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BUHqMHH014894;
        Thu, 30 Dec 2021 17:55:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3d5tx9m9wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 17:55:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BUHtf6d36503898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Dec 2021 17:55:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80797A4054;
        Thu, 30 Dec 2021 17:55:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90DEFA405B;
        Thu, 30 Dec 2021 17:55:40 +0000 (GMT)
Received: from [9.145.148.112] (unknown [9.145.148.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Dec 2021 17:55:40 +0000 (GMT)
Message-ID: <aa72bd76-2af5-202d-8a2c-afb5a700b6c0@linux.ibm.com>
Date:   Thu, 30 Dec 2021 18:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] scsi: Do not break scan luns loop if add single lun
 failed
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@suse.de>,
        Martin Wilck <martin.wilck@suse.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, Wu Bo <wubo40@huawei.com>
References: <20211225232911.1117843-1-haowenchao@huawei.com>
From:   Steffen Maier <maier@linux.ibm.com>
In-Reply-To: <20211225232911.1117843-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WVK6rLWyMvFuuJV-iwgYC27-GNoenQWu
X-Proofpoint-ORIG-GUID: BsdB5KAvYxPjCw8iuUDSo5v5GjP4RpLw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-30_06,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112300101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/21 00:29, Wenchao Hao wrote:
> Failed to add a single lun does not mean all luns are unaccessible,
> if we break the scan luns loop, the other luns reported by REPORT LUNS
> command would not be probed any more.
> 
> In this case, we might loss some luns which are accessible.

Could you please add more details about the specific use case, where this 
actually was a problem, for my understanding?

> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 23e1c0acdeae..fee7ce082103 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1476,13 +1476,13 @@ static int scsi_report_lun_scan(struct scsi_target *starget, blist_flags_t bflag
>   				lun, NULL, NULL, rescan, NULL);
>   			if (res == SCSI_SCAN_NO_RESPONSE) {
>   				/*
> -				 * Got some results, but now none, abort.
> +				 * Got some results, but now none, abort this lun

abort => skip ?

>   				 */
>   				sdev_printk(KERN_ERR, sdev,
>   					"Unexpected response"
>   					" from lun %llu while scanning, scan"
>   					" aborted\n", (unsigned long long)lun);

That message would no longer be correct with your change, as it would not abort 
the scan any more.

> -				break;
> +				continue;
>   			}
>   		}
>   	}


Wouldn't this change existing semantics for LLDDs intentionally returning 
-ENXIO from their slave_alloc() callback in certain cases?:


> static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
...
> 	if (shost->hostt->slave_alloc) {
> 		ret = shost->hostt->slave_alloc(sdev);
> 		if (ret) {
> 			/*
> 			 * if LLDD reports slave not present, don't clutter
> 			 * console with alloc failure messages
> 			 */
> 			if (ret == -ENXIO)
> 				display_failure_msg = 0;
> 			goto out_device_destroy;
...
> out_device_destroy:
> 	__scsi_remove_device(sdev);
> out:
> 	if (display_failure_msg)
> 		printk(ALLOC_FAILURE_MSG, __func__);
> 	return NULL;


scsi_probe_and_add_lun() [such as called by scsi_report_lun_scan() for the case 
at hand] converts this case into a SCSI_SCAN_NO_RESPONSE return value.

> static int scsi_probe_and_add_lun(struct scsi_target *starget,
...
> 	int res = SCSI_SCAN_NO_RESPONSE, result_len = 256;
...
> 		sdev = scsi_alloc_sdev(starget, lun, hostdata);
> 	if (!sdev)
> 		goto out;
...
>  out:
> 	return res;


Such as being used by zfcp:

> static int zfcp_scsi_slave_alloc(struct scsi_device *sdev)
> {
...
> 	unit = zfcp_unit_find(port, zfcp_scsi_dev_lun(sdev));
> 	if (unit)
> 		put_device(&unit->dev);
> 
> 	if (!unit && !(allow_lun_scan && npiv)) {
> 		put_device(&port->dev);
> 		return -ENXIO;
                        ^^^^^^

which implements an initiator-based LUN masking that is necessary for shared 
HBAs virtualized without NPIV.
https://www.ibm.com/docs/en/linux-on-systems?topic=devices-manually-configured-fcp-luns

While things might still work, as zfcp now "just" gets (much) more callbacks to 
slave_alloc() it has to end with -ENXIO, the user may get flooded with the 
error(!) sdev_printk on "Unexpected response from LUN ..." in 
scsi_report_lun_scan().
In the worst case, we could get this message now 64k - 1 times in a zfcp 
scenario connected to IBM DS8000 storage being able to map (all) 64k volumes to 
a single initiator (HBA), where the user via zfcp sysfs decided to use only the 
first lun reported (for the vHBA).

Other LLLDs also seem to intentionally return -ENXIO from slave_alloc() 
callbacks, such as but not limited to lpfc or qla2xxx:

> int fc_slave_alloc(struct scsi_device *sdev)
> {
> 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
> 
> 	if (!rport || fc_remote_port_chkready(rport))
> 		return -ENXIO;

> static int
> qla2xxx_slave_alloc(struct scsi_device *sdev)
> {
> 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
> 
> 	if (!rport || fc_remote_port_chkready(rport))
> 		return -ENXIO;


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z and LinuxONE

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
