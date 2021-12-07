Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6348546B1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhLGDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:52:10 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52442
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234400AbhLGDwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:52:09 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E3F53F1BA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638848916;
        bh=oKuPbwQTn9l3ivjW4HOB3TsWnJVEANZ6w2H8mPDmtZI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lHtovbBq25SrZA663bHWx/rvCvKKXOQgOVaH810LmXGUVTmmrt9ZUCJS/yUuw8tFf
         g79XXKyp309kAVO2ZegCWHRQ2R8m5SzgV2xZ5BAuynzjPbm8bAeN/gW8qELQmq2ZYW
         NUzb85+9/7IIygXTH0/g7KeUeQCxyhJX6U5O/MIqAqKMH34J0bDrEf3WWg3q/wJ0y+
         iYF/G+tDCoLMziJk8ohsBk+6kXeShbwA/Gboe1M9/nlPNB2zYJHMSoUWHZw8qvjyJ1
         WarwviJPWAiVyuQHYHWWlREnHh80yqdk6JjCODlMDidD7NR5zmRo1lUUGHH9qidgzU
         w8kD8+XILEtXQ==
Received: by mail-oi1-f199.google.com with SMTP id bm27-20020a0568081a9b00b002bd445624cdso9625817oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 19:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKuPbwQTn9l3ivjW4HOB3TsWnJVEANZ6w2H8mPDmtZI=;
        b=rzFqldqC9CqTEA4qUdjylxSyvVZcV4fWzmY1Cr6czKlrtFh8bXxC8UrmnPs5tNxaNN
         PK8qyIBBMohiW/NDf3Isfs7yfM8b6TB1Kiyl7gu92BgUDeTdlysxBP6tNZ3EC+IDxuBI
         lsR6hriQJZj/SZwRiNO7BTegC2JcZwwJkItElpDyFZfPm0oHHUN4HPK+FjVHmLxPeYqX
         5lTOt5ilL81zPJSxHUaHisQWLuZtIkEzORAuB5hw8MT8jtQYcUEkbf+MTxUTKOIN0QOO
         1dF4FEKSEQh+nOt7NsG59m7ff8VdQhopUV2PbVc9tbC8OzaRPh8z0hXD5B4ns8xRRLWL
         qIKQ==
X-Gm-Message-State: AOAM533Sqbz6ADkIGk9b+hU48YUlsn25hiqHUqnbhuGaRaZOIDYsuatk
        1r1rfSODrEzEPY6TdheZgVSWwTF52da+bo70hz6vi1TFntJqAJ+U5aDDuTO/A6jv4j0mjpEEvG7
        V2GxuYP2xQvkBXont1cNgSFhXyIKp7jvR6r7bybc420cVwgnGW6zO7PcTBQ==
X-Received: by 2002:a4a:9406:: with SMTP id h6mr25259295ooi.80.1638848915299;
        Mon, 06 Dec 2021 19:48:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwdVBQRzwe/XtZ36ycwvtkY6L1d7+yU1qfzf1krp8YZEdPzfO4+xEtG9YrQ3gSxzbh3c1vru0yxixD7+s1/UY=
X-Received: by 2002:a4a:9406:: with SMTP id h6mr25259284ooi.80.1638848914987;
 Mon, 06 Dec 2021 19:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20211204030452.1482507-1-kai.heng.feng@canonical.com> <CAHp75VccS43XVophOW=+5=A4p4cUiwvXdwGp-yU+BNDN3cOu3g@mail.gmail.com>
In-Reply-To: <CAHp75VccS43XVophOW=+5=A4p4cUiwvXdwGp-yU+BNDN3cOu3g@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 7 Dec 2021 11:48:23 +0800
Message-ID: <CAAd53p7L6Wcp7wBeHRp7NDPbKJ+kPPAPXi27zWQ08jZbt3M6aA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Assume 0 by default for PNP UID
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andy@kernel.org" <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 8:49 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Saturday, December 4, 2021, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > There's an EHL board that the DSDT doesn't have _UID for pinctrl device,
> > and that causes a NULL pointer dereference in strcmp().
> >
> > So in the absence of _UID, assume it's 0 by default to avoid the issue
> > and get a pinmap.
>
> Do you have updated firmware?

Customer confirmed new code drop from Intel does have _UID defined.
So I guess this patch is not needed anymore?

Kai-Heng

>
>
> --
> With Best Regards,
> Andy Shevchenko
