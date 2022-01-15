Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9948F76F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 16:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiAOPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 10:21:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43124 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiAOPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 10:21:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 516A660B3D;
        Sat, 15 Jan 2022 15:21:56 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 8095AC36AEA;
        Sat, 15 Jan 2022 15:21:52 +0000 (UTC)
Date:   Sat, 15 Jan 2022 15:27:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 06/10] iio: document bno055 private sysfs attributes
Message-ID: <20220115152749.173b7172@jic23-huawei>
In-Reply-To: <CAN8YU5NO5mcrPa5ZCB3XnAb=3N3cyXZUT=gH5G+EbnM-En0a3Q@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-7-andrea.merello@gmail.com>
        <20211028120405.6ffb01d1@jic23-huawei>
        <CAN8YU5Orbbzq-eDxmrR00xHwXQ=0LU2G3_yEtHGMkbVhmdcqgg@mail.gmail.com>
        <20211114162032.425ab36d@jic23-huawei>
        <CAN8YU5NO5mcrPa5ZCB3XnAb=3N3cyXZUT=gH5G+EbnM-En0a3Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 12:42:40 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Sorry for the huge delay...

No problem though I may have forgotten some of the discussion!

> 
> > There is still a units question though.  Should we express the ranges
> > in _processed or _raw units?  Or do we make it explicit and call it
> > rangeprocessed for example?  For some devices the range will naturally
> > be expressed as the range of ADC raw values, so there is definite room
> > for confusion if we don't make it clear in the name.
> >
> > I'm open to other suggestions of how we name this to avoid falling into
> > any heffalump traps.  
> 
> You are right: this might lead to confusion.. Making it explicit in
> the name seems a good idea.
> 
> I've looked at other iio sysfs attributes in the DOC.  It seems  that
> "thesh" and "roc" attributes allows for both preprocessed and raw
> data: I found e.g. "<type>[Y][_name]_<raw|input>_thresh_value", but
> the related "what" entries written above all seem to omit both "_raw"
> and "_input"; I don't understand why.

Excellent point.  That documentation is garbage.  Events are meant
to pick it up implicitly from the related channel _raw or _input.
I don't remember them ever having raw or input in their naming but
it's possible they did right at the beginning before the ABI was anywhere
near stable.  Gah. I dread to think how long that that has been wrong.

> 
> In any case, maybe we can stick to that already-existent naming schema?

It doesn't exist really the docs are wrong.  

> 
> Assuming the pattern is correct, then wouldn't it be
> "in_accel_raw_range"  (or "in_accel_x_raw_range", in case it could
> have different values for each axis) or "in_accel_input_range" in case
> range applies to preprocessed vals, etc ?

Tricky corner but I'd go with no, because the pattern is

direction_type_infotype

and in this case the infotype is rangeraw. We've not been totally consistent
on whether we allow spaces in infotype or not.  Intially we always did but then
some of the userspace folks asked us to stop doing so because it requires
all userspace software to have an explicit list rather than just adding
controls to some GUI based on generic parsing.  Hohum. Historical decisions that
lead to messy interfaces... *sigh*

Nearest to what you have here though are peak_raw and mean_raw
though those are odd in of themselves in that they are basically special forms
of _raw rather than something else that is in _raw units...

So I think range_raw postfix is the best bet.

Jonathan





>

> 
> Andrea

