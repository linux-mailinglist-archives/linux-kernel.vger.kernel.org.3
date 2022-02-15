Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B191A4B6678
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiBOIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:48:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiBOIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F171133F7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644914880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0eleqiUVBeAPaQGD2Q6ihFW/Z9JIAN0Kj0GeNRsLaA=;
        b=hZ8/MBLrVc6e47xeqr0zeRNqq3lYvaHYh1RV47u4VogIRGM0SyYAHTMuHGfFg82rlBV8ED
        hRjZnZusZnbAexGHS5fdWlYz3r0oOp1zg05gT4OEF33TyEj0omsSu4lE8W1d5AtCeGqmjt
        owQ8h5No98y+lgq27yuJ9KrruH3oepw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-BDH4GidiMZq2hO3_Y3qZGQ-1; Tue, 15 Feb 2022 03:47:55 -0500
X-MC-Unique: BDH4GidiMZq2hO3_Y3qZGQ-1
Received: by mail-pl1-f200.google.com with SMTP id e7-20020a170902ef4700b0014d2b420f1fso7903391plx.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0eleqiUVBeAPaQGD2Q6ihFW/Z9JIAN0Kj0GeNRsLaA=;
        b=Q3lWn1fk88fItxwXUtxgxOFfC4KgKdDzFodxwQPmtsfFoeO8uMqyF9n2wO44DvxWHc
         14tHt1lVZHxWgWqjLkWcB4/0ZNF3EO6DUvI/5QjxXZfRfQ23w4Z1VtDanq8LixpUKpwj
         +QnbIK9lvJgIkZ305UZ1Vpek5qBDVsLTFQLAi5MLiU2FxgbjHNtJIZBxhqOCQNuCLIno
         cTK31zyxfxTYtBUje/ww5OebCQ+yNd8ifiNqthIf6I2Xv2sus6fPCtXc6Jho8K5AMd4z
         XfU5c8LjpYojDAyr+Xmi8Mt4w+HseRdsLv99uarIm5P1PLwkeYIb3G9uBRhMwIovCfqt
         gutw==
X-Gm-Message-State: AOAM531H/rOtwhaSnKTuVXEiA9FQrShgn/NrGCOcNTgzrScJT8vM6mK/
        uQEy2gnQZYKqH/vqCGIh/ewoVerqKDWpu+LWVn1RPgqd5ESIw8fsF687GUdoxeGKiuhbSnwf2MQ
        2N74U+Ixjxdfjpi4Bjyn4aS8MvJHsYjyvsyNxnKfc
X-Received: by 2002:a05:6a00:9a9:: with SMTP id u41mr3233697pfg.83.1644914874664;
        Tue, 15 Feb 2022 00:47:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1RXfHqGKUOwHiOd9TXDCmkRfLOApnv8+NP4UBdUIs2zHseVmQ3Z770IwhZgE/Zg1NSmgYeteqUdN9fAOzix8=
X-Received: by 2002:a05:6a00:9a9:: with SMTP id u41mr3233676pfg.83.1644914874405;
 Tue, 15 Feb 2022 00:47:54 -0800 (PST)
MIME-Version: 1.0
References: <1644890154-64915-1-git-send-email-wangqing@vivo.com> <1644890154-64915-6-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644890154-64915-6-git-send-email-wangqing@vivo.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 15 Feb 2022 09:47:43 +0100
Message-ID: <CAO-hwJJK5yeW+K_vLpWV9t3TsEdk0xCO-ETxeJsXM2c117JzNw@mail.gmail.com>
Subject: Re: [PATCH V3 5/13] hid: use time_is_after_jiffies() instead of open
 coding it
To:     Qing Wang <wangqing@vivo.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 2:56 AM Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> Use the helper function time_is_{before,after}_jiffies() to improve
> code readability.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

FWIW, this one is
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Wang, is there any plan to take this series through the trivial tree
or should each maintainer take the matching patches?

Cheers,
Benjamin

> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
> index 8ccb246..15e1423
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -578,7 +578,7 @@ static void _ish_sync_fw_clock(struct ishtp_device *dev)
>         static unsigned long    prev_sync;
>         uint64_t        usec;
>
> -       if (prev_sync && jiffies - prev_sync < 20 * HZ)
> +       if (prev_sync && time_is_after_jiffies(prev_sync + 20 * HZ))
>                 return;
>
>         prev_sync = jiffies;
> --
> 2.7.4
>

