Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134BE5250B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355642AbiELOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351615AbiELOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:53:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4476246DA0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:53:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z2so10781839ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XvPMge8GrQx5gO2KcAEj9ecLQjDwShTO+vRI9VUWdM=;
        b=AdeM+wd9VggiptdGj4RlKrq1Zoo5M7tYT3f+1hw3KBsuT0NlLz8HDkN9enALA6YUgM
         4LmTl7YdtM6Gqknm6oJrxF86dlzGfvj0zhXoaViAfDDi91bMpxqQGpppi1RtNV3+Bavl
         FrusBYZ2HYsLB4m2+WwRZe9HSPiWzO98UPRWijcCsYdvoM35T4aUbxfuk0l6jG51jn/q
         J4504prHIlTda4/dbJzTvSV7M3SWPD5hrrWC5XbJ4MsJpphdrQG5C9LAlgURXMBUpgXp
         HiY0kU18wRukU3+bOcjOXDVRb+F6bjRztYM6uHospU4WWRHfhqk+yJzHSThFRJ0QJcYN
         Rb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XvPMge8GrQx5gO2KcAEj9ecLQjDwShTO+vRI9VUWdM=;
        b=Qw0ssBRcznIZ8vTlmA1+XP4NH/hKtz1az+7Q80GYh1ubcE6O9ZytiXJujkZO5/6FRo
         oSMs6azXwro2p/2xvOrerARYlziJNzctiZi0bHkRhzjF47x4IffFLZb9ndvn8JQA//fQ
         X81Dtq4+ICgu+rXcxjzkB4AfsaosPo19AAydBiz8zeSF4YyUAQKSZcYN/IV5fDEWhX1o
         CgrHnDFtLV1OMhyHbSSISeECxxeKq+1DwgA+l7fOcFxyVaSFU6wRz0qFoUaOulGkLfyN
         xeD8a7sMreEX4c6KCEOlaptHGPztUC7RuiHtjxRzfqatP67IjINF8x9aEufnd4GUsSQE
         SEeQ==
X-Gm-Message-State: AOAM533Vzxbfh1rwGsY+W6EA4pJ69n8i+QOpA2FAZYfkvtooGJ+SDXn/
        hXALq3N89NbgftehvfFGuObpGepYz1b/l6B6ShMLDQ==
X-Google-Smtp-Source: ABdhPJz4KM01Q6WW2YJQ2mtQoa4n66n6UyZA8le0momIGBOrHbnlH9NMzSRAZfxRiY9E+0mGNck+N9MIeDV3c9P/z0U=
X-Received: by 2002:a17:907:1b1f:b0:6f0:21ec:6051 with SMTP id
 mp31-20020a1709071b1f00b006f021ec6051mr235589ejc.533.1652367228047; Thu, 12
 May 2022 07:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220512083627.885338-1-tzungbi@kernel.org> <20220512083627.885338-2-tzungbi@kernel.org>
In-Reply-To: <20220512083627.885338-2-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 07:53:36 -0700
Message-ID: <CABXOdTeBRz=TYdrXEERHek+QXtYi5f9+jCDnuZYdc5VDmGtwoA@mail.gmail.com>
Subject: Re: [PATCH 1/6] platform/chrome: cros_ec_proto: drop unneeded
 BUG_ON() in prepare_packet()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
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

On Thu, May 12, 2022 at 1:36 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> prepare_packet() gets called if `ec_dev->proto_version` > 2.  For now, it
> must be equivalent to EC_HOST_REQUEST_VERSION.
>
> Drop the BUG_ON().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

An alternative would be to return -EPROTO, but given the context this
is just a waste of code space.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index ac1419881ff3..db1c8ba43171 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -60,7 +60,6 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
>         int i;
>         u8 csum = 0;
>
> -       BUG_ON(ec_dev->proto_version != EC_HOST_REQUEST_VERSION);
>         BUG_ON(msg->outsize + sizeof(*request) > ec_dev->dout_size);
>
>         out = ec_dev->dout;
> --
> 2.36.0.512.ge40c2bad7a-goog
>
