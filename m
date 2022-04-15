Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A64502D38
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349281AbiDOPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiDOPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:43:14 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5392338;
        Fri, 15 Apr 2022 08:40:46 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id z33so15077894ybh.5;
        Fri, 15 Apr 2022 08:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siQwI8deKdhHuH3vRXoSE7cu7PIu6L4/ZKF1nngalP8=;
        b=lJted+6nzCX/TmPSEV27OEVQ+FB0znDWFH+ESkGqvymGUsFAlNeIsiY8r8n7/u7iTf
         klMFOUQPp+GZaIgziXQxVBZ20AY3gwikjNLsskuhKsRIAtUFrmJKd87/AnPa3WjA9eGS
         k+g0muoLaKKNtcffZ6rusJ0Z+E5gDGNv3qz3Tfq2aJ5LEv+Xp5TYQPKdtlgedJ1Bae+t
         FRovKjOFdfYqmTFLviU8dvACxA4hMDjI0MIQmQHbdnjeajUXw0LyP/jtL8iQ/nrpGtlE
         OqPvwzRkH+YTaO3AhxHA+SR73Vi/v1Rl2C6DOwcZMNUbiK+HgcNz3HjeWlmn3FZTB518
         tC4Q==
X-Gm-Message-State: AOAM532MJ4X+SVM6efcQapXoJ4B4fO0YO00+v2X2Uw2Tx4hP7JNtLtD2
        ZTujW+wRu6jWrrbfHcEMmjGAy4nTn0SMs9tml8c=
X-Google-Smtp-Source: ABdhPJxW2Py97UUCGXi4mm+J3kzUaSrm2VZ814zQbxslS3B6faAjoAZXHccBUUiOJ56uqCFyhUQzMtJDS6hFu4QYUsI=
X-Received: by 2002:a25:ac9b:0:b0:641:3c32:bee7 with SMTP id
 x27-20020a25ac9b000000b006413c32bee7mr5453873ybi.633.1650037245392; Fri, 15
 Apr 2022 08:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
 <YlcUMNe5gDsEca4f@smile.fi.intel.com> <YlcVFRQ9wJIH+sjI@smile.fi.intel.com>
 <YldE6L7MbgS0NXQY@paasikivi.fi.intel.com> <YlgdGb/vKfdCXXx1@smile.fi.intel.com>
In-Reply-To: <YlgdGb/vKfdCXXx1@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Apr 2022 17:40:34 +0200
Message-ID: <CAJZ5v0gHROpQqWXOh6fZo4k-=1_w0x9=e0fQBvU4TrShwRFiFA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 14, 2022 at 12:47:20AM +0300, Sakari Ailus wrote:
> > On Wed, Apr 13, 2022 at 09:23:17PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 13, 2022 at 09:19:28PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 13, 2022 at 08:10:22PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Apr 8, 2022 at 8:49 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > > > -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> > > > > > +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
> > > > > >  {
> > > >
> > > > > >         if (!fwnode_has_op(fwnode, get))
> > > > > >                 return fwnode;
> > > >
> > > > ^^^^, so it needs a casting, but then we have to comment why is so.
> > >
> > > Note, it means that the fwnode parameter either invalid or has no given option.
> > > It's not a problem to drop casting in the first case, but the second one should
> > > be justified and Sakari wants to be sure that the initial container is not
> > > const, which seems can't be achieved even with the original code.
> >
> > I wonder if I'm missing something. The fwnode argument originally was not
> > const here.
>
> Yes, and our discussion went to the direction of what const qualifier implies
> here. I assume that the const means that we do not modify the fwnode object,
> while its container is another story which we have no influence on. You, if
> I read your messages correctly, insisting that const here implies that the
> container object is const as well.
>
> Reading current implementation I see now, that with children APIs we have
> two pointers passed, while with parent APIs only a single one. In children
> API due to above is easy to use const qualifier for the first argument.
> Parent APIs missed that and hence have this problem that we can't constify
> their parameters.
>
> to_of_node() expects const parameter while returns non-const container.
> Is it a subtle issue there? (I believe it should be consistent then)

This is fine AFAICS.

The const parameter means that to_of_node() will not update the memory
pointed to by it, which is correct.

The value returned by it may be used by its caller in whatever way
they like, because the caller has no obligation to preserve the memory
pointed to by it, unless they've also received that pointer with the
const qualifier, but then they need to know how it is related to the
to_of_node() return value and what to do with it.

IOW, to_of_node() has no information on its caller's obligations with
respect to the memory pointed to by its argument, so it is OK for it
to return a non-const result.  Moreover, if it had done otherwise, it
might have created an obligation for the caller that didn't exist
before.

> This patch and the followed one can be moved without understanding why
> we need the non-const parameter there.

I'm not sure what you mean here, sorry.
