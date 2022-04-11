Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A14FBC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbiDKMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiDKMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BFBE1ADAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649680870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rCUb2yDm5mJpYByGfKW+rR8LpG6P+usFgoGWtpndHY=;
        b=dO8+o4udNJH5I/Sep1K870+0lzRFkaLtLoceGUs57JVgA3ZNgJ69DyN3phc2IZ1eJwih8F
        VaTQSsc5IDyPbj2kxb+6J6kwoqCxg7O9HTdCPNaqqdArb8I/M0wblUMzAQHhTlKDP+jlyI
        0/4xTqnRQGUsEL0vCXKb96bNSpHytFU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-GERdfLi8MFa_8q-tat_U8A-1; Mon, 11 Apr 2022 08:41:08 -0400
X-MC-Unique: GERdfLi8MFa_8q-tat_U8A-1
Received: by mail-ej1-f69.google.com with SMTP id nd34-20020a17090762a200b006e0ef16745cso6931929ejc.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5rCUb2yDm5mJpYByGfKW+rR8LpG6P+usFgoGWtpndHY=;
        b=V0Y1Ry614Q/y7diAvKGktogT+69FrmxfAmb4oYcfCEWqqLTdThuzpj6DRBMAGGB8tr
         F7Aytbw8SsdQZz06vRI5NaQVayreU9xsjZNL9iTF5YAd06K6cXJyFoZIwxKzVh08WZnS
         kwuTZVPYhMHbQDCyysu9rNJNEPM3WQmKaax3i0psYidjuep5tlyTeOKtrnnHm0tqv5qm
         s/XVZkH6/1qBExQFhxpxxrrKbOUXVCyrVPgMaMn86ddFem5U+8pywpA0MObmi24RjoYO
         +7/0OEl2tA+S2o56xglVIqcEl/zxcY/5umqfuu9BFs7cwgyP1KpUqHOcRjmT2CZ4S8BY
         eS/g==
X-Gm-Message-State: AOAM531drhx4po9gfVBmBSc+ZAAkuKczb4rIiMS4JPrmSbfSz701cCvs
        nXCyu8KxaUiLJBK6LzdeFbBXwh09uj4UElZ8BAy7kH9jQ64xpWgAZK5PXCc0np7botpQCFJ/AuN
        9tVkAC10VpVwlgrVB0pL6J9pQ
X-Received: by 2002:a50:eb89:0:b0:41d:6fe7:377c with SMTP id y9-20020a50eb89000000b0041d6fe7377cmr10096915edr.75.1649680867394;
        Mon, 11 Apr 2022 05:41:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLLKgqJxMOMGaeuPMwiSBK0/78V3MoT5+FmrTsWQ3F9HuIE208gmgNSJOCf/1wRCP2vTkCaQ==
X-Received: by 2002:a50:eb89:0:b0:41d:6fe7:377c with SMTP id y9-20020a50eb89000000b0041d6fe7377cmr10096900edr.75.1649680867219;
        Mon, 11 Apr 2022 05:41:07 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm14938694edt.94.2022.04.11.05.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 05:41:06 -0700 (PDT)
Message-ID: <d280b348-0daa-3cc1-3b31-cffb42a89bf9@redhat.com>
Date:   Mon, 11 Apr 2022 14:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] platform/x86: wmi: replace usage of found with dedicated
 list iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220324072015.62063-1-jakobkoschel@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220324072015.62063-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/24/22 08:20, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/wmi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 58a23a9adbef..aed293b5af81 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1308,21 +1308,20 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
>  				    void *context)
>  {
> -	struct wmi_block *wblock;
> -	bool found_it = false;
> +	struct wmi_block *wblock = NULL, *iter;
>  
> -	list_for_each_entry(wblock, &wmi_block_list, list) {
> -		struct guid_block *block = &wblock->gblock;
> +	list_for_each_entry(iter, &wmi_block_list, list) {
> +		struct guid_block *block = &iter->gblock;
>  
> -		if (wblock->acpi_device->handle == handle &&
> +		if (iter->acpi_device->handle == handle &&
>  		    (block->flags & ACPI_WMI_EVENT) &&
>  		    (block->notify_id == event)) {
> -			found_it = true;
> +			wblock = iter;
>  			break;
>  		}
>  	}
>  
> -	if (!found_it)
> +	if (!wblock)
>  		return;
>  
>  	/* If a driver is bound, then notify the driver. */
> 
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613

