Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228CC546A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiFJQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243783AbiFJQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ADA716A53E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654876936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhmytT78BlDY4e8la+yN4LLQpbXocNUTqD927fzV6Mk=;
        b=QrXeKLdARx5JL1+9vHojy0g2aQlAsfvZtBMo1rRJdCstTuMYhXWmpHBYuU/1bmPcr/RBqO
        qEq608D7v3fHg0LBX0iPuAXu494LWg0JAoPgr6hYGY1NxDgesgpJb46SvPIDu7GYG9DueR
        Rzm7wDHGQmPGjY9wWCBsp54YbcqxZBY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-Z-KQZK8ROwGTpAZrVdafDw-1; Fri, 10 Jun 2022 12:02:15 -0400
X-MC-Unique: Z-KQZK8ROwGTpAZrVdafDw-1
Received: by mail-ej1-f72.google.com with SMTP id l2-20020a170906078200b006fed42bfeacso12715410ejc.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uhmytT78BlDY4e8la+yN4LLQpbXocNUTqD927fzV6Mk=;
        b=MGZD1LshqhKXfICTjw0zooJMeesg9e4Mhq0zTI43Zah6MFk+Cxp39cGWe909lAELjZ
         PTY/zUyFbP41nbewbczzzPerdRiU6zxme4gEE5MObxMZZWQnpWJ2pCTTVjBHyudK06h/
         qeyf/tWH6BkBd3SuakvkcVhpipakUxzggCydzcbRvWNPlskes8Gw3CDBGwJqwoLhWJIh
         RHPheU8lB8sUREJvsMuWvmTjvTQ7zOKvpl/pywhW35KmRkjDcG0l1gI9jC+aUEsgEUie
         gFo1eztyBsryBMea8g34lIelD2pDLUQM/G3n1j6CL3lZfVYADuLKnGj23mZxCtn2/p/0
         gpAQ==
X-Gm-Message-State: AOAM530TO371vRBV/BWvTqclDZwpzRjSASLugaUS5L7xoRQT1rdKtkeh
        qDPQJvGcmpYA4E6XEEkWfQ2q33MOChONrqUpJ/EAeduNUcajZiTIPDN5w3vY+qRnQHdBVzrFPZj
        AGsPBdnfcv/uwNUVUOS3Viotz
X-Received: by 2002:a17:907:3fa4:b0:6fe:b83b:d667 with SMTP id hr36-20020a1709073fa400b006feb83bd667mr40535928ejc.481.1654876934302;
        Fri, 10 Jun 2022 09:02:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvqRkYcdnOrlJm8pksenJSo9pUsVP9Cg3+TsU2esDWCQMlj0C+T/TfqmRjwB7BOAHgT8sIeA==
X-Received: by 2002:a17:907:3fa4:b0:6fe:b83b:d667 with SMTP id hr36-20020a1709073fa400b006feb83bd667mr40535908ejc.481.1654876934068;
        Fri, 10 Jun 2022 09:02:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906198800b00711d5bc20d5sm6620873ejd.221.2022.06.10.09.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 09:02:13 -0700 (PDT)
Message-ID: <de4521a5-aeb6-6b92-358b-be910029c1b7@redhat.com>
Date:   Fri, 10 Jun 2022 18:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] vboxguest: add missing devm_free_irq
Content-Language: en-US
To:     Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20220609134057.2485190-1-pterjan@google.com>
 <YqNMGgwsjhB7TNzk@kroah.com>
 <CAANdO=KDp9aYbRGxb4sDQtBD4rrjpy6_ruQBt9mZiVKtW_KZGw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAANdO=KDp9aYbRGxb4sDQtBD4rrjpy6_ruQBt9mZiVKtW_KZGw@mail.gmail.com>
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

On 6/10/22 17:00, Pascal Terjan wrote:
> On Fri, 10 Jun 2022 at 13:50, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jun 09, 2022 at 02:40:57PM +0100, Pascal Terjan wrote:
>>> This fixes the following warning when unloading the module:
>>>
>>> [249348.837181] remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'vboxguest'
>>> [249348.837219] WARNING: CPU: 0 PID: 6708 at fs/proc/generic.c:715 remove_proc_entry+0x119/0x140
>>>
>>> [249348.837379] Call Trace:
>>> [249348.837385]  unregister_irq_proc+0xbd/0xe0
>>> [249348.837392]  free_desc+0x23/0x60
>>> [249348.837396]  irq_free_descs+0x4a/0x70
>>> [249348.837401]  irq_domain_free_irqs+0x160/0x1a0
>>> [249348.837452]  mp_unmap_irq+0x5c/0x60
>>> [249348.837458]  acpi_unregister_gsi_ioapic+0x29/0x40
>>> [249348.837463]  acpi_unregister_gsi+0x17/0x30
>>> [249348.837467]  acpi_pci_irq_disable+0xbf/0xe0
>>> [249348.837473]  pcibios_disable_device+0x20/0x30
>>> [249348.837478]  pci_disable_device+0xef/0x120
>>> [249348.837482]  vbg_pci_remove+0x6c/0x70 [vboxguest]
>>>
>>> Signed-off-by: Pascal Terjan <pterjan@google.com>
>>> ---
>>>  drivers/virt/vboxguest/vboxguest_linux.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
>>> index 6e8c0f1c1056..faa4bc9f625c 100644
>>> --- a/drivers/virt/vboxguest/vboxguest_linux.c
>>> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
>>> @@ -423,6 +423,7 @@ static void vbg_pci_remove(struct pci_dev *pci)
>>>       vbg_gdev = NULL;
>>>       mutex_unlock(&vbg_gdev_mutex);
>>>
>>> +     devm_free_irq(gdev->dev, pci->irq, gdev);
>>
>> The whope point of using devm_* calls is so you don't have to do stuff
>> like this.  Perhaps this should not be using devm_() for the irq at all?
> 
> My initial assumption was that some sort of dependency was missing
> somewhere to ensure this gets freed first, but I failed to find any
> documentation on how this is supposed to work, so I went with a fix
> that would work.
> 
> But you are obviously right, if we manually free it in the normal path
> then using devm_{request,free}_irq sounds like just overhead without
> benefits.

Right, please also move the irq-request over to be non devm and
also don't forgot that the error-exit path from the probe()
function also needs to free the irq before disabling the pci-dev.

Regards,

Hans

