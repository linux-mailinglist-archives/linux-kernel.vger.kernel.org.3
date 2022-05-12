Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A9524D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353876AbiELMig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353773AbiELMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:38:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D86212B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:38:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so9964935ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoGfAeZQWxmcbzhHC6mTnSs1oZv+JtjPmO1ajlNx7xY=;
        b=b1wUoho9j1rQF9AgKvIZh6E7b3xVmeysOq+HQQYVvd1mbqPZRM87eyHi+uDOfsuWFA
         Mpyt973hsn3vGm6/EpFYegwcoNln/LUONWa03KjfvpKldjDxI+UU9mOPrwi0nR4plq3u
         wTANUhx4kd/3V9fr+XP8lgU3bkOwvHoYI+HHXaY9WlcFlZkdRSfWENzM73CHIrdXREYO
         8PMte1L5SN2hDAVN9snogABa67l+slqwBVTEXlAp2Jh00G5ytO/E6mgsbjfthkyPTc6k
         x38hbD7Sykg/XiiX4r4chB7OA8dMuwot6RnIGRQbgP7Fuhfb7s9GrJoWhjEUOa68rh5K
         Likw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoGfAeZQWxmcbzhHC6mTnSs1oZv+JtjPmO1ajlNx7xY=;
        b=E/EeVkpVgUpvOqzp4CHP6RRo24iVMqdJ8Q9CNgxt568JX6/b859sfDKvWdkskDUrZm
         zT3eMmaEC+vq1CbCjq6RHcLDFsXKuj1eJJYbJEHQelvo1bhBRFTxW6eqC8H1hSqTKt0W
         us7nlfRsIiC2r1un03RkCCGBdEd3dpxn8NvIyRQH143FuvQy58k13MlL4MJevo0vwsqd
         WLt4vX/GtxxhK9eUp5E1p/IGLSial6l5FIi1DN25tqnMSSCf7stdBiZyoYjD9GJ0uoRW
         GpgmVascJ8CDUoqKVzTgsXpzjZBX/XAtoQ1zZ4WLhfHPFRfCWokVTHzSBQQg31KcXqkk
         Ndog==
X-Gm-Message-State: AOAM533k5G1QIQqiDZ7t04jR4fkTZTs7xX93st2HaILNaZTSdlElAXcV
        +4X0GB6WlqfJV2ejk9X6l6X4ilE2GY4krVWAIPE=
X-Google-Smtp-Source: ABdhPJxyZQsOCxEgrJZ2NAiC1Xo6LDdCxh8GoYT6et8Ll4kjTZqtuvt2+XhFH0OByYZ9Rnqwnsq2/IAW528XPmAKjhM=
X-Received: by 2002:a17:907:1b19:b0:6f0:1022:1430 with SMTP id
 mp25-20020a1709071b1900b006f010221430mr30637029ejc.13.1652359110183; Thu, 12
 May 2022 05:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220511054052.51981-1-linmq006@gmail.com>
In-Reply-To: <20220511054052.51981-1-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 12 May 2022 14:38:19 +0200
Message-ID: <CAFBinCAQaCNcYmF0kT6o7zOCHy3eV+vHOHC10XULYXvDO6_-6w@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
To:     Miaoqian Lin <linmq006@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 7:41 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount
> leak.
>
> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks for sending this patch!

Neil, while reviewing this I noticed that on module unload we're also
not calling put_device().
This note doesn't affect this patch - but I am wondering if we need to
put that put_device() during module unload on our TODO-list?


Best regards,
Martin
