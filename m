Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D141595602
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiHPJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHPJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:15:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5BF3ECF2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:31:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 202so8548701pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pZomNtEzGUGKmXZCD2savVujU1seUHJVTQWF1eiOxNQ=;
        b=QjmEQILSFjI4Kne6cLHVWxwMBbH8TRZBTwz+LT/nsjKCXQsQsL/GH4dBb21VBnKfzs
         9O7iBv+ixAgNKPkN8httl0K9Z34Tq53RpQBNjxCDhJR68ZGqfNJxSb7ZSLiwy+gdgwUe
         Ev4+LeabykTjCmIO27EtOHkGhI16jH54LInfIm1mEULvkbQG07OE04+Uh664WlHw9bEB
         cItnNF2cDpO+8wsv0BkJ5mh34xiuTb5nSGs/rdlXQDwqtb6dHCH5o0yQpmFR5J87vqnC
         +LH/4xaTOZsE97EO6yi2ROYnZrwzImc6tGGqp4yLC0gfAb3DkR1kY2Ph9O7qpIBSCXdI
         65ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pZomNtEzGUGKmXZCD2savVujU1seUHJVTQWF1eiOxNQ=;
        b=sJKc/gI3vQsFGsF9PLncIhmK8ykpQ7O/bnBY9kCNKww2Z/cejHxuW65HSuD3w5wF0o
         Ns34WdKEpRC3wJ5hv0By/jzKhePlsWec06t0P7KHQNxSdH1KRK8D0QR3yZ++wa+kd2jX
         t5cpjSBbnUtgcsCkms/cMAAJSXOVoMmEYaIW67q3S5TBmPSp7FJO7H0HRpVzMpwmnZ0+
         xQumKoCBQqOWPt4Vr+GJa4jwUop304znouNAQ1caIiBt5PE4sGfe52FqlayYDp73b07k
         rBAvJX07whpgRLeEfQk5mn5uY57L7921AAlevZNHuZAjUfb7ibZCSTcoQvDvqCxnI+uZ
         xGqQ==
X-Gm-Message-State: ACgBeo2sRUYD3JmAuCCbjfxAFrYT8z5D33YCF7ODXGtgmgkzuUmCYKOM
        f3CbzcNIFKz7BJNP5E3w52aqlvij9eRFtOiB2D7T/g==
X-Google-Smtp-Source: AA6agR7CMyviWO+Ob4bSFymSDvQjhmLVmHYcGGzU5T6qjyiPeGUaPlrAt9Vi66x+ZK47aKX0xest2qDOiNdQtIiZaK0=
X-Received: by 2002:a05:6a00:1d9e:b0:52d:aa13:67fc with SMTP id
 z30-20020a056a001d9e00b0052daa1367fcmr19695840pfw.73.1660635066424; Tue, 16
 Aug 2022 00:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220801220931.181531-1-f.fainelli@gmail.com> <20220801220931.181531-4-f.fainelli@gmail.com>
 <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org> <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
 <fa283e3c-5b96-b0a4-95c5-a7230d16d8ca@linaro.org> <ec06e9c6-f475-fe19-9046-d57a6168e72b@gmail.com>
 <c51c360e-a73f-9333-ffa1-3461de29f41f@linaro.org> <90d37d6e-52df-149e-5691-ae7a91521482@gmail.com>
In-Reply-To: <90d37d6e-52df-149e-5691-ae7a91521482@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Tue, 16 Aug 2022 10:30:55 +0300
Message-ID: <CAGE=qrqpnbgCkn3v2KfQs=VpGw+XOXndzWh2sg=6tXbj7Y3KHQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022 at 01:23, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 8/12/22 11:41, Krzysztof Kozlowski wrote:
> > On 12/08/2022 20:52, Florian Fainelli wrote:
> >
> >>>> unless you also implied enclosing those functions under an #if
> >>>> IS_ENABLED(CONFIG_PM) or something which is IMHO less preferable.
> >>>
> >>> Are you sure you added also pm_ptr()? I don't see such warnings with W=1
> >>> and final object does not have the functions (for a different driver but
> >>> same principle).
> >>
> >> Yes I am sure I added pm_ptr() see the v4 I just submitted. I don't see
> >> how the compiler cannot warn about the functions being unused the day
> >> they stop being referenced by the pm_ops structure which is eliminated?
> >
> > I don't have the answer how it exactly works (or which gcc version
> > introduced it), but I tested it and the functions were not present in
> > the object file, thus of course no warnings.
> >
> > The driver change I am referring to is:
> > https://lore.kernel.org/all/20220808174107.38676-15-paul@crapouillou.net/
> >
> > I think the only difference against your v4 is:
> > DEFINE_SIMPLE_DEV_PM_OPS
> > and lack of __maybe_unused on the functions.
> >
> > The DEFINE_SIMPLE_DEV_PM_OPS itself adds __maybe_unused for !CONFIG_PM
> > case, but I don't think it is relevant.
>
> It definitively is relevant here. SIMPLE_DEV_PM_OPS without
> __maybe_unused results in the following pre-processed code:
>

What I was referring to is "__maybe_unused" is not relevant here. The
DEFINE_SIMPLE_DEV_PM_OPS (with pm_ptr()) are the change you need.

Best regards,
Krzysztof
