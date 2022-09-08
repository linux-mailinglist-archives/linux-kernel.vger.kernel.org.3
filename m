Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116FB5B19A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiIHKIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIHKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:08:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567DC6FC7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:08:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 65so7187394pfx.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eNsw9HCRudZI37V7FqOkLkvCnQwl5nklhqhhFtZ1w0U=;
        b=lp489DB/MU2LeSP99euMcl/rDD1m7kuWqPXn67FbLopzBRNL9CLeoXy7b7RPdiuDaV
         bDJJ03AN9pFnNKf4rXiZjnifDjpJ2+zy3xGDfQw58PKfDbGZ4/j0c691qEyyJLglYDbD
         sS7j+gQgmRRs42mfXqk7WXGdPOCr79qi8sZp2Wuu6XYyyHWjAqxsC3pSkcOFvIQ4i6Yd
         kvuIrKM3O3VLyWe2WvkYRp1IuCjXBv1075ix2j6Sy+HFtaOj07k+QT8Yo6EyMGxYbzMG
         i+SsEv1fwxEQ3BdSY6ArH+uLJJObabxoYuMwkpBKXkxrBYegP8ewIbWngo+cbB7e4FtK
         LR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eNsw9HCRudZI37V7FqOkLkvCnQwl5nklhqhhFtZ1w0U=;
        b=UwLXaD6w0hXBeQWLhg1Y5evwt2zCpm/FVV2AQUHaHoSWfcwPmAkqegaVV6DjH7yA4W
         P25qZbe7RrXjuuI9OYY6gy2Fnr98BW+OJWDEY2tOLv9nuGacKh9a0q+hLOC18FvQE8Kk
         d6INtyEWpEI3ur3wLe41stbFSn1ttFXJYSR2v5v0+Ct4re49iU4G0jS3701BA1klX9Zr
         qxj8xtdzpf/YLy4pffyFlW2Oaz/cJDem/q8Evwkw8hZ0bIXaZtGHdttm/I+tf7mAoFdz
         GfjL+tAOCUo0O6vO/s+0ya7oKCCq1FlRjx+iBIvq11gt9SuTVc0rIYmD78Kp20Vzy8+q
         Lfkg==
X-Gm-Message-State: ACgBeo2KIfrjmd9XYL4O4mcdPj7LuCJcvz85Bqs7pEaVCKEquveZpB30
        KcRuD1tXl8i4f6f55W8ooEHf2ZJtFFt7w7sZDP6mQ1nLqlQa6MgE
X-Google-Smtp-Source: AA6agR4S5spcsyA+CQsER+jQdvETPNK7BRfeF/c6RHRirga/6s0JpSVxrNRu3KkPY2uzYoExMo4fL9oymDRxgd0jYs0=
X-Received: by 2002:aa7:8583:0:b0:53e:5344:2b7d with SMTP id
 w3-20020aa78583000000b0053e53442b7dmr8254104pfn.49.1662631691202; Thu, 08 Sep
 2022 03:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220907145240.1683088-1-sudeep.holla@arm.com> <20220907145240.1683088-10-sudeep.holla@arm.com>
In-Reply-To: <20220907145240.1683088-10-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 8 Sep 2022 12:08:00 +0200
Message-ID: <CAHUa44ETVSsfpnUHWU=cuwZqpQbEUeUVetJMkxyCMrCFt5rM9g@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] firmware: arm_ffa: Set up 32bit execution mode
 flag using partiion property
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

On Wed, Sep 7, 2022 at 4:53 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> FF-A v1.1 adds a flag in the partition properties to indicate if the
> partition runs in the AArch32 or AArch64 execution state. Use the same
> to set-up the 32-bit execution flag mode in the ffa_dev automatically
> and ignore any requests to do the same from the ffa_driver.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 13 ++++++++++++-
>  include/linux/arm_ffa.h           |  2 ++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 42bc22220c69..34e12a2a98fe 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -648,11 +648,19 @@ static int ffa_partition_info_get(const char *uuid_str,
>         return 0;
>  }
>
> -static void ffa_mode_32bit_set(struct ffa_device *dev)
> +static void _ffa_mode_32bit_set(struct ffa_device *dev)
>  {
>         dev->mode_32bit = true;
>  }
>
> +static void ffa_mode_32bit_set(struct ffa_device *dev)
> +{
> +       if (drv_info->version > FFA_VERSION_1_0)
> +               return;
> +
> +       _ffa_mode_32bit_set(dev);
> +}
> +
>  static int ffa_sync_send_receive(struct ffa_device *dev,
>                                  struct ffa_send_direct_data *data)
>  {
> @@ -744,6 +752,9 @@ static void ffa_setup_partitions(void)
>                                __func__, tpbuf->id);
>                         continue;
>                 }
> +
> +               if (!(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
> +                       _ffa_mode_32bit_set(ffa_dev);

For FF-A 1.0 it looks like we change the dev->mode_32bit default value
from false to true. Or am I missing something?

Cheers,
Jens

>         }
>         kfree(pbuf);
>  }
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 09567ffd1f49..5964b6104996 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -106,6 +106,8 @@ struct ffa_partition_info {
>  #define FFA_PARTITION_DIRECT_SEND      BIT(1)
>  /* partition can send and receive indirect messages. */
>  #define FFA_PARTITION_INDIRECT_MSG     BIT(2)
> +/* partition runs in the AArch64 execution state. */
> +#define FFA_PARTITION_AARCH64_EXEC     BIT(8)
>         u32 properties;
>         u32 uuid[4];
>  };
> --
> 2.37.3
>
