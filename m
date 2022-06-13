Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309FA54A0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiFMVMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351961AbiFMVMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68FF53E5EB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655153449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHh1Mc7ZpYll3jkRg/4I2vZLEod4WMai9S1oJy78FZg=;
        b=HaFtrNhqDdyXicP9yPhPOcblhPU24z6gvNzZX+e2ITvmr6JvvVlJWGx1EXngtCyzMzcQRy
        EfSGqOa9sJcm2aCmFOJ8mXRrW75jAHsV7wornbSadQEGQksLodg+6vstswjSaSHi8cYu2f
        aoeq0ymFDJ9SYhXd071uhpEEBr/dF4U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-p69iTIA2MIaMne9qU-wmzQ-1; Mon, 13 Jun 2022 16:50:48 -0400
X-MC-Unique: p69iTIA2MIaMne9qU-wmzQ-1
Received: by mail-ed1-f72.google.com with SMTP id g7-20020a056402424700b0042dee9d11d0so4655903edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uHh1Mc7ZpYll3jkRg/4I2vZLEod4WMai9S1oJy78FZg=;
        b=jTzpndcoIwk7lou0w4ZPWGQmdBHoY9NaKIC8vjVWFXOVKIAhi7gcoeu9D3LU5g/w6Z
         gNfXuvmJ7qvbtEmWH6xBGW0emXz5rjYrT8yVk1foTnvjnRBZ2uFbg+6IeHjhY606yA1v
         /stoPzT8KF2QX10TzXYCvamv85sRsByB0FZwRNBudSPJ4MzaAX0/eGAhoktAIRDEqrvm
         iJi1v3h7stZuE0TRWcbjKp1f91qvePaBPmp5udrLWBKogM2a/uHVKNywxZFbXax3xCRp
         3yMQoM1CIZeIiBwWcp/rRK2MEzKSZaLSpVd4zam3o37gn5pAYF02U9zMLKSM/1oVO7BP
         3pqg==
X-Gm-Message-State: AJIora+HfY18swWsc92WygnOGiy4Sf2jDvFoJeJtH8JFzh79GNntsWtx
        68VcKYzw/ESzOKDjuH0bUt2k0M0tHTAJz7KS+Y5pPtdg87YfFWljHgoDTVAT4UQkhAF8j3fxUYX
        nN8fH8hJBJs+scl5dpOqlrt1u
X-Received: by 2002:a17:907:160c:b0:711:3b56:dc7 with SMTP id hb12-20020a170907160c00b007113b560dc7mr1377166ejc.587.1655153446903;
        Mon, 13 Jun 2022 13:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLiEiFvejpV3bRXy2k4g93sSKykLlmNzgB4sMsx4IWkixW2j3DGJCzho0mbCSzEtPT4MlbBg==
X-Received: by 2002:a17:907:160c:b0:711:3b56:dc7 with SMTP id hb12-20020a170907160c00b007113b560dc7mr1377157ejc.587.1655153446669;
        Mon, 13 Jun 2022 13:50:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id za14-20020a170906878e00b00706c1327f4bsm4243279ejb.23.2022.06.13.13.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:50:46 -0700 (PDT)
Message-ID: <81a7cbe7-068a-d9ab-74b1-b6891f5a6f10@redhat.com>
Date:   Mon, 13 Jun 2022 22:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 12/16] platform/x86/thinkpad_acpi: Use
 acpi_dev_for_each_child()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <2091400.OBFZWjSADL@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2091400.OBFZWjSADL@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/13/22 20:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
> 
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, feel free to take this upstream through the apci tree.

Regards,

Hans




> ---
> 
> v1 -> v2:
>    * Eliminate unnecessary branch (Andy).
> 
> ---
>  drivers/platform/x86/thinkpad_acpi.c |   53 +++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/thinkpad_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/thinkpad_acpi.c
> +++ linux-pm/drivers/platform/x86/thinkpad_acpi.c
> @@ -6841,6 +6841,31 @@ static const struct backlight_ops ibm_ba
>  
>  /* --------------------------------------------------------------------- */
>  
> +static int __init tpacpi_evaluate_bcl(struct acpi_device *adev, void *not_used)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int rc;
> +
> +	status = acpi_evaluate_object(adev->handle, "_BCL", NULL, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	obj = buffer.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
> +		acpi_handle_info(adev->handle,
> +				 "Unknown _BCL data, please report this to %s\n",
> +				 TPACPI_MAIL);
> +		rc = 0;
> +	} else {
> +		rc = obj->package.count;
> +	}
> +	kfree(obj);
> +
> +	return rc;
> +}
> +
>  /*
>   * Call _BCL method of video device.  On some ThinkPads this will
>   * switch the firmware to the ACPI brightness control mode.
> @@ -6848,37 +6873,13 @@ static const struct backlight_ops ibm_ba
>  
>  static int __init tpacpi_query_bcl_levels(acpi_handle handle)
>  {
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *obj;
> -	struct acpi_device *device, *child;
> -	int rc;
> +	struct acpi_device *device;
>  
>  	device = acpi_fetch_acpi_dev(handle);
>  	if (!device)
>  		return 0;
>  
> -	rc = 0;
> -	list_for_each_entry(child, &device->children, node) {
> -		acpi_status status = acpi_evaluate_object(child->handle, "_BCL",
> -							  NULL, &buffer);
> -		if (ACPI_FAILURE(status)) {
> -			buffer.length = ACPI_ALLOCATE_BUFFER;
> -			continue;
> -		}
> -
> -		obj = (union acpi_object *)buffer.pointer;
> -		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
> -			pr_err("Unknown _BCL data, please report this to %s\n",
> -				TPACPI_MAIL);
> -			rc = 0;
> -		} else {
> -			rc = obj->package.count;
> -		}
> -		break;
> -	}
> -
> -	kfree(buffer.pointer);
> -	return rc;
> +	return acpi_dev_for_each_child(device, tpacpi_evaluate_bcl, NULL);
>  }
>  
>  
> 
> 
> 

