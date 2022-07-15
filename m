Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7B575E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiGOJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiGOJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:03:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8261265DA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:03:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so5870614wrq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBnANm3Q5A2PJY9aeSUc7ohmvMH+myjaxt+W7/dm5Xg=;
        b=A3EIJdWC+rs1GD+oMHlvaDHnlloFu2pxTrMInfDEm2SmomsWLOXswFlzOUFn06jYQm
         zInzhuki4SyfxHOv4+GDkhBWkX3eEz9jQuobWcrQ8N1+StmqvouMfheHLjipKEM3q4Nk
         2CPNUOoQbC9XiiKxHI6l2pUMu5lgzsj024BgOonGpZ9iXrayFRSZbqgx1whl6u2tshGb
         GXTyb0WrKGKNZZogtFVe8nn8ZCHvyniI3iZ7fqOVZW97iNJv1VyUHoagKQdQEZ+Up0s+
         iX+GbhJg++bcEP/zpXYIOoS8q7BxTCSreUUd1sWG2y2tStyNRna4lSHFgMpR13UzJEvG
         EUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBnANm3Q5A2PJY9aeSUc7ohmvMH+myjaxt+W7/dm5Xg=;
        b=iteVsD9tjYVHorls8R3RCaM/Tjiwy1SzIp67zeIIYVO6YfEebpBoayiKDhsRDUNRuY
         nNDB3+vCyJxCRFVY2LLvAbyyMbkGxbYdY4mc9QCRcIiOaCmf+72XubkNPywBPVeUDl9B
         W3umBuwkzh/KAdnGYwhVouG8VFxvVFByCv+z5ED02r2osRF3pt01NhammvRj78ORHeyR
         xwG1op2612fdNbfUicj/HBVPHnRhQI2H8zMo8MJ6+NfNJgsp4Q15GNi3UFuQ++STl/hF
         uVB8KXgGC5K0DVvl5q4JtFNLVKA3Q87WmHz79vW9IGLgaamkyZ8g4U+CCgRX/Tf35Cc8
         qYhA==
X-Gm-Message-State: AJIora/ewa2PqYtPMQsyWXqHgLlM3PDbADowl7MXHJyET4aT5l8QronJ
        tYsN4jYrIDLTDGHpXkthK1oABajan6aJPg==
X-Google-Smtp-Source: AGRyM1vXdCEdArP+QaQdNEY6f2R87CoZt3nA6uoWQy+wb3N7Q4yvWxRhVv7rpzO5yYN3RA5l97tp0w==
X-Received: by 2002:adf:9ccf:0:b0:21d:6df9:cb28 with SMTP id h15-20020adf9ccf000000b0021d6df9cb28mr12003871wre.499.1657875810984;
        Fri, 15 Jul 2022 02:03:30 -0700 (PDT)
Received: from fedora ([2a01:e0a:1d2:1f90:be95:f3a2:4d99:a3b3])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003a2fde6ef62sm4979101wmq.7.2022.07.15.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:03:30 -0700 (PDT)
Date:   Fri, 15 Jul 2022 11:03:23 +0200
From:   Matthieu CHARETTE <matthieu.charette@gmail.com>
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
To:     =?iso-8859-1?b?QW5kcuk=?= Almeida <andrealmeid@igalia.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <N512FR.B1R49X9JM9FW2@gmail.com>
In-Reply-To: <120a8dc1-7e5c-85da-e087-10d21fedbf20@igalia.com>
References: <WKTLER.NFH5CX2O259Q@gmail.com>
        <120a8dc1-7e5c-85da-e087-10d21fedbf20@igalia.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, my email client removed every tab. I will send the v2 in a new=20
thread.

Thanks.

Matthieu

On Thu, Jul 14 2022 at 11:23:10 AM -0300, Andr=E9 Almeida=20
<andrealmeid@igalia.com> wrote:
> Hi Matthieu,
>=20
> Thanks for your patch.
>=20
> =C0s 11:58 de 06/07/22, Matthieu CHARETTE escreveu:
>>  Loading an EDID using drm.edid_firmware parameter makes resume to=20
>> fail
>>  after firmware cache is being cleaned. This is because edid_load()=20
>> use a
>>  temporary device to request the firmware. This cause the EDID=20
>> firmware
>>  not to be cached from suspend. And, requesting the EDID firmware=20
>> return
>>  an error during resume.
>>  So the request_firmware() call should use a permanent device for=20
>> each
>>  connector. Also, we should cache the EDID even if no monitor is
>>  connected, in case it's plugged while suspended.
>>=20
>>  Signed-off-by: Matthieu CHARETTE <matthieu.charette@gmail.com>
>>  ---
>>  drivers/gpu/drm/drm_connector.c | 9 ++++
>>  drivers/gpu/drm/drm_edid_load.c | 81=20
>> ++++++++++++++++++++++++++++-----
>>  include/drm/drm_connector.h | 12 +++++
>>  include/drm/drm_edid.h | 3 ++
>>  4 files changed, 94 insertions(+), 11 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/drm_connector.c
>>  b/drivers/gpu/drm/drm_connector.c
>>  index 1c48d162c77e..e8819ebf1c4b 100644
>>  --- a/drivers/gpu/drm/drm_connector.c
>>  +++ b/drivers/gpu/drm/drm_connector.c
>>  @@ -31,6 +31,7 @@
>>  #include <drm/drm_privacy_screen_consumer.h>
>>  #include <drm/drm_sysfs.h>
>>=20
>>  +#include <linux/platform_device.h>
>>  #include <linux/uaccess.h>
>>=20
>>  #include "drm_crtc_internal.h"
>>  @@ -289,6 +290,9 @@ int drm_connector_init(struct drm_device *dev,
>>=20
>>   drm_connector_get_cmdline_mode(connector);
>>=20
>>  + connector->edid_load_pdev =3D NULL;
>>  + drm_cache_edid_firmware(connector);
>>  +
>>   /* We should add connectors at the end to avoid upsetting the=20
>> connector
>>    * index too much.
>>    */
>>  @@ -473,6 +477,11 @@ void drm_connector_cleanup(struct drm_connector
>>  *connector)
>>    connector->tile_group =3D NULL;
>>   }
>>=20
>>  + if (connector->edid_load_pdev) {
>>  + platform_device_unregister(connector->edid_load_pdev);
>>  + connector->edid_load_pdev =3D NULL;
>>  + }
>>  +
>=20
> The indentation of your patch is wrong in different places, like in=20
> this
> if here. It should be like
>=20
> + if (connector->edid_load_pdev) {
> + 	platform_device_unregister(connector->edid_load_pdev);
> + 	connector->edid_load_pdev =3D NULL;
> + }
>=20
> ./scripts/checkpatch.pl can help you detect those issues for your v2
>=20
> Thanks,
> 	Andr=E9


