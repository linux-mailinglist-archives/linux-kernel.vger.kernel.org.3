Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D65816A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiGZPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbiGZPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:41:50 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF92C118;
        Tue, 26 Jul 2022 08:41:50 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id f73so25934788yba.10;
        Tue, 26 Jul 2022 08:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XZBi7IzCqvfKTanZDhCaN3J6iz5Ywu+mqR8S9am4fhs=;
        b=QDDQn9lnU62NcpS9soWU772pkL/9HkB1xjc/a5W+bfCduAK+Pa6gcb8xPeulpWJyXJ
         6/uOyy8QuglLUQwmHmv2MhQue7NY/xz52ILoBSqMLyoG8eObuszPJ5Dv4ekNMfF3OeWN
         PKVUlku7hNaqs2z6oqQdR0WICfNAR62NHvJA3QLyxJFpnFNvb2hld//6v0fs65mIfmk2
         Kyu3wv6SmyuC+Vl1hLz7mRKq6Fh4ndYxn/GOz9azS8vQ7jdh9u+WAN02TAz6WtUQaoLa
         FnFLH8sc8Dxeh6HB54CPK12I1osOWgjWTWR6hSk1iLpEdR7gd85XFkL6etjveuAFmjEN
         bCSQ==
X-Gm-Message-State: AJIora/gMiMfvdZe96ZNAsHDKySi2fFeiMe1VUjVS7zGST/t/Uv2IgEp
        gz99M7Sd0NsSYXSnyDWRoUlPdyrT+dEsAiBppXo=
X-Google-Smtp-Source: AGRyM1tagkoanXWG4bh0W25Ylp/aPCF89fBrmoKdcJqs7qiNOxQ5gGAdGZLvN0DeMzruyK55onWK4fqRCht4OkOWItU=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr12936010ybu.365.1658850109317; Tue, 26
 Jul 2022 08:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220620144231.GA23345@axis.com> <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com> <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
In-Reply-To: <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 17:41:38 +0200
Message-ID: <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
Subject: Re: PM runtime_error handling missing in many drivers?
To:     Oliver Neukum <oneukum@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Tue, Jul 26, 2022 at 11:05 AM Oliver Neukum <oneukum@suse.com> wrote:
>
>
>
> On 08.07.22 22:10, Rafael J. Wysocki wrote:
> > On 7/8/2022 1:03 PM, Vincent Whitchurch wrote:
>
> >> Perhaps Rafael can shed some light on this.
> >
> > The driver always knows more than the framework about the device's
> > actual state.  The framework only knows that something failed, but it
> > doesn't know what it was and what way it failed.
>
> Hi,
>
> thinking long and deeply about this I do not think that this seemingly
> obvious assertion is actually correct.

I guess that depends on what is regarded as "the framework".  I mean
the PM-runtime code, excluding the bus type or equivalent.

> > The idea was that drivers would clear these errors.
>
> I am afraid that is a deeply hidden layering violation. Yes, a driver's
> resume() method may have failed. In that case, if that is the same
> driver, it will obviously already know about the failure.

So presumably it will do something to recover and avoid returning the
error in the first place.

From the PM-runtime core code perspective, if an error is returned by
a suspend callback and it is not -EBUSY or -EAGAIN, the subsequent
suspend is also likely to fail.

If a resume callback returns an error, any subsequent suspend or
resume operations are likely to fail.

Storing the error effectively prevents subsequent operations from
being carried out in both cases and that's why it is done.

> PM operations, however, are operating on a tree. A driver requesting
> a resume may get an error code. But it has no idea where this error
> comes from. The generic code knows at least that.

Well, what do you mean by "the generic code"?

> Let's look at at a USB storage device. The request to resume comes
> from sd.c. sd.c is certainly not equipped to handle a PCI error
> condition that has prevented a USB host controller from resuming.

Sure, but this doesn't mean that suspending or resuming the device is
a good idea until the error condition gets resolved.

> I am afraid this part of the API has issues. And they keep growing
> the more we divorce the device driver from the bus driver, which
> actually does the PM operation.

Well, in general suspending or resuming a device is a collaborative
effort and if one of the pieces falls over, making it work again
involves fixing up the failing piece and notifying the others that it
is ready again.  However, that part isn't covered and I'm not sure if
it can be covered in a sufficiently generic way.
