Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA37523C61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbiEKSVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiEKSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:21:13 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D1880C2;
        Wed, 11 May 2022 11:21:12 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f16645872fso31065187b3.4;
        Wed, 11 May 2022 11:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEzE/fMbhkvTCsodGRCOYp8X3T4STTiJO+VQ1gmZOvI=;
        b=69XoAQJt9HUPpv5YLVTxKqdeOIf7HqT5s8kdZS6tU8cAUuLHBhMUaQ7c/u4a65rKuX
         Ot3olPDSESZUqrEtN4w7/amKiM/lBhdMsF752aEgzOQh3o79x+cAVfbGw4dF/Q9OGeLW
         6g3H5sP0wknVAysa8kFHt2pA7VjJWtghz8LzBfoQymnmbz369ArfvgOBOWCJArvUKCHD
         22hd+D0k2WwcNEx2t+ZaYdpU5PIGMa/8J1VWEzgi3O9XNCU2yPQHBdzSrDjJHY4bh/hu
         DmAHM6Ot8YGjyzAL5Mgn+AuXTaDJ4hErsOvAvz/EOPvvY3Z5ncEzugy1Oes0ps3McJlC
         s62w==
X-Gm-Message-State: AOAM5309XwuEWyh0ZcsA2XJYS87v99V39f6fnlsbe12qriHrK9Jy7K7b
        eJxRusGVrSjtqSoqu1ymm0ab8U4dJ8Z8QGpCk58=
X-Google-Smtp-Source: ABdhPJwncJBUe1wfJI5lpUwPYq136NaNF02hOPCE3KR8Y4JdX25D5xhv7O0q5uOnp4UKFutJCLGixkwWj/8cqY/5RmM=
X-Received: by 2002:a81:2f4e:0:b0:2fb:2c97:d66f with SMTP id
 v75-20020a812f4e000000b002fb2c97d66fmr27202703ywv.196.1652293271699; Wed, 11
 May 2022 11:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220511151230.2983227-1-linux@roeck-us.net>
In-Reply-To: <20220511151230.2983227-1-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 20:21:00 +0200
Message-ID: <CAJZ5v0gk19uQG-+_gm7J_Gk+H2mtH+SmEojnPcEDiFdPoyjCzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hwmon: Introduce and use hwmon_device_register_for_thermal
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The thermal subsystem registers a hwmon driver without providing
> chip information or sysfs group information. This is for legacy reasons
> and would be difficult to change.
>
> At the same time, several attempts have been made to convert hwmon
> drivers using the deprecated hwmon_device_register() to use
> hwmon_device_register_with_info() by just providing NULL parameters.
> This is an abuse of the hwmon API. To prevent this abuse, we want to
> enforce that a parent device pointer as well as chip information is
> provided when registering a hwmon device using
> hwmon_device_register_with_info().
>
> To be able to do this, introduce and use a special API for use only by
> the thermal subsystem (patches 1 and 2). Patch 3 makes the 'dev' and 'chip'
> parameters of hwmon_device_register_with_info() mandatory.
>
> ----------------------------------------------------------------
> Guenter Roeck (3):
>       hwmon: Introduce hwmon_device_register_for_thermal
>       thermal/drivers/thermal_hwmon: Use hwmon_device_register_for_thermal()
>       hwmon: Make chip parameter for with_info API mandatory
>
>  Documentation/hwmon/hwmon-kernel-api.rst |  2 +-
>  drivers/hwmon/hwmon.c                    | 41 ++++++++++++++++++++++++++++++++---------
>  drivers/thermal/thermal_hwmon.c          |  6 ++++--
>  include/linux/hwmon.h                    |  3 +++
>  4 files changed, 40 insertions(+), 12 deletions(-)

This looks good to me from the thermal perspective, so please feel
free to add my ACKs to the first two patches.

Thanks!
