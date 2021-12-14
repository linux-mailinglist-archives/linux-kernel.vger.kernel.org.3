Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB3473CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhLNFx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:53:59 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59378
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230045AbhLNFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:53:58 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5C013F4B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639461237;
        bh=0/qQRLtF8a22mPdnKriVPX9p7Fl5BEnFhsEpo3VjKNY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KVlBD7bzvDHsRhE7e5pZdbMGDXMT2/pA25gO3Gw4p6qLIUGdmMi/yIIvkzU9NmTBS
         TXmS8L1rxz8N97E/P6jhnAB1fPWJ1gvNej8Fw86+Pcn451Jggm+tiv1R89IspnGqEZ
         b4hfvOK9VcDKeWtglAUqly3I3cWG2u42I8H+/lBtY+cqkZSf6COjqXX9tH9Rqul19V
         jFaaVdggQ3zEIato11dyCoqIqi86hJcnSOHKluOhcfk4CLbSo1htldLLN5YufAyJ4k
         r6ILl998kBYGRqz1968guroDwuyFuKB0cnZ3IHBZs90XorSoCymyUZLU7KyJx0k7jq
         VcTp5Yw01pXcg==
Received: by mail-oi1-f197.google.com with SMTP id j125-20020aca3c83000000b002bc93dd9241so12315145oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/qQRLtF8a22mPdnKriVPX9p7Fl5BEnFhsEpo3VjKNY=;
        b=tMRZSppTH5ITQBIj6O/2lOc0VinP4MzBP6MPtkZ+OAnrj+gq+z7xcjJaEUIfp9xbx+
         0QD/c/L+597TG1pUAMGVulQXbn+xWrF8BobgZQ5Om+HfqzUgDBXm60xrjG+4XFMKjp7R
         4dgakK8/5tE4X4N36COR7ho21ldnrMM8YV3GwdH8e8Ahlcoxj0sgwB0aKL1B+1RAWbLj
         YyMel2mhezAXkr36RGVQ9JUoVoJmfa7XsXbHDC8+A+XjRg0rrnevm/ceLM7EsS7smNE0
         1Rbwj3twO2KZH6t2Pk/mLvlmR4FjEuMuDH+/JH+j6HKwWi6rpN7XVtf+O8psuYoGOAq1
         FTTA==
X-Gm-Message-State: AOAM5303uMfXDBnCSz3I0ikhNnIkjxE5P+xKInqKVMFmFDjjPpVhf5po
        J/zHGyjcH2bDtiXrfWanN0k2TgwPMkG5BcmlbMkqDO4UUmyq/1OBPf1eCRipdCFP6CG4VQITfL4
        C6D9qBaCP1uLql5inn5ZZEDyNhvy7ZoDR6QbjRm2FjqcdXlM9tJGWu0sXkQ==
X-Received: by 2002:aca:ab84:: with SMTP id u126mr30810079oie.41.1639461236568;
        Mon, 13 Dec 2021 21:53:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoGBvcLA8wUYeZIWQ7TMEHHWKYi3fljr0QNgTSWL43Olys/u/zfpiNcMtUwGvvhKvjbdBv6K4pbvy6FDCHi9A=
X-Received: by 2002:aca:ab84:: with SMTP id u126mr30810055oie.41.1639461236205;
 Mon, 13 Dec 2021 21:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20211208070835.8877-1-kai.heng.feng@canonical.com>
 <YbEnf2NUr/BCV4Gb@rowland.harvard.edu> <CAAd53p61w-AHBxy05Hx-gwae1rUxZxsaVfmH=--bQUkPxYj8Nw@mail.gmail.com>
 <YbIo/ZBRgK5NDZJb@rowland.harvard.edu> <CAAd53p5HfGz-D-QvYvPuDY4qLe0nYncY077=n-gvnYym4A8E0w@mail.gmail.com>
 <YbN/8AOHHR7fNFGd@rowland.harvard.edu>
In-Reply-To: <YbN/8AOHHR7fNFGd@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 14 Dec 2021 13:53:44 +0800
Message-ID: <CAAd53p6pCb6x6x-YXicXHwUeor3HJ+fx8z_j7F6cCSBoM1OG1g@mail.gmail.com>
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

On Sat, Dec 11, 2021 at 12:27 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Dec 10, 2021 at 02:06:10PM +0800, Kai-Heng Feng wrote:
> > On Fri, Dec 10, 2021 at 12:04 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 09:19:24AM +0800, Kai-Heng Feng wrote:
> > > > On Thu, Dec 9, 2021 at 5:45 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Wed, Dec 08, 2021 at 03:08:33PM +0800, Kai-Heng Feng wrote:
> > > > > > When a new USB device gets plugged to nested hubs, the affected hub,
> > > > > > which connects to usb 2-1.4-port2, doesn't report there's any change,
> > > > > > hence the nested hubs go back to runtime suspend like nothing happened:
> > > > >
> > > > > That's a bug in the hub.  When there's a change in the connection status
> > > > > of one of its ports, it should report this change to the kernel.
> > > >
> > > > I think it should, but when I searched through the USB spec and I
> > > > can't find anywhere specify hub requires to report it in change
> > > > status.
> > >
> > > USB-2.0 spec, section 11.24.2.7.2.1 (C_PORT_CONNECTION):
> > >
> > >         This bit is set when the PORT_CONNECTION bit changes because of an
> > >         attach or detach detect event (see Section 7.1.7.3). This bit will be
> > >         cleared to zero by a ClearPortFeature(C_PORT_CONNECTION) request or
> > >         while the port is in the Powered-off state.
> >
> > It's indeed set for the hub's downstream facing port, and that's why
> > wake up the hub and check its ports can still find connect event.
> > But I can't find anywhere stats how hub's upstream facing port should be set.
>
> It looks like the port status-change bits don't get set in response to a
> wakeup signal, for SuperSpeed links.  Section C.1.2.3 in the USB-3.1
> spec says:
>
>         Note that C_PORT_LINK_STATE is not asserted in the event of a
>         remote wakeup. As discussed previously, in the event of a
>         Remote Wakeup the associated function sends the host a Function
>         Wake device notification packet.
>
> I don't know if we receive those Function Wake notification packets, or
> what we do with them.
>
> In any case, section C.1.4.5 says that during remote wakeup, all of the
> links from the remote wakeup device up to the controlling hub transition
> to U0.  But your log extract showed:
>
> [  281.110147] usb 2-1.4-port2: status 0263 change 0000
>
> So even though the 2-1.4.2 hub originated a wakeup signal, the upstream
> link to the 2-1.4 hub remained in U3 according to these status bits.
> Could it be that we need to include an extra delay, so the link has
> enough time to get into the U0 state?

You are right, adding delay works and it can get to U0.
This only happens to USB3 devices, the hub has no problem detecting
USB2 devices.
Let me prepare v2 for this.

Kai-Heng

>
> Maybe Mathias can help investigate this issue.
>
> Alan Stern
