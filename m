Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA583582C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiG0Qrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbiG0Qq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:46:58 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6952DFE;
        Wed, 27 Jul 2022 09:32:00 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id z132so12214227yba.3;
        Wed, 27 Jul 2022 09:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1+FyBD7qfpB/NcO18BYu7xfIXfdCx5KarG2Yv/S7Vqo=;
        b=JYxMw0mHbxinVXm9i9+14CdGALVjrTYiDeUhJVuPMZgET/swLcNWhLTeLJXYiFGEIj
         Erf65NbkqFM46rSJTDAazMlOXYo46t79HK9Sg8tvEvOBNCEVj3Fkdg74KmXuJEJ7A/4+
         sH98FfH2si/TC83Cop3IjGagaQpCAhiW4LmjcsEFRtbgEbFHdX/y53SmTDmo6AjT1FY5
         p9upzGfzyuHbKlOetTlbpiYCf8z8jSTsjNXclKrQxf4ilw+sfa07F/I3U8J5Dg409896
         YOVdofXp+Hhq90S9iF5LHRgFR88GoyAwG6fGjokHJnzXOTWzpjqtDc/roewQJmN/umjb
         zDYg==
X-Gm-Message-State: AJIora9U0CiWaZQKZ2+LkwvLanf8LlxK92hInHjllzKj8yILb2XH8LMe
        h2+Atr/GH+i2QkujazvVIBaetojxFvVWo+KCI6c=
X-Google-Smtp-Source: AGRyM1u6NteAhBXoLYdxy51ZeQgx+cCae1ZObILPbmLMpJfLv5mQSrC8YmVtriF4gtEgnkp8zwQjnFXzqKEjKETPdiQ=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr16706157ybu.365.1658939519456; Wed, 27
 Jul 2022 09:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220620144231.GA23345@axis.com> <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com> <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com> <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
In-Reply-To: <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jul 2022 18:31:48 +0200
Message-ID: <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
Subject: Re: PM runtime_error handling missing in many drivers?
To:     Oliver Neukum <oneukum@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
>
>
>
> On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > On Tue, Jul 26, 2022 at 11:05 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> > I guess that depends on what is regarded as "the framework".  I mean
> > the PM-runtime code, excluding the bus type or equivalent.
>
> Yes, we have multiple candidates in the generic case. Easy to overengineer.
>
> >>> The idea was that drivers would clear these errors.
> >>
> >> I am afraid that is a deeply hidden layering violation. Yes, a driver's
> >> resume() method may have failed. In that case, if that is the same
> >> driver, it will obviously already know about the failure.
> >
> > So presumably it will do something to recover and avoid returning the
> > error in the first place.
>
> Yes, but that does not help us if they do return an error.
>
> > From the PM-runtime core code perspective, if an error is returned by
> > a suspend callback and it is not -EBUSY or -EAGAIN, the subsequent
> > suspend is also likely to fail.
>
> True.
>
> > If a resume callback returns an error, any subsequent suspend or
> > resume operations are likely to fail.
>
> Also true, but the consequences are different.
>
> > Storing the error effectively prevents subsequent operations from
> > being carried out in both cases and that's why it is done.
>
> I am afraid seeing these two operations as equivalent for this
> purpose is a problem for two reasons:
>
> 1. suspend can be initiated by the generic framework

Resume can be initiated by generic code too.

> 2. a failure to suspend leads to worse power consumption,
>    while a failure to resume is -EIO, at best

Yes, a failure to resume is a big deal.

> >> PM operations, however, are operating on a tree. A driver requesting
> >> a resume may get an error code. But it has no idea where this error
> >> comes from. The generic code knows at least that.
> >
> > Well, what do you mean by "the generic code"?
>
> In this case the device model, which has the tree and all dependencies.
> Error handling here is potentially very complicated because
>
> 1. a driver can experience an error from a node higher in the tree

Well, there can be an error coming from a parent or a supplier, but
the driver will not receive it directly.

> 2. a driver can trigger a failure in a sibling
> 3. a driver for a node can be less specific than the drivers higher up

I'm not sure I understand the above correctly.

> Reducing this to a single error condition is difficult.

Fair enough.

> Suppose you have a USB device with two interfaces. The driver for A
> initiates a resume. Interface A is resumed; B reports an error.
> Should this block further attempts to suspend the whole device?

It should IMV.

> >> Let's look at at a USB storage device. The request to resume comes
> >> from sd.c. sd.c is certainly not equipped to handle a PCI error
> >> condition that has prevented a USB host controller from resuming.
> >
> > Sure, but this doesn't mean that suspending or resuming the device is
> > a good idea until the error condition gets resolved.
>
> Suspending clearly yes. Resuming is another matter. It has to work
> if you want to operate without errors.

Well, it has to physically work in the first place.  If it doesn't,
the rest is a bit moot, because you end up with a non-functional
device that appears to be permanently suspended.

> >> I am afraid this part of the API has issues. And they keep growing
> >> the more we divorce the device driver from the bus driver, which
> >> actually does the PM operation.
> >
> > Well, in general suspending or resuming a device is a collaborative
> > effort and if one of the pieces falls over, making it work again
> > involves fixing up the failing piece and notifying the others that it
> > is ready again.  However, that part isn't covered and I'm not sure if
> > it can be covered in a sufficiently generic way.
>
> True. But that still cannot solve the question what is to be done
> if error handling fails. Hence my proposal:
> - record all failures
> - heed the record only when suspending

I guess that would boil down to moving the power.runtime_error update
from rpm_callback() to rpm_suspend()?
