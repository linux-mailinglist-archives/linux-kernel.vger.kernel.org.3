Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125F547A77
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiFLONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiFLONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B1A6173
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655043209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pASw1zgGePMBmimeAzlBhYmb0S8/jbcXfI6crj8gLvU=;
        b=DMNa8zShBqASBO+mFv4O+CvAqY7SPAn2Pm2xi6vykLpPrEOL9p1shVYrX6RQ7meTWEjchQ
        vNbf6ZSurC5HCDmGjtboKBbsG5MxKJl8dMnEHB9XAPVjzYojiWpHvNwN8P2bNZKxXTRZJw
        lwv7Z+RqkSTVuKPvaKkqzQ95nx0xzxk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-rgxT6qbJNQmNnxoxJDvn0g-1; Sun, 12 Jun 2022 10:13:27 -0400
X-MC-Unique: rgxT6qbJNQmNnxoxJDvn0g-1
Received: by mail-ed1-f70.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso2504466eda.23
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pASw1zgGePMBmimeAzlBhYmb0S8/jbcXfI6crj8gLvU=;
        b=1DDlEAzl8l5Hivp73VbZCoYCEQSBRWtAQfFkKKI3SFEp5GFdiVvswokgY1u+x59dbR
         N9DI492lyPZk1y9qXS6lzDAlHXLGj65eBG1QtnS5obSv9Mwe+raw4PEX9gg/c2snhq7A
         IQ2b/JOKjl2v7AndQJGNganKgN5SsWH81vCi0miHDQb+820lNKQ6Bj6Bf0IeXJWCCk6m
         DTKFYZUG/tE8aSwcqh8ItTwTAFfB95Cvr4OGG9BL5v0twFF5pTjLI2ZGmcRp3ytF30Lm
         G0NzQ3H7rRwtydyHJn3PdIjqVoT4EWmUwgSkAD7qHrDH9VbMxePiPXyaVSY60QjqCYue
         bkWg==
X-Gm-Message-State: AOAM531Vn8y/GYuYHHeZiAv+fW1t5ntYPge4hBTTZU5BCh3D/jHy70PY
        BTbjABcGwX7G5WxOF7ybWpYq6WpHxXmkZ1BAzO+yCbqX+x6gbIgMCX+L8NcnDvz2SB4KjOd8nMT
        99OrWdTzD0p0VVQvt9jjBxmrc
X-Received: by 2002:a17:907:724c:b0:711:d0bc:2369 with SMTP id ds12-20020a170907724c00b00711d0bc2369mr32471222ejc.23.1655043206278;
        Sun, 12 Jun 2022 07:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyofkfyKFgDkxha6719mb7gj4razOO32vWu7d4eCMg4gE7c406/nAiMetkV0gUodfp1O24d4g==
X-Received: by 2002:a17:907:724c:b0:711:d0bc:2369 with SMTP id ds12-20020a170907724c00b00711d0bc2369mr32471212ejc.23.1655043206123;
        Sun, 12 Jun 2022 07:13:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fe6-20020a1709072a4600b00704a5c530ccsm2492532ejc.162.2022.06.12.07.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 07:13:25 -0700 (PDT)
Message-ID: <869d4532-3cd4-a202-b56b-6708ed6cf844@redhat.com>
Date:   Sun, 12 Jun 2022 16:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] vboxguest: Do not use devm for irq
Content-Language: en-US
To:     Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
References: <de4521a5-aeb6-6b92-358b-be910029c1b7@redhat.com>
 <20220612133744.4030602-1-pterjan@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220612133744.4030602-1-pterjan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/12/22 15:37, Pascal Terjan wrote:
> When relying on devm it doesn't get freed early enough which causes the
> following warning when unloading the module:
> 
> [249348.837181] remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'vboxguest'
> [249348.837219] WARNING: CPU: 0 PID: 6708 at fs/proc/generic.c:715 remove_proc_entry+0x119/0x140
> 
> [249348.837379] Call Trace:
> [249348.837385]  unregister_irq_proc+0xbd/0xe0
> [249348.837392]  free_desc+0x23/0x60
> [249348.837396]  irq_free_descs+0x4a/0x70
> [249348.837401]  irq_domain_free_irqs+0x160/0x1a0
> [249348.837452]  mp_unmap_irq+0x5c/0x60
> [249348.837458]  acpi_unregister_gsi_ioapic+0x29/0x40
> [249348.837463]  acpi_unregister_gsi+0x17/0x30
> [249348.837467]  acpi_pci_irq_disable+0xbf/0xe0
> [249348.837473]  pcibios_disable_device+0x20/0x30
> [249348.837478]  pci_disable_device+0xef/0x120
> [249348.837482]  vbg_pci_remove+0x6c/0x70 [vboxguest]
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
> v2: stop using devm rather than adding a manual devm_free_irq

Thanks, v2 looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
>  drivers/virt/vboxguest/vboxguest_linux.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 6e8c0f1c1056..dec36934d679 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -360,8 +360,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  		goto err_vbg_core_exit;
>  	}
>  
> -	ret = devm_request_irq(dev, pci->irq, vbg_core_isr, IRQF_SHARED,
> -			       DEVICE_NAME, gdev);
> +	ret = request_irq(pci->irq, vbg_core_isr, IRQF_SHARED, DEVICE_NAME,
> +			  gdev);
>  	if (ret) {
>  		vbg_err("vboxguest: Error requesting irq: %d\n", ret);
>  		goto err_vbg_core_exit;
> @@ -371,7 +371,7 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	if (ret) {
>  		vbg_err("vboxguest: Error misc_register %s failed: %d\n",
>  			DEVICE_NAME, ret);
> -		goto err_vbg_core_exit;
> +		goto err_free_irq;
>  	}
>  
>  	ret = misc_register(&gdev->misc_device_user);
> @@ -407,6 +407,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	misc_deregister(&gdev->misc_device_user);
>  err_unregister_misc_device:
>  	misc_deregister(&gdev->misc_device);
> +err_free_irq:
> +	free_irq(pci->irq, gdev);
>  err_vbg_core_exit:
>  	vbg_core_exit(gdev);
>  err_disable_pcidev:
> @@ -423,6 +425,7 @@ static void vbg_pci_remove(struct pci_dev *pci)
>  	vbg_gdev = NULL;
>  	mutex_unlock(&vbg_gdev_mutex);
>  
> +	free_irq(pci->irq, gdev);
>  	device_remove_file(gdev->dev, &dev_attr_host_features);
>  	device_remove_file(gdev->dev, &dev_attr_host_version);
>  	misc_deregister(&gdev->misc_device_user);

