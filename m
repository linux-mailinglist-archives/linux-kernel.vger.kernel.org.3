Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE3532CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiEXOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiEXOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:55:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CAC793B1;
        Tue, 24 May 2022 07:55:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OEiGW0000425;
        Tue, 24 May 2022 14:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=9uxr3NGA2zX6jSJmJFYnHqEJ2iM9RMmnNPTxV1OQoY0=;
 b=fAmmkCsMVl38qKsGkTuBWSUqx+wuLw8cG6xB4AHGEZbwfxCpXya/RWNEKKMmQTu7ZlX9
 5ox+pZERg8hP81vAySzt4yWQgnlnX77dnArgimNDv2dHZjGGCxwqiUu7my3kCygswyc5
 rUMr+vy+LsLw4aQFrW9B2FibSoxSulmAPSivvvN2MM4yBrjJgnGvdsPkrasqoBsIIiQK
 hdH4cHmsp+jn47+I99fmpARyp0atq+s1MwyA9ZgJxzpAczbozWoxGDydyHel2z+F/YLp
 5UwCsiDiGM3hGwULpP2s6rKnjjwraYwLUhYgxAuojmsKbEJK0XfiOJnIkSKd2KizOnQE Hw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g91crr7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:55:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OEjKwX005170;
        Tue, 24 May 2022 14:55:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3g6qq9535w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:55:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OEtH6f28377398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 14:55:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 862CA42041;
        Tue, 24 May 2022 14:55:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 196CE42049;
        Tue, 24 May 2022 14:55:17 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.98])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 14:55:17 +0000 (GMT)
Date:   Tue, 24 May 2022 16:55:15 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390: Add attestation query information
Message-ID: <20220524165515.393cd8cd@p-imbrenda>
In-Reply-To: <20220518135908.1110319-2-seiden@linux.ibm.com>
References: <20220518135908.1110319-1-seiden@linux.ibm.com>
        <20220518135908.1110319-2-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YXaZJ4pwvENFRB8GmC7tLwz5Ov0bLndR
X-Proofpoint-ORIG-GUID: YXaZJ4pwvENFRB8GmC7tLwz5Ov0bLndR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 13:59:08 +0000
Steffen Eiden <seiden@linux.ibm.com> wrote:

> We have information about the supported attestation header version
> and plaintext attestation flag bits.
> Let's expose it via the sysfs files.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

when you have fixed the commit message as indicated by Heiko:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/boot/uv.c        |  2 ++
>  arch/s390/include/asm/uv.h |  7 ++++++-
>  arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index 67c737c1e580..a5fa667160b2 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -45,6 +45,8 @@ void uv_query_info(void)
>  		uv_info.supp_se_hdr_pcf = uvcb.supp_se_hdr_pcf;
>  		uv_info.conf_dump_storage_state_len = uvcb.conf_dump_storage_state_len;
>  		uv_info.conf_dump_finalize_len = uvcb.conf_dump_finalize_len;
> +		uv_info.supp_att_req_hdr_ver = uvcb.supp_att_req_hdr_ver;
> +		uv_info.supp_att_pflags = uvcb.supp_att_pflags;
>  	}
>  
>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 3e597bb634bd..18fe04c8547e 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -124,7 +124,10 @@ struct uv_cb_qui {
>  	u64 reservedc0;				/* 0x00c0 */
>  	u64 conf_dump_storage_state_len;	/* 0x00c8 */
>  	u64 conf_dump_finalize_len;		/* 0x00d0 */
> -	u8  reservedd8[256 - 216];		/* 0x00d8 */
> +	u64 reservedd8;				/* 0x00d8 */
> +	u64 supp_att_req_hdr_ver;		/* 0x00e0 */
> +	u64 supp_att_pflags;			/* 0x00e8 */
> +	u8 reservedf0[256 - 240];		/* 0x00f0 */
>  } __packed __aligned(8);
>  
>  /* Initialize Ultravisor */
> @@ -350,6 +353,8 @@ struct uv_info {
>  	unsigned long supp_se_hdr_pcf;
>  	unsigned long conf_dump_storage_state_len;
>  	unsigned long conf_dump_finalize_len;
> +	unsigned long supp_att_req_hdr_ver;
> +	unsigned long supp_att_pflags;
>  };
>  
>  extern struct uv_info uv_info;
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 84fe33b6af4d..c13d5a7b71f0 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -479,6 +479,24 @@ static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
>  static struct kobj_attribute uv_query_max_guest_addr_attr =
>  	__ATTR(max_address, 0444, uv_query_max_guest_addr, NULL);
>  
> +static ssize_t uv_query_supp_att_req_hdr_ver(struct kobject *kobj,
> +					     struct kobj_attribute *attr, char *page)
> +{
> +	return scnprintf(page, PAGE_SIZE, "%lx\n", uv_info.supp_att_req_hdr_ver);
> +}
> +
> +static struct kobj_attribute uv_query_supp_att_req_hdr_ver_attr =
> +	__ATTR(supp_att_req_hdr_ver, 0444, uv_query_supp_att_req_hdr_ver, NULL);
> +
> +static ssize_t uv_query_supp_att_pflags(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *page)
> +{
> +	return scnprintf(page, PAGE_SIZE, "%lx\n", uv_info.supp_att_pflags);
> +}
> +
> +static struct kobj_attribute uv_query_supp_att_pflags_attr =
> +	__ATTR(supp_att_pflags, 0444, uv_query_supp_att_pflags, NULL);
> +
>  static struct attribute *uv_query_attrs[] = {
>  	&uv_query_facilities_attr.attr,
>  	&uv_query_feature_indications_attr.attr,
> @@ -490,6 +508,8 @@ static struct attribute *uv_query_attrs[] = {
>  	&uv_query_dump_storage_state_len_attr.attr,
>  	&uv_query_dump_finalize_len_attr.attr,
>  	&uv_query_dump_cpu_len_attr.attr,
> +	&uv_query_supp_att_req_hdr_ver_attr.attr,
> +	&uv_query_supp_att_pflags_attr.attr,
>  	NULL,
>  };
>  

