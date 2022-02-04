Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FE4A9F54
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376742AbiBDSk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiBDSk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:40:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7FAC061714;
        Fri,  4 Feb 2022 10:40:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u24so14721439eds.11;
        Fri, 04 Feb 2022 10:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZGtsZQhsyyrcBRG0j+lN7s+2dtv9Gc6gA1EuDqdvH6c=;
        b=arbPf9n8sfnhQZJyx/AG6Ogn3hTOZNDvfPc3y4PXMWw0EU1rRvj/PZe+bJaIiZPrZF
         GzxbYbOwJ+BEbyeXSUIEEpVR/2Xmn5hGAur7LjX1uDiLnn078w3UbrUDCb/++eYe+Pgz
         WvC6vIIenYdbvxtvQyF4iJTVPbJtgllBWEdDgOPk/LhnrmjwTWQwMHXVV4gTgXUEX9Yf
         JQyDXXhAGSkxLNW5Z7PbEA7VY2IjvMRo4q1IMF3L95GOOfH6pTCFccRkL0yhqlpAldDc
         6XtQoIVjkm2mTo7EUIZUM5aQ/ESJuY3mgS+Jlm66J8pgxox4gqKlvsOpzS4qzvy7dwjc
         cnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZGtsZQhsyyrcBRG0j+lN7s+2dtv9Gc6gA1EuDqdvH6c=;
        b=Hg55LuA4M25YSy241pa5i4u/m5SWbGhhsi5v5DcxoTOd0Iabc/u8dC+XHfoAwn1KfY
         0niBQl1uMyd2jJTDevlAhD50zBhYAWH0U7d4TL/tKhN5bChEfrck0GtTHt/OLCfrYIWe
         7ZynIyKTHWqO9oUtoFZcf+F3oR3m8cbbE4q+OQfo8IBcZmg7wy4W0K9O6Vugoak6inQP
         T7eB5ThHwzvFjZIz9//AbprMMA4nCwvtqrqWz/ykqKVIhs5y6Wv4iFtPoEY6WiqJ2mLV
         mZki8BMsUUs35n/xEZWlcL3FQpfQECTkWVkjWJDLcrByI06p9S6iSCMhupY3wPs9+lTv
         gRzQ==
X-Gm-Message-State: AOAM533cbpk+/s7GZNEhSzB8Ghi2pnENS5FEX/sOVkeczeBrt2Efma1W
        Qo6Xvit39j2ZP8h0Uj2fcQLrn6t0NjI2sXC3NTo=
X-Google-Smtp-Source: ABdhPJxEm7NFYtDxqO0RvMy0fL2LAK2EIChbvzMQZ6XV4+dfC4ZuIY9e4NkrESmCV42jrxrTkFZjDGNZWYNdx/76ARk=
X-Received: by 2002:aa7:dd8f:: with SMTP id g15mr489557edv.436.1644000024185;
 Fri, 04 Feb 2022 10:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-6-sean.anderson@seco.com> <CAHp75Vc--RYW7P0wLA8Jcr53xKSkphJV=wTeZiPC-AYu4sGYFA@mail.gmail.com>
 <2c1832a5-1e13-1423-2be8-e31b5ec5195a@seco.com>
In-Reply-To: <2c1832a5-1e13-1423-2be8-e31b5ec5195a@seco.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Feb 2022 20:38:50 +0200
Message-ID: <CAHp75VfGFNFqOU0BymNwh_FWKVw+rSyJJRDSKOinWY_Z39qaGA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 6:00 PM Sean Anderson <sean.anderson@seco.com> wrote=
:
> On 2/4/22 7:54 AM, Andy Shevchenko wrote:

...

> > On Thursday, January 27, 2022, Sean Anderson <sean.anderson@seco.com <m=
ailto:sean.anderson@seco.com>> wrote:

> > Is it function or interface clock?
> >
> > We have standard property for the functional clock rate, I.e. =E2=80=9C=
clock-frequency=E2=80=9D (in Hz), can it be used here?
>
> I believe this is a "functional" clock. It it is a reference for the USB
> signals. I'm not sure exactly what the purpose of this clock is, since I
> do not have access to the databook for this IP. I considered using
> "clock-frequency", but I am concerned about ambiguity because there is a
> second "suspend" clock which is also a "functional" clock. The latter
> clock appears to be used when the PHY is shut down (and not necessarily
> corresponding to Linux's notion of a suspended device). If it is
> necessary in the future to configure that clock on ACPI platforms (e.g.
> to set GCTL.PWRDNSCALE) I think it is clear what the property name would
> be (snps,susp-clock-frequency-hz).

In order to have more or less unified APIs in the future I would
suggest using 'clock-frequency' for the "main" functional clock. For
example, 8250_dw uses it for the baud rate generator, while it also
utilizes auxiliary clock(s) on some platforms.

--=20
With Best Regards,
Andy Shevchenko
