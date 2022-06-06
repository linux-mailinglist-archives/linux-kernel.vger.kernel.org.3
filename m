Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975753E8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbiFFQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiFFQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:06:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D41A1A0740
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:06:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id me5so29347544ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mn094xLxYvy/uwKOFCOzbLjQc3NujMKvTQCk/c8be38=;
        b=Q9eiPQeBD46xdljUtyRhI0cfafmKZr+gI4gbJWsOIZYn3sMPGIT74ZWMQu09oLN9OO
         xC7uCagHPs4HmSoDFPGvwyLNhmGpgmWxB24jbD/f6hK3vueJLAY82G/T3EsfC3z+IdYu
         9wdJ+FHI2f6syBJzxr6Watdyl/PCrJrKN6fels9N4B/dJjGVhcvmrkpb6M4EMRAeIgM7
         OiK/goMdYVvgGZ5C9F+paLHk1j9dNCURPiAo6qCN1t3RlmM9bA6jQquEfesps6Dn+gcT
         wJCQpDgW2KCxMpiUQ3nyyHyWH27bVv9GF5yLAsxObhnE7QYAk0++KUp1vwm9RCS6TTnF
         AIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mn094xLxYvy/uwKOFCOzbLjQc3NujMKvTQCk/c8be38=;
        b=Kt9nqekpp/+tfCa4g4w/beHWfElWChnP0IaXOWTtKnRgjoER0+GhelgBTEjkLyakNI
         velZmbSapyQTuZohgHCTPnDCr3ky0FLPcOGBZGFlJN9ugEB/EK+YIjy43+CgbTfAQ3jX
         n17FuE2WIZXmG7/aB9K5NglOU+Ph07AfT6xjZMXoMZ4GiU5fFVn3KnsFeAV97r81y01B
         +Yk4p9htYE2mZqjIPfdepEaUPIYgaoo5WryzBDSV5D5mXzJLfkt8wpAQtSeq4ZojIH7V
         zlrHwLYwN59Wn4KdyMZp9g7n7SS0n4FHTDxS9i2ASrv1+JMajfKsLQetxaC7h6zhxLvP
         SRew==
X-Gm-Message-State: AOAM533wELXtzH8MWmzzWfOGsmA4oQHoZ6uCXKBcthsue+f27jl+7YM/
        Jfg+fpoSRgnhHegb01/XyPZ8sswQ49tUxIgCV695zAYJECo0rQEQ
X-Google-Smtp-Source: ABdhPJyJErIX5ewf1M2ltYU2ap5fLcO+GOHlqG0k+W7K4Krhxy/yk0XV0eYzhsHETpSuSNtJgCc5DjKL0B9DXel6JI0=
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id
 nb40-20020a1709071ca800b0070c68cedademr19305680ejc.723.1654531574705; Mon, 06
 Jun 2022 09:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-8-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-8-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 09:06:03 -0700
Message-ID: <CABXOdTfNMpDUBpLVxiV1+B7M4jmG9998rC5WmrJvbuijXaGwBA@mail.gmail.com>
Subject: Re: [PATCH 07/13] platform/chrome: cros_ec_proto: separate fill_protocol_info()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
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

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Rename cros_ec_host_command_proto_query() to fill_protocol_info() and
> make it responsible for setting `ec_dev` fields according to the
> response protocol info.
>
> Also make cros_ec_get_host_event_wake_mask() allocate its own message
> buffer.  It was lucky that size of `struct ec_response_host_event_mask`
> is less than `struct ec_response_get_protocol_info`.  Thus, the buffer
> wasn't overflow.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c      | 130 +++++++++----------
>  drivers/platform/chrome/cros_ec_proto_test.c |  28 ++--
>  2 files changed, 76 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 71ba6a56ad7c..f57b4dba95b7 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -242,47 +242,53 @@ EXPORT_SYMBOL(cros_ec_check_result);
>   * the caller has ec_dev->lock mutex, or the caller knows there is
>   * no other command in progress.
>   */
> -static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
> -                                           struct cros_ec_command *msg,
> -                                           uint32_t *mask)
> +static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint32_t *mask)
>  {
> +       struct cros_ec_command *msg;
>         struct ec_response_host_event_mask *r;
>         int ret, mapped;
>
> +       msg = kzalloc(sizeof(*msg) + sizeof(*r), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
>         msg->command = EC_CMD_HOST_EVENT_GET_WAKE_MASK;
> -       msg->version = 0;
> -       msg->outsize = 0;
>         msg->insize = sizeof(*r);
>
>         ret = send_command(ec_dev, msg);
>         if (ret >= 0) {
>                 mapped = cros_ec_map_error(msg->result);
> -               if (mapped)
> -                       return mapped;
> +               if (mapped) {
> +                       ret = mapped;
> +                       goto exit;
> +               }
>         }
>         if (ret > 0) {
>                 r = (struct ec_response_host_event_mask *)msg->data;
>                 *mask = r->mask;
>         }
>
> +exit:
> +       kfree(msg);
>         return ret;
>  }
>
> -static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
> -                                           int devidx,
> -                                           struct cros_ec_command *msg)
> +static int fill_protocol_info(struct cros_ec_device *ec_dev, int devidx)

I would suggest to keep the cros_ec_ prefix. Also, "fill" sounds a bit
too much as if the function would fill some structure fields. "get"
(ie cros_ec_get_proto_info or similar) might be a better name,

Thanks,
Guenter

>  {
> -       /*
> -        * Try using v3+ to query for supported protocols. If this
> -        * command fails, fall back to v2. Returns the highest protocol
> -        * supported by the EC.
> -        * Also sets the max request/response/passthru size.
> -        */
> +       struct cros_ec_command *msg;
> +       struct ec_response_get_protocol_info *info;
>         int ret;
>
> -       memset(msg, 0, sizeof(*msg));
> +       ec_dev->proto_version = 3;
> +       if (devidx > 0)
> +               ec_dev->max_passthru = 0;
> +
> +       msg = kzalloc(sizeof(*msg) + sizeof(*info), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
>         msg->command = EC_CMD_PASSTHRU_OFFSET(devidx) | EC_CMD_GET_PROTOCOL_INFO;
> -       msg->insize = sizeof(struct ec_response_get_protocol_info);
> +       msg->insize = sizeof(*info);
>
>         ret = send_command(ec_dev, msg);
>         /*
> @@ -299,15 +305,43 @@ static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
>                 dev_dbg(ec_dev->dev,
>                         "failed to check for EC[%d] protocol version: %d\n",
>                         devidx, ret);
> -               return ret;
> +               goto exit;
>         }
>
> -       if (devidx > 0 && msg->result == EC_RES_INVALID_COMMAND)
> -               return -ENODEV;
> -       else if (msg->result != EC_RES_SUCCESS)
> -               return msg->result;
> +       ret = cros_ec_map_error(msg->result);
> +       if (ret)
> +               goto exit;
> +
> +       info = (struct ec_response_get_protocol_info *)msg->data;
> +
> +       switch (devidx) {
> +       case CROS_EC_DEV_EC_INDEX:
> +               ec_dev->max_request = info->max_request_packet_size -
> +                                               sizeof(struct ec_host_request);
> +               ec_dev->max_response = info->max_response_packet_size -
> +                                               sizeof(struct ec_host_response);
> +               ec_dev->proto_version = min(EC_HOST_REQUEST_VERSION,
> +                                           fls(info->protocol_versions) - 1);
> +               ec_dev->din_size = info->max_response_packet_size + EC_MAX_RESPONSE_OVERHEAD;
> +               ec_dev->dout_size = info->max_request_packet_size + EC_MAX_REQUEST_OVERHEAD;
> +
> +               dev_dbg(ec_dev->dev, "using proto v%u\n", ec_dev->proto_version);
> +               break;
> +       case CROS_EC_DEV_PD_INDEX:
> +               ec_dev->max_passthru = info->max_request_packet_size -
> +                                               sizeof(struct ec_host_request);
> +
> +               dev_dbg(ec_dev->dev, "found PD chip\n");
> +               break;
> +       default:
> +               dev_dbg(ec_dev->dev, "unknwon passthru index: %d\n", devidx);
> +               break;
> +       }
>
> -       return 0;
> +       ret = 0;
> +exit:
> +       kfree(msg);
> +       return ret;
>  }
>
>  static int cros_ec_host_command_proto_query_v2(struct cros_ec_device *ec_dev)
> @@ -417,51 +451,13 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>  int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  {
>         struct device *dev = ec_dev->dev;
> -       struct cros_ec_command *proto_msg;
> -       struct ec_response_get_protocol_info *proto_info;
>         u32 ver_mask = 0;
>         int ret;
>
> -       proto_msg = kzalloc(sizeof(*proto_msg) + sizeof(*proto_info),
> -                           GFP_KERNEL);
> -       if (!proto_msg)
> -               return -ENOMEM;
> -
>         /* First try sending with proto v3. */
> -       ec_dev->proto_version = 3;
> -       ret = cros_ec_host_command_proto_query(ec_dev, CROS_EC_DEV_EC_INDEX, proto_msg);
> -
> -       if (ret == 0) {
> -               proto_info = (struct ec_response_get_protocol_info *)
> -                       proto_msg->data;
> -               ec_dev->max_request = proto_info->max_request_packet_size -
> -                       sizeof(struct ec_host_request);
> -               ec_dev->max_response = proto_info->max_response_packet_size -
> -                       sizeof(struct ec_host_response);
> -               ec_dev->proto_version =
> -                       min(EC_HOST_REQUEST_VERSION,
> -                                       fls(proto_info->protocol_versions) - 1);
> -               dev_dbg(ec_dev->dev,
> -                       "using proto v%u\n",
> -                       ec_dev->proto_version);
> -
> -               ec_dev->din_size = proto_info->max_response_packet_size + EC_MAX_RESPONSE_OVERHEAD;
> -               ec_dev->dout_size = proto_info->max_request_packet_size + EC_MAX_REQUEST_OVERHEAD;
> -
> -               /*
> -                * Check for PD
> -                */
> -               ret = cros_ec_host_command_proto_query(ec_dev, CROS_EC_DEV_PD_INDEX, proto_msg);
> -
> -               if (ret) {
> -                       dev_dbg(ec_dev->dev, "no PD chip found: %d\n", ret);
> -                       ec_dev->max_passthru = 0;
> -               } else {
> -                       dev_dbg(ec_dev->dev, "found PD chip\n");
> -                       ec_dev->max_passthru =
> -                               proto_info->max_request_packet_size -
> -                               sizeof(struct ec_host_request);
> -               }
> +       if (!fill_protocol_info(ec_dev, CROS_EC_DEV_EC_INDEX)) {
> +               /* Check for PD. */
> +               fill_protocol_info(ec_dev, CROS_EC_DEV_PD_INDEX);
>         } else {
>                 /* Try querying with a v2 hello message. */
>                 ec_dev->proto_version = 2;
> @@ -524,8 +520,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
>
>         /* Get host event wake mask. */
> -       ret = cros_ec_get_host_event_wake_mask(ec_dev, proto_msg,
> -                                              &ec_dev->host_event_wake_mask);
> +       ret = cros_ec_get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
>         if (ret < 0) {
>                 /*
>                  * If the EC doesn't support EC_CMD_HOST_EVENT_GET_WAKE_MASK,
> @@ -556,7 +551,6 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         ret = 0;
>
>  exit:
> -       kfree(proto_msg);
>         return ret;
>  }
>  EXPORT_SYMBOL(cros_ec_query_all);
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 5169bf33360b..cdedbdfc1885 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -194,7 +194,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -207,7 +207,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For fill_protocol_info() with passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -255,7 +255,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -273,7 +273,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, ec_dev->dout_size, 0xbe + EC_MAX_REQUEST_OVERHEAD);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For fill_protocol_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -348,7 +348,7 @@ static void cros_ec_proto_test_query_all_no_pd(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -364,7 +364,7 @@ static void cros_ec_proto_test_query_all_no_pd(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For fill_protocol_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND,
>                                                     sizeof(struct ec_response_get_protocol_info));
> @@ -375,7 +375,7 @@ static void cros_ec_proto_test_query_all_no_pd(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -387,7 +387,7 @@ static void cros_ec_proto_test_query_all_no_pd(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For fill_protocol_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -411,7 +411,7 @@ static void cros_ec_proto_test_query_all_legacy_normal(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND,
>                                                     sizeof(struct ec_response_get_protocol_info));
> @@ -433,7 +433,7 @@ static void cros_ec_proto_test_query_all_legacy_normal(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -771,7 +771,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>         /* Set some garbage bytes. */
>         ec_dev->host_event_wake_mask = U32_MAX;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -787,7 +787,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For fill_protocol_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND,
>                                                     sizeof(struct ec_response_get_protocol_info));
> @@ -819,7 +819,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For fill_protocol_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -831,7 +831,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For fill_protocol_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> --
> 2.36.1.255.ge46751e96f-goog
>
