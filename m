Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19845573C72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiGMSTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiGMSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:19:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6C24964
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:19:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l23so21291701ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KohUrBmDurVBooPdiYyB7gOaJD1TmlyoWIhvQZBEuEU=;
        b=dKsPRBVLByu28QFGbHxsNaJ7Oj051WWN9eXj89MWzHIHTee+qkO/AiGhoh4UnteV9m
         FvcSG+2Na8HGyqJzyUbqmkMrqkfIt4BMIduf9jIkPY36PfouJKys6TiGIIoFiyBIqM1h
         c3bP2WDQzbMgDACvRkHF+0+7EjVNcpmkI8vHLqOQLT6Ljmo6ZktaFzu34V6rMpptHDg7
         LLtCeK96hmm7UksmkE4SzjBeHMTbzR0p6pjXU6bF5nhSHFOqSeLpYpzRdeG2jszMM/le
         VtDIGEygSedRachxWG5X3QyC12xdEGnjBDP/D4vkTBJwUGxJLyyiWw7cXDjuDzqyGEZZ
         KcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KohUrBmDurVBooPdiYyB7gOaJD1TmlyoWIhvQZBEuEU=;
        b=ZxmHHX90M+LGC9ypGZgcTic3KE6BjdD9iY9x9dcgtvMiWw6W+OlzpoALPO68y3ad/l
         ODmzA9KERl9Ab2fa1KVBb3KCfUxgQ8MxxTK7NVnz3iAfYnklM3KKq5WPVxS2pCdkQSpP
         e6RskwwSdw5zDVaWr/TS3zVoZzdMHy+xm6iCJQr8QdsdLGRcR/Wcct/AjopQtvi02oli
         JrvTzYNWZop+GljMjAyd6tvoj2OxdR1qCx4Zm5ddzudImIGuLp96FZcKrlZZvz3MtBsx
         wUoSjEZ/mfi/44hvAkRS40LUMlrtmSPL1+mU1SDQnae741GMpTWO/gFJ18vv3s8M9g4a
         gBpA==
X-Gm-Message-State: AJIora8EXmDr24vTOb24Bf9tc8qGc6h2XJV5b1OKHLRVhErzqv3+nFqR
        rZOdBkriX6QpwZqTDyMn3Oyvl2RYzX8MnEn3EHpHww==
X-Google-Smtp-Source: AGRyM1smYL3KTATzHxWiw4hPtQUF27x/M3YaAXOvvUqkVlsIeJKQeuxcfy/93Llvw3gIJjHFe1eZ8Eufp7P04LLNirQ=
X-Received: by 2002:a17:907:6d12:b0:72b:6e70:8c7d with SMTP id
 sa18-20020a1709076d1200b0072b6e708c7dmr4925612ejc.23.1657736347623; Wed, 13
 Jul 2022 11:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-9-tzungbi@kernel.org>
In-Reply-To: <20220628024913.1755292-9-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 11:18:56 -0700
Message-ID: <CABXOdTec8MtFU2N60fXy-z=cKUXkO4ZtCCRHPXjZUuX3JJ2NOw@mail.gmail.com>
Subject: Re: [RESEND PATCH 08/11] platform/chrome: cros_ec_proto: change Kunit
 expectation for EC errors
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
>
> Change the Kunit test expectation to align them.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index fbb872040711..2a6b099fbfd9 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1927,7 +1927,7 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_return_error(struct kunit *t
>         }
>
>         ret = cros_ec_cmd_xfer(ec_dev, &msg);
> -       KUNIT_EXPECT_EQ(test, ret, 0);
> +       KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
>
>         KUNIT_EXPECT_EQ(test, msg.result, EC_RES_INVALID_COMMAND);
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
