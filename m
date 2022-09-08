Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C035B1997
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIHKGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIHKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:05:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E505BC135
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:05:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b144so12625810pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UboqYnyT4/uuK4NVYWqNgFRYLyGREU+4ehotshppyGw=;
        b=h3H0bpjhYA8WkHusTvL546EQkA72uQPZ0FAFNBZwrI0AaO2I2+NWbOs+QnEbI3ZAZ9
         6e4y4MvyWliR4P/3YYEicxqoymdShy8seh+ixdNg0Az6/LAlbG/A935bbNEr9LR/6EjL
         0BbxM9VtbpZli0TjxzNHA7+DzJ18Gk1DX+2s+t8mFOBHXlNhk+FtJFBQKuy1Bic07deW
         Lkto3PbTJ/6gJwAWHrKuEuqWROEN0zc9kWfqWF1xRhZx1RWPZVs0V9wbmOnWxZKuGm4+
         sGQ6eLymnGH9mAbJUsnjLE2I+D9seTIrmH1w0/mTJy0rpGA2GiDFc6BboUQpdoTJn6OO
         rJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UboqYnyT4/uuK4NVYWqNgFRYLyGREU+4ehotshppyGw=;
        b=AVCS7hu2qBXRyaBh9pVObvBqJ3u4pEmZde2ZbKijXT7ifHDJ+kum5Pl4WzpP82O11X
         AD7Y3oSwpFlXRI07TnuTANgTbPilazYZLm9meKA0Tkwg5prL6wINbDbhOwr1NLIO3vvM
         KykYklci8Hd3t9mjer6iAqTQKuY+1g1gIMJUrhxDRun/Y2BuU6UGxOAfPgh4jxQwouJp
         ljDTSPOMEtecubE9kfqe4AHe2jYIzZ84Kb6yl3i/MjZcUMcumH0Hf3+sat2E48qK6945
         okij1SYxgI2QEhiLc1IOcJU5tZwYAATOmPvi2Xy0SOne76E0UHGMmK6yME/AljEJgsWV
         eY3w==
X-Gm-Message-State: ACgBeo3eJPeBEmv+YsDoYo/I1rJgULboyv3QBIGtXlENsa3uQrH/pMB5
        HQZVywWd+NdU0rSOhAe7VlkyJDrRNp84QpWBBH1frw==
X-Google-Smtp-Source: AA6agR54IFnFpuIX06NMu1FZ2UvrM00Q1Whrm/mlGwDHh+w4hOqwgKLFUt2pMFAFoXeoOYyx+2UYmm2lpJUNt+wgjWg=
X-Received: by 2002:a63:1a23:0:b0:434:4395:8b5a with SMTP id
 a35-20020a631a23000000b0043443958b5amr7009145pga.428.1662631557238; Thu, 08
 Sep 2022 03:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220907145240.1683088-1-sudeep.holla@arm.com> <20220907145240.1683088-9-sudeep.holla@arm.com>
In-Reply-To: <20220907145240.1683088-9-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 8 Sep 2022 12:05:46 +0200
Message-ID: <CAHUa44G_ahJe0HpPWW_WVF_=9jWYqVGJ=ozo5WA6KwMchs1zow@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 4:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
> missing in v1.0 and which the driver workarounds by using UUIDs supplied
> by the ffa_drivers.
>
> Add the v1.1 get_partition_info support and disable the workaround if
> the detected FF-A version is greater than v1.0.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 43 +++++++++++++++++++++++++------
>  include/linux/arm_ffa.h           |  1 +
>  2 files changed, 36 insertions(+), 8 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 2532e0f16cc9..42bc22220c69 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
>         return 0;
>  }
>
> +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY   BIT(0)
> +
>  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
>  static int
>  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
>                          struct ffa_partition_info *buffer, int num_partitions)
>  {
> -       int count;
> +       int idx, count, flags = 0, sz, buf_sz;
>         ffa_value_t partition_info;
>
> +       if (!buffer || !num_partitions) /* Just get the count for now */
> +               flags = PARTITION_INFO_GET_RETURN_COUNT_ONLY;
> +
>         mutex_lock(&drv_info->rx_lock);
>         invoke_ffa_fn((ffa_value_t){
>                       .a0 = FFA_PARTITION_INFO_GET,
>                       .a1 = uuid0, .a2 = uuid1, .a3 = uuid2, .a4 = uuid3,
> +                     .a5 = flags,
>                       }, &partition_info);
>
>         if (partition_info.a0 == FFA_ERROR) {
> @@ -285,8 +291,19 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
>
>         count = partition_info.a2;
>
> +       if (drv_info->version > FFA_VERSION_1_0) {
> +               buf_sz = sz = partition_info.a3;
> +               if (sz > sizeof(*buffer))
> +                       buf_sz = sizeof(*buffer);
> +       } else {
> +               /* FFA_VERSION_1_0 lacks size in the response */
> +               buf_sz = sz = 8;
> +       }
> +
>         if (buffer && count <= num_partitions)
> -               memcpy(buffer, drv_info->rx_buffer, sizeof(*buffer) * count);
> +               for (idx = 0; idx < count; idx++)
> +                       memcpy(buffer + idx, drv_info->rx_buffer + idx * sz,
> +                              buf_sz);
>
>         ffa_rx_release();
>
> @@ -681,6 +698,14 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
>         int count, idx;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> +       /*
> +        * FF-A v1.1 provides UUID for each partition as part of the discovery
> +        * API, the discovered UUID must be populated in the device's UUID and
> +        * there is no need to copy the same from the driver table.
> +        */
> +       if (drv_info->version > FFA_VERSION_1_0)
> +               return;
> +
>         count = ffa_partition_probe(uuid, &pbuf);
>         if (count <= 0)
>                 return;
> @@ -694,6 +719,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
>  static void ffa_setup_partitions(void)
>  {
>         int count, idx;
> +       uuid_t uuid;
>         struct ffa_device *ffa_dev;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> @@ -704,14 +730,15 @@ static void ffa_setup_partitions(void)
>         }
>
>         for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
> -               /* Note that the &uuid_null parameter will require
> +               import_uuid(&uuid, (u8 *)tpbuf->uuid);
> +
> +               /* Note that if the UUID will be uuid_null, that will require
>                  * ffa_device_match() to find the UUID of this partition id
> -                * with help of ffa_device_match_uuid(). Once the FF-A spec
> -                * is updated to provide correct UUID here for each partition
> -                * as part of the discovery API, we need to pass the
> -                * discovered UUID here instead.
> +                * with help of ffa_device_match_uuid(). FF-A v1.1 and above
> +                * provides UUID here for each partition as part of the
> +                * discovery API and the same is passed.
>                  */
> -               ffa_dev = ffa_device_register(&uuid_null, tpbuf->id, &ffa_ops);
> +               ffa_dev = ffa_device_register(&uuid, tpbuf->id, &ffa_ops);
>                 if (!ffa_dev) {
>                         pr_err("%s: failed to register partition ID 0x%x\n",
>                                __func__, tpbuf->id);
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 4c4b06783035..09567ffd1f49 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -107,6 +107,7 @@ struct ffa_partition_info {
>  /* partition can send and receive indirect messages. */
>  #define FFA_PARTITION_INDIRECT_MSG     BIT(2)
>         u32 properties;
> +       u32 uuid[4];
>  };
>
>  /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registers */
> --
> 2.37.3
>
