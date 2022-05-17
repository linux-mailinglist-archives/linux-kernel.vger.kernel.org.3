Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5C52A9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbiEQR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350016AbiEQR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:56:43 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEAE50067;
        Tue, 17 May 2022 10:56:40 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHaJas028882;
        Tue, 17 May 2022 17:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=6LZ8jU3+K8LPvnlHjnTzUT4p6ahBohmi4B8Y1g0MNFY=;
 b=fLj5z/o9TFT2rmeW9HwvXpin8ZIbDdoS4fFNGBZOCvmKoQFpUFHVQUTTiLLZN/hVxR2N
 Smt4B+PRtTNsxxqyg8dN5KMQdWbfAhgMK2Uk38aujaCI4ou6Fw6yDb9NKTQbMdJMZzE3
 asISnlxBmr6AuWLvdPH0sScENVTouTFcj3Zy/vm20+N2Y8DTalXgYPyi+xvu/IFTI5Qm
 hOHqyhZUCmu4EXQetmem2s07ZcuEUH/Byi/RB+Y+jz8Y3pvSlHvDcmfl1eB24SriPPBY
 l00X+ei2BuAHpgGjvMbtAOBWRLdL2LVffce577hbNe5Jole0nVyj5EHQaEU37devh46I Lg== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3g47ev7uyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 17:56:32 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 4B42883;
        Tue, 17 May 2022 17:56:31 +0000 (UTC)
Received: from ubuntu-20.04.3 (unknown [16.99.205.220])
        by g2t2360.austin.hpecorp.net (Postfix) with SMTP id 4965B3D;
        Tue, 17 May 2022 17:56:30 +0000 (UTC)
Date:   Tue, 17 May 2022 17:56:29 +0000
From:   James Liu <james.liu@hpe.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: OSL: Fix the memory mapping of an ACPI GAS that
 addresses a data structure
Message-ID: <20220517175629.GA4788@ubuntu-20.04.3>
References: <20220401172840.1252-1-james.liu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401172840.1252-1-james.liu@hpe.com>
X-Proofpoint-GUID: JciBQzZfoZnr2tAHbRWlB54r6XiY_eao
X-Proofpoint-ORIG-GUID: JciBQzZfoZnr2tAHbRWlB54r6XiY_eao
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=896 spamscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170106
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael and all,
Could you take a look into this patches? The mentioned bug blocks EINJ
testing whenever a system firmware can correctly support GAS according 
to ACPI 6.4.

On Fri, Apr 01, 2022 at 05:28:40PM +0000, james.liu@hpe.com wrote:
> From: James Liu <james.liu@hpe.com>
> 
>     Modify acpi_os_map_generic_address and acpi_os_unmap_generic_address
>     to handle a case that a GAS table (i.e., Table 5.1 in ACPI 6.4) is used
>     to address a data structure; in this case, the GAS has the field of
>     "Register Bit Width" equal to 0.
> 
>     For example, "Injection Instruction Entry" (Table 18.25 in ACPI 6.4)
>     has a RegisterRegion field that is a GAS that points to a data
>     structure SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required
>     when using EINJ (Error Injection module).
> 
>     This fix preserves a fairly sufficient memory space (i.e., page size)
>     to store the data structure so as to prevent EINJ module from loading
>     failure if platform firmware can support Injection Instruction Entry in
>     an EINJ table.
> 
> Signed-off-by: James Liu <james.liu@hpe.com>
> ---
>  drivers/acpi/osl.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 45c5c0e45..ab2f584b1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -457,9 +457,15 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
>  	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		return NULL;
>  
> +	/* Handle a case that GAS is used to address an ACPI data structure */
> +	if (!gas->bit_width) {
> +		pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
> +		return  acpi_os_map_iomem(addr, PAGE_SIZE);
> +	}
> +
>  	/* Handle possible alignment issues */
>  	memcpy(&addr, &gas->address, sizeof(addr));
> -	if (!addr || !gas->bit_width)
> +	if (!addr)
>  		return NULL;
>  
>  	return acpi_os_map_iomem(addr, gas->bit_width / 8);
> @@ -474,9 +480,22 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>  	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		return;
>  
> +	/* Handle a case that GAS is used to address an ACPI data structure */
> +	if (!gas->bit_width) {
> +		pr_info("An ACPI data structure at 0x%llx is unmapped\n", addr);
> +		mutex_lock(&acpi_ioremap_lock);
> +		map = acpi_map_lookup(addr, PAGE_SIZE);
> +		if (!map) {
> +			mutex_unlock(&acpi_ioremap_lock);
> +			return;
> +		}
> +		acpi_os_drop_map_ref(map);
> +		mutex_unlock(&acpi_ioremap_lock);
> +	}
> +
>  	/* Handle possible alignment issues */
>  	memcpy(&addr, &gas->address, sizeof(addr));
> -	if (!addr || !gas->bit_width)
> +	if (!addr)
>  		return;
>  
>  	mutex_lock(&acpi_ioremap_lock);
> -- 
> 2.25.1
> 
