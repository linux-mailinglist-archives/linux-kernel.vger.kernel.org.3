Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEA573C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiGMSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGMSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:16:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB972E9C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:16:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mf4so20109278ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncNTnSyyHX2VTcK/5a+3RxtAnZS3Eiu/HYYWKWm5tqk=;
        b=d+ahix7JcEXFi1nCKUaO270dPP5Gkcbc8fr4FdUEJqZ14KEunHgDh3euSMzf5FShlN
         SFDKz7Xd7f4Kz0Dpr9CCICsrZ1C5sIJ3V+DTysNAFniDi9omM/KVgs8J8pz4Y1+ysVHl
         B0AfFrQkGKgoT4WovgJ3nFKpXjmKh9I/3o+sUVb7JW8c8kOGpZfwpGNRBkGMpH83IGed
         BfkxeRLJqN/3vYwwg4GnlIIElMx82l70UhHfl8lyXzbfgeIMUI1qZgkNsRtLADMQphVo
         oIY5FwVXb7zi8w/KdUXQo+5uBx43Bq8XRcc3tZhanvJkOjnF4f7YJXiYiUj46F1JjW4u
         ROkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncNTnSyyHX2VTcK/5a+3RxtAnZS3Eiu/HYYWKWm5tqk=;
        b=5vluMmBjreOQ8qpBduSZnUUp/azfGHydGVyD9dTQ7nF7EfFDmyg64tcbYFvcYJzKaJ
         U7jZS8jJJiUh9ymr6b5ZJ53O8IZ5JCwnA7IaNMTOVEr4HbCGFNCinOe8yjxk079BjGwI
         E/HQAG9oHTpZawU+WVASNKbNFVfCovxUoU5jSpK6+QZC749LPUAi8bXqiJNnj3QNeWY0
         fKZ2f6nPcQXrMkAqNbBJGQLEdg7giw9CR8QpyYsoZYVJIQvSvC+Zl58wnz3YObVM26N7
         aOeBLcZPDrvhje3bhhdYdDiusvNSkPk+Ql44SXZTnnacCbRhiWQxN3Q+Y4d6cSghXEo5
         a92w==
X-Gm-Message-State: AJIora/rhFJ+hduVIOy4UdmoeFMJgfJwnXAkCkY/UsK2aV5AxoYxAM9B
        s2X7EnqgE4ubQEdjz+B/BUDvW/5xoZynrv2+MC30QRcLtxk=
X-Google-Smtp-Source: AGRyM1sH0nSfuYL+3mf0INCiKCLD2n9ZcPY/cIny3nLwPEs8TXfhKQaFxML+tKuumf7uEZZqIgpTV07KVdi1L0//cPA=
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id
 ia15-20020a170907a06f00b0072b564c465bmr4785902ejc.344.1657736192657; Wed, 13
 Jul 2022 11:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-7-tzungbi@kernel.org>
In-Reply-To: <20220628024913.1755292-7-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 11:16:21 -0700
Message-ID: <CABXOdTcS25n5u0PyZTC2Exs8wLc1-1WRMTJhgwAjpsbCby_dcg@mail.gmail.com>
Subject: Re: [RESEND PATCH 06/11] platform/chrome: cros_ec_proto: change Kunit
 expectation when timed out
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
> While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
> EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
> cros_ec_wait_until_complete() doesn't return an error code.
>
> Change the expectation to an error code.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 64100fd81c6a..fbb872040711 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1870,9 +1870,7 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing(st
>         }
>
>         ret = cros_ec_cmd_xfer(ec_dev, &msg);
> -       KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_comms_status));
> -
> -       KUNIT_EXPECT_EQ(test, msg.result, EC_RES_SUCCESS);
> +       KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
>
>         /* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
>         KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 51);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
