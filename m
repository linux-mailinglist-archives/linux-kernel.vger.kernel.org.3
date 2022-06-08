Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90225438DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbiFHQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245393AbiFHQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:26:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288A13EAC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:26:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x5so22728324edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z7UL87qNPTqb+Q3KPHmVnfDvzgXsjCKSbw/KgXuHW8=;
        b=nuXw81uWjcRA3iwjIPUWjjPWyYPm5FPGVF8S1Tr25dWvIRloo6TQdefzttqaK/WyEv
         6DTjUBANjKXLyWZSM7zPGHUDuAx3/9At5QmWNdQzkzuz9W8dBWd2b44Fye14M6JLxX11
         nCVMKTBomK7opo6KD58DUr+X86bTGm4o+ETeFlELCjTEFfG99b8v9MK7m3HYHmyXZUaj
         nPA7fuTHuwC9melcOmht9C3Y9GRhqy+Ih4i28GqZA0m8fmfkVju0bAKf+1P1S4kPqU6E
         /RuufGpmPhphjH38kFkntEU5i4o9MM2/gaogP2sxHEjOI0t4ROZgwDgMQiaWAewu9Doc
         0YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z7UL87qNPTqb+Q3KPHmVnfDvzgXsjCKSbw/KgXuHW8=;
        b=KimOHC0RvrCRjCydWjZUUS6/wAuvEJXGhn7lyO1HRnlZc4teDrk65D9z3fTaM3djav
         yptPEXn4uMn127VXH0Tz3+0GYWTkk/moSIsJHHqZw15dTdk6DAWZx/SkWY1IDopf/mdQ
         CdsUY13ZoU0S4X3lc/qQwUco8+3NZddwPixLQ5q9P6xAfrvugtrmlK3z1nwBSF8mlE76
         w3gKa/Pt6u+fy9edZVdzo8zrg3paaQdook3GfiSX+wZjdSFliEFjaxZo6hH9TM87bB/R
         Fm2EtXrgAKmXRGKFebH3Frr0s38DVz8jJq9Ht1ztYd7Fs4VV4u4qgGZiQfNPjeozC/Sk
         9vZg==
X-Gm-Message-State: AOAM533obIj4rFYM1Q7d4HNxCjtLcaod3L/bIIvi1uYI2jclbCb+opPg
        FAbzM+0ECokzEGm6t4Xkld+N0LpRmnih3wfH09BaHg==
X-Google-Smtp-Source: ABdhPJyxupeF0svhcBIYgAv9ztnH1682B7s9bQSzLdi2vZpE3OrurGLDRapBZDFAYuEUOVSmacyWBAUNKYvd1z9W3xM=
X-Received: by 2002:a05:6402:f14:b0:42d:f989:4a21 with SMTP id
 i20-20020a0564020f1400b0042df9894a21mr40418553eda.168.1654705597304; Wed, 08
 Jun 2022 09:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-22-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-22-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:26:26 -0700
Message-ID: <CABXOdTcoL7f68bqN5L_HSu5rk9+t+jm=-0rzHVGmoMozGro4nQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/23] platform/chrome: cros_ec_proto: return 0 on
 getting wake mask success
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

On Wed, Jun 8, 2022 at 4:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_get_host_event_wake_mask() used to return value from
> send_command() which is number of bytes for input payload on success
> (i.e. sizeof(struct ec_response_host_event_mask)).
>
> However, the callers don't need to know how many bytes are available.
>
> Don't return number of available bytes.  Instead, return 0 on success;
> otherwise, negative integers on error.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v2:
> - Separate Kunit test to another patch.
>
> Changes from v1:
> - Return 0 on success; otherwise, negative intergers.
>
>  drivers/platform/chrome/cros_ec_proto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 9e95f9e4b2f8..68a411e84744 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -236,7 +236,7 @@ EXPORT_SYMBOL(cros_ec_check_result);
>   *
>   * @ec_dev: EC device to call
>   * @msg: message structure to use
> - * @mask: result when function returns >=0.
> + * @mask: result when function returns 0.
>   *
>   * LOCKING:
>   * the caller has ec_dev->lock mutex, or the caller knows there is
> @@ -266,6 +266,7 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
>         if (ret > 0) {
>                 r = (struct ec_response_host_event_mask *)msg->data;
>                 *mask = r->mask;
> +               ret = 0;
>         }
>
>  exit:
> --
> 2.36.1.255.ge46751e96f-goog
>
