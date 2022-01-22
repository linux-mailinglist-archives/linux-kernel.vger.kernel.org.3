Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD34496C80
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiAVNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 08:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAVNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 08:16:25 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D540C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 05:16:25 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f24so14091121ioc.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cw8oAeTADjmoJN3cZNiurSuYAXwioROhV2ueLKFr/Q8=;
        b=Ja/bcenQsj94P7yALHaIcE63sVm4fcMxCZBvqEMdmQuRKX5VN9HhhF3npkq6RZU3c9
         DXrm7hTkHBiV72Xl9tESTx+wC2FTh2KNU45uzYNGgzLknL2GV4zyl3OQgkjwCyOe8+bv
         8cCyDc7V5UP6au3SY1x9yqX2AYBf82ZLarThNEEQ7Y0Zb3dAfijfWfqrGG8azN8CQINF
         wGsKgi6Cr1arnjnpeqEaKpIY7xjK7a8KjPkc2ripB4aJ2LnHoLGtu+qz6/YyJCTTU3Kz
         7n9SG99Xbh360iHzcbPcdd2Zgx0WOku9c2rpq3r1Tnw9VW9/q531WDG8bSBDLxHdpf4I
         +Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cw8oAeTADjmoJN3cZNiurSuYAXwioROhV2ueLKFr/Q8=;
        b=T5EmtqQazAyh6M3KUoEPvQjC7J0xyiNM3S0e+QNstohgatgsz8pF6gt2dCpxUkzcF6
         ar+tAt7NpJZnyIZ8mME1K0bSiKiJ6HAiUHGMLNE5sjrotpzYTHQQQP82/b+nsrAbAlQk
         N4L2VRSn/us2jv9i8eKG7rnBtNzw9HknGxsBHL0vMV2BslBwhDa0e9SHScWFJrozVDGQ
         AYx1w+pRxGfhMRCEBEHwGjyAx3MOJLCE5pO2CaR/9RdqNoJBD6crLm8y8O07Ugs82U5o
         QFXxHQk1HWirq6N7gKQXaijjb4qjNEARn9FPXHr6njTlLHNYIuSxlBSChKtnr6bPdsV4
         P37Q==
X-Gm-Message-State: AOAM532mzTOj+6NxsTphHkJDmccZmJffGMolt5KtnrI1EisrhXBeT6PV
        VCylYBTXqL/Fa0j4lyrdg1NaI7bnnVaJqoUR5bnNvgVe
X-Google-Smtp-Source: ABdhPJwBUkJHYgYALboncKIpReYuC45b7zGZ62CgNr/YMXLDZMIMeKLTT52BjoLT+YQyAxfbscDVy9ssZZFXhJkeeHo=
X-Received: by 2002:a05:6638:242:: with SMTP id w2mr3039454jaq.256.1642857385060;
 Sat, 22 Jan 2022 05:16:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
 <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
 <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
 <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com> <CANiq72=HdsTfQt5DWKf065pENN0xrOwvKq+T3JpHdyyRkPVx8w@mail.gmail.com>
In-Reply-To: <CANiq72=HdsTfQt5DWKf065pENN0xrOwvKq+T3JpHdyyRkPVx8w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Jan 2022 14:16:14 +0100
Message-ID: <CANiq72mmFn8KUjhcOHhTbWGCktK-HEvAQ+nz8HZhM598XqO2aw@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:41 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> So it is coming -- the question is whether we wait a bit until LLVM 11
> is the minimum supported version (nowadays LLVM 10) or we are willing
> to require LLVM 11.

LLVM 11 is now the minimum with commit df05c0e9496c ("Documentation:
Raise the minimum supported version of LLVM to 11.0.0"), so I will
give this a go.

Cheers,
Miguel
