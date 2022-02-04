Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333104A9431
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbiBDGzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242384AbiBDGzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:55:42 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183FC06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 22:55:42 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id g3so33453qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrQwIpuL5QQfrgQ1xY53TifwqFAdlu7lxhrd4A0K1Og=;
        b=ZUhCgpFYZFBMz0t/T/beYFLKyn+oTMgDvYNPCbrlZ+O0b0zjcOqM77KZwgcsko/rfY
         Opae/By9+juSbUqZyAJn3N+M/IW4QNYoDVqQn5S8v1Wg9cw35yR5424cTMW/AzJfReQW
         d4r4Sn5ZhN1aL1JuGq5Xyb2RcWHA5vjxUlYPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrQwIpuL5QQfrgQ1xY53TifwqFAdlu7lxhrd4A0K1Og=;
        b=geOgxHztpWYUNroPCgSPTIweCdAgpafbez6xJgqEVQUPPVA6TsRfaL6caOZ7bVE0lu
         8CthvFnQfm8ukdd7OCAvl+SKiEbIo/cG9SZ2qj1YTMe0nqiBjWkG5WunFlGFnTpqwf2/
         aueQFvWmaf4a/U5t8kpfgjr5AmuykaisCJQoib32PL3IIfo/qIzpcjF0K88WQ2NchfnW
         jdmgrn8T58QPAls5M5v/N0qjbnXPhk7v1J2jeOfpm9OYCBdsLmJ08MNPfkvtp7xr8YD/
         m1ayWfdtfRnb8yvPY+Z67Q4KlfgBVEhNM2Fi9p+oCueJJx55HhOddrVW5sLJzVuyv/1W
         18YA==
X-Gm-Message-State: AOAM532W/ltKaN8hxrdjlR2zsOLaE0OrnYP+waxB7V0tFtXHrU4DdDeN
        ZYLT7AKf8Esi9ClKeiTxXrWfiAHQ6+ufwU3Gcu8=
X-Google-Smtp-Source: ABdhPJxIjXiua+2yaEudTWQZyVYtPJtC/dM9ic+ZK8TwsIe6R0AL7UGzZh5w9Deg7uDYYn4w0AGn6vDx1cg4HSF2Ovg=
X-Received: by 2002:ad4:5f89:: with SMTP id jp9mr908243qvb.130.1643957739826;
 Thu, 03 Feb 2022 22:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20220203115344.267159-1-joel@jms.id.au> <20220203115344.267159-2-joel@jms.id.au>
 <YfvONCxvTTuWqI+J@kroah.com>
In-Reply-To: <YfvONCxvTTuWqI+J@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 4 Feb 2022 06:55:26 +0000
Message-ID: <CACPK8Xf-gEkMUxB=numzbzQyM7f+YioUcocDP9=6T4VaF822sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] firmware: Add boot information to sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 at 12:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 03, 2022 at 10:23:42PM +1030, Joel Stanley wrote:

> > diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
> > new file mode 100644
> > index 000000000000..3fe630b061b9
> > --- /dev/null
> > +++ b/include/linux/firmware_bootinfo.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> I have to ask, do you really mean "or later"?

Yeah. That's what we're told we should use.

> > +/* Copyright 2022 IBM Corp. */
> > +
> > +#include <linux/sysfs.h>
> > +#include <linux/init.h>
> > +
> > +#define BOOTINFO_SET(b, n, v) b.n.en = true; b.n.val = v
>
> Please use a while {} loop around these two statements.
>
> Didn't checkpatch warn you about that?

No, it didn't. I'll add it.

>
> > +struct bootinfo_entry {
> > +     bool en;
>
> What does "en" mean?  "enabled"?  If so, please spell it out.
>
> > +     bool val;
>
> How can a "value" have a boolean?  Is this "valid"?  Again, please spell
> it out, we have no lack of letters to use here to keep people from being
> confused.

I meant value. I think it's reasonable for a value to be true or
false. I'll make the names clearer with docs as you suggest.

>
> Can you please use kernel-doc comments to describe this structure?
>
>
> > +};
> > +
> > +struct bootinfo {
> > +     struct bootinfo_entry abr_image;
> > +     struct bootinfo_entry low_security_key;
> > +     struct bootinfo_entry otp_protected;
> > +     struct bootinfo_entry secure_boot;
> > +     struct bootinfo_entry uart_boot;
> > +};
>
> Same here, please use kernel-doc
>
> > +
> > +int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init);
>
> __init is not needed on a function definition like this.

ack.
