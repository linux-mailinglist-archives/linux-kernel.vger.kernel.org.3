Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3197E476EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhLPKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236128AbhLPKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639651011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNKVWqh9lxh9Grr+ulLOOV8QYTTYcK7iY8OykZzbHhQ=;
        b=Hsxq2EN2kWMul+VyKzWLmy9C2QFM32dgDmVP2TnaS26c4LQ5r0Geam0q7QP8F7Lt10LPtG
        mz2bQbxqKShYeVGEx7UpA69H7yrZuyQJ+SNPDoG8/fq5KCnbg9PfRnXxMsXs+fBqVsUF2X
        aThgigeSGw3XHKeXSsSU0imR27P9NmM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-4jjt-_nsMWe6WEfUEIzFrA-1; Thu, 16 Dec 2021 05:36:50 -0500
X-MC-Unique: 4jjt-_nsMWe6WEfUEIzFrA-1
Received: by mail-pj1-f69.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso1465501pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNKVWqh9lxh9Grr+ulLOOV8QYTTYcK7iY8OykZzbHhQ=;
        b=zt1gplJFXoA+qGGRXJ8HEMgIVAYJPt/RrM+4bIlmovcdlMyQmxvEx0yxI0IpRV0xx1
         yMidybiVVRHL1xL00gXa5qJox9sANexduuxvUluzkCrrPCIe9hG8OWqo2VHjJfrlLL9j
         52EDksoRz7M9Fs17WmDDc3129FMUyWKGAEIEjkLVO91SFQqoIp/am0rtFoZNAhdxIMl4
         jbGI/s75zpPHwfFjptyue5KZJfPGCi6yjS18SKdgpAjU+5CFigC7fegW5D62vsaYEMuT
         EY+LCrD24yowTDEgF8aP6FJbRcl9/JO2nLa5hgA9uHrcLIMFXJa2SL0SNUfQ0hjUOGml
         JHKg==
X-Gm-Message-State: AOAM530pz+W+PxihZOZ3e9JimPlccMcig5FvgGmYYJhWPGd4zxs2AzrY
        cLpjRVoidYj9bz6a2vQxWPqa9NZPwi5JcWJjCdHaKBkmEjUAatFXdgDD7/CwzW1ELiqGOmwtfUL
        +q4PcLbz9qsBM7DIYSvhbXFB7+9IrBXfAtV+8nCsp
X-Received: by 2002:a63:ea51:: with SMTP id l17mr11594800pgk.363.1639651009531;
        Thu, 16 Dec 2021 02:36:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8BgAyAP7ogoS70w55qoy/NR8MoIchYzF9iRxpRTE6C/dcU+rowv7TA61xTF+tB2Mqi/JKOnRQHRwo8GDEOv8=
X-Received: by 2002:a63:ea51:: with SMTP id l17mr11594781pgk.363.1639651009203;
 Thu, 16 Dec 2021 02:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
In-Reply-To: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 16 Dec 2021 11:36:37 +0100
Message-ID: <CAO-hwJ+nm3jUo9znsROjc0=e_3aGOq-L43OVvUHwBewtwODJfA@mail.gmail.com>
Subject: Re: [RFCv5 0/2] HID: Add USI support
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On Wed, Dec 15, 2021 at 2:42 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi,
>
> These two patches add the missing pieces for HID USI support. First one
> adds the HID core changes to support the new Misc events for pen ID,
> line color and line style. The second patch adds a BPF program on top of
> the HID-BPF driver which adds support for writing the Pen parameters
> from userspace, and to add filtering of HID low level events for ELAN
> USI controller. The BPF programs are not built by the kernel as of now
> (there are no Makefile changes), as there is a plan to most likely
> integrate these to a kernel external repository. I have tested these in
> my own external build setup though, and I can provide the makefile for
> that if needed. Also a sample client program is provided for
> communicating with the D-BUS server.

I had a deeper look at the recordings, and I am very worried in what I
am seeing:
- the USI parameters seems to be transmitted only after the touch
- the USI parameters takes *a lot* of time to be transmitted (2 bytes
every 2 reports)
- the recording of the goodix one starts with a stylus touch without hovering
- the only "reliable" information we get when hovering seems to be the
transducer index

So I am wondering a few things:
- what happens when you switch between pens?
  * Do we immediately get a different transducer index?
  * Are the values right there or do they also take time to be updated?
- on the goodix one, do you still need to issue a get_report on the
feature to get the USI parameters, even when you change the pen?

Could you give me the following recording (with an updated hid-tools
master branch):
- on the Elan:
  * start the recording from a fresh boot (no BPF loaded)
  * hover for a few secs the first USI pen you have
  * touch it for a few secs
  * release, then out of proximity
  * approach the other pen
  * touch
  * release, out of prox
  * then once again with the first pen
  * then once again with the second pen

- on the goodix: same thing

- on the goodix: same thing but with a BPF program to trigger the
GET_REPORT if you can cook one quickly (not a big issue if you can
not).

The reason I am asking about those recordings is because with the 2
logs you kindly provided, there is no way we can forward the raw
information to userspace. So I am slightly tempted to only rely on a
USI manager, in the form of the BPF program in 2/2 to transmit that
information to userspace.

If this is bulky just for the first event, then the input events might
be OK, we can assume when the application needs those events they will
be there.

>
> I have also a kernel testing branch available at [1], which contains a
> few fix patches on top of Benjamin's HID-BPF driver work, and is rebased
> on top of latest hid/for-next. The HID-BPF fixes have been cleaned up a
> bit compared to previous setup. There are also a couple of new patches
> for adding support for a delayed_work BPF program on top of the
> hid-bpf driver; this is used to execute the raw_requests in non-irq
> context.

Thanks for that. I had a very quick look. I thought we could directly
use the bpf_timer_* functions instead of having to cook another API.
I'll play around with this, but thanks for pushing forward :)

IIRC you asked me when I was counting on submitting the HID BPF work.

So my answer is that I wanted to submit it by the end of 2021, but it
looks like I have only one week to finalize this :/

The current missing points are:
- add selftests for all the new API introduced
- review the entire API to not have to deal with a mistake forever
- rebase against bpf-next

One part of the API I am wondering is whether it is good or not to
have bpf_hid_foreach_rdesc_item(). This function is complex and we
could in theory parse the report descriptor in userspace, even before
we load the program. So all the parameters you need in the various
raw_event functions could be computed in user space, leading to a much
smaller API. The other benefit would be that the API would only deal
with arrays of bytes, which is a small enough and versatile enough API
:)

Cheers,
Benjamin

>
> -Tero
>
> [1] https://github.com/t-kristo/linux/tree/usi-5.16-v5-bpf
>
>

