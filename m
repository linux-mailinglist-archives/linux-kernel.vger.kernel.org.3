Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED04F9763
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiDHN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiDHN47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F516103B9E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649426095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5sD64Phf4jmlSsRv9AVRFCmgTMkGKZ3Wla+3d8FT/4=;
        b=hq0PWQpgcS671/n8FE+ddYQOirCpBGeYRLUgOSkS+e92h3Df+wfJsY3mR2sL+0v3nG1gIJ
        Js8d2tpiba2NjybCP0wbL0+i+ISkk+tkYkGrSV+aL80uys1RjdnxqYneBIhZgkGygWXAzL
        SzMnYx8CLS0j6y1QpHf0OFtmAdugLkg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-HVQN8e_AOuWyNlqxFcWlvg-1; Fri, 08 Apr 2022 09:54:54 -0400
X-MC-Unique: HVQN8e_AOuWyNlqxFcWlvg-1
Received: by mail-yb1-f198.google.com with SMTP id x9-20020a5b0809000000b00631d9edfb96so6673558ybp.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5sD64Phf4jmlSsRv9AVRFCmgTMkGKZ3Wla+3d8FT/4=;
        b=xujiY79VGUV/ngov8b6L9BH+Qn1fJUnplNiVwFutkl2lDcxxLgCJvNEvBH4yL+JBzf
         VK1AcoTE2MIFsqZbPFYJC7cryk+kJgXixwJNj+3yETWZVyGV7SdBcEOI1AANEEm417jj
         5lOg2mklpUdJfVNZOOV4v2p8DLGWGNvm5mbha1OSlNqo+X78QFZ2OtXwz4E87ei+f9qn
         gWJfS9EVHox9DYkP5zeToNl1OiXpaN3+eFbg+8LvBRZ7wa6J0y0QWPlL6Pki2HQkF2+i
         Wt0Uwx5fnIy+R93TFWw8uksekkQjcVdTJi7tIujJhxR8Rs5bT8mVmUfidFsoUeWqz3Kk
         spHw==
X-Gm-Message-State: AOAM530wbF7C/cHBVQgVreRw1t18YPHjNVqaVzBzm3G2K/QtyWLJYu9F
        rYpxUw2jwqyTEwRBmF0FkqVvnhVYzP4tITdRFAJ7sIO2Yn4PrEOShqeRUdhgid3f5xu4sK1XzSN
        L3TqkBMwzK5rKXGvjK9POuCZtPRc4QXY+KkFJgifu
X-Received: by 2002:a81:1592:0:b0:2eb:5472:c681 with SMTP id 140-20020a811592000000b002eb5472c681mr15950764ywv.10.1649426093615;
        Fri, 08 Apr 2022 06:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTXEngUHw92cMsf+0F9pm0X5XaJw9xfqRkKaZ44wHd20q0vawVBEKrFIMJMvcAduOirlI4ThcUFntR6NFVc0E=
X-Received: by 2002:a81:1592:0:b0:2eb:5472:c681 with SMTP id
 140-20020a811592000000b002eb5472c681mr15950749ywv.10.1649426093406; Fri, 08
 Apr 2022 06:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220407105120.1280-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20220407105120.1280-1-lorenzo.pieralisi@arm.com>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Fri, 8 Apr 2022 15:54:17 +0200
Message-ID: <CA+tGwnmjv0nj11zRtcu8ZLCng9d94E1rVn71dfopHK16WiuMUQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: osl: Fix BERT error region memory mapping
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Aristeu Rozanski <aris@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 12:51 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
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

Hi,

I tested this patch on top of the arm tree for-kernelci branch (a2c0b0fbe014).
I wasn't able to trigger the original problem on the same HW, and the patch
didn't introduce any new issues on these runs, nor on other randomly
chosen aarch64 machines.

Tested-by: Veronika Kabatova <vkabatov@redhat.com>


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
>                               loff_t offset, size_t count)
>  {
>         struct acpi_data_attr *data_attr;
> -       void *base;
> -       ssize_t rc;
> +       void __iomem *base;
> +       ssize_t size;
>
>         data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
> +       size = data_attr->attr.size;
> +
> +       if (offset < 0)
> +               return -EINVAL;
> +
> +       if (offset >= size)
> +               return 0;
>
> -       base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
> +       if (count > size - offset)
> +               count = size - offset;
> +
> +       base = acpi_os_map_iomem(data_attr->addr, size);
>         if (!base)
>                 return -ENOMEM;
> -       rc = memory_read_from_buffer(buf, count, &offset, base,
> -                                    data_attr->attr.size);
> -       acpi_os_unmap_memory(base, data_attr->attr.size);
>
> -       return rc;
> +       memcpy_fromio(buf, base + offset, count);
> +
> +       acpi_os_unmap_iomem(base, size);
> +
> +       return count;
>  }
>
>  static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
> --
> 2.31.0
>

