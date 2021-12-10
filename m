Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7734C46FA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhLJGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:10:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36386
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236848AbhLJGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:10:02 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2CEDF402EA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639116384;
        bh=gD558dGTsqZPPqVUuXs9/pBTwBroTzKLjNW1jVNpBk4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Zjxf4NgFP17vOxYSTMdNO4Ledzzaj+LWlXgN6h/v4osxmoLjV8WZSR21Xu5do3qqi
         H4FletjkgOHQcVTp+1EJIfjlUTSYB7o7w1jsDkCoTZtfNOQaDJWlvHD0vOd8kwaimt
         /vICQRhlb/C7L7ZzumNfQygovuUwRlfWBZzsN8neFgadpjZyjbUqp4f1rTcKU0Jn97
         UvdkbxAGvErJ9LXg8EZredEpajtWTGjghKyfQEn+GomfxvfYucZ1zfPCwMZEJiU9/W
         e3OZyiygXiaX4t5KxRaKJUM7c7VXM2HwwK0qTnodVnwNv7RiW0exQgzKyMc17WVpu/
         9mIy4G9XWGwFg==
Received: by mail-ot1-f70.google.com with SMTP id z16-20020a056830129000b0055c7b3ceaf5so2941582otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 22:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gD558dGTsqZPPqVUuXs9/pBTwBroTzKLjNW1jVNpBk4=;
        b=Zp17LbA6tFKIE+IcHaYpWXeIBy9IZsv/YJ6TCMGvLpyHH8wXH8Iqd2ad5WwMJE5x2E
         hvnakON/Dz+cFhvf+Ol+4Lvby0E39tNqYHZfTlQoU1QunuTm8jPm5iTuTOEFQ9ShRD8H
         eUnmDb9pDyE7wS66u/40Snl9q0ZTO7EV/jEH35xjpCHqB2s662m4i8D1kqs8GlSUPCww
         GWhnQSnRS47g2vnZ3QdpQG4Cw24qKFih9KMRyrkl6OP/DhHBkQLIS03HROG5wbzZB0Qp
         0Ymwpuk/CzgmqR7eAYi3ARyE+9y9hBhGFwdVmY5446yp9ebUzqZRlatw8WUo1S5WOeLC
         G5Cg==
X-Gm-Message-State: AOAM531r/mdakmtbMfQHi8LDD0aMueTTNTa8DlRnmJyxwilPsF+fZ70a
        3c6e2rwjToRIULU+qh6pdxa4oUG8xuPdv5F/qjaTc4OFQpFmHxfOBVVOrMVCd6GzNOcLzSjKN9e
        MhaZD0qtzTSqDS1vI8sCT4IQQmOeSMC2ZmgIo69GhEOs/xi/8LOLmAmu8RA==
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr9791609oth.233.1639116382621;
        Thu, 09 Dec 2021 22:06:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybhcdHJs6z65gxvDmqz0jJ8dw6+/mS/4MLMLTUVjIZYX0zGjN5gmZTu85abimAPCGmSWdsyRqzBVaK43lFBUs=
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr9791590oth.233.1639116382329;
 Thu, 09 Dec 2021 22:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20211208070835.8877-1-kai.heng.feng@canonical.com>
 <YbEnf2NUr/BCV4Gb@rowland.harvard.edu> <CAAd53p61w-AHBxy05Hx-gwae1rUxZxsaVfmH=--bQUkPxYj8Nw@mail.gmail.com>
 <YbIo/ZBRgK5NDZJb@rowland.harvard.edu>
In-Reply-To: <YbIo/ZBRgK5NDZJb@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 10 Dec 2021 14:06:10 +0800
Message-ID: <CAAd53p5HfGz-D-QvYvPuDY4qLe0nYncY077=n-gvnYym4A8E0w@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: Resume hubs to find newly connected device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:04 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Dec 09, 2021 at 09:19:24AM +0800, Kai-Heng Feng wrote:
> > On Thu, Dec 9, 2021 at 5:45 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, Dec 08, 2021 at 03:08:33PM +0800, Kai-Heng Feng wrote:
> > > > When a new USB device gets plugged to nested hubs, the affected hub,
> > > > which connects to usb 2-1.4-port2, doesn't report there's any change,
> > > > hence the nested hubs go back to runtime suspend like nothing happened:
> > >
> > > That's a bug in the hub.  When there's a change in the connection status
> > > of one of its ports, it should report this change to the kernel.
> >
> > I think it should, but when I searched through the USB spec and I
> > can't find anywhere specify hub requires to report it in change
> > status.
>
> USB-2.0 spec, section 11.24.2.7.2.1 (C_PORT_CONNECTION):
>
>         This bit is set when the PORT_CONNECTION bit changes because of an
>         attach or detach detect event (see Section 7.1.7.3). This bit will be
>         cleared to zero by a ClearPortFeature(C_PORT_CONNECTION) request or
>         while the port is in the Powered-off state.

It's indeed set for the hub's downstream facing port, and that's why
wake up the hub and check its ports can still find connect event.
But I can't find anywhere stats how hub's upstream facing port should be set.

>
> > > So because of this buggy hub, you now want to wake up _every_ hub in the
> > > system whenever any wakeup event occurs?  Is this really a good idea?
> > > Is there a better way to solve the problem, such as a special quirk
> > > flag?
> >
> > If there's no other activities, the USB hub should go back to suspend
> > immediately, so the impact is minimal.
>
> Not immediately, but after a few seconds.  However your patch will affect every
> hub, not just the one that the new device was plugged into.

Yes, that's the case here.

>
> > I've seen several similar bug reports so I think this solution should
> > be applied for all hubs.
>
> Maybe those bug reports all had something in common, such as the type of hub or
> the bus speed they were running at.  Did you check?

The hub in question is a SuperSpeed hub. Let me scan bug reports on
Launchpad and see what I can find.

Kai-Heng

>
> Alan Stern
