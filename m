Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C44B90B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiBPSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:49:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBPStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:49:24 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9312AD673;
        Wed, 16 Feb 2022 10:49:10 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id y6so8055964ybc.5;
        Wed, 16 Feb 2022 10:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4Pqo8atSYgTlXJ5wXcr78qoJ5iUUldz07qz8NHE45M=;
        b=WFNH7u2VSzDHCEb4kja0wytleUNgh5361yIJomURYmDLxJaMiiZECH3hDbXkLOtZJ6
         RZ4ji31X3oMnst0y3qNsCNP6f7aqIU3e6WDvf4rJJYtTjpQ6FfrHHkr4384KzaPIzAEj
         vlyMt2Yt99h5N19VhKfkLPCYHZMcjb8y4+MuVrMeh4kSAjvH+yc/MTDjSlkzBvaFI7cO
         PGzh1mexOrh9fVOyySYk5aD9g+42gkyPgLYcrrGw2fPxihY5ITHhmz0FuDLCY8mm35yc
         gDuDsH4c2cL/GLf2uuGa0xHlCit/yGUcohKJpF34C8lUUivhlPxSVmqGKvXWtDR2L8x7
         koXg==
X-Gm-Message-State: AOAM531Lqyg+85jVvGySxuyEClyPlUfUw2r6cI2ku/gJ1QfNZBWFhMfy
        AJGgKOAbhvXnIKQG9zAXiJMH5c9c5AiMRh7BWZE=
X-Google-Smtp-Source: ABdhPJywFZuX5F1YBITyR02pZNLQusQElDgosfaQS0kba1e2c1LohbTufEiB0gY36e/dIydA1WwqO4XuI5q7qQpyy58=
X-Received: by 2002:a25:782:0:b0:61d:62ed:112d with SMTP id
 124-20020a250782000000b0061d62ed112dmr3399911ybh.466.1645037349567; Wed, 16
 Feb 2022 10:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20220209112951.3073370-1-yebin10@huawei.com>
In-Reply-To: <20220209112951.3073370-1-yebin10@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 19:48:58 +0100
Message-ID: <CAJZ5v0iMOJ-mHL6hUUWs+kuq=4C=_DGUM5b9=jHUp=qnEB2Gqg@mail.gmail.com>
Subject: Re: [PATCH -next] PM:hibernate:fix miss close 'hib_resume_bdev' in load_image_and_restore
To:     Ye Bin <yebin10@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
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

On Wed, Feb 9, 2022 at 12:13 PM Ye Bin <yebin10@huawei.com> wrote:
>
> As 'swsusp_check' open 'hib_resume_bdev', if call 'create_basic_memory_bitmaps'
> failed, we need to close 'hib_resume_bdev' in 'load_image_and_restore' function.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/power/hibernate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e6af502c2fd7..49d1df0218cb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -689,8 +689,10 @@ static int load_image_and_restore(void)
>
>         lock_device_hotplug();
>         error = create_basic_memory_bitmaps();
> -       if (error)
> +       if (error) {
> +               swsusp_close(FMODE_READ | FMODE_EXCL);
>                 goto Unlock;
> +       }
>
>         error = swsusp_read(&flags);
>         swsusp_close(FMODE_READ | FMODE_EXCL);
> --

Applied as 5.18 material, thanks!
