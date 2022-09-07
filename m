Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07245B0779
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIGOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIGOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:49:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDF4DB32
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:49:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l14so7454228eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9Egso+F9oAqpmnjS5DTHauVPwDLq9mb6P2D6VOioG74=;
        b=GJH3rh/Lggajl8hpTEBX35JHXSivg85bmb3IntirQOIXPUYhecuXuFTAKNkeGZKElr
         1zTyVTl0dikamJeacrK4dDipNLeX7crqRfTO8j5DILmwXbMmL0L6KzfdoYlgxfQncEAA
         naE3Kl4csXUkopC68eMXzq+655Nj2N3VmW7Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9Egso+F9oAqpmnjS5DTHauVPwDLq9mb6P2D6VOioG74=;
        b=X1/TY03M/G0ye/pU0zlAQVHKUMwvuXlxjVIuNIrcNrOMA+afVM0c+Kk0X47IEf3d4i
         m3FWyiHL7dHbt3f5siaUE0ZQZHM0D/x/svkjEj72dS04NpVzjkrxH5DEdvZ+cN9K9oj/
         R8Z/ZZLtF4jg5Zd3XNDri1a++fwZHVRWr23dOH3nJPlwrr79onh+2Upzy7vDKjsDEoHW
         I9gjWKCgR6CJtp+2oUe6OUMeS0VMhTgMEJcWiFNNfiGwMeah0wDd+xfGZRpqb+Yn1kAc
         tQfpHYYUlR2qHbx4G3DQF0jWm5Xk8b44pNHIdlAl+tESKqLKDJElB+0lOsXShhiKlxs1
         k2Cg==
X-Gm-Message-State: ACgBeo1CEF/cblhPsCBD59gZfD+RvOUWN7ZK+yy/7CI9pqKiSlnUwVTF
        PRjzDVvVs+swL00sdBdlwccmVNcvdb1rvkyw
X-Google-Smtp-Source: AA6agR73g1kTTuIOxdPGTgjE+7Vcb2SCt4g6WTXZIzxraQSgYsJ7oNQ5HJf1Q7h4abYY2B2t79HoRw==
X-Received: by 2002:a17:907:9814:b0:73d:8afe:6039 with SMTP id ji20-20020a170907981400b0073d8afe6039mr2575635ejc.566.1662562188195;
        Wed, 07 Sep 2022 07:49:48 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0073ae9ba9ba8sm8456081ejd.3.2022.09.07.07.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:49:46 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id bj14so7509977wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:49:46 -0700 (PDT)
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id
 z12-20020a5d4d0c000000b00228cd9f5a4cmr2462176wrt.138.1662562186396; Wed, 07
 Sep 2022 07:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
In-Reply-To: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Sep 2022 07:49:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEkPfU9wjwGrp59QJDAspUbWwmOTSZfE1Y5PWt1w309w@mail.gmail.com>
Message-ID: <CAD=FV=XEkPfU9wjwGrp59QJDAspUbWwmOTSZfE1Y5PWt1w309w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 6, 2022 at 10:52 PM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> Add an elan touch screen chip eth3915n.
> This chip requires more delay time than the eth3500.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)

Technically that's not true. You changed your Signed-off-by between v1
and v2. That would be something to mention in the changelog.

Also: I suspect that when a maintainer lands your patch that they'll
get into trouble. That's because your email was sent from
"yunlong.jia@ecs.corp-partner.google.com" but your "Signed-off-by" was
"yunlong.jia@ecs.com.tw". If I try grabbing your patch from the
mailing lists, applying it, and then running it through "checkpatch":

 ./scripts/checkpatch.pl
0001-input-touchscreen-elants_i2c-Add-eth3915n-touchscree.patch
WARNING: From:/Signed-off-by: email address mismatch: 'From: Yunlong
Jia <yunlong.jia@ecs.corp-partner.google.com>' != 'Signed-off-by:
Yunlong Jia <yunlong.jia@ecs.com.tw>'


If I had to guess, the problem is with Google's SMTP servers. If you
logged into the SMTP server with your "corp-partner" address then
Google's SMTP server will automatically re-write your "From" address
to be whatever address you logged in with. I'd guess your options are:

1. Use an official SMTP server for "ecs.com.tw"

...or...

2. I _suspect_ that it will work to set the git config
"sendemail.envelopeSender" to
"yunlong.jia@ecs.corp-partner.google.com". I haven't tested this but I
think it'll work.

Note that when you send a v3, make sure to carry David Heidelberg's Ack.

-Doug
