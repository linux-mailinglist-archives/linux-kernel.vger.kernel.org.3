Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228C59237E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiHNQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbiHNQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04117E39;
        Sun, 14 Aug 2022 09:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06C4760F4E;
        Sun, 14 Aug 2022 16:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF469C433D6;
        Sun, 14 Aug 2022 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660493756;
        bh=xVTcmGG9OL0uC/4v49WHvtlR/iFN2KD0cTGuGXzzoB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MrJglOx+bzOb4NgjUM6qveUa3aNC8MVxeIGJQbQq3IYD5iGJudyLgpT1Qs4W4gwcI
         cODi7DldT5OrpeKE619yOGo1nIHj9/F+hesMvD0DX6DVkrQUvpNlwP4Gvo0F831oK9
         kfRzC1034bJhpHE3hq2xQIcTeuMwxMnOAzuSWEiOsKDD5YdfXK9eALqO7y6pDUZi1r
         /JNpEs78QN222ce2BHsUvtFCuZY8N6e+TdvEQrZH/TXRMBasDDctTIxDRUxvMCWM13
         HrHa3fb7algVs+irilUEn09EkArG8v29rAK2tVdHMdpFN0P/4CMmYuI47nH/dmYupr
         575LIQsPKQRlA==
Date:   Sun, 14 Aug 2022 17:26:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220814172622.3b14ab3b@jic23-huawei>
In-Reply-To: <CAHp75Ve8VtwGX6YeuGvhUat5UfoLXB4RdkW4vc1kQUk71+_aCA@mail.gmail.com>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
        <20220812165243.22177-7-ddrokosov@sberdevices.ru>
        <CAHp75Ve8VtwGX6YeuGvhUat5UfoLXB4RdkW4vc1kQUk71+_aCA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022 01:34:40 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 12, 2022 at 7:52 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> >
> > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > sensitivity consumer applications. It has dynamic user-selectable full
> > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> > with output data rates from 1Hz to 1000Hz.  
> 
> > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf  
> 
> Can you use Datasheet: tag below (just before your SoB tag)?
> 
> > This driver supports following MSA311 features:
> >     - IIO interface
> >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> >     - ODR (Output Data Rate) selection
> >     - Scale and samp_freq selection
> >     - IIO triggered buffer, IIO reg access
> >     - NEW_DATA interrupt + trigger
> >
> > Below features to be done:
> >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> >     - Low Power mode  
> 
> ...
> 
> > +static const struct {
> > +       int val;
> > +       int val2;
> > +} msa311_fs_table[] = {
> > +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> > +};  
> 
> At least you may deduplicate the type definition for these data structures, like
> 
> struct iio_float {

iio_int_plus_micro maybe...
we have lots of fixed point types and they definitely are floats
then integer, micro


>   int integer;
>   int fract;
> };
>
