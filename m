Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128B45438BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245489AbiFHQUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245494AbiFHQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:20:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D64926D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:20:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me5so41939212ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmDceGWW6LP3wfxI3yqcjFMbNeD7K7beSuFUrjXeR0w=;
        b=UV8kMWLoytR4IJW6CbsB8cH10BvVrj56KVYteRKxaYm1iEX0Nklw33dFypmPPi/PBN
         vDExHNbxuQigkwpNpt8/nK9uQENDeKsPKU0UFaCFMN22pal+v/hLUGYeAitykRADOVQg
         2ZA/+OI91ZI8YcT9ssbUq5MwljFBoK6PNRz7G2sv7/WoL/8/Kwp7rkjJMxxb8Rh3DpLy
         QUOP1K28c8lk61flXWRr0eVbG1gfYhVUpuhmUAa8KPelp/eFt+Y9yq//LOru43+XBsaz
         9bGCBEQ0rEW/6v2YFq1dOinZzbT0AEZVbb/uZNJ6tMb3gk/l2ZQgqdlWE0TYwuknDKSl
         4YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmDceGWW6LP3wfxI3yqcjFMbNeD7K7beSuFUrjXeR0w=;
        b=ib0o26Uy4Uk3XwFSPMKtgcXjcs1QmTGimJlwJ0JHenLQuQ6cAC0NCmTsNTHwX3nT30
         jfaJf6q6ym4RJmniFeRU+W/jfUSWJw2cpM+w7Enh+5u+nBU+3sYfqnZqNW1g8r0nItEl
         zWKvo1d1zr8vItmXMtUc2GY+OAatsEedQM22JxIyBHMj+ayCYWQ5SOIFvhR1keRcTMRl
         ua1LvH4I3HnCH70HRO9MXoeK2l0Y7Bi8fMsrGJOzU8RU7JCLhE7W892hcDUm7MPt4Eod
         Ni8afOq8AYg0tmNTY5lZdztvL8QQsNYrf9XnSls5YVb/xFL/26NPQ66rJ1EY4nn24tjN
         iSyQ==
X-Gm-Message-State: AOAM532AaKkdPTrXgNvzSvlMRSnzhEhzroAdKH9Y6bpUZr3I+jnBPBsc
        lDeDB5AqGEaU1FYjiKBikK6wd7Q2/VP4GIaW4lY0oQ==
X-Google-Smtp-Source: ABdhPJxxoJyx1HvNWhRKyxEg6Po41wCjmAnKE6n1u8PuJGFw1V5vlfYQA9oUqdlunBWPcV6g4JDVqMeo6b8eZIm8lZk=
X-Received: by 2002:a17:907:8689:b0:6fe:e525:ea9c with SMTP id
 qa9-20020a170907868900b006fee525ea9cmr32584625ejc.720.1654705240639; Wed, 08
 Jun 2022 09:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-17-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-17-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:20:29 -0700
Message-ID: <CABXOdTd76gczEimVxqWFmyHtbjG=dqALcGcudfZJrUd7qKcVfA@mail.gmail.com>
Subject: Re: [PATCH v3 16/23] platform/chrome: cros_ec_proto: return 0 on
 getting cmd mask success
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
> cros_ec_get_host_command_version_mask() used to return value from
> send_command() which is number of available bytes for input payload on
> success (i.e. sizeof(struct ec_response_get_cmd_versions)).
>
> However, the callers don't need to know how many bytes are available.
>
> Don't return number of available bytes.  Instead, return 0 on success;
> otherwise, negative integers on error.
>
> Also remove the unneeded `ver_mask` initialization as the callers should
> take it only if cros_ec_get_host_command_version_mask() returns 0.

Make sure this compiles with W=1. Compilers may think that ver_mask
may be uninitialized when used.

>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Otherwise

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v2:
> - Separate Kunit test to another patch.
> - Rephrase the commit message.
>
> Changes from v1:
> - Return 0 on success; otherwise, negative intergers.
>
>  drivers/platform/chrome/cros_ec_proto.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index efbabdcb31ae..06bc7db1213e 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -453,6 +453,7 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>         if (ret > 0) {
>                 rver = (struct ec_response_get_cmd_versions *)msg->data;
>                 *mask = rver->version_mask;
> +               ret = 0;
>         }
>
>         kfree(msg);
> @@ -469,7 +470,7 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>   */
>  int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  {
> -       u32 ver_mask = 0;
> +       u32 ver_mask;
>         int ret;
>
>         /* First try sending with proto v3. */
> @@ -505,9 +506,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                 return -ENOMEM;
>
>         /* Probe if MKBP event is supported */
> -       ret = cros_ec_get_host_command_version_mask(ec_dev,
> -                                                   EC_CMD_GET_NEXT_EVENT,
> -                                                   &ver_mask);
> +       ret = cros_ec_get_host_command_version_mask(ec_dev, EC_CMD_GET_NEXT_EVENT, &ver_mask);
>         if (ret < 0 || ver_mask == 0) {
>                 ec_dev->mkbp_event_supported = 0;
>         } else {
> @@ -517,10 +516,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         }
>
>         /* Probe if host sleep v1 is supported for S0ix failure detection. */
> -       ret = cros_ec_get_host_command_version_mask(ec_dev,
> -                                                   EC_CMD_HOST_SLEEP_EVENT,
> -                                                   &ver_mask);
> -       ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
> +       ret = cros_ec_get_host_command_version_mask(ec_dev, EC_CMD_HOST_SLEEP_EVENT, &ver_mask);
> +       ec_dev->host_sleep_v1 = (ret == 0 && (ver_mask & EC_VER_MASK(1)));
>
>         /* Get host event wake mask. */
>         ret = cros_ec_get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
> --
> 2.36.1.255.ge46751e96f-goog
>
