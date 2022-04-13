Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914264FFD74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiDMSJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiDMSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:09:01 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E54C7A4;
        Wed, 13 Apr 2022 11:06:38 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f17so5171853ybj.10;
        Wed, 13 Apr 2022 11:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfKhK3uqPfbVCv99PeforoVikIn2c2jPfy2wcY5O6XQ=;
        b=IROXXhwF7RTi0KF5eJPG02cvSsZcZnN1pmC4VG7VPBjlF5V8i+SU/Rva2nn7F42hKp
         oUkAIE6K2DStYXp5I0THDAEFTiPiWP9ThSkmfaP+O1snqRZNTE9eiP7JiMplQ7jH10tC
         C76Tphv/9vVKVqXQNROfXJjLW5OnJ/ItTDSHqvYXM/DP7eBZjOv3lDpPIkoN3ThkKUfP
         yNMW1k4tKcV2EAsKkoMuPz1TkFR/XVJyL1irkqsMZQev6s76uqVhvGt8C3Pmz/PUEFc/
         C/qH+c3GzGH4TIjjMf872ZwMf4zTXE0LE2qM8UuQmLR83z6GEWfGx3P1W9q0Q9WVIEWr
         h1UA==
X-Gm-Message-State: AOAM53108I5q+7t+NbZFomqy0Ax/K9UkacqC1Mo+XI8Dfj7Gtd4FbUVA
        Bxqc+twcQ8IaWRf3xxpj5M8VnaiGW4zDs2P1yfI=
X-Google-Smtp-Source: ABdhPJyVhsbJNC6CH+LKu5oL5g1G0fNXh+jBfotxvCkl81nkSFlFJP/32iJp4rXNNfAsYouo/NgBrKKwRMHeh+6lGqM=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr81011ybs.365.1649873198214; Wed, 13 Apr
 2022 11:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <YlQyEz3/J0rb2Hew@smile.fi.intel.com> <YlQ69jMduq/evgTt@kroah.com> <YlRNPyxHcNRQE/5A@smile.fi.intel.com>
In-Reply-To: <YlRNPyxHcNRQE/5A@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:06:27 +0200
Message-ID: <CAJZ5v0gGc8cVzGgXVuHW6hQ67h9b+HfSj_EqFPCOrTfjYGVOUg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] device property: Allow error pointer to be passed
 to fwnode APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Michael Walle <michael@walle.cc>
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

On Mon, Apr 11, 2022 at 5:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 11, 2022 at 04:28:06PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 11, 2022 at 04:50:11PM +0300, Andy Shevchenko wrote:
> > > On Fri, Apr 08, 2022 at 09:48:40PM +0300, Andy Shevchenko wrote:
> > > > Some of the fwnode APIs might return an error pointer instead of NULL
> > > > or valid fwnode handle. The result of such API call may be considered
> > > > optional and hence the test for it is usually done in a form of
> > > >
> > > >   fwnode = fwnode_find_reference(...);
> > > >   if (IS_ERR(fwnode))
> > > >           ...error handling...
> > > >
> > > > Nevertheless the resulting fwnode may have bumped the reference count
> > > > and hence caller of the above API is obliged to call fwnode_handle_put().
> > > > Since fwnode may be not valid either as NULL or error pointer the check
> > > > has to be performed there. This approach uglifies the code and adds
> > > > a point of making a mistake, i.e. forgetting about error point case.
> > > >
> > > > To prevent this, allow an error pointer to be passed to the fwnode APIs.
> > >
> > > Rafael and Greg, if this okay for you, can the first three patches be
> > > applied, so we will have at least the fix in and consider constification
> > > a further work?
> >
> > Give us a chance, you sent this on friday and are asking about it first
> > thing Monday morning?
> >
> > Please go and review other patches sent on the list to help us catch up.
>
> OK! Reviewed (actually commented on) a few patches so far.

I've just queued up the first three patches in the series for 5.19.

Thanks!
