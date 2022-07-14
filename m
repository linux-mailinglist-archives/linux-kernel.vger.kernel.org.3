Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB2574F51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiGNNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiGNNiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:38:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640054CAE;
        Thu, 14 Jul 2022 06:38:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y9so1849148pff.12;
        Thu, 14 Jul 2022 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OpmfwN/J8ZTICSzccrhBIpc9ZkfZKVmS0yTPE9OckSU=;
        b=P8JDkffPEQJ+0PZuxarOGUq/HuVCJaA++tVCBZCJfVuhM8VTaal2y1cnCnHMW4FqPN
         IDdiIJwCf2/IOvb8PAKpL4Cv1H/hWcMU84KYyFSj8TL8wBeSYxIov1xyLjuIx5cY1r75
         2m6MO5Z+H6sN5VqelhgzaGIsKPkbkiwkRnX3ULDmhUo40oKKPy7XqGDCu0ux1uGUJSQR
         aZXfZT8kv2TxP8rzFXKld5bpREnpphvTQBns6gBXF4C515nnfR1IJ5KEeIXv1BptB925
         N2bHYmilJTyYuH8qSwkmrRaRFbQ3Py6JMtRMFI8MjU0BOROgkj5MGOOBk4WHJA0ewLcI
         USPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OpmfwN/J8ZTICSzccrhBIpc9ZkfZKVmS0yTPE9OckSU=;
        b=hL9Vk7Wt3p1Hh9mWNj0or0/TGrncS6O3kcIPpzw7ouGdnVXPbFXn+41HLab1K4p/o0
         9l2/VC/yjOQ103MTl72Fc3fkvU9ItDoj65KQgJUyw8tLsYjmT4SrwB1Gw8IMRxhLq5Z1
         PqEPndQYo7F0BZ/4BVBhW8zHV1+fTAC1v2NW/6lAqgFUODWJbt00OoYdk5OcZ/AxY3f8
         41mYUOg1uL5mxZihS/kQVg+gvuqis4sDM/B11xvsMMSe/22Fqd4QoMGCobSZGtgduB1y
         9eYOG4XeZRlh/AjSSVI/LQOQtuJGrPGtg/r4pJ7LJE+pUy3dtRg34GJ3Vjcn6TltBsHi
         0DUA==
X-Gm-Message-State: AJIora8CBiaT1F9fONeY3c0BRrS9SYBS9hdu+KWMdLT8BQka3g41TE6t
        VAV0lbyhXrmbk6ejFPz2ONA=
X-Google-Smtp-Source: AGRyM1vCtckFmC3nc6mMaAk1y5t2v7Ybn8SDjp47SI6V+JOzOavjkwqLvW+ropO8RiT8WLqz/VLpgg==
X-Received: by 2002:a63:3181:0:b0:417:b4b5:df09 with SMTP id x123-20020a633181000000b00417b4b5df09mr7803649pgx.398.1657805887022;
        Thu, 14 Jul 2022 06:38:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7-20020a63ff47000000b0041981461f5dsm1286244pgk.90.2022.07.14.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:38:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 14 Jul 2022 06:38:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Kallas, Pawel" <pawel.kallas@intel.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        iwona.winiarska@intel.com
Subject: Re: [PATCH 0/3] hwmon: (pmbus) add power from energy readings
Message-ID: <20220714133800.GA3916254@roeck-us.net>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
 <20220706131758.GA652205@roeck-us.net>
 <dc8771ad-b48b-317d-b132-47208ef58710@intel.com>
 <20220707140952.GB3492673@roeck-us.net>
 <0b776040-c3bd-034f-bbcd-b929f1a4d19a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b776040-c3bd-034f-bbcd-b929f1a4d19a@intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 06:00:45PM +0200, Kallas, Pawel wrote:
> 
> On 07-Jul-22 4:09 PM, Guenter Roeck wrote:
> > On Thu, Jul 07, 2022 at 04:01:54PM +0200, Kallas, Pawel wrote:
> > > On 06-Jul-22 3:17 PM, Guenter Roeck wrote:
> > > > On Wed, Jul 06, 2022 at 12:40:21PM +0200, Kallas, Pawel wrote:
> > > > > Add support for reading EIN or EOUT registers and expose power calculated
> > > > > from energy. This is more accurate than PIN and POUT power readings.
> > > > > Readings are exposed in new hwmon files power1_average and power2_average.
> > > > > Also add support for QUERY command that is needed to check availability
> > > > > of EIN and EOUT reads and its data format. Only direct data format is
> > > > > supported due to lack of test devices supporting other formats.
> > > > > 
> > > > I don't think this is a good idea. EIN/EOUT report energy consumption,
> > > > not power.
> > > According to PMBus-Specification-Rev-1-3-1-Part-II-20150313 "READ_EIN and
> > > READ_EOUT commands provide information that can be used to calculate power
> > > consumption". That is accumulator summing instantaneous input power
> > > expressed in "watt-samples" and counter indicating number of samples.
> > > The only reasonable thing that can be done with those values is calculating
> > > power.
> > Yes, but that is not the responsibility of the kernel. Just like we don't add
> > up power measurements to calculate energy, we don't take energy measurements
> > and calculate power consumption. Similar, we don't take voltage and current
> > measurements and report power consumption from it either.
> > 
> > > > The "average" attributes as implemented don't really report
> > > > a reliable number since the averaging period is not defined.
> > > Agree, it is calculating average power since last read, which could be
> > > incorrect with multiple consumers. However, this is the only possibility
> > > without adding some timer logic.
> > Another reason for doing it in userspace. Read energy every N seconds, and use
> > the difference to calculate average power consumption average over that time
> > period.
> We cannot "read energy". Raw value from READ_EIN and READ_EOUT is not
> energy.

Sure, it is an accumulation of power reading samples over time. as such,
it doesn't really even report a power average. Either case, any value
derived from it is all but worthless unless a well defined time interval
is available.  Unfortunately, such a time interval would require a kernel
timer, which would, at least in low power situations, have impact on the
power readings and is thus unacceptable. Maybe that is why later PMBus
specification introduced explicit READ_KWH_IN and READ_KWH_OUT commands.

> > > > Also, kernel
> > > > drivers should not make up such numbers. I don't mind adding energy
> > > > attribute support, but that should be reported as what it is, energy.
> > > > What userspace does with it would then be a userspace concern; it can
> > > > calculate all kinds of averages from it as much as it wants.
> > > Returning direct value of read registers would also work for our use case,
> > > but it is not in line with sysfs interface.
> > I did not suggest that. Just use the "energyX_in" attributes.
> Expressing raw value from READ_EIN or READ_EOUT is not in line with
> sysfs interface, because "energyX_in" should have microJoules as unit.
> Those commands have very specific format that is not actually energy.
> Since the only sensible use case for those raw values is calculating power
> we figured it would be better (and more accurate) to do it in kernel.
> Also, if we just express raw value, the user would have to know data format
> of the values for the device and know register format to decode the data.

A joule is one watt-second, and the registers accumulate power samples over
a period of time. Sure, dividing the reported values by the time interval
results in the average power consumption over that time interval. Just like
multiplying the average power consumption with the time interval results in
the energy consumption over that timer interval. If we say we can't
determine the energy because the accumulated values are just snapshots in
time, we just as well can't trust the average power calculated from it.

Anyway, I don't really see an acceptable solution. Reporting the average
power would require a periodic function running every second or so which
would at least potentially falsify the reported values, and if you say that
reporting the energy (which might still require a timer function, but less
frequently) isn't feasible I take you by your word.

Guenter

> > 
> > Thanks,
> > Guenter
> > 
> > > > Also, new attributes should not depend on query command support.
> > > > I don't mind adding support for that, but it would have to be independent
> > > > of energy attribute support.
> > > > 
> > > > Thanks,
> > > > Guenter
> > > > 
> > > > > Kallas, Pawel (3):
> > > > >     hwmon: (pmbus) add support for QUERY command
> > > > >     hwmon: (pmbus) refactor sensor initialization
> > > > >     hwmon: (pmbus) add EIN and EOUT readings
> > > > > 
> > > > >    Documentation/hwmon/pmbus-core.rst |   7 +
> > > > >    drivers/hwmon/pmbus/pmbus.c        |  20 +++
> > > > >    drivers/hwmon/pmbus/pmbus.h        |  19 +++
> > > > >    drivers/hwmon/pmbus/pmbus_core.c   | 261 +++++++++++++++++++++++++++--
> > > > >    4 files changed, 291 insertions(+), 16 deletions(-)
> > > > > 
> > > > > 
> > > > > base-commit: 7c1de25c06f31b04744beae891baf147af9ba0cb
