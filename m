Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BBF4FFDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiDMSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiDMSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:24:18 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098DD1EC69;
        Wed, 13 Apr 2022 11:21:53 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ebd70a4cf5so32081327b3.3;
        Wed, 13 Apr 2022 11:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Loh92sh7gXXIMM+xZlFKvmQrGTMosnWDw8l4bYatwi4=;
        b=MwZ27xmwaA6Pddjb51TOWoKalJXTfY7u4eZZ12Gx1/pUzLloequcx39RE/6kIyBZAn
         KrM1rV8W/bT7SjWxjDS7T/8pOmnhpRtBjP2sd9A+qBjxHqFMMJF9bijadHn43VZ8RPDN
         Vaoz+6IlsHueKZxa54CBs+f/jOqsrE/akXXfEXCwCqviq77HyBtEp/LHlJmS+ibpSxVc
         EdlmsMKikrNCrmCpB7VGi0VgB7KhbyO0i1McirT+5F1xBh2mLxH5un3Y8HYMwrjP37TI
         eC2f+e31J38qNRu/9lunnBTWljCK13jGrXeMxlr09dhPYDJa2Y+a0ANbbFk1Nj0nKhP6
         ifCQ==
X-Gm-Message-State: AOAM531i96Ent0eoA75sj+l9aqOku8nPXZyiFl5ufzES+sUjt1ai0xrH
        xaZ3nds7K4RipDlZq7tNIkSeKtIGSjX5wAdfZfg=
X-Google-Smtp-Source: ABdhPJy0QfC7cfF9K+H0ZNCn7FaTuWEXk3t/NydqhNkNaQqbHedbuHrlNSZApLdviurLxeWz0TiBOt/IaTXl2hhEWMo=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr165747ywa.19.1649874112323; Wed, 13
 Apr 2022 11:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <YlCq79KveByePxe9@paasikivi.fi.intel.com> <CAHp75Ve-5=6bsF1mMQ4RceobV=OsR6VwZeP==iFGQJLEbt0-yg@mail.gmail.com>
 <YlbfwjQcxj6fK7re@paasikivi.fi.intel.com> <YlcAYpZ0yB6wh1uA@smile.fi.intel.com>
In-Reply-To: <YlcAYpZ0yB6wh1uA@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:21:41 +0200
Message-ID: <CAJZ5v0jcDztpR4rn0JqksCDwbFzq8VD8nZG-9QypQo63y-h1Sg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 6:58 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 13, 2022 at 05:35:46PM +0300, Sakari Ailus wrote:
> > On Sun, Apr 10, 2022 at 05:10:23PM +0300, Andy Shevchenko wrote:
> > > On Sat, Apr 9, 2022 at 2:35 AM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > > On Fri, Apr 08, 2022 at 09:48:43PM +0300, Andy Shevchenko wrote:
> > > > > As to_of_node() suggests and the way the code in the OF and software node
> > > > > back ends actually uses the fwnode handle, it may be constified. Do this
> > > > > for good.
> > > >
> > > > How?
> > > >
> > > > If the fwnode is const, then the struct it contains must be presumed to be
> > > > const, too.
> > >
> > > Why? The idea is that we are not updating the fwnode, but the container.
> > > The container may or may not be const. It's orthogonal, no?
> >
> > As you wrote: may or may not. The stricter requirement, i.e. const, must be
> > thus followed. I think it would be fine (after adding a comment on what is
> > being done) if you *know* the container struct is not const. But that is
> > not the case here.
>
> But even with the original code one may not guarantee that. How the original
> code works or prevents of using a const container against non-const fwnode
> pointer?

I don't think that this is the point here.

If const struct fwnode_handle *fwnode is passed to the ->get()
callback, the callback itself (and any function called by it)
shouldn't attempt to update the memory pointed to by fwnode.  It need
not be the memory starting at the fwnode address IIUC, so that would
cover the whole object the fwnode is embedded in.

This way the caller of ->get() can assume the immutability of the
memory passed to it for read access.

The question is whether or not ->get() needs to update the memory in
question.  If it doesn't, making fwnode const is correct.
