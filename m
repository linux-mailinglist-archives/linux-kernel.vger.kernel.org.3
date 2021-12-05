Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198F5468D14
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 20:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhLETvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 14:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhLETvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 14:51:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526AC061714;
        Sun,  5 Dec 2021 11:48:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so34229790edr.5;
        Sun, 05 Dec 2021 11:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4fF1nSTHBf3HTdpKCFdl3la1UMZb2JlN7zUcVFPI0Q=;
        b=p2Aa7ze1cA+B7Je1fJf2L2fwd3q0Kxi7FvdtQskiHKb/loDhLVtuO4eo2BT+7loQJR
         fHYaHl905UL8dHv7dNUzA3+QaYbxuoka6L3FKL+Xt+ui/fKtdgN8iS4t0n2DPYj0VSgB
         fSLB6T37pZrh7fALYbn76jZAV83b+XlOQeUbCM0qTJdkMDlQsAcE91moa0z1J100Reiw
         SrLOnX6UCdaop6DIerUP64l2raCBGNvGan6Ba3S9kbGl/4zlmOwz5JFDwGW5dS+aLstK
         0G7pYVYSi2q9hmdZx1Ya5CVFUzk/B9YgoIYT/E2qskJa7wCWTbcOfCymsTqgjqKor0kR
         bxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4fF1nSTHBf3HTdpKCFdl3la1UMZb2JlN7zUcVFPI0Q=;
        b=NaExmg1IGfZPq/8mO7f+1MrUOunM0hZGLaEa2blYYQmMvzWYdPDogNbneNLfg6196v
         qAhPUNcMQTlHiSlFBwxXUbnsrhTiFr2Gfq34ii/uPagyp5QZw79PXM0Pya3WsSmrnutP
         T5Ge1IjZHA7AP5nkMTnTTnfVrHGjUiQXnSU+PhomzNaJHqHnUsTuFbE8kbZwhQ0GO6e0
         Vt/d58Eza4rNiXKK07nDwyIsT6MyxQyfs2RL9zHXPo61in2pQxzmQBegP3Hca3P4hoKM
         oY8gP/BrUPDckkYO6nqgZV3ViRfW/MTuuf4cXkcEQGqnFzrtHFWHJzi75/F3voRLzPS8
         fDNQ==
X-Gm-Message-State: AOAM530ryJpVnLPOITbOsJ/4DHsq4jLavMVqUII0KCjzvazDFq7vLAnh
        BEI2LwBoy/0okUuMDJW6KbEUks9dkUrVTf9MxSM=
X-Google-Smtp-Source: ABdhPJzvgUKoM8Bu93028z3ABP72O9wxEG3S/N7Z8Pa+EoPj2gtw7MDRqftbOQe3WIrr2K0eb12UElxeCG+uGbwlNiE=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr47124784edd.258.1638733695046;
 Sun, 05 Dec 2021 11:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20211205190101.26de4a57@jic23-huawei>
In-Reply-To: <20211205190101.26de4a57@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 21:47:38 +0200
Message-ID: <CAHp75VeqVTnMyjbmfKhvgTVaj1G+gq6FXfVR4EZjXLjSdO7ETA@mail.gmail.com>
Subject: Re: RFC: Should we have a device_for_each_available_child_node()?
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we need Rob here (or anybody with DT API knowledge) to explain
this subtle detail you found, i.e. checking node for availability in
of_fwnode_get_next_child_node(). This raises another question why do
we have for_each_available_child_of_node() in the first place if it's
equivalent (is it?) to for_each_child_of_node()/

On Sun, Dec 5, 2021 at 8:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hi All,
>
> This came up in review of
> https://lore.kernel.org/linux-iio/20210725172458.487343-1-jic23@kernel.org/
> which is a series converting a dt only driver over to generic properties.
> I'm sending a separate email to raise the profile of the question rather
> higher than it was buried in a driver review.
>
> The original code used for_each_available_child_of_node(np, child)
> and the patch converted it to device_for_each_child_node().
>
> Andy raised the question of whether it should have been
> device_for_each_available_child_node() but that doesn't exist currently.
>
> Things get more interesting when you look at the implementation of
> device_for_each_child_node() which uses device_get_next_child_node()
> which in turn calls fwnode_get_next_child_node() which calls
> the get_next_child_node() op and for of that is
> of_fwnode_get_next_child_node() which uses of_get_next_available_child()
> rather than of_get_next_child().
>
> So I think under the hood device_for_each_child_node() on of_ is going to
> end up checking the node is available anyway.
>
> So this all seemed a little odd given there were obvious calls to use
> if we wanted to separate the two cases for device tree and they weren't
> the ones used.  However, if we conclude that there is a bug here and
> the two cases should be handled separately then it will be really hard
> to be sure no driver is relying on this behaviour.
>
> So, ultimately the question is:  Should I add a
> device_for_each_available_child_node()?  It will be something like:
>
> struct fwnode_handle *device_get_next_child_node(struct device *dev,
>                                                  struct fwnode_handle *child)
> {
>         const struct fwnode_handle *fwnode = dev_fwnode(dev);
>         struct fwnode_handle *next;
>
>         /* Try to find a child in primary fwnode */
>         next = fwnode_get_next_available_child_node(fwnode, child);
>         if (next)
>                 return next;
>
>         /* When no more children in primary, continue with secondary */
>         if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
>                 next = fwnode_get_next_available_child_node(fwnode->secondary, child);
>
>         return next;
> }
>
> #define device_for_each_child_node(dev, child)                          \
>         for (child = device_get_next_available_child_node(dev, NULL); child;    \
>              child = device_get_next_avaialble_child_node(dev, child))
>
> As far as I can tell it doesn't make any difference for my particular bit
> of refactoring in the sense of I won't break anything that currently
> works by using device_for_each_child_node() but it may cause issues with
> other firmware by enumerating disabled child nodes.
>
> Jonathan
>
>
>
>
>


-- 
With Best Regards,
Andy Shevchenko
