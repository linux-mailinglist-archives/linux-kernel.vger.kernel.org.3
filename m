Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F85A55F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiH2VHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH2VHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF4C8C022;
        Mon, 29 Aug 2022 14:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A8B061055;
        Mon, 29 Aug 2022 21:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1F0C433D6;
        Mon, 29 Aug 2022 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661807236;
        bh=hxUND/iA6gKnrumrh+GrZLfVn5DNjHCkcqAfHCfKpUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eFkxgjy/lSPAHc+PIWic8Qq4EVSYPpo+SHo/CWkIN4Xag0lpz6iP+4HH3TkwpMdzi
         p7S/wzHUsDsdE1WFOUeUbjUH7EqWMViV/WQIWxCF+S02E9wbnRSK19YGU8yg4OVJsf
         slwRjhcWyENHA4wFtwmyaS5telPEOkJw6GyYLL9U=
Date:   Mon, 29 Aug 2022 14:07:14 -0700
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
Message-Id: <20220829140714.78974f21bb44eaed2b9896e1@linux-foundation.org>
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

Mainly because [0/n] was titled "units: ...", not "iio: ..."!

> Anyhow, I see they are still in Andrew's nonmm-unstable tree, so
> assuming he won't mind me picking them up through IIO instead / as well.
> If nothing else git will sort this out when the two trees reach
> linux-next or upstream anyway.

I'll drop 'em.
