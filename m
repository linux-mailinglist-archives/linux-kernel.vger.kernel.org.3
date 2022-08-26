Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5695A2B14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiHZPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiHZPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:24:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D857DCFF8;
        Fri, 26 Aug 2022 08:18:57 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x5so1455653qtv.9;
        Fri, 26 Aug 2022 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ir9pClhHiSh9+thFreEL1bpBTTHeDK2kTUYhvRZSn1I=;
        b=YIvMvlkoqy6Ddjk4k+h0nO4nYRRCIovSaDWQ2Go+InBBpKqzYWhelaRUMWf11OXU+3
         dBrCHpKSYeBMVA1eSkuNOqD460NLrqYexVXA30kGDVWYMB+Mhw+K6NaXacfyaKbP+ode
         eVYs+YUfuS3sFPczAVaGJi/L3PixT7SE7n10apMiTQe3qzxfa6J+gINjmxqHu4A/6rxx
         umrLaDPoe0nDBmLCSHpjp1A3nrrJwtsYmqk7WVio6HUFMnAmDyVXGGz/yRGO6Vg9oAQX
         N9+fnWaz5YXUmy8UGxkg/Yltw4RYlz2qfypQbqZlck2+3lKg4UWA5BOAV+lr35AOZix4
         MsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ir9pClhHiSh9+thFreEL1bpBTTHeDK2kTUYhvRZSn1I=;
        b=Vjo3RY7fv4jS6uE6qW1Zqr4jZAVEoauj1Pr6mpaOYXPld6GvTklK70idiILaV28VOf
         KNofYLRVvMYWxhy03DOxBaEHtmlgJuzs2NPaA3UE+A9/qGeGh5blY44CIpaYzcK44j6h
         jemzQ9DlgrwQMn0V4rdLyR18YIQDw8AWfyK/jpVM8VuAUVDBtpG1yK6HWasZTzkOaU00
         9UI9R8C6EY2asi3uW933meU3rulp1feXetMseEJBZmkUxJVeqENVgiato6MMKym8CnAr
         +GIasHZ+J4Oun5yyMHvL9i2POv4YXptVxZp8K2OMEcZl9/cZ2usGZ3bUfdP8JktbDfzR
         0Hwg==
X-Gm-Message-State: ACgBeo1oVo84zsKu1nowF3susGL8+e7p5FmWHNXeTXbtP41i5jDy8kcs
        H1w/jb7auIieeLYcyeoCPmnbPL4F5qcYCokV45U=
X-Google-Smtp-Source: AA6agR4UCrZD21JUkGpHAkQLjM5NAmWv2LS38onN0nlK38RIv7t8Cv6mTPpy9oKZJWTzJt560Y6E94qEAWNXs/nSBvk=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr156849qtx.61.1661527136190; Fri, 26 Aug
 2022 08:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220825144012.24a33bb0@endymion.delvare> <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
 <20220826124603.4a28a154@endymion.delvare>
In-Reply-To: <20220826124603.4a28a154@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:18:20 +0300
Message-ID: <CAHp75VcGopXaksmvXP_vMM-iGK0o_g5Fw_F5zvH+PXcCUx_cDQ@mail.gmail.com>
Subject: Re: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
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

On Fri, Aug 26, 2022 at 1:46 PM Jean Delvare <jdelvare@suse.de> wrote:
> On Thu, 25 Aug 2022 23:12:43 +0300, Andy Shevchenko wrote:
> > On Thu, Aug 25, 2022 at 3:54 PM Jean Delvare <jdelvare@suse.de> wrote:

...

> Now I'm curious, is there a well-defined subset of device names that
> can be found in an ACPI table? If not, does that mean that any driver
> with an OF entry could match,

Yes, anything can be matched by ACPI with any of the compatible strings.

> therefore of_match_ptr() should be
> removed from the kernel entirely?

In most cases yes, like for discrete components that can be connected
to any SoC on ACPI/DT/whatever platform. But for some cases it still
makes sense: platform is known to never be non-OF, component is known
to be used only on such platforms, etc.

-- 
With Best Regards,
Andy Shevchenko
