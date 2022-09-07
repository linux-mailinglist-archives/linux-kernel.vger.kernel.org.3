Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3355AFF56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIGIko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiIGIkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:40:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF377E85
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:40:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o4so13809200pjp.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qRQJH9FOv1ch+h8S4C846f5bMyz0NyEFQNx3nL1ReVg=;
        b=eUG+wNmW7Vyte1QmieH1HM2Qnhz3qg45qPZTtVe/gYrUTTg8oHuJMcsmtf2aqKbJQg
         5APYoKp9WNzVrzvfaxM/pZYV+XAJKYIqq5eVPr6yyjr3Cp938WdirdNGZrjORHcsvzEC
         lPslAxO/ChFBNVqTlvGu7/ekBueDTP2etqYasWagGrEKneXVXx/2EEXaHm6daZZwT/qK
         hc65dseoySBgaMqHHfjkljm0ZNRJoNnerNZQxoDhdiUzcE2934B58a6W+QXqcSxDzd53
         aE0lyFx1W62jt4o6PQrznulgeK0vcM+fhRpE5qf6MkXCazeZ6COhNYFoC/hKkv8a6a1u
         w5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qRQJH9FOv1ch+h8S4C846f5bMyz0NyEFQNx3nL1ReVg=;
        b=xXKN18zHvOmLc3UGgi5gTIZKTemuEnW9MfPKHvYl99V4Ka2Cn1Hr5Yg8IM9U+QX9gZ
         23zp4SwDUrj/0IjlMfuuaA1lDP24R2Lt6xQLLM5QE8Vzh/7ibaGrDk+6JpcKr8b384eu
         Zm9j6Ajcas9I+mXVcXxGB+YKiNwrfGy0gJ6EAthapi+g4/3zHZqO8GwifKnQG+suUg3E
         HuFojplc7n2tsXszbhoxXCXfE3Y7pYmMfwe0hqLNCXnIGcro1RxxIfQVI/lD7sujAVXZ
         YdQveez86phOUUo53n0XN2fYk0s/HY8TUgL5j03PLZk7OHslZaimHUm9GaPXncDShnId
         nn7Q==
X-Gm-Message-State: ACgBeo2zlBxkOCfZ7OTI2PQboTQKeOz1GSoNtiU6USXsl/W6kSqMrb14
        eV9M23m5C83VzqHnPzolY+XkMXcxl66qUv65TKyAhQ==
X-Google-Smtp-Source: AA6agR7bNx7uBZkaPR6jMj+dSklZn/4W7kAB2osB0whpYmLrxW5bYCst8mrGbsVqOxjode+yGgxLhXDT6ogcCzzGbck=
X-Received: by 2002:a17:902:f684:b0:172:d54d:6f9e with SMTP id
 l4-20020a170902f68400b00172d54d6f9emr2830838plg.174.1662539895784; Wed, 07
 Sep 2022 01:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220902124032.788488-1-sudeep.holla@arm.com> <20220902124032.788488-9-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-9-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 7 Sep 2022 10:38:05 +0200
Message-ID: <CAHUa44FR7PN99CK6Qq4tSoKWm7uEgctJOLEW5F3jhZhSV19QXg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
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

On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
>  drivers/firmware/arm_ffa/driver.c | 42 +++++++++++++++++++++++++------
>  include/linux/arm_ffa.h           |  1 +
>  2 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 2532e0f16cc9..dd6ab2f81580 100644
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
> @@ -285,8 +291,18 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
>
>         count = partition_info.a2;
>
> +       if (drv_info->version > FFA_VERSION_1_0) {
> +               size = partition_info.a3;
> +               if (size > sizeof(*buffer))
> +                       size = sizeof(*buffer);

Below when calculating the address in the source buffer with
"drv_info->rx_buffer + idx * size" you should use the size from
partition_info.a3 even if it's larger than sizeof(*buffer). The amount
of bytes to copy looks correct though. Does that make sense?

Cheers,
Jens

> +       } else {
> +               size = 8; /* FFA_VERSION_1_0 lacks size in the response */
> +       }
> +
>         if (buffer && count <= num_partitions)
> -               memcpy(buffer, drv_info->rx_buffer, sizeof(*buffer) * count);
> +               for (idx = 0; idx < count; idx++)
> +                       memcpy(buffer + idx, drv_info->rx_buffer + idx * size,
> +                              size);
>
>         ffa_rx_release();
>
> @@ -681,6 +697,14 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
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
> @@ -694,6 +718,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
>  static void ffa_setup_partitions(void)
>  {
>         int count, idx;
> +       uuid_t uuid;
>         struct ffa_device *ffa_dev;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> @@ -704,14 +729,15 @@ static void ffa_setup_partitions(void)
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
