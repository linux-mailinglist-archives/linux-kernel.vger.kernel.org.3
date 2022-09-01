Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6773F5A9253
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiIAIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiIAIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:44:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4C132529
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:44:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id x80so12168337pgx.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=z3MpKPOKhWMkp1oTncrfmX+YNtx4if3SENXhIS6AeVs=;
        b=UKV3nroDJR9uqrC9IA3y1mFbmNAuvephyam7xkPuCFCnz8TZ1WeshiCyKn39PTFo65
         mHPL7EVW+s/IBS136py0gULfttKne+IadkpV3kkS18/yzIAEWPhD5Hn6rcq9TdPUF1XB
         XtMkh1ShNxsl22+qjCHLv3ijX9xM654ebNaqTmlxl01DH48s30r8D8AOkZgpNBTOrxgM
         TVfNhF/c1kxlZlP+SL2W0aqoZGr61wPSNmCq+KwIrZGOwvyyGy52uaj/Y/Cu/NUCs6EU
         TN/a7ch1tgLfGQq7u4gF+hg6Xgnql5e6ckTZoYD3E3ZKvALhBk/MBdq+6LeU5u+OAoy5
         4c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=z3MpKPOKhWMkp1oTncrfmX+YNtx4if3SENXhIS6AeVs=;
        b=dOU2qb5jhJhzILOt0on9EBvdha8CZfY5RZNRYsk9Ex8i8PYt4hXhX5Duq0w4J3yCKs
         k3Yv6mlExUagQmGMcuMTvy4XFCbl0Q+PukEKMpVD3cIwulJJ9XODumFRogZfVV5l0KMg
         QltAmrTLOOgWOhWITC3ySFzGpFVvuqLvbFqVoYCbGdZgHMldlBIuy5KwgWty4icfpwEd
         4jUIAyfc6GN9TAUCojH3poIq4KaexiBziVLSYWx+BbtaWuJOFJG2UFqNrL2lWPy9yU0V
         Z1zHgMktjzjZTnxyQ54RKJ8EPoIQk5KtovMt64G5KU6gNyvIXWi1iRffu3ZGq/PGV8bx
         rJcg==
X-Gm-Message-State: ACgBeo08+islsV4lzByymakGBTeaQ7kw4M0SBLLK8ylLzKJ0UAJcby8s
        R+FpxhV0w3ZEgNVqZUVJhWYIc8tyD71lO7bcJT1FzwLLDcl5QA==
X-Google-Smtp-Source: AA6agR4vloiT6c++TzPayVC/YVNtoyJgFDf5qkl9UNGBw/9kHhnpt1XgjBNLfAbV2soVPbn4Ot4uGDJkccwTu2acS1E=
X-Received: by 2002:a63:5809:0:b0:42a:3145:507d with SMTP id
 m9-20020a635809000000b0042a3145507dmr24754857pgb.428.1662021849282; Thu, 01
 Sep 2022 01:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-8-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-8-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 10:43:58 +0200
Message-ID: <CAHUa44Fmr=vDLbST5qwTDOtSZJq4RYqO+Y4Pij64VeBU-0BgrQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] firmware: arm_ffa: Add v1.1 get_partition_info support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
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

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
>  drivers/firmware/arm_ffa/driver.c | 39 ++++++++++++++++++++++++-------
>  include/linux/arm_ffa.h           |  1 +
>  2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 5c8484b05c50..6822241168d6 100644
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
> +       int idx, count, flags = 0, size;
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
> @@ -285,8 +291,15 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
>
>         count = partition_info.a2;
>
> +       if (drv_info->version > FFA_VERSION_1_0)
> +               size = partition_info.a3;

What happens if this value is larger than sizeof(struct ffa_partition_info)?

> +       else
> +               size = 8; /* FFA_VERSION_1_0 lacks size in the response */
> +
>         if (buffer && count <= num_partitions)
> -               memcpy(buffer, drv_info->rx_buffer, sizeof(*buffer) * count);
> +               for (idx = 0; idx < count; idx++)
> +                       memcpy(buffer + idx, drv_info->rx_buffer + idx * size,
> +                              size);
>
>         ffa_rx_release();
>
> @@ -678,6 +691,14 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
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
> @@ -691,6 +712,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
>  static void ffa_setup_partitions(void)
>  {
>         int count, idx;
> +       uuid_t uuid;
>         struct ffa_device *ffa_dev;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> @@ -701,14 +723,15 @@ static void ffa_setup_partitions(void)
>         }
>
>         for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
> -               /* Note that the &uuid_null parameter will require
> +               import_uuid(&uuid, (u8 *)tpbuf->uuid);
> +
> +               /* Note that the UUID will be uuid_null and that will require

Note that if the UUID is uuid_null, that will require ...

Cheers,
Jen s

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
> index eafab07c9f58..b40afa7933dc 100644
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
> 2.37.2
>
