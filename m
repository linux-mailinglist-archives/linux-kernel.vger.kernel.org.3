Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33561579B64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiGSM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiGSMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:24:57 -0400
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7850727;
        Tue, 19 Jul 2022 05:09:48 -0700 (PDT)
Received: from [90.243.4.253] (port=53018 helo=jic23-huawei)
        by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1oDm2o-006mKs-1X; Tue, 19 Jul 2022 13:09:42 +0100
Date:   Tue, 19 Jul 2022 13:19:28 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        robh+dt@kernel.org, Zhigang.Shi@liteon.com, krisman@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 2/2] iio: light: Add support for ltrf216a sensor
Message-ID: <20220719131808.7899acd4@jic23-huawei>
In-Reply-To: <1e880d3f-758b-56a8-d468-dcb06f4cbc18@collabora.com>
References: <20220715111626.1066513-1-shreeya.patel@collabora.com>
        <20220715111626.1066513-3-shreeya.patel@collabora.com>
        <20220718182547.360e5cf2@jic23-huawei>
        <1e880d3f-758b-56a8-d468-dcb06f4cbc18@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 14:56:51 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 7/18/22 20:25, Jonathan Cameron wrote:
> > What turns this off again?  I'd expect to see a devm_add_action_or_reset()
> > to do that in the !CONFIG_PM case.
> > 
> > This is also an unusual pattern. As far as I can tell it works.
> > Normal trick for ensuring !CONFIG_PM works is to:
> > 
> > 1) Unconditionally turn device on.
> > 2) Register unconditional device off devm_callback. Very rarely harmful even if device already off
> >    due to runtime pm.  
> 
> If CONFIG_PM is disabled, do we really need to care about the power
> management on removal?
> 

Best effort + in general if we do something probe(), we want to do the
reverse in remove().  Sure it's not super important, but it's a nice
to have.  This tends to get 'fixed' by people revisiting the driver
after it has merged.

> > 3) Then call pm_runtime_set_active() so the state tracking matches.  
> 
> We can add pm_runtime_set_active() before h/w is touched for more
> consistency. On Steam Deck supplies are always enabled, but this may be
> not true for other devices.

Generally set it wherever you 'enable' the device as you are indicating
the state after that has happened. That might be really early though.

> 
> > 4) Call 	
> >   pm_runtime_mark_last_busy(dev);
> >   pm_runtime_put_autosuspend(dev);
> >   (here you have a function to do this anyway)
> >   to let runtime_pm use same path as normal to autosuspend
> > 
> > the upshot of this is that if !CONFIG_PM 3 and 4 do nothing and device
> > is left turned on.  Is there something I'm missing that makes that cycle
> > inappropriate here?  The main reason to do this is it then looks exactly
> > like any other runtime_pm calls elsewhere in the driver, so easier to review.  
> 
> It's appropriate, although caring about PM when it's disabled in kernel
> config could be unnecessary, IMO. It was my suggestion to keep the h/w
> enabled on driver's removal with !CONFIG_PM, minimizing the code.
> 
For the cost of about 4-8 lines of code, I think it's worth having, but can
also see why you decided against.

Jonathan


