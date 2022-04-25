Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16150EB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbiDYVUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiDYVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:20:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC73A5F9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:17:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so14346023edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MjmPAa3fuV4x9AO1hWu5W5LzK42h/xrrV3+xEL5r7Q=;
        b=W/yNy5Lne60psuJAyN141Qys5/VAQk7y/70nMc2zXcz9rKyq+1Z/+Rh3d7evsUbeg2
         bMNGAtB5OaeBS4zXipeKAaEZmEuOIIWW8kdGXceL2YIUzgsXNicxArZpPJ+ENcwVDtQR
         tzYpaGfNchGoL6bLTUO8R8NA8CW1AS+fOZPuCHA5lsqISiEB5+X85SwLCF/9XY8w2q1S
         qFsOIbMyRKjM6Ili/BKpuDrALDDKhxu2Va8K4wQ95l3r2tiFxQVOEQImdZQwqNcZtn6n
         O+RPAqdpixPpDWjsTl0Jf2l/zo8MwF73fMGrZXED3KhYL/m+9fmkp6sZgIaI+PSFjD1E
         z5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MjmPAa3fuV4x9AO1hWu5W5LzK42h/xrrV3+xEL5r7Q=;
        b=apFtpHyGkuJ3osPvq4I08hWdoFnT5okfiFAxEe37B0xMf/XFd7SwPLY8DjKsfRH9f0
         0PV0WJ2Qp7FBn4s16F7rRi7kMuSTrBi3UK/nHGjsK11LDuXiJCv/DAfVmP51EwY0BPb5
         U/7TC/Gd6T5RzYfR3jTA5VlQWRfTnL5vkcZVQVqZAyJImSPbWCWJOAdso4meUDSXy3Cc
         3prJUDFQKeDx49BP2L2WZ2e2nfAOzMNXTrlfwL4UO+s9pJZaI5WE7NnA78RBcPoEo18v
         4TxoFMH7NmNvLO5bliCaTJz6BxgGyPVCoK4km1m3frYjbVYyGn/crKi2NX9E+0poas6S
         Spnw==
X-Gm-Message-State: AOAM531EFQXipugcmGCreJ09Di88+Cn65jv7W26hb1O2njaV8dO3KVGT
        1sYAe2zADF62blXcoe1a4IqtnPbXhKDmo3jkUCFQ65UwOahs3g==
X-Google-Smtp-Source: ABdhPJx9cLKOfXpy6EJ6RwXdWQqyZdTcjXPpujIWqZxKX1TvWL9hA+z/+woQ9jrT5Nb+lYH1xyFrEpFrBCRURXo9rPE=
X-Received: by 2002:a05:6402:34c7:b0:423:d44a:4c6c with SMTP id
 w7-20020a05640234c700b00423d44a4c6cmr21153822edc.356.1650921456451; Mon, 25
 Apr 2022 14:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220425210726.3813477-1-swboyd@chromium.org>
In-Reply-To: <20220425210726.3813477-1-swboyd@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 25 Apr 2022 14:17:25 -0700
Message-ID: <CABXOdTeAdi4ifPaA--_UfjP3=UShJUuruuOQmWKq0Dc7DVLa4g@mail.gmail.com>
Subject: Re: [PATCH v2] Input: cros-ec-keyb: Only register keyboard if
 rows/columns exist
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
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

On Mon, Apr 25, 2022 at 2:07 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the device is a detachable, we may still probe this device because
> there are some button switches, e.g. volume buttons and power buttons,
> registered by this driver. Let's allow the device node to be missing row
> and column device properties to indicate that the keyboard matrix
> shouldn't be registered. This removes an input device on Trogdor devices
> such as Wormdingler that don't have a matrix keyboard, but still have
> power and volume buttons. That helps userspace understand there isn't
> a keyboard present when the detachable keyboard is disconnected.
>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes from v1 (https://lore.kernel.org/r/20220413033334.1514008-1-swboyd@chromium.org):
>  * Use device_property_present
>
>  drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 6534dfca60b4..ceb23e2e0d94 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -537,6 +537,15 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
>         u32 key_pos;
>         unsigned int row, col, scancode, n_physmap;
>
> +       /*
> +        * No rows and columns? There isn't a matrix but maybe there are
> +        * switches to register in cros_ec_keyb_register_bs() because this is a
> +        * detachable device.
> +        */
> +       if (!device_property_present(dev, "keypad,num-rows") &&
> +           !device_property_present(dev, "keypad,num-cols"))
> +               return 0;
> +
>         err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
>         if (err)
>                 return err;
>
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> --
> https://chromeos.dev
>
