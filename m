Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2C543915
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbiFHQbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiFHQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:31:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5EA271460
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:30:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 25so27556527edw.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LOrhUovmaXW0suEK++cbwhUK+zWv0DfKlBlUwAV4lo=;
        b=qYqOefA9OScbwUmWnO/BEh0VDQeePTDaCToVY2urQCiAvHu9sZEiQjL0YthhKgOYGS
         3dJmrcyo0vMgf0UKjbjh80XGcUItQIPbTGBDDUm28eqUhq70+tNp5TDESRDUGoacMAMX
         2K5hLE8pcV9r+dufkNka+Ddt4bdCaxUTq2bZ7YNCuDzfgRZuv/SWkDbRx0PYx7fS9/XG
         cOD7w+avBg7n8JNzFWBnjDfAjCgkT0jmvJEldObj4OiSnPLeeYTpiGKY1sjBnSJg2jx2
         WOZAbWsDqsMB6Re/ge4p7ditTPeHtm1xzF8V3l+8v5mq3xejXena1B+ldtTOocAoMEAG
         AEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LOrhUovmaXW0suEK++cbwhUK+zWv0DfKlBlUwAV4lo=;
        b=7Z79LRg6+qEKpCDzHtVkKVRb4Tg20HEKPmIzvNKpv2N5VKB6Lf9eL9qLyU+yb8y3Yi
         DVJcDkrXlTN5ETqDAp/TkUWoxIx2u7NHNL3eaZTzff/rOhWmW1KDB2Yz4J2PYeQ49bNe
         IJ/IdWv111IVxujAQkiKJBhtsr6YXwWE8ZwEBBGrAmLEkka/RIujtqCZ1+GV0O1wpkuD
         xbsZ+/x8/HS4p/JAqm6BQW+UuP0Ql35l31uqwRnZNsgb5mY/y3vnXaq1Ea5XoEFOlWaw
         RfYhfOBdIGkFbK1nZ3VDwyPAtmDF2G7Zrt9rYkGxYyLFpdfqsNrlVy/I9xdVWBKl/2yo
         txxw==
X-Gm-Message-State: AOAM533MSTpz55eo6vkscgv7eejv5B3mRS40mPX7kcBTCs0y1wxGBY1j
        y4omR6SoVcplrKlEq0HH0r8u8YkwPoRbtS7M6iBPkQ==
X-Google-Smtp-Source: ABdhPJxaDgaNer/+GfHw7iyy/pyb3b2P5Mhjw1tdAYR/amDWZz1ff+RoIUIJpg6SkoACSFVSlDqNJu32kGl/yzE5130=
X-Received: by 2002:a05:6402:2687:b0:430:328f:e46b with SMTP id
 w7-20020a056402268700b00430328fe46bmr2235466edd.33.1654705830946; Wed, 08 Jun
 2022 09:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-24-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-24-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:30:19 -0700
Message-ID: <CABXOdTfLVq30r0+E9GaThXaJgSVjYg6AMP4JfxoiVZ64bdT+Bw@mail.gmail.com>
Subject: Re: [PATCH v3 23/23] platform/chrome: cros_ec_proto: handle empty
 payload in getting wake mask
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
> cros_ec_get_host_event_wake_mask() expects to receive
> sizeof(struct ec_response_host_event_mask) from send_command().  The
> payload is valid only if the return value is positive.
>
> Return -EPROTO if send_command() returns 0 in
> cros_ec_get_host_event_wake_mask().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No v2.  New and separated from the original series.
>
>  drivers/platform/chrome/cros_ec_proto.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 68a411e84744..5cbaaba26ff7 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -256,19 +256,23 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
>         msg->insize = sizeof(*r);
>
>         ret = send_command(ec_dev, msg);
> -       if (ret >= 0) {
> -               mapped = cros_ec_map_error(msg->result);
> -               if (mapped) {
> -                       ret = mapped;
> -                       goto exit;
> -               }
> +       if (ret < 0)
> +               goto exit;
> +
> +       mapped = cros_ec_map_error(msg->result);
> +       if (mapped) {
> +               ret = mapped;
> +               goto exit;
>         }
> -       if (ret > 0) {
> -               r = (struct ec_response_host_event_mask *)msg->data;
> -               *mask = r->mask;
> -               ret = 0;
> +
> +       if (ret == 0) {
> +               ret = -EPROTO;
> +               goto exit;
>         }
>
> +       r = (struct ec_response_host_event_mask *)msg->data;
> +       *mask = r->mask;
> +       ret = 0;
>  exit:
>         kfree(msg);
>         return ret;
> --
> 2.36.1.255.ge46751e96f-goog
>
