Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68A4A5CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiBAM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiBAM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:58:24 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A291C061714;
        Tue,  1 Feb 2022 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HCuPWo35iIHW6bwAsEpQu9KIym1ffHCR2MBVlEBOvsc=; b=I9DJhd2nWqYJk96O9DFM5j9ogj
        Q6xUhXwDUUvPgPtN1A4nVnzXAK2P7UbBcG2pQI9b4XFLRdzVQ9rMpnXv39ep7R4wenyhb6NMeK702
        /MSYUEj17cv70b9KcKZQv6C+eHG3XL5LQb0F54nBYwkW7B0PSHMGMQjcjvva8Fxda/uucp9ohnNXo
        LyhAsBru/gD8+phe8VBd/KehESFmYxKKBAPD8tXsuBEjIic3PFJJtUpMh1rOXsfYerCi7YsCouH1L
        hxLtBX0M5hI/bqQWFKUb7kj+ntV1IUQsN9kaIwYi9yEECUB4QNKQNfPBQOOrDJ5jWSKc3Ec5zHcNu
        y0y5Q8eg==;
Received: from [2a01:799:95e:a400:5d05:6ef3:cded:ad3] (port=53808)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nEsjk-0001CN-9z; Tue, 01 Feb 2022 13:58:20 +0100
Message-ID: <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
Date:   Tue, 1 Feb 2022 13:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
To:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <YfhMESTylI1NTKDg@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 31.01.2022 21.52, skrev Sam Ravnborg:
> On Mon, Jan 31, 2022 at 09:12:21PM +0100, Javier Martinez Canillas wrote:
>> There isn't a connector type for display controllers accesed through I2C,
>> most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.
>>
>> Add an I2C connector type to match the actual connector.
>>
>> As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
>> type"), user-space should be able to cope with a connector type that does
>> not yet understand.
>>

It turned out that I wasn't entirely correct here, mpv didn't cope with
unknown types. In the PR to add support Emil Velikov wondered if libdrm
should handle these connector names:
https://github.com/mpv-player/mpv/pull/8989#issuecomment-879187711

>> Tested with `modetest -M ssd1307 -c` and shows the connector as unknown-1.
> I had expected unknown-21??
> 
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Sam, didn't you and Laurent discuss adding DRM_MODE_CONNECTOR_PANEL for
such a use case?

If someone adds parallel bus support to the MIPI DBI helper, there will
be one more connector type (I wonder what that one will be called).

Noralf.

>> ---
>>
>>  drivers/gpu/drm/drm_connector.c | 1 +
>>  include/uapi/drm/drm_mode.h     | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index a50c82bc2b2f..975a7525a508 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -105,6 +105,7 @@ static struct drm_conn_prop_enum_list drm_connector_enum_list[] = {
>>  	{ DRM_MODE_CONNECTOR_WRITEBACK, "Writeback" },
>>  	{ DRM_MODE_CONNECTOR_SPI, "SPI" },
>>  	{ DRM_MODE_CONNECTOR_USB, "USB" },
>> +	{ DRM_MODE_CONNECTOR_I2C, "I2C" },
>>  };
>>  
>>  void drm_connector_ida_init(void)
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index e1e351682872..d6d6288242db 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -421,6 +421,7 @@ enum drm_mode_subconnector {
>>  #define DRM_MODE_CONNECTOR_WRITEBACK	18
>>  #define DRM_MODE_CONNECTOR_SPI		19
>>  #define DRM_MODE_CONNECTOR_USB		20
>> +#define DRM_MODE_CONNECTOR_I2C		21
>>  
>>  /**
>>   * struct drm_mode_get_connector - Get connector metadata.
>> -- 
>> 2.34.1
