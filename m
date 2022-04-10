Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EEA4FAE26
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiDJONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiDJONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:13:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C710FCD;
        Sun, 10 Apr 2022 07:11:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so25954085ejd.3;
        Sun, 10 Apr 2022 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGD7XaA8jtkjD0CdMIP1+1J/OWFQgaWYVAAlaGQ+xes=;
        b=bPdX8Dgs0S3fMk9FYedEZzwHEBbOE7dK77medvKAXAJu55KHRN7SP7fn6m3GPYYFc0
         gx4edqTdQ9uozq5aPJfon6JPsbhp+nZ3ngSFuHFtTNZMkxKSzQhexKK1yezQLTe+Afhv
         x2/ci1ci7Ar1ATInaMEy9krYTpR1vC3Tdb3zA4s3Or9IjJmne7qXFcITeIxSCkBviUFL
         Zp5J/DXy2lXU7L2/1zxBDogx+mPdKXyUdPkN+1ADkQjvvx6BiQiJSOvjBRIQ2qpAdQGZ
         EffCbEhh7TbDcRmSMRiOK74lnZT4B648tLGVgPYKwfnjBVB/kcYD5lHRypeW6U85iDPK
         gp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGD7XaA8jtkjD0CdMIP1+1J/OWFQgaWYVAAlaGQ+xes=;
        b=Pr2MTte5sQSEtAk2ORqEslcwSGkXRRTREiwTyv7/y5AvYR6jfvOl+F98uxUyVb1pB8
         kzjbe7kJv6RM9wni9X7HVFILQaTW8K59jrVkmP7/F3IDsrrqexl/Nv5WvbIMB7mczCw/
         B5KpCy7aAKImVdX9Nj9Q/ImJfsq/SqVbUqm9TILKfBJ6LS5Me2nM0dENmB5k2oCUInke
         CjApn5M794aurTHlGL66dXl2kVCzlH+rEcMFg7EJMHhuOPMz5Ji5U5lmPZM8nnU45q4N
         x8vzKUVuy9EJ9osipd3Q6GnRzeyxH8LL8VYTgs5t7fZlSzMdsijs8urNVLpodax8hT0O
         pdTA==
X-Gm-Message-State: AOAM531+a5PAD1c2LvXG6R5MBSNSM56do1U5eLvFot9fCOCBfcFapuuc
        Lc+woR4iNl+fsdxWJnZ7866cR3F7kaL208Lhl5YPXnZyI3B/fA==
X-Google-Smtp-Source: ABdhPJx9kKLxqA8eyuu2lo5p3nU5s7uNOd0CQgMoAcRK27tmdg1jU4C8fEPYb4knoKBDtSHOQKnw9daqIqet7+uMB+A=
X-Received: by 2002:a17:907:8a05:b0:6e8:441c:358d with SMTP id
 sc5-20020a1709078a0500b006e8441c358dmr13228729ejc.77.1649599859419; Sun, 10
 Apr 2022 07:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com> <YlCq79KveByePxe9@paasikivi.fi.intel.com>
In-Reply-To: <YlCq79KveByePxe9@paasikivi.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Apr 2022 17:10:23 +0300
Message-ID: <CAHp75Ve-5=6bsF1mMQ4RceobV=OsR6VwZeP==iFGQJLEbt0-yg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 2:35 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Fri, Apr 08, 2022 at 09:48:43PM +0300, Andy Shevchenko wrote:
> > As to_of_node() suggests and the way the code in the OF and software node
> > back ends actually uses the fwnode handle, it may be constified. Do this
> > for good.
>
> How?
>
> If the fwnode is const, then the struct it contains must be presumed to be
> const, too.

Why? The idea is that we are not updating the fwnode, but the container.
The container may or may not be const. It's orthogonal, no?

-- 
With Best Regards,
Andy Shevchenko
