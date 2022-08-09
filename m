Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97358D6A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiHIJlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiHIJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:41:33 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87512222B5;
        Tue,  9 Aug 2022 02:41:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i4so8131660qvv.7;
        Tue, 09 Aug 2022 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ci2ls7U2nuSCUe0dlH3AzImlyXCli4yH62m5As59nY8=;
        b=FpTSUdjzNKGxsQw4Qr9Sw2khzp61ywT2GjN+Y47mcY+i8NsVEPI2HedFE7RWONyyfp
         0Ho3kRzV5BtCtmmQkoYSTbVljV85r3JQ2y1FC3sxzjJ3wHf/nBPXkV0YByj6BcNydB/H
         SyBcq51WqRLu5X9kVO470kXSsu7Khz3nUmPPDwNk2gmRVgY5/447yW4eQx6iVaQOlQAG
         Jomn3U066VaN2wzXYSHiZHwdPZ24kmKdoefGi/8tpwasjVxIYE2aENZNKfZl+6Gb8APA
         FDd3SQRY4682fwmAdh4PXs9Vnh56Squg5Qkj+/hJVqYiV6Dxen0INiDr/ffFC4AtgeCr
         CKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ci2ls7U2nuSCUe0dlH3AzImlyXCli4yH62m5As59nY8=;
        b=NrpFArST3DIqJUJLR0uucSr9LC6ohsCvG8h5DrSJnj+AuVaXvhcGD/ltztJOchnb8a
         5DdCqShexk/eP6+qHJJgLYpSES1vTjkGJN+qv9+kLeERmqRiegKbNBJQe1WyZkGQJZUX
         R8kyvtjNE1+9PzID1caBEfGTjbr7LuYxttw31zU4EgByQqlFHCCv5Jb81CPbp5+c0Rlh
         khboNGTMmkIJ2Wl6OW8C9ko1NeJWWaeE150+N2ViUZIsmxlT/EK6SLxTg1si89PGIjf8
         FL380oWBtnQhBQjBoqzTGA0SFBGkxNinG3IuE56RN3gq7UWyYx/Fia2hZFKLG/Qwd94E
         XRaw==
X-Gm-Message-State: ACgBeo2YUg+SgGF0GIba6KA6NCGOu6lUILfGCP2c1nq9eU+zdhEvg3G2
        e1ddSdg7zBaOqjpLcZ98HWdL+q9EJKaEzZplcjM=
X-Google-Smtp-Source: AA6agR4csQGQVizYsqrcvJGOpMqckJzg5kR2dW30zWgr1UqpI/7Tkg4pVVnw1mUPpeciubqQIbAU8SaX5SxEdRL5dHA=
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id
 iu3-20020ad45cc3000000b004748ddadfb6mr19208051qvb.82.1660038091542; Tue, 09
 Aug 2022 02:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
 <20220809073648.167821-5-marcus.folkesson@gmail.com> <CAHp75Vc-cd_-+qyd62tcJGdXh917AgZY5VB0ztXR3zwrGoMCRQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc-cd_-+qyd62tcJGdXh917AgZY5VB0ztXR3zwrGoMCRQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:40:55 +0200
Message-ID: <CAHp75VdhdpKasyYrb1tkhL6yjfZwMcbWJYNc9bw8LDr7KLT6jw@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] iio: adc: mcp3911: use resource-managed version of iio_device_register
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 11:39 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

...

> You may rather switch to devm_clk_get_enabled() and drop this.

While doing this I would recommend to split the regulator case and clock case.

-- 
With Best Regards,
Andy Shevchenko
