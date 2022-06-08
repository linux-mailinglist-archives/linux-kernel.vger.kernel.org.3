Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB95438D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbiFHQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbiFHQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:24:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F119C77C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:24:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd25so27832088edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHmSX/+IrCFNegvbLq/KbryGfOKoReahgwi84iPHREk=;
        b=exlHTD26n1woC75nYXQqD7MSrK1NcMRDeViWnpyM21efKY/9x7ptHc9hL4qoeQkdO1
         AQ8iLeSnsN5DvPhCnEhnkKAjFAOJHr/RCVkFEg1iCMNfrkBpvF20h055Yxj6QClLkVKG
         hpbqLAme+/1wb5X8rfHnsDgmRxwlANFef3fm3DCdWWWkKVlefcPO7FZtS3aXcHm9gprA
         ZJQLQRbsdYtSZEmfoHTlp2RpM+ix4sDpARwADpRARi+pObRWQieQLtxoqxHKVZop0L3S
         tywQ9+TQ63IrwcbSo3LGJ7eg5FKn2gi7SEZg8yht3/dpG9r04tu8jO7M8/sNEGBCEiic
         8lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHmSX/+IrCFNegvbLq/KbryGfOKoReahgwi84iPHREk=;
        b=zoh57KqWZj7bmvO3OzXQ8TiEyiLEN0fIf33eEthqsEi4/IybERz1kA1mahrUaTw6hK
         0+4d0O5Dij2Eo3uzBDtf1/BG0052zA+b2e8essC8wQVkRNTODvCL8eLdQVOzyeL8v9UI
         yjKNRRSs9Dhqzrte+uC1PupfAxBIgKWNZG+JK8VhnDGOqEjk2aYlQys0ScKF++uRABUO
         NZbP03Za5DxaYsYf9mbwYYXSc+a7pYFwgWkHltpjSFNU/u3q+efBXQ7VVfTULVBT5/qv
         guYbxOVDzuBS0TKY/1TdFUt/JEFYyb4wZzygtIwNN2QqYz6sbGo+j4ZWoQJcp4DcqJqh
         zfhw==
X-Gm-Message-State: AOAM533V+MIL2L9Pawnod07nxlW4lmECxx773eV8xfXn5bYSnlyewrX0
        vmvHhLgB/ifqmxeSb4Rd+trYJg+fj8lVklZhXw9eJg==
X-Google-Smtp-Source: ABdhPJzcgrDqdyNxP5/wE+aC9cCO13ejUBwYztiDOChX/CzbQiemjTtslfL99Zk5TZz6wo8zRhGUgeJ1NYhhNWxaT10=
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr29818135edd.11.1654705465508; Wed, 08
 Jun 2022 09:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-21-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-21-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:24:14 -0700
Message-ID: <CABXOdTdqguBzxcKWXm+tQJ-XGa_1J26bBJqPLiY7qn4gfn+czg@mail.gmail.com>
Subject: Re: [PATCH v3 20/23] platform/chrome: cros_ec_proto: handle empty
 payload in getting cmd mask
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
> cros_ec_get_host_command_version_mask() expects to receive
> sizeof(struct ec_response_get_cmd_versions) from send_command().  The
> payload is valid only if the return value is positive.
>
> Return -EPROTO if send_command() returns 0 in
> cros_ec_get_host_command_version_mask().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

That answers my previous question.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No v2.  New and separated from the original series.
>
>  drivers/platform/chrome/cros_ec_proto.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 6a5771361383..9e95f9e4b2f8 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -458,6 +458,11 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>                 goto exit;
>         }
>
> +       if (ret == 0) {
> +               ret = -EPROTO;
> +               goto exit;
> +       }
> +
>         rver = (struct ec_response_get_cmd_versions *)msg->data;
>         *mask = rver->version_mask;
>         ret = 0;
> --
> 2.36.1.255.ge46751e96f-goog
>
