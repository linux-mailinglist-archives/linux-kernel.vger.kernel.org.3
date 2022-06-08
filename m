Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709A5438C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbiFHQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245385AbiFHQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:21:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7E4B1E5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:21:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fu3so40973002ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0c4Gn5I2o58WzgwyMKPBdqh6wLqRLIJsSDMIz4+N3Ok=;
        b=DItdxYRWi3rvmBKzbNyNp6ydZfygezeGVUwXWW3R4zL3sDQX0eu4zKDMQaTmGD+mfi
         n6/XUw99yJ9wCdlG9nLmYQbUmnObMKeRMTqJRRg6/x9tB9ASK5DZhZiPytABpzd+FAYG
         pqqPMawkMLbY5rQyUtJFO+nbAD/q16eFWXwgwdj2cpPUrGf6jqfc0gD1pevDSh1Q/mof
         yY1MvML2FH95AEVyyulYw76e1dkyms2rvEmHCsi3A6BZP9/t3BXkpBsMWSWRRxhWVOcl
         oN8Y/LOwTYxAbfYA9Vhoy128wkeXy8dy5pGVOWZJC3dEAnWLEKAsIkYRv7gTBvL1cCpT
         Dlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0c4Gn5I2o58WzgwyMKPBdqh6wLqRLIJsSDMIz4+N3Ok=;
        b=vfCl+R4VmniXy/liGve7OsFoQcys3j01w/1qe+lNzQJKw36gSTreoAuJRjSeVq+dMh
         oPR2uG6fIU8Le1YZH1Qk1bKjO927eD+dAUZvtqCXqqLa5zOPi+gLhN0OmCg9NTIBt/uV
         +81c0wJmXkZ5KcbFl6QOPCHpcooDaWTn1KDvZXdwNHcBJzaRuiaGYMcEhMjIWSm+Vrw1
         faZvmj/NUIDrS1cp2+aZtbz4gpt5N/ZI7+QwB3FOLiMptxGjznPTA9d7jYotHT17dzO8
         iBH19yyvO/pcc1S5OEiRfbdgKGkqW8KQ6VRm6drifif2q8g4lBN5/z/oQdS6FTK2XXsF
         JE7g==
X-Gm-Message-State: AOAM5334mrkIf4DaESXZy4ryVQrxyffUVf0BTG80uodsh9hhbH97UEOX
        GTKRE7Kwnbp6wWhPpRvOoEza7x77ASJY8FJAPGYXSQ==
X-Google-Smtp-Source: ABdhPJyF/2uThEWGuPqdkmfGF5GVHZWauHBFomIZVrjEeecusT1Hiy/CdpkwwFC8rio5G1nCAgQ4INubOL4IZiiNMJo=
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id
 nb40-20020a1709071ca800b0070c68cedademr29476068ejc.723.1654705282368; Wed, 08
 Jun 2022 09:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-18-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-18-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:21:10 -0700
Message-ID: <CABXOdTd=LgPysNBejqF3tGxX2Ze6caSW=DAOrgRo_Y-CaPJJsw@mail.gmail.com>
Subject: Re: [PATCH v3 17/23] platform/chrome: cros_ec_proto: add Kunit test
 for getting cmd mask error
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
> cros_ec_query_all() uses cros_ec_get_host_command_version_mask() to
> query the supported MKBP version; cros_ec_get_host_command_version_mask()
> uses send_command() for transfering the host command.
>
> Returning >=0 from send_command() only denotes the transfer was success.
> cros_ec_get_host_command_version_mask() should check if EC wasn't happy
> by checking `msg->result`.
>
> Add a Kunit test for returning error in `msg->result` in
> cros_ec_get_host_command_version_mask().  For the case,
> cros_ec_query_all() should find the EC device doesn't support MKBP.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No v2.  New and separated from the original series.
>
>  drivers/platform/chrome/cros_ec_proto_test.c | 89 ++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index ec106d0f5648..eb6d77b95c9f 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -892,6 +892,94 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>         }
>  }
>
> +static void cros_ec_proto_test_query_all_no_mkbp_return_error(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +
> +       /* Set some garbage bytes. */
> +       ec_dev->mkbp_event_supported = 0xbf;
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               struct ec_response_get_protocol_info *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               /*
> +                * Although it doesn't check the value, provides valid sizes so that
> +                * cros_ec_query_all() allocates din and dout correctly.
> +                */
> +               data = (struct ec_response_get_protocol_info *)mock->o_data;
> +               data->max_request_packet_size = 0xbe;
> +               data->max_response_packet_size = 0xef;
> +       }
> +
> +       /* For cros_ec_get_proto_info() with passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       cros_ec_proto_test_query_all_pretest(test);
> +       ret = cros_ec_query_all(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_protocol_info));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       /* For cros_ec_get_proto_info() with passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command,
> +                               EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
> +                               EC_CMD_GET_PROTOCOL_INFO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_protocol_info));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       {
> +               struct ec_params_get_cmd_versions *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_cmd_versions));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
> +
> +               data = (struct ec_params_get_cmd_versions *)mock->i_data;
> +               KUNIT_EXPECT_EQ(test, data->cmd, EC_CMD_GET_NEXT_EVENT);
> +
> +               KUNIT_EXPECT_EQ(test, ec_dev->mkbp_event_supported, 0);
> +       }
> +}
> +
>  static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>  {
>         struct cros_ec_proto_test_priv *priv = test->priv;
> @@ -1185,6 +1273,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_query_all_legacy_data_error),
>         KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return0),
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
> +       KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp_return_error),
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
>         KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
>         {}
> --
> 2.36.1.255.ge46751e96f-goog
>
