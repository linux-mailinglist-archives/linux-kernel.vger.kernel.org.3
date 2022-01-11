Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5ED48AFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiAKOwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:52:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239774AbiAKOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:52:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BDKA9C023362;
        Tue, 11 Jan 2022 14:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iNjbHA6SpCgF1GPDCuXlvA+wXrmFnY2IG6lGEui+yhE=;
 b=ton8AmfMn+FBNTEFW5MmpnHah65Mjy5rDFEMHSJBjls87O/Il6shuQqfTQoAYNXVjEmM
 aEzXPouCpsAC+hcfm52fqp3YsunvSAqv/BAHiqoGmCKuMRb+qKw9ZF8nvboSiEQc7xmd
 vQGuYwtqNkOGClydvqd6DJjoEotjFFeHj1eAeDI5HcZUJUN2+derWMhRAV3KkwuhgzOl
 VfIqTKnL8f0lxblfCFUqENPWiamaBoZpfL0GLG3WiB9xeLsOVuVrva019aT0R6DCLIph
 /I83niWAGIjEZi1Sxh+PdpvBxV/W1U10zO2LL3C0eec7rbCgEjjBGpsuwFy2l9SawQKs 0A== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh6u17g82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 14:52:02 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BEmafO009960;
        Tue, 11 Jan 2022 14:52:02 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3df28ajup6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 14:52:01 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BEq0xg29098326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 14:52:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48199C607F;
        Tue, 11 Jan 2022 14:52:00 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E47FDC605A;
        Tue, 11 Jan 2022 14:51:59 +0000 (GMT)
Received: from [9.211.115.86] (unknown [9.211.115.86])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 14:51:59 +0000 (GMT)
Message-ID: <b649e6ad-54c7-abfa-c9cd-45c0a99f56b1@linux.ibm.com>
Date:   Tue, 11 Jan 2022 08:51:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fsi: core: Check error number after calling
 ida_simple_get
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220111073411.614138-1-jiasheng@iscas.ac.cn>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220111073411.614138-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O6rlhOVklPvhnn5zS9AJRj4GXP507m8f
X-Proofpoint-ORIG-GUID: O6rlhOVklPvhnn5zS9AJRj4GXP507m8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/11/22 01:34, Jiasheng Jiang wrote:
> If allocation fails, the ida_simple_get() will return error number.
> So master->idx could be error number and be used in dev_set_name().
> Therefore, it should be better to check it and return error if fails,
> like the ida_simple_get() in __fsi_get_new_minor().


Reviewed-by:  Eddie James <eajames@linux.ibm.com>


>
> Fixes: 09aecfab93b8 ("drivers/fsi: Add fsi master definition")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/fsi/fsi-core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 59ddc9fd5bca..92e6eebd1851 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1309,6 +1309,9 @@ int fsi_master_register(struct fsi_master *master)
>   
>   	mutex_init(&master->scan_lock);
>   	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
> +	if (master->idx < 0)
> +		return master->idx;
> +
>   	dev_set_name(&master->dev, "fsi%d", master->idx);
>   	master->dev.class = &fsi_master_class;
>   
