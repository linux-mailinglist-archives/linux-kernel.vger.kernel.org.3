Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B144761B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbhLOT23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbhLOT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:28:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07CC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:28:15 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bk14so33096982oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Kj/BFZO3Hvw7KDfmOPPURsnohWF/YRKh55lIf7IVKHo=;
        b=lCWWDWlNGmoaQYNw7R9rVb+To+hJEvRVSPt7PpnoF5B9IY03uFCB60WnVPVc7MDaB4
         uQXUGTJmaDI5pssqR2T/medK1mKMSm+gUjRJMnFjtuviNhkqtadA1biCe76mEqzpLjN6
         w7RkGh7zOrp0/IJp6H/EK9yF2f82JlAtO4OcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Kj/BFZO3Hvw7KDfmOPPURsnohWF/YRKh55lIf7IVKHo=;
        b=PiHluEGGI16nI7017KXj+uznP7I7lLYb4y2xApvLCB7VYCaSRVYiN8FaxzDRyKL3bV
         4tmq9wL69L3cguWkjEAKq7YyJwyzfdNgMyKXARbyqDhWQvqaBVY0g8DHbQexuAY6RiGV
         JyFBxXjq3XqrR6hJff2XYniJcOUNIG6ef2kbZyBRSDrOCewkyghMHDfmRfeRznLNMEVS
         cdVFWocaTRrQR0OhNAIotA8fecES+XRjsN/PZsB2UdORZ/Sx5B0pNVFtu6msMe0Rlp/b
         D4vRULX19jnzx2+5iULGH6MPuLrXMIEx0fQYXmNV9VxDKV8o99OCObBQqioDP8getKa3
         9nxg==
X-Gm-Message-State: AOAM532/2VuAiu61VzpaWTNH1GEvAX1/DMcbbl5CWe8zno6JSFHFAwms
        TgA24/Y2eJ+vs/geHTZLvYfTLrYXwKEPe8rTrRTppg==
X-Google-Smtp-Source: ABdhPJy2pVCa/ZruIwIjC9oyWlykk+V4rc88WGJyUS/ok5EcGwhGV2BAEEhsZ2wXJGNqoOY0NphDKrG1WoAaBp2N8Gc=
X-Received: by 2002:a05:6808:211f:: with SMTP id r31mr1299622oiw.64.1639596494559;
 Wed, 15 Dec 2021 11:28:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 11:28:14 -0800
MIME-Version: 1.0
In-Reply-To: <Ybm6KQiS7B28QOSW@kernel.org>
References: <20211215072011.496998-1-swboyd@chromium.org> <Ybm6KQiS7B28QOSW@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 11:28:14 -0800
Message-ID: <CAE-0n53sMjF7-STAyn=snT5NSAMYSXhkBXJ4ay_fPiB_DbV_gg@mail.gmail.com>
Subject: Re: [PATCH v2] of/fdt: Don't worry about non-memory region overlap
 for no-map
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Rapoport (2021-12-15 01:49:29)
> Hi,
>
> On Tue, Dec 14, 2021 at 11:20:11PM -0800, Stephen Boyd wrote:
> > In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> > already reserved regions") we returned -EBUSY when trying to mark
> > regions as no-map when they're in the reserved memory node. This if
> > condition will still trigger though if the DT has a /memreserve/ that
> > completely subsumes the no-map memory carveouts in the reserved memory
> > node. Let's only consider this to be a problem if we're trying to mark a
> > region as no-map and it is actually memory. If it isn't memory,
> > presumably it was removed from the memory map via /memreserve/ and thus
> > can't be mapped anyway.
>
> I have no objections for this patch, but I afraid that this is a never
> ending story of reservation vs nomap ordering and this won't be the last
> fix in the area.

Ugh ok

>
> I was toying with the idea to use flags in memblock.reserved to have
> clearer view of how the reserved memory was used and then we won't need
> to guess firmware intentions.
> Thoughts?

My understanding of the commit being fixed was that it tried to detect
bad DT where two reserved regions overlapped and different reserved
memory regions stomped on each other. It certainly seems like that could
be improved by recording what reserved memory region it belongs to, but
within memblock I don't know if it cares. I thought memblock just cared
to find out what is memory and what is supposed to be mapped into the
page tables.

>
> > This silences a warning seen at boot on sc7180-trogdor.dtsi boards that
> > have /memreserve/ populated by the bootloader where those reserved
> > regions overlap with the reserved-memory carveouts that we have in DT
> > for other purposes like communicating with remote processors.
>
> Do you mind adding the relevant pats of the device tree to the changelog?

Sure. Let me add the reserved memory snippet.
