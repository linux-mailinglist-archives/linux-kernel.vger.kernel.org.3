Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DC4F925F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiDHKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiDHKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 126D9635A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649411911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtmdMak2TwS9HPPLdqWkiNqzZ5EgXZBqTTonDXpXiL4=;
        b=Y2H3vTSQJIVHEMkARrkqyaePyH60GQbk3713UGqyLVq9WC2rZbHzZ2MtjNkgy8VrFzyZ1/
        toLkh4iXOUX3zViBrOR1ZdXUjQv+gXq3lJbjBv7g4vw5eQ9yvhUVDx1QorI50UVprjsN3U
        RTYP3kq9e2xdxZMo9uC9GuBYT1LXwQo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-5VRlYPTmNNqX5--WHCpGkA-1; Fri, 08 Apr 2022 05:58:30 -0400
X-MC-Unique: 5VRlYPTmNNqX5--WHCpGkA-1
Received: by mail-ej1-f70.google.com with SMTP id hs16-20020a1709073e9000b006e853a25acfso602762ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qtmdMak2TwS9HPPLdqWkiNqzZ5EgXZBqTTonDXpXiL4=;
        b=rM0Z/3PQfUjkzcx1CEitOdrSjy4jeIKA+M3HK5hUkqtl4jZKQKwjIszi3xotr+jVD+
         3UcIEPKE+GsFs0KYrIxMw0i4bXUqAoPoZ223X81lgC9u5MCkxCH2vrcYg1SrA+bdOLz0
         sdqlKiMn/uTtx1bU7DkWwHGjfk/q9T8szCAAJda3TgnN4AZpsgTx+hWa5BGd/RF/msxx
         uwHilDQCJhcd8qjpbXT0lJOvJvUs85FSXSiEMAaBTUwUQF7zWcVKPSrcEF+39EfBtJAj
         Bn9AvsLhUAxw8CYuEZKEdZyuYi53hByiQs9g27kB1yKlKzxSkGtJYC+dOEh6U0wqrjsl
         b6Gw==
X-Gm-Message-State: AOAM5305EBgtNCARpkCKqZqQRtCEdZA72UCC4gMpQsVqVeAYZWO1+RYA
        c/0Rw98urHVNMEX3T+CyQlLqgDcS8Q9C7DxzALhZxn0HFFO85OGbqvnN2dG9sChwzCCKTNxVm2j
        gpPXvCAOkwub5EVw9WQI5jfSI
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id dr2-20020a170907720200b006df83a967d2mr17200915ejc.327.1649411908894;
        Fri, 08 Apr 2022 02:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx91axWjyup0IOH2zxg1tPrnb1zqwfKtM/IP3NPLAkL782ZQt2ATNiiHzzjwtP42VX+qhJJuQ==
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id dr2-20020a170907720200b006df83a967d2mr17200903ejc.327.1649411908688;
        Fri, 08 Apr 2022 02:58:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm10004727edu.44.2022.04.08.02.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 02:58:28 -0700 (PDT)
Message-ID: <676ef816-6380-e102-d4ea-9f2774a63d9a@redhat.com>
Date:   Fri, 8 Apr 2022 11:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: rtl8723bs: remove header rtw_ioctl.h
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220408081956.1093-1-straube.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220408081956.1093-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/8/22 10:19, Michael Straube wrote:
> Nothing from the header rtw_ioctl.h is used in the driver code.
> Remove the header.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/staging/rtl8723bs/include/drv_types.h |  1 -
>  drivers/staging/rtl8723bs/include/rtw_ioctl.h | 72 -------------------
>  2 files changed, 73 deletions(-)
>  delete mode 100644 drivers/staging/rtl8723bs/include/rtw_ioctl.h
> 
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index 0ce08c2a0755..0bbbdebdf157 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -42,7 +42,6 @@
>  #include <rtw_mlme.h>
>  #include <mlme_osdep.h>
>  #include <rtw_io.h>
> -#include <rtw_ioctl.h>
>  #include <rtw_ioctl_set.h>
>  #include <osdep_intf.h>
>  #include <rtw_eeprom.h>
> diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl.h b/drivers/staging/rtl8723bs/include/rtw_ioctl.h
> deleted file mode 100644
> index 7179591cb01d..000000000000
> --- a/drivers/staging/rtl8723bs/include/rtw_ioctl.h
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/******************************************************************************
> - *
> - * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
> - *
> - ******************************************************************************/
> -#ifndef _RTW_IOCTL_H_
> -#define _RTW_IOCTL_H_
> -
> -/* 	00 - Success */
> -/* 	11 - Error */
> -#define STATUS_SUCCESS				(0x00000000L)
> -#define STATUS_PENDING				(0x00000103L)
> -
> -#define STATUS_UNSUCCESSFUL			(0xC0000001L)
> -#define STATUS_INSUFFICIENT_RESOURCES		(0xC000009AL)
> -#define STATUS_NOT_SUPPORTED			(0xC00000BBL)
> -
> -#define NDIS_STATUS_SUCCESS			((uint)STATUS_SUCCESS)
> -#define NDIS_STATUS_PENDING			((uint)STATUS_PENDING)
> -#define NDIS_STATUS_NOT_RECOGNIZED		((uint)0x00010001L)
> -#define NDIS_STATUS_NOT_COPIED			((uint)0x00010002L)
> -#define NDIS_STATUS_NOT_ACCEPTED		((uint)0x00010003L)
> -#define NDIS_STATUS_CALL_ACTIVE			((uint)0x00010007L)
> -
> -#define NDIS_STATUS_FAILURE			((uint)STATUS_UNSUCCESSFUL)
> -#define NDIS_STATUS_RESOURCES			((uint)STATUS_INSUFFICIENT_RESOURCES)
> -#define NDIS_STATUS_CLOSING			((uint)0xC0010002L)
> -#define NDIS_STATUS_BAD_VERSION			((uint)0xC0010004L)
> -#define NDIS_STATUS_BAD_CHARACTERISTICS		((uint)0xC0010005L)
> -#define NDIS_STATUS_ADAPTER_NOT_FOUND		((uint)0xC0010006L)
> -#define NDIS_STATUS_OPEN_FAILED			((uint)0xC0010007L)
> -#define NDIS_STATUS_DEVICE_FAILED		((uint)0xC0010008L)
> -#define NDIS_STATUS_MULTICAST_FULL		((uint)0xC0010009L)
> -#define NDIS_STATUS_MULTICAST_EXISTS		((uint)0xC001000AL)
> -#define NDIS_STATUS_MULTICAST_NOT_FOUND		((uint)0xC001000BL)
> -#define NDIS_STATUS_REQUEST_ABORTED		((uint)0xC001000CL)
> -#define NDIS_STATUS_RESET_IN_PROGRESS		((uint)0xC001000DL)
> -#define NDIS_STATUS_CLOSING_INDICATING		((uint)0xC001000EL)
> -#define NDIS_STATUS_NOT_SUPPORTED		((uint)STATUS_NOT_SUPPORTED)
> -#define NDIS_STATUS_INVALID_PACKET		((uint)0xC001000FL)
> -#define NDIS_STATUS_OPEN_LIST_FULL		((uint)0xC0010010L)
> -#define NDIS_STATUS_ADAPTER_NOT_READY		((uint)0xC0010011L)
> -#define NDIS_STATUS_ADAPTER_NOT_OPEN		((uint)0xC0010012L)
> -#define NDIS_STATUS_NOT_INDICATING		((uint)0xC0010013L)
> -#define NDIS_STATUS_INVALID_LENGTH		((uint)0xC0010014L)
> -#define NDIS_STATUS_INVALID_DATA		((uint)0xC0010015L)
> -#define NDIS_STATUS_BUFFER_TOO_SHORT		((uint)0xC0010016L)
> -#define NDIS_STATUS_INVALID_OID			((uint)0xC0010017L)
> -#define NDIS_STATUS_ADAPTER_REMOVED		((uint)0xC0010018L)
> -#define NDIS_STATUS_UNSUPPORTED_MEDIA		((uint)0xC0010019L)
> -#define NDIS_STATUS_GROUP_ADDRESS_IN_USE	((uint)0xC001001AL)
> -#define NDIS_STATUS_FILE_NOT_FOUND		((uint)0xC001001BL)
> -#define NDIS_STATUS_ERROR_READING_FILE		((uint)0xC001001CL)
> -#define NDIS_STATUS_ALREADY_MAPPED		((uint)0xC001001DL)
> -#define NDIS_STATUS_RESOURCE_CONFLICT		((uint)0xC001001EL)
> -#define NDIS_STATUS_NO_CABLE			((uint)0xC001001FL)
> -
> -#define NDIS_STATUS_INVALID_SAP			((uint)0xC0010020L)
> -#define NDIS_STATUS_SAP_IN_USE			((uint)0xC0010021L)
> -#define NDIS_STATUS_INVALID_ADDRESS		((uint)0xC0010022L)
> -#define NDIS_STATUS_VC_NOT_ACTIVATED		((uint)0xC0010023L)
> -#define NDIS_STATUS_DEST_OUT_OF_ORDER		((uint)0xC0010024L)  /*  cause 27 */
> -#define NDIS_STATUS_VC_NOT_AVAILABLE		((uint)0xC0010025L)  /*  cause 35, 45 */
> -#define NDIS_STATUS_CELLRATE_NOT_AVAILABLE	((uint)0xC0010026L)  /*  cause 37 */
> -#define NDIS_STATUS_INCOMPATABLE_QOS		((uint)0xC0010027L)  /*  cause 49 */
> -#define NDIS_STATUS_AAL_PARAMS_UNSUPPORTED	((uint)0xC0010028L)  /*  cause 93 */
> -#define NDIS_STATUS_NO_ROUTE_TO_DESTINATION	((uint)0xC0010029L)  /*  cause 3 */
> -
> -extern struct iw_handler_def  rtw_handlers_def;
> -
> -#endif /*  #ifndef __INC_CEINFO_ */

