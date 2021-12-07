Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8303846C674
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbhLGVQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhLGVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:16:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D7C061574;
        Tue,  7 Dec 2021 13:12:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09BF6B81E80;
        Tue,  7 Dec 2021 21:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC890C341C6;
        Tue,  7 Dec 2021 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911566;
        bh=Wk563gZgYgtu8GxzZ2NAZJQhdfrVeMSvAYGKU1N9DE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JQkZ9L3UE9lbs0DFU/Lg/0MmVArCZnlgeW+h2yJsXPE+IPi0BPwCt5E/BYzZeJkBp
         1ibnWEIMh7pRmm1QDkBU7YczYjb87snQTkTaS9/mmPgXckkYQ4sUv0hZc1V6OhPO2/
         Pe06up8EmdtFB8o9iu6Vcm0YoVQfXIo0j2ymROzCnRl7SFMNjtdY3R2YdaYiUtyFen
         QgUj42WXSTFqgvHq2RHVtJxKqqb9+HT6sdVTcO+0Lkxds9x9NrPe2cWUNZOMmUs6Rr
         nP+eD3Us+mwqJ6gIuFSZFL6p4WJ0aaZ0cxMZRv2QByUK66sVwk2B8EGy+T2v2hXFEW
         Ha2PnoGPSAclw==
Received: by mail-ed1-f50.google.com with SMTP id r25so1044924edq.7;
        Tue, 07 Dec 2021 13:12:46 -0800 (PST)
X-Gm-Message-State: AOAM533mFye894/m7HyuKvLFRRIsX0L2cKEczWrvxkYwNHuPQlzb5vNc
        LSG2KFO6EzlurlFVayBoucRH8FHTq9QT64qwMg==
X-Google-Smtp-Source: ABdhPJx3pCJatQo5ZDkz+iIedAgS5UWQ9f5rZvjfx/ywhKjZj5zkYicvAVXLgX7lYzmOtFWx/7Hpe2W/ubuaXnj3eiE=
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr13101561eda.22.1638911564955;
 Tue, 07 Dec 2021 13:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20211205190101.26de4a57@jic23-huawei> <CAHp75VeqVTnMyjbmfKhvgTVaj1G+gq6FXfVR4EZjXLjSdO7ETA@mail.gmail.com>
In-Reply-To: <CAHp75VeqVTnMyjbmfKhvgTVaj1G+gq6FXfVR4EZjXLjSdO7ETA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Dec 2021 15:12:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKdMjVbMcK5k5c9YEKAzcOTK6JXLWzxHbxPSdUgvM=m8A@mail.gmail.com>
Message-ID: <CAL_JsqKdMjVbMcK5k5c9YEKAzcOTK6JXLWzxHbxPSdUgvM=m8A@mail.gmail.com>
Subject: Re: RFC: Should we have a device_for_each_available_child_node()?
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 1:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I think we need Rob here (or anybody with DT API knowledge) to explain
> this subtle detail you found, i.e. checking node for availability in
> of_fwnode_get_next_child_node(). This raises another question why do
> we have for_each_available_child_of_node() in the first place if it's
> equivalent (is it?) to for_each_child_of_node()/

It's not equivalent, but in an ideal world they would have been. Most
of the time, one should be using for_each_available_child_of_node() as
that treats disabled nodes as if they were non-existent.
Unfortunately, there are some cases where walking the disabled nodes
is desirable/needed. On !Arm, disabled CPU nodes are ones that are
offline for example.

Ideally, we would have had for_each_child_of_node() and
for_each_yes_I_really_want_disabled_child_of_node() instead.

> On Sun, Dec 5, 2021 at 8:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Hi All,
> >
> > This came up in review of
> > https://lore.kernel.org/linux-iio/20210725172458.487343-1-jic23@kernel.org/
> > which is a series converting a dt only driver over to generic properties.
> > I'm sending a separate email to raise the profile of the question rather
> > higher than it was buried in a driver review.
> >
> > The original code used for_each_available_child_of_node(np, child)
> > and the patch converted it to device_for_each_child_node().
> >
> > Andy raised the question of whether it should have been
> > device_for_each_available_child_node() but that doesn't exist currently.
> >
> > Things get more interesting when you look at the implementation of
> > device_for_each_child_node() which uses device_get_next_child_node()
> > which in turn calls fwnode_get_next_child_node() which calls
> > the get_next_child_node() op and for of that is
> > of_fwnode_get_next_child_node() which uses of_get_next_available_child()
> > rather than of_get_next_child().

That may have been based on my feedback so that fwnode has the 'right'
interface...

> > So I think under the hood device_for_each_child_node() on of_ is going to
> > end up checking the node is available anyway.
> >
> > So this all seemed a little odd given there were obvious calls to use
> > if we wanted to separate the two cases for device tree and they weren't
> > the ones used.  However, if we conclude that there is a bug here and
> > the two cases should be handled separately then it will be really hard
> > to be sure no driver is relying on this behaviour.
> >
> > So, ultimately the question is:  Should I add a
> > device_for_each_available_child_node()?  It will be something like:
> >
> > struct fwnode_handle *device_get_next_child_node(struct device *dev,
> >                                                  struct fwnode_handle *child)
> > {
> >         const struct fwnode_handle *fwnode = dev_fwnode(dev);
> >         struct fwnode_handle *next;
> >
> >         /* Try to find a child in primary fwnode */
> >         next = fwnode_get_next_available_child_node(fwnode, child);
> >         if (next)
> >                 return next;
> >
> >         /* When no more children in primary, continue with secondary */
> >         if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
> >                 next = fwnode_get_next_available_child_node(fwnode->secondary, child);
> >
> >         return next;
> > }
> >
> > #define device_for_each_child_node(dev, child)                          \
> >         for (child = device_get_next_available_child_node(dev, NULL); child;    \
> >              child = device_get_next_avaialble_child_node(dev, child))
> >
> > As far as I can tell it doesn't make any difference for my particular bit
> > of refactoring in the sense of I won't break anything that currently
> > works by using device_for_each_child_node() but it may cause issues with
> > other firmware by enumerating disabled child nodes.
> >
> > Jonathan
> >
> >
> >
> >
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
