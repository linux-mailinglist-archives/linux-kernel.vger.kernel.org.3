Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23A53D730
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiFDOSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiFDOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F033E17;
        Sat,  4 Jun 2022 07:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A463B60C13;
        Sat,  4 Jun 2022 14:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2766C385B8;
        Sat,  4 Jun 2022 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654352293;
        bh=D5lPavrfLD0VtXRKigqWh1Y8dtn2cjHrLnqBDqhJYKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oqm1DwhVrj7q+/MRS+WDQcIZOv2UlfMvrBl2Spr+LUxPOIANvk7DKbAac3MtLhVnZ
         zK/34jzloOLVKKRouJlZCKSAut3ri875PGFGu311RMoBa4JapYgvBUp+LlMa5JlLmT
         5mdESMe17XP7KK7fLJw8DRDy4hexNthV+QmQgYza6zdTZ0gy0G5vP5Upp2rl87nQLE
         xAsrr6G2qoY10BSbM9zpVS5HG7cqz0aWDQnIM/FjaaTowe9jUh/PmvJ4+VSgizKdf3
         yf/0cc9dlZDv92FUhZO52uBiUkSCvNJhY8SWmAyuGTi63t5/I9az1H3CLFOy4JfVaC
         0RSSc7Ttemnjg==
Date:   Sat, 4 Jun 2022 15:27:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lars@metafoo.de
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, rafael@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] iio: adc: axp20x_adc: Add support for AXP192
Message-ID: <20220604152711.22268711@jic23-huawei>
In-Reply-To: <e9ABtmBNzztlyRcJD5f36OmAYZW4i7KH@localhost>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
        <20220603135714.12007-9-aidanmacdonald.0x0@gmail.com>
        <20220603174744.642157d8@jic23-huawei>
        <e9ABtmBNzztlyRcJD5f36OmAYZW4i7KH@localhost>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jun 2022 12:47:38 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Fri,  3 Jun 2022 14:57:12 +0100
> > Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
> >  
> >> The AXP192 is identical to the AXP20x, except for the addition of
> >> two more GPIO ADC channels.
> >> 
> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>  
> > Hi Aidan,
> >
> > A few minor questions and comments inline.
> >
> > Thanks,
> >
> > Jonathan
> >
> > Unless I missed a previous patch adding labels to the other devices supported,
> > this is the first driver to use these.  Why do they make sense here but not
> > to add to existing supported devices?
> >
> > I don't particularly mind this addition, just looking for an explanation.
> >  
> 
> That'd be because 1d4ef9b39ebecca8 ("iio: core: Add optional symbolic
> label to a device channel") added read_label in 2020, while the AXP
> driver was introduced in 2017. I could add read_label for the other
> chips while I'm here, for consistency.

Thanks, I don't really mind either way on adding support for additional parts.

> 
> One question I have is why read_label exists when the kernel already has
> unique names for IIO channels. Why not just expose the datasheet_name to
> userspace from the IIO core instead of making drivers do it?

In general, datasheet_name refers to the name of the pin on a datasheet for this
device, whereas label can refer to how it is used.
There are dt bindings to allow a per channel label letting a driver (where it
makes sense) provide them for each individual ADC channel.
(e.g. the ad7768-1 driver does this).

On other devices they come from entirely different sources such as the hardcoded
choices in hid-sensor-custom-intel-hinge.

I vaguely recall that we've talked in the past about exposing datasheet name directly
but for many devices it's not that useful (the user doesn't care if a channel is
aux channel 1 or 7, but rather what it is wired up to).

At the moment this driver just exposes all channels rather than having
per channel bindings, so we don't have the option to use labeling in the device
tree to assign the names.   If it's particularly useful to you to have labels
that are datasheet names that's fine.

Jonathan
