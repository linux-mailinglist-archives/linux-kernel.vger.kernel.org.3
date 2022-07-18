Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979575783D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiGRNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiGRNgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:36:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075B1AF23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:36:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so21283787ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYapis5pL2GsM/+bQ//lPqJxu7xeZJywZkYGhYCVVq8=;
        b=kQTHiVY/U+LmzL7mCF2q7vhT3/o2VbzKA3dPYLhnZb2iyy4fmiU5txKdA0YA95Vx5Q
         w50I5ONgoWY1Mz3OGr7/NRfgks2qt9HXU5jn+n5GORo3bnaP0VcCd+Nalz3LFudj+nSb
         QdZ7BMAf2SOLoTM0cCkydANQ4/GYWRHMuYSXUtE5AmrZmF/ikrteBPDQ4UGFc9J48EFi
         /Q904GYLhgr5DyUOvHHsYdhznWznbSPx72WW69vp7RcHu6hM9vQALCr0JkTO0KM2LP9/
         lCdeSNKQW7kcS2da1INtgmU/HzXdW8ZMQ3If3qo+MPF0RAo69pT46Oj37knTGBB/rzhi
         LErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYapis5pL2GsM/+bQ//lPqJxu7xeZJywZkYGhYCVVq8=;
        b=PaQyYLANcCyfel+CvhlnWyeR2rY/zwy/XTmFBoaCnXrL2P5dQ5lhp9qZCdkyNZA9nV
         cAHR8DsxLWBbyC3fzDVYVhyHR6mhC+rsOeFaDjFr+J25ksDXnJ9NfI59Pes6KAM2I4Bc
         Z442pl0Vl2zBTENKOx4J0u8qeTKD8v/HR1Pd5zmoBcSjEgysaKfuDgAsM5JNoOrm4qtX
         XMaGDJKNfOmsNPmaCuP/PKiX5sd5WNyst00h+4uxJItWjZNU2GlaKyvLSXpzAlvpRmlY
         ApDdRCVhXPNm5sAcqlQlrCE2uJ2kNVMuHsd+Jj85rzF8K2k7v/wS5YKZvEeMxaIESCGz
         gTcQ==
X-Gm-Message-State: AJIora8W2IcKHzlMQ2uhgGvqajiaiTcz6N2/lEUB9gNPVIz5ngnBGwRI
        tHajulSGOhGScPoW09CS2X7h+UGTFTXQq67NSTAAkuhDPk8=
X-Google-Smtp-Source: AGRyM1tJE/TQhSnBw6G6m1T3lO6O2PQroT28N742q1NQ35QszkOlnDnebdAzXv0b8UdwxOew6qyKyuolj/u5fcPNZ8Y=
X-Received: by 2002:a17:907:2ce9:b0:72b:30e5:f1bc with SMTP id
 hz9-20020a1709072ce900b0072b30e5f1bcmr25123323ejc.127.1658151406372; Mon, 18
 Jul 2022 06:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220718050914.2267370-1-tzungbi@kernel.org> <20220718050914.2267370-10-tzungbi@kernel.org>
In-Reply-To: <20220718050914.2267370-10-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 18 Jul 2022 06:36:35 -0700
Message-ID: <CABXOdTcNrNdF_x8x7EVi7HvsJktPHMSLBdcuL=xSu3va-U3=_Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] platform/chrome: cros_ec_proto: add Kunit test
 for empty payload
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
> cros_ec_wait_until_complete() sends EC_CMD_GET_COMMS_STATUS which expects
> to receive sizeof(struct ec_response_get_comms_status) from
> cros_ec_xfer_command().
>
> Add Kunit test and expect to receive an error code when
> cros_ec_xfer_command() returns 0.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No changes from v1.
>
>  drivers/platform/chrome/cros_ec_proto_test.c | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index fbb872040711..d76e09b8a36a 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1934,6 +1934,36 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_return_error(struct kunit *t
>         KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
>  }
>
> +static void cros_ec_proto_test_cmd_xfer_in_progress_return0(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EPROTO);
> +
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2013,6 +2043,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_xfer_error),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return_error),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return0),
>         {}
>  };
>
> --
> 2.37.0.170.g444d1eabd0-goog
>
