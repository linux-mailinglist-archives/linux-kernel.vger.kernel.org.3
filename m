Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C4598C76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbiHRTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiHRTXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:23:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A8B02BD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:23:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f4so1868554qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=p3cR/K/0vZ/Tc7MLwc8jPl6fy/ZdfnyyXBziXqzK06w=;
        b=Qs/wldAhGABgsNVJIQVPjenaCKMwOh1tRBe4xiX0yQarkhVcyYLOCSl4hmhga/scM6
         /n/gDoix/997EQrUwp+0yzJuIjDi1FzBVfq9IdCtKfOJcFlw1DR4xaYzUhI1/ZsyHem+
         J3ahS7DKEE0mU8vIMMHgT7vHFXTaZDWjJ1w/l67r9zbPBbBEh3ZesuucM0Y+z2dkJY0L
         VwSIK2AwRyKlZisrW/4QusKCynFOeLKGvrShktVVIlRLPHqW1ioATnTi54rjiJAnVqUP
         pEtl+jFD85pGFqB+lvAnQs7VjivPX8NZJRu0BOCsCfiMNxo5ujSNoerKKjqwTcUU9dgj
         x1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=p3cR/K/0vZ/Tc7MLwc8jPl6fy/ZdfnyyXBziXqzK06w=;
        b=1WJqhsEI4K1xGzQ3BwgO/kAYqvV3eXhI5IR9T4BFdbX94SkuAdyN8ZAYDUjl6DUeL5
         FauXcYGYoZ890Jfejlj2RjuXFcj40lbKuA2dA/UrlgS84GXN3F+z7HRz8IPbgBscPkIq
         orxJzD1HJOf1oGkP1bHT2vypTdT+XhKsoEO1014tUXXhU68xH80umVXimlA+9YzZ4bwX
         U2OlkjKzZ8sYYAUoSCoMZKalaj7SQJU3eNMPN2eI1a/oz0+80JSsu8YqVOpMjcz+HH7t
         Qxzouwbka7Wcr+wFEzuDB8J/bD0REcPN5R1hV/hhBDk1crpNcEvECk1XvPlS9aaqG4Uv
         6z4A==
X-Gm-Message-State: ACgBeo3DOCpHFFuFeMq07gt+ezgHSuezXMul+RzXrIgiu0E9nEq2fWdM
        azWO9S4zYt/RkuU37GxfpP5pDxiOH1gTgvdPQaXnRiF3R8GqTg==
X-Google-Smtp-Source: AA6agR4PT/UEFyPsj0FMFVgUCVZDj0ZMBCzQUhV8GCeaTI2G6rwcPtUqRxLFN36qVnZZdMcJNAOTTxdBjzyHWGhgUcA=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr3287627qkp.748.1660850588134; Thu, 18
 Aug 2022 12:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220817200335.911-1-kabel@kernel.org> <20220817200335.911-3-kabel@kernel.org>
In-Reply-To: <20220817200335.911-3-kabel@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 22:22:31 +0300
Message-ID: <CAHp75Vcn1MXEB_+kJuR3qY8qxi6oq0pEFFSFrmKv2-tE-YP-zA@mail.gmail.com>
Subject: Re: [PATCH linux-phy v2 2/4] device property: Add {fwnode/device}_get_tx_p2p_amplitude()
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:09 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> Add functions fwnode_get_tx_p2p_amplitude() and
> device_get_tx_p2p_amplitude() that parse the 'tx-p2p-microvolt' and
> 'tx-p2p-microvolt-names' properties and return peak to peak transmit
> amplitude in microvolts for given PHY mode.
>
> The functions search for mode name in 'tx-p2p-microvolt-names' property,
> and return amplitude at the corresponding index in the 'tx-p2p-microvolt'
> property.
>
> If given mode is not matched in 'tx-p2p-microvolt-names' array, the mode
> name is generalized (for example "pcie3" -> "pcie" -> "default", or
> "usb-ss" -> "usb" -> "default").
>
> If the 'tx-p2p-microvolt-names' is not present, the 'tx-p2p-microvolt'
> property is expected to contain only one value, which is considered
> default, and will be returned for any mode.

It's very specific to a domain. NAK for putting it to the generic
code, otherwise explain how it can be useful outside of the PHY world.

...

> +       cnt =3D fwnode_property_string_array_count(fwnode, names_prop);
> +       if (!cnt || cnt =3D=3D -EINVAL)
> +               /*
> +                * If the names property does not exist or is empty, we e=
xpect
> +                * the values property to contain only one, default value=
.
> +                */
> +               return fwnode_property_read_u32(fwnode, vals_prop, amplit=
ude);
> +       else if (cnt < 0)
> +               return cnt;

You may count the values and read them all, and then check the names
and compare count to the read values. In such a case you don't need
too many (overlapped) checks. I think the current implementation is
far from being optimal. Take your time and try to get rid of 20% of
lines in this function. I believe it's doable.

...

> + * Gets the peak to peak transmit amplitude in microvolts for a given PH=
Y mode
> + * by parsing the 'tx-p2p-microvolt' and 'tx-p2p-microvolt-names' proper=
ties.
> + * If amplitude is not specified for @mode exactly, tries a more generic=
 mode,
> + * and if that isn't specified, tries "default".

Gets --> Get
tries --> try

Otherwise add a subject to the sentences.

--=20
With Best Regards,
Andy Shevchenko
