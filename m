Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C745A3E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiH1QVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1QVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C41CFFE;
        Sun, 28 Aug 2022 09:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432FD60B3E;
        Sun, 28 Aug 2022 16:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA299C433D7;
        Sun, 28 Aug 2022 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661703690;
        bh=qYruH8K/GFaVT47Q2Gp0/tqxVZZ0LOn2zgpb+Qy0tMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LV9FfEsOCa+wpjcTo6584src7EGkGKYdBVjujp7f3pBNuPBKqXz6r6IMc0d6HIUpj
         B1GbebuZvK6SNN41Za9QHOcnJZ4esq2/REoU3mkqWwGrf/nYrJvjJsutjPKEaZn1II
         VEvBeaAhMjCNY8LbKFwI01+9KwtA72mCgw48hczTmbday4HA1wwJ2gHpDjImv9BEOE
         llBLgphQePOuC2ffYZlX9MRr6gYfWd5aXZtANjfm8g/9JQfS6ZkuRESPTOWTXsxXPI
         jKvYRF/omTJyC96i1+6uD5SqoBvqHoke9FamjSrwZ6+kiHlPHJ8OgFn9o9FSaZBcaA
         KbxPpfhoyeh8Q==
Date:   Sun, 28 Aug 2022 16:47:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] units: complement the set of Hz units
Message-ID: <20220828164708.017c400d@jic23-huawei>
In-Reply-To: <20220801143811.14817-1-ddrokosov@sberdevices.ru>
References: <20220801143811.14817-1-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 14:37:23 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> During msa311 accel IIO driver development
> 
> https://lore.kernel.org/linux-iio/20220616104211.9257-1-ddrokosov@sberdevices.ru/
> 
> Andy requested to use proper units in the hz->ms calculation. Current
> units.h header doesn't have milli, micro and nano HZ coefficients, so
> some drivers (in the IIO subsystem) implement their own copies for that.
> 
> The current patchset resolves such a problem and intoduces general
> MILLIHZ_PER_HZ, MICROHZ_PER_HZ and NANOHZ_PER_HZ definitions in the units.h,
> and fixes all drivers which duplicate these units.

Ok, I'm just about convinced this is worth doing given the precedence
of similar cases. Applied to the togreg branch of iio.git and pushed
out as testing.

Thanks,

Jonathan
> 
> Changes:
> * v2->v3:
>     - changed UHZ_PER_HZ to MICROHZ_PER_HZ and NHZ_PER_HZ to
>       NANOHZ_PER_HZ to save name consistency for all new HZ units
> 
> * v1->v2:
>     - changed MHZ_PER_HZ to a different name as Andy suggested
>       (suppose MILLIHZ_PER_HZ is good enough)
> 
> Dmitry Rokosov (3):
>   units: complement the set of Hz units
>   iio: accel: adxl345: use HZ macro from units.h
>   iio: common: scmi_sensors: use HZ macro from units.h
> 
>  drivers/iio/accel/adxl345_core.c           | 7 ++++---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 8 ++++----
>  include/linux/units.h                      | 3 +++
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 

