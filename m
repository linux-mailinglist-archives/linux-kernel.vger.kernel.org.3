Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70E5883D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiHBV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiHBV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:57:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC51AF23
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:57:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so11544725edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iErLUqQt0QpWnjCPSCabDR6OOKvgu8mEY10yTyCcHLg=;
        b=YtOAJ/9dRfKsfmxdRQChT6LeIzaAmIN1IXVER+bUFlzRTjdkQd1fVBBtmpPo8/09CJ
         +jYJlwdnnY5mBKg6eY+TbHgNQbmwghsNgYxFV5llylDF3n8foSg9ThNqBFtyMG0awlZx
         r7xJM70/Bhah7X6YbwBs+sb1Lo99xoc6z/hQAE2mFdKYECs+QSXlJyMM/a2gcAzr/lH6
         Nv5xj1Aa+LaOSGCHYScrdlmCjLqAnm5PCVyChxLX/q5SC9BXrfbh/DpLvfArWtJBtmoi
         MaMdBJ8O8vYMjGhcAAowIT8zELBJreF082j+43qCvLHkD5VL9aqSvCYfuWNcDdM6zqt3
         AhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iErLUqQt0QpWnjCPSCabDR6OOKvgu8mEY10yTyCcHLg=;
        b=R3/cGHi6dqNr0gZUbRKYY3mwCfDk2ukydvinN18rVXvQ7uLAVW2+bKwaspm41xlPey
         2vGPQq7FtKc1qrFmOiOY6qf9OOvJ+VW6/MFBO67TUBNy9tNxwcLbDbn338QtcQAyQFjC
         xOTy1oWGp+QiYGW716RAC140ccXlxI9pWLOevniSpwt5xPtIqlUHHeM4vb/XwnUCTvDk
         zAvag0zZkyOOUCkOs9nKPMAysoADx/4zEKKbFZDxIGhaP6VvYdXt8JUPy1HljxuyQSn6
         YBaUe5W8UjYSx3oSIsLEcCe2VymeMwcMc8anvLRoEGH1MLngsNz5bj+83NVFqEovaJ8T
         X/mw==
X-Gm-Message-State: ACgBeo2wBM67GgNYBK5lsvpj/RrbC/LTXGml9K9OIE0jbnZIuCYOErAu
        UN9qMKiNGcPEj4Q9h3Ek2Y7dcJsiSB6uWBbReCy/7Q==
X-Google-Smtp-Source: AA6agR7Iq/NhQ4VL1e2mBRNVeVHP/OQ/xEhKiETJ37KAE2ZtD20dq/lcNTdMrvjwAUaMXOKqzd1xH3c4eI/GaTuBgP0=
X-Received: by 2002:a05:6402:4385:b0:43d:4820:4532 with SMTP id
 o5-20020a056402438500b0043d48204532mr17798591edc.233.1659477470934; Tue, 02
 Aug 2022 14:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220802212621.420840-1-mairacanal@riseup.net> <20220802212621.420840-3-mairacanal@riseup.net>
In-Reply-To: <20220802212621.420840-3-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 14:57:39 -0700
Message-ID: <CAGS_qxqBCjcX1iL9D_1pCM47pN+OwRG7=Pfd2DWyzwFNFJhkgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 2, 2022 at 2:26 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> Increament the example_all_expect_macros_test with the

nit: typo ("Increment")
But "Augment" would be a bit more idiomatic here

Sorry I didn't catch this one in v1.

> KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros by creating a test
> with memory block assertions.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!
Just a couple very small nits (one above, one below).

> ---
> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to =
make
> it easier for users to infer the right size unit (Daniel Latypov).
> - Replace a constant number of array elements for ARRAY_SIZE() (Andr=C3=
=A9 Almeida).
> - Rename "array" and "expected" variables to "array1" and "array2" (Danie=
l Latypov).
> ---
>  lib/kunit/kunit-example-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index f8fe582c9e36..8a9b0eeb1934 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -86,6 +86,9 @@ static void example_mark_skipped_test(struct kunit *tes=
t)
>   */
>  static void example_all_expect_macros_test(struct kunit *test)
>  {
> +       const u32 array1[] =3D { 0x0F, 0xFF };
> +       const u32 array2[] =3D { 0x1F, 0xFF };
> +
>         /* Boolean assertions */
>         KUNIT_EXPECT_TRUE(test, true);
>         KUNIT_EXPECT_FALSE(test, false);
> @@ -109,6 +112,10 @@ static void example_all_expect_macros_test(struct ku=
nit *test)
>         KUNIT_EXPECT_STREQ(test, "hi", "hi");
>         KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
>
> +       /* Memory block assertions */
> +       KUNIT_EXPECT_MEMEQ(test, array1, array1, sizeof(u32) * ARRAY_SIZE=
(array1));
> +       KUNIT_EXPECT_MEMNEQ(test, array1, array2, sizeof(u32) * ARRAY_SIZ=
E(array1));

Note: the following would be equivalent
  KUNIT_EXPECT_MEMEQ(test, array1, array1, sizeof(array1));
  KUNIT_EXPECT_MEMNEQ(test, array1, array2, sizeof(array1));
I think now we've dropped the use of "array equal", sizeof() is also
generally more appropriate.

We could also optionally prefix these with
  KUNIT_ASSERT_EQ(test, sizeof(array1), sizeof(array2));
if we want to be extra paranoid here, but I don't think that's really neces=
sary.
