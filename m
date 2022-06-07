Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E0541CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382594AbiFGWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378807AbiFGVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:01:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762920ED52
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:45:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so29777042ejx.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McvS43/j6GRD/cbarNGkzV1RLB0K56f9Y1z9J33bZkc=;
        b=D3gqQ56jhvTkYWs/+MKcVrFgQ3+awTVy8k+23TpUWxlnM08XfxWefqSSh0u6Ei4Ytb
         uI6l7fheTH9OkwsT5/SeM7ZNDT5+mi7ddBTTAtyoZ/Y4Agzp95giUo6fuRyRvm1+2U+F
         +hOUwVdXAoUyeTOZLYtMUUef8zf7IInyqh3YBgwUAjbXOPX0hyNIRYK5olyDLoZr5x3G
         HAX2jBzdsztg2Eyx2FE4SyAYNia7sYUalVYZFs7+voPq5r6gdnwFfTcTaPWRorPe/b/N
         vp3OI1nJSS8ArKYC29RQyJ+7CeonymSGkQYTWc1JMQ6wv7DWgSWkP2rRQkynddfppnDj
         fcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McvS43/j6GRD/cbarNGkzV1RLB0K56f9Y1z9J33bZkc=;
        b=4H88AstTH2EaC/I9tWWxywl9K0NVLssUjSVdn10vT8fyNHxUrE2JkuoCnJVWcMX+nc
         pTht0CZjdgnB4wpWU2Prc7k9HBqlkzucbCz5aYWrM59HCDgu+727zyVQukqIihEV2565
         vOTmXUqRG3euAUBOXe4dSN/z04B/lDUgPVhs44v/DFDWBjeVzVZwXx23OAjaXCcAOwDa
         ay8DceUY6e4Cav5qFJZ6xXJL2oTVLhHWrMMpRA8aaI2E2IWce+iE7YgsrVzyASYJxEic
         XljvuLGR5tWnI+2oRKKYqAEQ3Vzu9MsKIJuKW5Tna5QfnmkxbAv2oSlvBaa4h48zyiXG
         hHUQ==
X-Gm-Message-State: AOAM530wSKcqxUel0JY2U7Inu9NfVuUi7fTeBCY7w2RRmRpgzILj0Oe/
        hrJclMgL4lx+UJ2c8iQizTKaGAqqnWtrCu1uzEHkYQ==
X-Google-Smtp-Source: ABdhPJzpaPCNnuJPs99p7zgzaUGfehX3brtkfPnsLtg+6+3YVVu+wtaydWe0fahOUH9/ItB1aE9FZAfmb1XpRRzVDac=
X-Received: by 2002:a17:906:85cb:b0:70b:ffb4:b0e with SMTP id
 i11-20020a17090685cb00b0070bffb40b0emr24599340ejy.533.1654627537270; Tue, 07
 Jun 2022 11:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220607145639.2362750-1-tzungbi@kernel.org> <20220607145639.2362750-8-tzungbi@kernel.org>
In-Reply-To: <20220607145639.2362750-8-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Jun 2022 11:45:24 -0700
Message-ID: <CABXOdTcO6xLoXdNXL_Djqb6DOLtiNB22m+Ag2sjU-ssTJ0ss7g@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Rename cros_ec_host_command_proto_query() to cros_ec_get_proto_info()
> and make it responsible for setting `ec_dev` fields according to the
> response protocol info.
>
> Also make cros_ec_get_host_event_wake_mask() allocate its own message
> buffer.  It was lucky that size of `struct ec_response_host_event_mask`
> is less than `struct ec_response_get_protocol_info`.  Thus, the buffer
> wasn't overflow.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v1:
> - Preserve the "cros_ec_" prefix.
>
>  drivers/platform/chrome/cros_ec_proto.c      | 134 +++++++++----------
>  drivers/platform/chrome/cros_ec_proto_test.c |  56 ++++----
>  2 files changed, 93 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 71ba6a56ad7c..893b76703da6 100644
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
> +static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
>  {
> -       /*
> -        * Try using v3+ to query for supported protocols. If this
> -        * command fails, fall back to v2. Returns the highest protocol
> -        * supported by the EC.
> -        * Also sets the max request/response/passthru size.
> -        */
> -       int ret;
> +       struct cros_ec_command *msg;
> +       struct ec_response_get_protocol_info *info;
> +       int ret, mapped;
> +
> +       ec_dev->proto_version = 3;
> +       if (devidx > 0)
> +               ec_dev->max_passthru = 0;
> +
> +       msg = kzalloc(sizeof(*msg) + sizeof(*info), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
>
> -       memset(msg, 0, sizeof(*msg));
>         msg->command = EC_CMD_PASSTHRU_OFFSET(devidx) | EC_CMD_GET_PROTOCOL_INFO;
> -       msg->insize = sizeof(struct ec_response_get_protocol_info);
> +       msg->insize = sizeof(*info);
>
>         ret = send_command(ec_dev, msg);
>         /*
> @@ -299,15 +305,45 @@ static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
>                 dev_dbg(ec_dev->dev,
>                         "failed to check for EC[%d] protocol version: %d\n",
>                         devidx, ret);
> -               return ret;
> +               goto exit;
> +       }
> +
> +       mapped = cros_ec_map_error(msg->result);
> +       if (mapped) {
> +               ret = mapped;
> +               goto exit;
>         }
>
> -       if (devidx > 0 && msg->result == EC_RES_INVALID_COMMAND)
> -               return -ENODEV;
> -       else if (msg->result != EC_RES_SUCCESS)
> -               return msg->result;
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
> @@ -417,51 +453,13 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
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
> +       if (!cros_ec_get_proto_info(ec_dev, CROS_EC_DEV_EC_INDEX)) {
> +               /* Check for PD. */
> +               cros_ec_get_proto_info(ec_dev, CROS_EC_DEV_PD_INDEX);
>         } else {
>                 /* Try querying with a v2 hello message. */
>                 ec_dev->proto_version = 2;
> @@ -524,8 +522,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
>
>         /* Get host event wake mask. */
> -       ret = cros_ec_get_host_event_wake_mask(ec_dev, proto_msg,
> -                                              &ec_dev->host_event_wake_mask);
> +       ret = cros_ec_get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
>         if (ret < 0) {
>                 /*
>                  * If the EC doesn't support EC_CMD_HOST_EVENT_GET_WAKE_MASK,
> @@ -556,7 +553,6 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         ret = 0;
>
>  exit:
> -       kfree(proto_msg);
>         return ret;
>  }
>  EXPORT_SYMBOL(cros_ec_query_all);
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 628c6582ca78..14a4441a39fc 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -194,7 +194,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -207,7 +207,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -255,7 +255,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -273,7 +273,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, ec_dev->dout_size, 0xbe + EC_MAX_REQUEST_OVERHEAD);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -351,7 +351,7 @@ static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
>         /* Set some garbage bytes. */
>         ec_dev->max_passthru = 0xbf;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -367,7 +367,7 @@ static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -377,7 +377,7 @@ static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -389,7 +389,7 @@ static void cros_ec_proto_test_query_all_no_pd_return_error(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -413,7 +413,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -434,7 +434,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -478,7 +478,7 @@ static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -495,7 +495,7 @@ static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ret, -EIO);
>         KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -526,7 +526,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -543,7 +543,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ret, EC_RES_INVALID_COMMAND);
>         KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -574,7 +574,7 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
>         struct ec_xfer_mock *mock;
>         int ret;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -596,7 +596,7 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ret, -EBADMSG);
>         KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -630,7 +630,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>         /* Set some garbage bytes. */
>         ec_dev->mkbp_event_supported = 0xbf;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -646,7 +646,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -667,7 +667,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -679,7 +679,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -723,7 +723,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>         /* Set some garbage bytes. */
>         ec_dev->host_sleep_v1 = true;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -739,7 +739,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -766,7 +766,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -778,7 +778,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -829,7 +829,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
>         /* Set some garbage bytes. */
>         ec_dev->host_event_wake_mask = U32_MAX;
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 struct ec_response_get_protocol_info *data;
>
> @@ -845,7 +845,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
>                 data->max_response_packet_size = 0xef;
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -873,7 +873,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
>         ret = cros_ec_query_all(ec_dev);
>         KUNIT_EXPECT_EQ(test, ret, 0);
>
> -       /* For cros_ec_host_command_proto_query() without passthru. */
> +       /* For cros_ec_get_proto_info() without passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -885,7 +885,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query() with passthru. */
> +       /* For cros_ec_get_proto_info() with passthru. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> --
> 2.36.1.255.ge46751e96f-goog
>
