Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C0573C78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiGMSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiGMSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:24:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D718B22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:24:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so15162610edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIstVleI5wOdnOiH/laD0icGVhvC0xTlsJeuVPlERzc=;
        b=eJtnAfCBo1bvcrDYMRslDTvpifIcKxQpQDw1j1O+JAPa0g4MuUPseIE0mzfD/lAX4B
         gBKJTam4L3/43Umw6PpQvgLQrPEo7CWDkcVRg0M+Pr0J4BvzNg8h/cqCnAzTlWijKyfx
         HRlV7MgVXQWviTwYkaK4JnvgiRQVFt32LZGxkPqq59/5XAGC1ivf1GWCRk/XP8Nfm6Fk
         /h5VTB9XJRIGXcHuRVYBP7FeLM8pl2ryP19MsI4VK/AW5HowltRFCerqEDiK928SB9Z3
         pOIDl3eTqN2s2RGwGgHH6t6qvleuNrXSbZi/J8B/qf2vZ2RKMZ+GU2o0lZtZmjEu2NcN
         oEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIstVleI5wOdnOiH/laD0icGVhvC0xTlsJeuVPlERzc=;
        b=C0PBNxSdYDCzmu6ZJ8dGyMMEqBm+ch9veUlB0kccw2WeYP5wRunLepRldiefawFtEb
         VpU4Z3Kbp3kUUMAIY+Rl4JhcKtcEWm9DGCd3+JYEpoULv5sTuI5fODkGSD58GCkh7LQC
         JKE3jKc7ZDivx40S5GrMUmbHFHJCrYGkZCJwopTXxdiZrtX3ACWaKUDbB4awr+vlAy2m
         pY12qZKOzbPc6L1zEnldg5CzQx305SsETCtdopDZLTqRV6r96C1KURPLGOrA3+BwJgC/
         KDURSA1ihlzA7JtOyc/CX6tqOz6DqsF9SvjdsnX4zZDel7laiY0Qy+Jd6yuFAnugD333
         WaZA==
X-Gm-Message-State: AJIora99iEYRhQCbGB5cd9439EqlR8Ph7GcJnWyzJx8ks1pfGfNMYgMm
        WMXK7VbVs5mX/dd7i7IO0Lt5qJnPapjGVdmUqRqFgw==
X-Google-Smtp-Source: AGRyM1v7XZi2EVvKT8MqJNjBZh774qZrYgHjj7ePEk9gcG/l1sBN8cEdgRGM0cdSU6c9mRtKCBB7jSyxL5xGE0jICIw=
X-Received: by 2002:a05:6402:50d0:b0:43a:df6d:6f4d with SMTP id
 h16-20020a05640250d000b0043adf6d6f4dmr6757899edb.72.1657736649926; Wed, 13
 Jul 2022 11:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-10-tzungbi@kernel.org>
In-Reply-To: <20220628024913.1755292-10-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 11:23:58 -0700
Message-ID: <CABXOdTeCFsXYdd6uVDYkOY-tGno_wW-ZyuMb44a63tFABic+NA@mail.gmail.com>
Subject: Re: [RESEND PATCH 09/11] platform/chrome: cros_ec_proto: return
 standard error codes for EC errors
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
> cros_ec_wait_until_complete() checks `msg->result` for
> EC_CMD_GET_COMMS_STATUS.  However, it doesn't return standard error codes
> like most of others.

The callers of cros_ec_send_command() do the mapping. I am not sure if
it is a good idea to change that; it may have undesired side effects
(such as changing the userspace ABI) for callers of
cros_ec_send_command() not expecting this change. It would also result
in double mapping in some situations.

Guenter

>
> Use cros_ec_map_error() to align them.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 49772a4c5353..5323edddb540 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -138,7 +138,7 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
>  {
>         struct cros_ec_command *msg;
>         struct ec_response_get_comms_status *status;
> -       int ret = 0, i;
> +       int ret = 0, i, mapped;
>
>         msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
>         if (!msg)
> @@ -160,8 +160,11 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
>                         break;
>
>                 *result = msg->result;
> -               if (msg->result != EC_RES_SUCCESS)
> +               mapped = cros_ec_map_error(msg->result);
> +               if (mapped) {
> +                       ret = mapped;
>                         break;
> +               }
>
>                 if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
>                         break;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
