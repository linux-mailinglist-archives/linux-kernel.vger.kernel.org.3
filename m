Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2C53E797
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiFFJRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiFFJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:17:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443A13524F;
        Mon,  6 Jun 2022 02:16:49 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2569CL7Z008565;
        Mon, 6 Jun 2022 09:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=QYEmeQE8+30+1aFDhZOWwmdvgWf38zX/CePvO7aXijM=;
 b=GeyOcFpJtZJQ3xcH5XdHfx9scPoibpR7IKcZWsGYfUL6CoDGWLCMs2J0pK6X+m3d4z+8
 9Yp6h579yfbVuJjcWYu3AP1phPTISN3iyk4bE9m8hIiluFAKFnmoSVjX6K0Nk7Xa+Z7O
 wJ+wECRwzO1MDI1i5GeilZ7ZHuZiOoi3MTYe0StR796sVVD4nFFCO0yLc5F+M+jDvtVy
 jBTs6aPCa4dvorhSB9QSGzx6ItsLsDEs+o/ofC9xFlL5q9m/GyjyqKEz6u6l3tynB4Zf
 LtF2qZ3TRrbgOqWXc/cnLfjkQK4lLpIBZAJR8ZAkxQfM6+NFRVmc7D2lKH62bpfdMEkR hw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gg0269amp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 09:16:40 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 09DC212E96;
        Mon,  6 Jun 2022 09:16:38 +0000 (UTC)
Received: from ubuntu-20.04.3 (unknown [16.99.211.150])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id B868E80DE70;
        Mon,  6 Jun 2022 09:16:37 +0000 (UTC)
Date:   Mon, 6 Jun 2022 17:16:36 +0800
From:   James Liu <james.liu@hpe.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: OSL: Fix the memory mapping of an ACPI GAS that
 addresses a data structure
Message-ID: <20220606091636.GA47704@ubuntu-20.04.3>
References: <20220522214302.39024-1-james.liu@hpe.com>
 <PH7PR84MB1958F5A9F4F05EFE72A9E906E6A29@PH7PR84MB1958.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR84MB1958F5A9F4F05EFE72A9E906E6A29@PH7PR84MB1958.NAMPRD84.PROD.OUTLOOK.COM>
X-Proofpoint-GUID: mk6Rf3NFqEPy-IJtKIgMN9e-KbMj0rsU
X-Proofpoint-ORIG-GUID: mk6Rf3NFqEPy-IJtKIgMN9e-KbMj0rsU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_03,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=884
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060043
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael, the reported warning (i.e., uninitialized local variable) in V1
by the robot has been fixed. Could you check V2 of this patch? Thanks.

> Subject: [PATCH v2] ACPI: OSL: Fix the memory mapping of an ACPI GAS that addresses a data structure 
>  
> From: James Liu <james.liu@hpe.com>
> 
>     Modify acpi_os_map_generic_address() & acpi_os_unmap_generic_address()
>     to correctly handle cases that a GAS table (i.e., Table 5.1, ACPI 6.4)
>     is used to address a data structure; in the case, the GAS has the field
>     of "Register Bit Width" equal to 0.
> 
>     For example, "Injection Instruction Entry" (Table 18.25, ACPI 6.4) has
>     a RegisterRegion field that is a GAS that points to a data structure
>     SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required when using
>     EINJ (Error Injection module).
> 
>     This fix preserves a fairly sufficient memory space (i.e. page size) to
>     store the data structure to prevent EINJ module from loading failure if
>     platform firmware can correctly support Injection Instruction Entry in
>     an EINJ table.
> 
> Signed-off-by: James Liu <james.liu@hpe.com>
> ---
>  drivers/acpi/osl.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 45c5c0e45..99f987c8c 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -452,14 +452,20 @@ EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
>  
>  void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
>  {
> -       u64 addr;
> +       u64 addr = 0;
>  
>          if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                  return NULL;
>  
> +       /* Handle a case that GAS is used to address an ACPI data structure */
> +       if (!gas->bit_width) {
> +               pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
> +               return  acpi_os_map_iomem(addr, PAGE_SIZE);
> +       }
> +
>          /* Handle possible alignment issues */
>          memcpy(&addr, &gas->address, sizeof(addr));
> -       if (!addr || !gas->bit_width)
> +       if (!addr)
>                  return NULL;
>  
>          return acpi_os_map_iomem(addr, gas->bit_width / 8);
> @@ -468,15 +474,28 @@ EXPORT_SYMBOL(acpi_os_map_generic_address);
>  
>  void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>  {
> -       u64 addr;
> +       u64 addr = 0;
>          struct acpi_ioremap *map;
>  
>          if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                  return;
>  
> +       /* Handle a case that GAS is used to address an ACPI data structure */
> +       if (!gas->bit_width) {
> +               pr_info("An ACPI data structure at 0x%llx is unmapped\n", addr);
> +               mutex_lock(&acpi_ioremap_lock);
> +               map = acpi_map_lookup(addr, PAGE_SIZE);
> +               if (!map) {
> +                       mutex_unlock(&acpi_ioremap_lock);
> +                       return;
> +               }
> +               acpi_os_drop_map_ref(map);
> +               mutex_unlock(&acpi_ioremap_lock);
> +       }
> +
>          /* Handle possible alignment issues */
>          memcpy(&addr, &gas->address, sizeof(addr));
> -       if (!addr || !gas->bit_width)
> +       if (!addr)
>                  return;
>  
>          mutex_lock(&acpi_ioremap_lock);
> -- 
> 2.25.1
