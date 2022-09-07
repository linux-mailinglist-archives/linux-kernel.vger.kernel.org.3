Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A75AFFCD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIGJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIGJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:01:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A633AF480
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:01:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y127so13978386pfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ELHyy9g5JRbfhKbhnhJOnuhdaHcEpPG9qj9a/5f8Kwg=;
        b=VOYtGdgtdkV8vp8Blh4Ol8K/8wn14f6F4+jLWUhWrYO0tb0bu7ZuQlUVq+aLyAS0rp
         R34HmstexRj3/pL5NOhYihAFoKKtJ+z7S5pgkqwB54hm4ULsrdy4auxOB2cw/ecSQf08
         hyRaoyx77iru9pL2CcOP4w+wtEK9ybUqcODsKmCsYD3PhOwTEAE0xzexFbhlSTqUd9/H
         NesIrO53RHkfa9QVOaDWEr8srFZn1T+aG+k6l1b30kq0r7EhjMVj7lQqqbyIPe0hzL4j
         ijC00cuDu6B/BDJPA5QvN2HV0QcOSUwbVgSxzloHG5PNv/pa6SNZBvlvISKOApRF66Il
         7vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ELHyy9g5JRbfhKbhnhJOnuhdaHcEpPG9qj9a/5f8Kwg=;
        b=Gfchee/Ldrc2u3H+QajZhf5yEwgXgFMG9+jDeBIKcxjdN5l4VWacvtwmuZgyKTlYgk
         n941lYVxYGX7Z8IIJt04w3E0XkfGwbiVNjagPppf39D16JJUlc8SnHitkfYjSQPnoosk
         nsyYPsERntuqn0sqFFMwGr9PsUTx5taNfuNCNp5EEVMjflsiw5A0i4g+a8BdFRtc6wFz
         XkcWCzBQS0+L0NQb8MYRtDNmGYOd/D+KBPpSYIBJ4qhp/frrhQcwGG4g6LXOv0EXdmko
         xylrmM1zg9Wtb0kvMGcgrsoW9YHOgDGf9mT5t0SPANFQT/sv7sFYa1w1UAcZw8ISbBRc
         leVg==
X-Gm-Message-State: ACgBeo08XChy43B/k5erYHzAjADF450dsNxs5K1j2WJV1ARLqOLusZNG
        smfNUmnpg+1V1mcBREUiC/ScHlCp0XoLcDMBX+Z+GQ==
X-Google-Smtp-Source: AA6agR7I+o8bSYOvyVGo/YjKwv8NK6ti1P4v5vZFfGP57JboHhl2jnqU0sIu8B+AddxliSXBsQrwncKnC++7Rwq8pWg=
X-Received: by 2002:a05:6a00:1a04:b0:52a:d4dc:5653 with SMTP id
 g4-20020a056a001a0400b0052ad4dc5653mr2705863pfv.69.1662541297803; Wed, 07 Sep
 2022 02:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220902124032.788488-1-sudeep.holla@arm.com> <20220902124032.788488-10-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-10-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 7 Sep 2022 11:01:27 +0200
Message-ID: <CAHUa44Gq+7_XT2+ccAMxC=ZFh4vV=YuUGLGx0MMYrZ1wne83bw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] firmware: arm_ffa: Set up 32bit execution mode
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

On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
> index dd6ab2f81580..dbbe15592173 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -647,11 +647,19 @@ static int ffa_partition_info_get(const char *uuid_str,
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
> @@ -743,6 +751,9 @@ static void ffa_setup_partitions(void)
>                                __func__, tpbuf->id);
>                         continue;
>                 }
> +
> +               if (tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)

Shouldn't this be !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)?

Before this, we used 64-bit calling convention by default for FF-A
v1.0. I suppose we would like to keep that behaviour.

Cheers,
Jens

> +                       _ffa_mode_32bit_set(ffa_dev);
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
