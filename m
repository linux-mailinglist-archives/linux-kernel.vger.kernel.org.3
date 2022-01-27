Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72449EC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbiA0U2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiA0U2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:28:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C1C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:28:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s5so8586029ejx.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41+S3e1G9az4hjoyIeQC86UioZgpO/adTzdGdboWJEs=;
        b=tkxspR5jl3OqRnxMSq8JDCc/cDWEPcSLiVi0a4mJ7qF992fNUR+q3YQCA1hwakMvH+
         /fZw1S+ki4w/7BxmAGOMfJPn4TiITIGxMr5DImnsW5S6YSFhqk8ksufG4P05yest9uUk
         qGrWiIjJA57IzJmWodDAHMtH/1QT4MKWsasSqKoX8wNdVRNRixGZHM+4fFCcW2RrEKV4
         Kn1WrqIBsbdeg0pTaZHEi5vt2qUL8mPlI8Q7HfMa1YxlQ85DMH1zRrHRyRrlNRGeBBml
         K90ZH5xajUuFBiIL8XvWWR1m3ahFyvb/k3gMq0mChUO580tNN/NONhl61tYJHmChAmKD
         ofag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41+S3e1G9az4hjoyIeQC86UioZgpO/adTzdGdboWJEs=;
        b=N1VRi6bBrlcYfmeUklx/Scb10oH9hC8TfcKG8DI9/XL28c+12KLPQtRf1GjQk1UJIb
         aO2Bco+Bbcm050UroGdvVWBbTmPWydgDHKUN05l7NqIDCXi5w+bn3kck+StGhhutpYAj
         67mDAKJMkFzY2wXnqwmn6NYy9bSF6XeiNai3jFlkVw0HfIVkITTnIvjZ2sseClW/RPEf
         h3RS9ulqQrlCyHMv1Wi6ePsn+YB8jxw9O1OvzAx5SHshW0saw2IefXum0rXm8DCGUKp+
         Yso//ZggN7lF9WZWCfjnMOi12iy4/s39yjUvUuvTEJbkNU5dzdIjk53XXbnTdxd7ae1R
         Saew==
X-Gm-Message-State: AOAM530iFfXlNeluBHi1xpaoKoIwzvVCcn5+Jby33aq1DmJOQ1+B65KX
        AkAiuhwekQlm4oRLMDFh2mpqMBetmpvnJ8wSEyiXgw==
X-Google-Smtp-Source: ABdhPJyBjlVg4LcpXCJNnPRMusqfU5Ajf+q6BnXvzgPaNAhuIT3jfgcOc9U2usc9V4RHgXKdo+PSsdqT45GXftqoTcU=
X-Received: by 2002:a17:907:6d25:: with SMTP id sa37mr4293287ejc.202.1643315315038;
 Thu, 27 Jan 2022 12:28:35 -0800 (PST)
MIME-Version: 1.0
References: <1641544906-7069-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1641544906-7069-1-git-send-email-chenxiang66@hisilicon.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 27 Jan 2022 13:28:23 -0700
Message-ID: <CANLsYkxdXFSVLEnJQTd87LqP5oootxyM3adbxvvpWSEvi5VcsA@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI / amba: Skip creating amba device when
 associated cpu is not online
To:     chenxiang <chenxiang66@hisilicon.com>
Cc:     linux@armlinux.org.uk, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, Suzuki.Poulose@arm.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cheng,

I am severely behind in my patch review process and as such will not
be able to start reviewing your work before the week of February 7th.

Thanks,
Mathieu

On Fri, 7 Jan 2022 at 01:47, chenxiang <chenxiang66@hisilicon.com> wrote:
>
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> If not up all the cpus with command line "maxcpus=x", system will be
> blocked.
> We find that some amba devices such as ETM devices, are associated with
> special cpus, and if the cpu is not up, the register of associated device
> is not allowed to access. BIOS reports all the ETM device nodes and a
> amba device is created for every ETM device, so even if one cpu is not up,
> the amba device will still be created for the associated device, and also
> the register of device (pid and cid) will be accessed when adding amba
> device which will cause the issue.
> To fix it, skip creating amba device if it is associated with a cpu which
> is not online.
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>  drivers/acpi/acpi_amba.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> index ab8a4e0191b1..2369198f734b 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/acpi_amba.c
> @@ -16,6 +16,7 @@
>  #include <linux/ioport.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <acpi/processor.h>
>
>  #include "internal.h"
>
> @@ -45,6 +46,35 @@ static void amba_register_dummy_clk(void)
>         clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
>  }
>
> +static int acpi_handle_to_cpuid(acpi_handle handle)
> +{
> +       int cpu = -1;
> +       struct acpi_processor *pr;
> +
> +       for_each_possible_cpu(cpu) {
> +               pr = per_cpu(processors, cpu);
> +               if (pr && pr->handle == handle)
> +                       break;
> +       }
> +
> +       return cpu;
> +}
> +
> +static int acpi_dev_get_cpu(struct acpi_device *adev)
> +{
> +       acpi_handle cpu_handle;
> +       acpi_status status;
> +       int cpu;
> +
> +       status = acpi_get_parent(adev->handle, &cpu_handle);
> +       if (ACPI_FAILURE(status))
> +               return -1;
> +       cpu = acpi_handle_to_cpuid(cpu_handle);
> +       if (cpu >= nr_cpu_ids)
> +               return -1;
> +       return cpu;
> +}
> +
>  static int amba_handler_attach(struct acpi_device *adev,
>                                 const struct acpi_device_id *id)
>  {
> @@ -54,11 +84,17 @@ static int amba_handler_attach(struct acpi_device *adev,
>         bool address_found = false;
>         int irq_no = 0;
>         int ret;
> +       int cpu;
>
>         /* If the ACPI node already has a physical device attached, skip it. */
>         if (adev->physical_node_count)
>                 return 0;
>
> +       /* If the cpu associated with the device is not online, skip it. */
> +       cpu = acpi_dev_get_cpu(adev);
> +       if (cpu >= 0 && !cpu_online(cpu))
> +               return 0;
> +
>         dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);
>         if (!dev) {
>                 dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
> --
> 2.33.0
>
