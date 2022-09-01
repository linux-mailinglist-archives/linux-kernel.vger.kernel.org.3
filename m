Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1FB5A9AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiIAOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiIAOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A482748
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662043738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ov7wwJ0fh1QZTrH+Sh8g22A0JfLzVY29JwityzZL8s=;
        b=IqulTX2atyOhTvhCkjoZCpwkspWmlKslHmlJGKV/yDJ+5aaPbf9ziaYA3EJKuA5LZwqO1K
        goynt7ARMeTINoP2IVw+d44zQtt8NF7RKWSdQX1j35BSnmJlNiUC9WgjwfyRyJ0/HCXNSM
        dxCfUBOAu/MnehMCFn9FATIkIy7Im3M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-qHarbQEiMtSTLtqRYmieRw-1; Thu, 01 Sep 2022 10:48:57 -0400
X-MC-Unique: qHarbQEiMtSTLtqRYmieRw-1
Received: by mail-ej1-f72.google.com with SMTP id sd6-20020a1709076e0600b0073315809fb5so6966529ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+ov7wwJ0fh1QZTrH+Sh8g22A0JfLzVY29JwityzZL8s=;
        b=0VT2nPAMyVI8Cbuwhb9uFsr7dp2tDqkGCRgbe+e9DgU3wZp3CcTkjdmH97aD4jb3J8
         i6EV2al14+WMT6Z2+orR8bOddtHw5lnP6YnF8ZIZSiVcJORkB3sH/m1oT3OT4LvxKyi1
         ibPXpyZe4V7Z20PAJCJeSmlrCa3qeGB9ZUxCfBRpXeXndqA7b53GGQCQjRjYIvsKibUP
         2ARhrV5lRfICF1RTWrkF8hq1HpBP50zQvLveUVAJaUHc+zh1fSeGcMH6UINdL9lC0W3/
         Kd5+vYzhjwqLCRBZDYygNYdJwe0gecO2ZPcyQh/3NfGUmgHhVRZVFlGOs1InLTjB3sYJ
         CmLw==
X-Gm-Message-State: ACgBeo0hxyaZMoXtLDowvE8L+cDFmM3DFqTyGKCOVGpeOSvItVq9WluQ
        S6pDcq57bBx1pkwE1oypKeDXOOF9uDYHD8kFVu73WaHXAmo/XMn3U4CoZiP53kmAJqjzVmDkXit
        Jsz6HesDuaJDRPgo9frGKYj3o
X-Received: by 2002:a17:907:78b:b0:741:3d29:33d2 with SMTP id xd11-20020a170907078b00b007413d2933d2mr19782674ejb.103.1662043735895;
        Thu, 01 Sep 2022 07:48:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR50ykrvGnM8MKw50x9TZflH8yEPLxxLkST/sFxaWdEgGOFvP2ZalhHmragwCrbAeThKzltrLA==
X-Received: by 2002:a17:907:78b:b0:741:3d29:33d2 with SMTP id xd11-20020a170907078b00b007413d2933d2mr19782662ejb.103.1662043735633;
        Thu, 01 Sep 2022 07:48:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906c40600b0073dd1ac2fc8sm8525162ejz.195.2022.09.01.07.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 07:48:55 -0700 (PDT)
Message-ID: <22b3904d-380c-a628-2f62-d108139f09e2@redhat.com>
Date:   Thu, 1 Sep 2022 16:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] virt: vbox: convert to use dev_groups
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20220901144610.3550300-1-jiasheng@iscas.ac.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220901144610.3550300-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/1/22 16:46, Jiasheng Jiang wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner. Moreover, it can
> guarantee the success of creation. Therefore, it should be better to
> convert to use dev_groups.
> 
> Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Change log:
> 
> v2-> v3:
> 
> 1. Switch to use an attribute group.
> 
> v1 -> v2:
> 
> 1. Use gdev->dev instead of dev.
> 2. Remove file when creation failed.
> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 4ccfd30c2a30..6fc81347ae72 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -270,6 +270,13 @@ static ssize_t host_features_show(struct device *dev,
>  static DEVICE_ATTR_RO(host_version);
>  static DEVICE_ATTR_RO(host_features);
>  
> +static struct attribute *vbg_pci_attrs[] = {
> +	&dev_attr_host_version.attr,
> +	&dev_attr_host_features.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(vbg_pci);
> +
>  /**
>   * Does the PCI detection and init of the device.
>   *
> @@ -390,8 +397,6 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	}
>  
>  	pci_set_drvdata(pci, gdev);
> -	device_create_file(dev, &dev_attr_host_version);
> -	device_create_file(dev, &dev_attr_host_features);
>  
>  	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
>  		 gdev->misc_device.minor, pci->irq, gdev->io_port,
> @@ -422,8 +427,6 @@ static void vbg_pci_remove(struct pci_dev *pci)
>  	mutex_unlock(&vbg_gdev_mutex);
>  
>  	free_irq(pci->irq, gdev);
> -	device_remove_file(gdev->dev, &dev_attr_host_features);
> -	device_remove_file(gdev->dev, &dev_attr_host_version);
>  	misc_deregister(&gdev->misc_device_user);
>  	misc_deregister(&gdev->misc_device);
>  	vbg_core_exit(gdev);
> @@ -488,6 +491,7 @@ MODULE_DEVICE_TABLE(pci,  vbg_pci_ids);
>  
>  static struct pci_driver vbg_pci_driver = {
>  	.name		= DEVICE_NAME,
> +	.dev_groups	= vbg_pci_groups,
>  	.id_table	= vbg_pci_ids,
>  	.probe		= vbg_pci_probe,
>  	.remove		= vbg_pci_remove,

