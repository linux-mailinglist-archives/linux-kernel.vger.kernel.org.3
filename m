Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26205A55EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiH2VGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiH2VGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:06:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3FF7B2B9;
        Mon, 29 Aug 2022 14:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B198B81162;
        Mon, 29 Aug 2022 21:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED93C433D6;
        Mon, 29 Aug 2022 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661807172;
        bh=0mcDMWOHxrfD5Tv/P4qNMYR0C9A+FHsaDwMm2tRHyOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0HTX24J+z5lpQJxLBuCvnFqrtnc+m7Vi5tt1i5mJZT0I+7158lB99II5Lb+fqWnKr
         wemh3r02eTFtMPMyWI74fu2J49hU+J4ADZfvOZrxYCukzVsSF7oAVrHOeYfZ4ZqALt
         m6c9b/ZJo4L8YJUrb1AJUqcUG0YzBhKk9Tw/htqA=
Date:   Mon, 29 Aug 2022 14:06:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] units: complement the set of Hz units
Message-Id: <20220829140611.5816d090c4505740a97b8918@linux-foundation.org>
In-Reply-To: <20220828165541.2cd81c97@jic23-huawei>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
        <20220812165243.22177-3-ddrokosov@sberdevices.ru>
        <20220828165541.2cd81c97@jic23-huawei>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022 16:55:41 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 12 Aug 2022 16:52:26 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> 
> > Currently, Hz units do not have milli, micro and nano Hz coefficients.
> > Some drivers (IIO especially) use their analogues to calculate
> > appropriate Hz values. This patch includes them to units.h definitions,
> > so they can be used from different kernel places.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> I'm not really sure why Andrew Morton picked these up as no obviously
> dependencies outside of IIO and we have other patches under review that
> need these.
> 
> Anyhow, I see they are still in Andrew's nonmm-unstable tree, so
> assuming he won't mind me picking them up through IIO instead / as well.
> If nothing else git will sort this out when the two trees reach
> linux-next or upstream anyway.
> 
> +Cc Andrew Morton.
> 
> this and next two patches applied to the togreg branch of iio.git.
> I'll push that out as testing for 0-day to do it's sanity checks then
> it'll go out as iio.git / togreg and get picked up by linux-next.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  include/linux/units.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/units.h b/include/linux/units.h
> > index 681fc652e3d7..2793a41e73a2 100644
> > --- a/include/linux/units.h
> > +++ b/include/linux/units.h
> > @@ -20,6 +20,9 @@
> >  #define PICO	1000000000000ULL
> >  #define FEMTO	1000000000000000ULL
> >  
> > +#define NANOHZ_PER_HZ		1000000000UL
> > +#define MICROHZ_PER_HZ		1000000UL
> > +#define MILLIHZ_PER_HZ		1000UL
> >  #define HZ_PER_KHZ		1000UL
> >  #define KHZ_PER_MHZ		1000UL
> >  #define HZ_PER_MHZ		1000000UL
