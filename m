Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596D0586649
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiHAIXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiHAIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:22:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306F32445;
        Mon,  1 Aug 2022 01:22:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy29so18884271ejc.12;
        Mon, 01 Aug 2022 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kjv0FJlI0lUU+rmPW0iCxfcBjoloU4HFBTK1BDc1WhU=;
        b=SGiD99rnB9w5Lo0zaLyFYjCLUr+HfzQo4L/onIg5UCJ2abXcfrLk0Q2J/0NhGPIOl5
         SxD7lkaGT75emAzQMOxY9SUdrDlDVUjzTEue0ynK8FRv5kPZFW2ayGmoNxxeliKJFp/j
         5/S5bOQSX/Z7HFoP8EgvaxtAuDmKTtAJSoGK2a/AOcUnPis74wVBWkq9zDVXRgbiUSkZ
         PWcapOxkFwNmFo2XT+47qaSwM9FjED5PGr+RFo/NrutdgfZ4ak0242zDBlgSWDTzpfew
         NW1KJ9UWEpRlj37b5SyFi5Bt+lex0J00UJ/VsTNalRTVRp5W/P0/e51LNfs/JY9CDWI5
         2XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kjv0FJlI0lUU+rmPW0iCxfcBjoloU4HFBTK1BDc1WhU=;
        b=5m70kx+5NY2MGTWdvU1K+HLvQ3DwpKoHAeQpTODE/X5vy75lRzLJIA9EPWY0/e0uSi
         eN+xSbLv67RctiRsQ0lxulLGxThJ9QlrvQHKp9dJhCxVk15LT65EkCLOtdeca08ZAxC3
         0qu42U/QFFPUpCfZV45SxISuq9co7XQwswWV/oEvGlQlNYALjzydCxYQYu5/1DMV5QzQ
         KoIH3De11UAr0ZK1087ZJ2oAxgi+bvQrfKnyWezPFxOmxB3gr5MRIFhFIAV3dp9GhC3u
         1XmjMXvFqEzNVy92ZYwkseUgCSpktMKF9M+SO1cFPriGOxyGaZfrTR5Q/kCTpPhZr0rj
         PEhw==
X-Gm-Message-State: ACgBeo27jFZGjAoIF2t6j7dYDWBk/jhq6FmS+jsww9Z/E7OcFGM4v+l2
        EZnGWLw6s+sdLASBC5pXQtIaK+9iw6drCyW2DXA=
X-Google-Smtp-Source: AA6agR7TnWJfR8dWO6hsj+nQSrs3tXP2aeFY2812Ck5pBsJqHWm0D1IIbq2EJIDt+JhUXE4Jac0EJWA+RjmNxfjA3us=
X-Received: by 2002:a17:906:e8f:b0:730:9480:9728 with SMTP id
 p15-20020a1709060e8f00b0073094809728mr832222ejf.99.1659342173330; Mon, 01 Aug
 2022 01:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com> <20220731130959.50826fc4@jic23-huawei>
 <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com>
In-Reply-To: <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 10:22:16 +0200
Message-ID: <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 3:52 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
> On 7/31/22 20:09, Jonathan Cameron wrote:

...

> In our hardware board, we have "ti,hdc1080" as main source, and "silabs,si7020"
> for 2nd source. This two chip are locate at same bus and same slave address,
> and we want to use multiple compatibles to support both chips with single device
> node in device tree.
>
> Ex:
> compatible = "ti,hdc1099", "silabs,si7020";

This is simply broken DT, you must not put incompatible hardware on
the same compatible string. DT is by definition the description of a
certain platform. What you showed is a combination of incompatible
chips in a single DT.

> In order to support this, I need to add ID checking mechanism into the current
> hdc100x driver, so the si7020 chip will fail to probe with hdc100x driver
> (because the ID checking is not failed), then success probe with si7020.
>
> Base on you explanation, it looks multiple compatibles is not suitable in this
> case? Would you mind advise us what would be the better approach for our case?

If I may advise... fix your DT by dropping the wrong compatible item.

-- 
With Best Regards,
Andy Shevchenko
