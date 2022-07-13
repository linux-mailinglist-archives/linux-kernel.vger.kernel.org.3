Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ABB573C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiGMS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiGMS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:26:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B1D2E9D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:26:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r6so15166736edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E/hA4MyH1jo4zKVeY77z+U8Ko/RGXbnbI2vCOCv4aM=;
        b=kVEsE8P6B37JNnIPhEAO+o4fp2kcRu+KbAmwyo1FUVOlC8YgSJpIizLMx3fNkwV0N6
         2V8z/66b+oU+UFYGOaA7yZlxzYgOsLDo8FCtAEf5DQc4OSKciJhayVEWDX5MZwDRgLjH
         IdZEAdJn9ZWpvYwkQjuYK/h3P0+oujngLkuEp2S8Oy9t4t5kMSdAzG9m2RAQNv90Zv20
         C/qT50wZ/qpOPlPDZxVSnscVT3xCn0SjJZEWBK4ZmQ4ajjIXTjW2PyZ1EFUVRqG+csKw
         y/atRGKCBglR7N/t0tuuJlt1Vu98Q0No59ISpmWq7wMJrmZ7FlKJd6JwPWol+nfVAw/j
         JE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E/hA4MyH1jo4zKVeY77z+U8Ko/RGXbnbI2vCOCv4aM=;
        b=HHBaZrUEmnJ+7etszAN+jeu5bXSANJ99HSUKINZBL0nkAxbuWRwfGKgOywo7yoTmM7
         hKkVNbghUKRqbJvEIUu0kKI/rcZb44mShO7Pxb6/TWdGYZctBLeG3vWy8fD9vI86CbiK
         Z/QNr3j9A9KhtQ/HrjGzp18uKZSywTnrulHE/vwnNWyjXjHBl86WB9AqlI8Cju615p83
         0upFSX6uCKEjFiUdLS5TQ/zgtRK2tNvbljEWuH7G2CQvBZHzGn/+ORy/9uUnMxLiE0/T
         IN4WEamebeBGQKKVTBNXoDW/M673A9ygfvmkfynWTtqQAdjItZ6jI9e6GPSzjpfOPdD2
         uzqA==
X-Gm-Message-State: AJIora9GThh3kiKeqvM6fMqMkWIiBY2WsDxiCoPR8mj0njBpTUv/769G
        bAEiW8PBbtq9tXbpNi+izJNbZ65v9eEf21AayzyylQ==
X-Google-Smtp-Source: AGRyM1tSACFNWUDNHletif+Y+sKlH7qNHpGCdNBV+K/6dOgFwy1BPUa/JcjPA1ErKpT/S8qeXbn0xB/Kd3XgxiZZiDg=
X-Received: by 2002:aa7:d389:0:b0:43a:56c0:c863 with SMTP id
 x9-20020aa7d389000000b0043a56c0c863mr6609524edq.373.1657736760905; Wed, 13
 Jul 2022 11:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-12-tzungbi@kernel.org>
In-Reply-To: <20220628024913.1755292-12-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 11:25:49 -0700
Message-ID: <CABXOdTe+M909H8J2QcAY2_OF1jw=4d9EXb6oerWHNdqjFndPfA@mail.gmail.com>
Subject: Re: [RESEND PATCH 11/11] platform/chrome: cros_ec_proto: return
 -EPROTO if empty payload
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_wait_until_complete() sends EC_CMD_GET_COMMS_STATUS which expects
> to receive sizeof(struct ec_response_get_comms_status) from
> cros_ec_xfer_command().
>
> Return -EPROTO if cros_ec_xfer_command() returns 0.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 5323edddb540..0c7042aa2640 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -166,6 +166,11 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
>                         break;
>                 }
>
> +               if (ret == 0) {
> +                       ret = -EPROTO;
> +                       break;
> +               }
> +
>                 if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
>                         break;
>         }
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
