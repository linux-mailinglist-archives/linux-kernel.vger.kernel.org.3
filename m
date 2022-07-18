Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306E65783BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiGRNd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiGRNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:33:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D29C3A2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:33:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id os14so21276497ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kXAx7ah4HpRG+01WFj99UWodkpRTD76480uGpstIdo=;
        b=fN/w6gbahfXVJVzwo0RCILbViBL9L0qywzdz9Ka3x0LdPCHqwgLEOiMnL0jrrW3qiE
         w134epUUAHiOzvsX6oObhsLZp3UtTn9cJ5tKkWkBpLNHQIyrimcHvTUrsqV4/MbClRgi
         3dQKWtRqnlL8KqoXPfkjur7Z7riJBc1mWGhlxGz+Vl+sVSh/c/uwolsMqC0hlC4yasbv
         oVfjLddvR7wO5NSuUoP2XLaBEA5OvwAlmMPcIkaiyAoQCsWkNTZZQvtZ8cOqy2py54OX
         h6NiAWfqH58kGNxVgiV6mqTaVRXBjYozhPagMuXeWtoNDoydl3MiruRpW7hze2b+df/H
         5ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kXAx7ah4HpRG+01WFj99UWodkpRTD76480uGpstIdo=;
        b=INOAEu4x7mo8sfzDBYUMdCg15k+igFRBs1Gebs0oOl/FU800JMXv9zqpFY5QTBF9Mc
         2JG2JaElHYCmVY6cW07Du4qtm2oKSJPq3Ge3UzzQRytmui2x5Rs7M815CgrrVdYtMjcZ
         Gcpo1rZVrK3oidwen+zxAYcZN+jRHR6fqScEtk8/P+a4kP4N1EZVuJmrppZQqY6KKxNN
         +7ppYEh6pBVpQ4228S7lIHKkpnmK8u//T7m4RZrzB3Znp4brlOq6AFZfvJK4dTvAKscn
         NWZ8bmIjxTrwifgH4etFFowWRT2sXZQYo17kvspQVWte0CuWVh9uV03s1pBuIxqWJ1wg
         N/Hg==
X-Gm-Message-State: AJIora8BJ+BG2/dkCnm3u/1LWZnujpGoPtaGa1SuG2ge3ULanIH98iEf
        4aLHulrlz6Xutbullx6/Ucxs0+ByI04o6uaHM5ghnw==
X-Google-Smtp-Source: AGRyM1u5fJVQo2Ki3UQ3YTx283cKYLZ8z7I+odIE1wk5V95Cu4ufa/Q/r9xT+1OzNOe956EgZNjg3le4dePsT/lnlqA=
X-Received: by 2002:a17:907:160c:b0:72f:1031:2184 with SMTP id
 hb12-20020a170907160c00b0072f10312184mr11133344ejc.355.1658151202457; Mon, 18
 Jul 2022 06:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220718050914.2267370-1-tzungbi@kernel.org> <20220718050914.2267370-9-tzungbi@kernel.org>
In-Reply-To: <20220718050914.2267370-9-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 18 Jul 2022 06:33:11 -0700
Message-ID: <CABXOdTeNi3k8ieL+A6+A7eZyYAzT6UL_M=2j6c0d5iW2_HuLNg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] platform/chrome: cros_ec_proto: return -EAGAIN
 when retries timed out
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 10:10 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
> EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
> cros_ec_wait_until_complete() doesn't return an error code.
>
> Return -EAGAIN in the case instead.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No changes from v1.
>
>  drivers/platform/chrome/cros_ec_proto.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index a6ad7f7956e6..9dec475edc84 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -167,6 +167,9 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
>                         return ret;
>         }
>
> +       if (i >= EC_COMMAND_RETRIES)
> +               ret = -EAGAIN;
> +
>         return ret;
>  }
>
> --
> 2.37.0.170.g444d1eabd0-goog
>
