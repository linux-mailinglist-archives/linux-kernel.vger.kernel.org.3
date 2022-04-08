Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064D4F99EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiDHPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiDHPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF794D3727
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649433173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4p+B4H/Dz0mub8FSLeM/V9Oz02JwEoHEYmciYvlkis=;
        b=YiA1ubv2t2Y9OpD4BArThYIxYlSUlAe9Bp4hdxHlhTeZuxCYgWfTnA2AHLXgS3el9K8f9u
        jlyWhiSDMM38HMmePGOLVQJ41LgTYIkdCYGaEeYeJR87p5Jza99mvp271bgptz8FBACnAa
        eLBRVyv8pVNBm7K6WYr8i/GIsTaAoEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-48R4cDirOfiEYVh8Ua3X5A-1; Fri, 08 Apr 2022 11:52:50 -0400
X-MC-Unique: 48R4cDirOfiEYVh8Ua3X5A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B976F811E81;
        Fri,  8 Apr 2022 15:52:49 +0000 (UTC)
Received: from napanee.usersys.redhat.com (ovpn-112-2.rdu2.redhat.com [10.10.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA29401E31;
        Fri,  8 Apr 2022 15:52:49 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 66F87C0528; Fri,  8 Apr 2022 11:52:49 -0400 (EDT)
Date:   Fri, 8 Apr 2022 11:52:49 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] ACPI: osl: Fix BERT error region memory mapping
Message-ID: <20220408155249.mdkmdttykmoenqeu@redhat.com>
References: <20220407105120.1280-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407105120.1280-1-lorenzo.pieralisi@arm.com>
User-Agent: NeoMutt/20211029
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:51:20AM +0100, Lorenzo Pieralisi wrote:
> Currently the sysfs interface maps the BERT error region as "memory"
> (through acpi_os_map_memory()) in order to copy the error records into
> memory buffers through memory operations (eg memory_read_from_buffer()).
> 
> The OS system cannot detect whether the BERT error region is part of
> system RAM or it is "device memory" (eg BMC memory) and therefore it
> cannot detect which memory attributes the bus to memory support (and
> corresponding kernel mapping, unless firmware provides the required
> information).
> 
> The acpi_os_map_memory() arch backend implementation determines the
> mapping attributes. On arm64, if the BERT error region is not present in
> the EFI memory map, the error region is mapped as device-nGnRnE; this
> triggers alignment faults since memcpy unaligned accesses are not
> allowed in device-nGnRnE regions.
> 
> The ACPI sysfs code cannot therefore map by default the BERT error
> region with memory semantics but should use a safer default.
> 
> Change the sysfs code to map the BERT error region as MMIO (through
> acpi_os_map_iomem()) and use the memcpy_fromio() interface to read the
> error region into the kernel buffer.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/sysfs.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a4b638bea6f1..cc2fe0618178 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -415,19 +415,30 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
>  			      loff_t offset, size_t count)
>  {
>  	struct acpi_data_attr *data_attr;
> -	void *base;
> -	ssize_t rc;
> +	void __iomem *base;
> +	ssize_t size;
>  
>  	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
> +	size = data_attr->attr.size;
> +
> +	if (offset < 0)
> +		return -EINVAL;
> +
> +	if (offset >= size)
> +		return 0;
>  
> -	base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
> +	if (count > size - offset)
> +		count = size - offset;
> +
> +	base = acpi_os_map_iomem(data_attr->addr, size);
>  	if (!base)
>  		return -ENOMEM;
> -	rc = memory_read_from_buffer(buf, count, &offset, base,
> -				     data_attr->attr.size);
> -	acpi_os_unmap_memory(base, data_attr->attr.size);
>  
> -	return rc;
> +	memcpy_fromio(buf, base + offset, count);
> +
> +	acpi_os_unmap_iomem(base, size);
> +
> +	return count;
>  }
>  
>  static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)

I've tested this patch with the reproducer and I was unable to reproduce
the issue.

Tested-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

