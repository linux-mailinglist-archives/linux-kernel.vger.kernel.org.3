Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FFF5A9430
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiIAKUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIAKUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D126ACB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662027608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DebMVALIie+lCOVcwWZ5+ynB1bwfkmkn/Tkn2tT6LHs=;
        b=Gv2sqg+2CiyPml1Ks6pCh0ZAOhLTUY305F5lV75mKeDIw+WqfNxaONMBWQU1JndB1Pda99
        kNMASD/1fpRBrvLFJB2fqt4lF1Ogd9jBIQORoCu9xGs5KHbFEnOIPsqLeBfTp1pKkL8U6e
        CAUmuS6Ayf4b2QjybOqLHbAHKvx6ec8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-UY98PbOhPb2Nb6wiWUq4rQ-1; Thu, 01 Sep 2022 06:20:05 -0400
X-MC-Unique: UY98PbOhPb2Nb6wiWUq4rQ-1
Received: by mail-ej1-f69.google.com with SMTP id sg35-20020a170907a42300b007414343814bso5809087ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DebMVALIie+lCOVcwWZ5+ynB1bwfkmkn/Tkn2tT6LHs=;
        b=8DDvTwqivRNozZFX4cXp8ZsEu2+EDL6FqqPRgvK3hT/mIRVy4PYDIpiyQnW281LpoI
         a3SDoGBtU5lWyr5iOvYEot1ZhBYbKn65mscJBhw4eNyhlteuQACdTWwHGqYXFdrkmWnF
         dfJykWomNgVtvA/Id0GC2R3g0f8YUhX9bCX6qZhSx2aU5HUkdyc0wkj2TO0RlKAxg6+e
         s1tsJrR8QbfLD6PJqaXxeazIe/457/0WX5e6xSNhQ4HJI2JDlpTm9Spjt0NpXESsnhKH
         nGjd/753Ik03LeVGJByrUmcsK55o3gQ6fhhKlZvr8UiHuG+Y6mMwVzkAU8SHauTgumKw
         uxwA==
X-Gm-Message-State: ACgBeo3kx9JBUfrm2onCuc5Nu2jQvekxACAj1Si/0xtshcpeJ4NQFzlo
        kaxhu9PckpKMdzWJpvTvpqxXqX3rZNQ6GgL+FKkngO4UdhGq2h1DFcFx6o9DUEwG5ROZrkmibV5
        e4bgnG9Tat8G1xwBdw6hSxbPO
X-Received: by 2002:a05:6402:254b:b0:448:92fa:3f69 with SMTP id l11-20020a056402254b00b0044892fa3f69mr13589574edb.316.1662027604270;
        Thu, 01 Sep 2022 03:20:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5iGDmB+PXM0ZvxLRw4ghAFE8r1xf8m52BmyKvE+v4mCnXyISiBZRkduG8vvHntlxLifLts9Q==
X-Received: by 2002:a05:6402:254b:b0:448:92fa:3f69 with SMTP id l11-20020a056402254b00b0044892fa3f69mr13589563edb.316.1662027604094;
        Thu, 01 Sep 2022 03:20:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0073db54ee934sm8227207ejb.43.2022.09.01.03.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:20:03 -0700 (PDT)
Message-ID: <172c819f-911f-245b-1f33-da34386f8872@redhat.com>
Date:   Thu, 1 Sep 2022 12:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] virt: vbox: Add check for device_create_file
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20220901101649.3499848-1-jiasheng@iscas.ac.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220901101649.3499848-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/1/22 12:16, Jiasheng Jiang wrote:
> On Thu, Sep 01, 2022 at 05:39:46PM +0800, Greg KH wrote:
>>> -	device_create_file(dev, &dev_attr_host_version);
>>> -	device_create_file(dev, &dev_attr_host_features);
>>> +
>>> +	ret = device_create_file(gdev->dev, &dev_attr_host_features);
>>> +	if (ret)
>>> +		goto err_unregister_misc_device_user;
>>> +	ret = device_create_file(gdev->dev, &dev_attr_host_version);
>>> +	if (ret)
>>> +		goto err_remove_file_features;
>>>  
>>>  	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
>>>  		 gdev->misc_device.minor, pci->irq, gdev->io_port,
>>> @@ -399,6 +404,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>>>  
>>>  	return 0;
>>>  
>>> +err_remove_file_features:
>>> +	device_remove_file(gdev->dev, &dev_attr_host_features);
>> Please make a patch series that is linked together, the one you just did
>> was not properly threaded at all (hint, use git send-email).
>>
>> And again, this is not the correct way to solve this issue, use a
>> default attribute group for the driver instead.  No driver should ever
>> be adding or removing files individually like this.
> 
> Need I use the group to replace the individually removal in
> vbg_pci_remove() too?

The idea is to do a change similar to this one:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=4b0133533e82af25d6aaf9d0c7b2a5af388feb74

Setting the driver's .dev_groups field will automatically
add the attributes when probe() succeeds and they will
also automatically be removed before the driver's remove()
function gets called.

So after this change you can remove both the manual add
calls from probe() as well as remove the remove calls
from vbg_pci_remove().

Regards,

Hans

