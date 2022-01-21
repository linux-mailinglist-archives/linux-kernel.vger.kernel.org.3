Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F1495DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380007AbiAUK2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344593AbiAUK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:28:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17CC061574;
        Fri, 21 Jan 2022 02:28:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so26930571edt.6;
        Fri, 21 Jan 2022 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YTbY1T0th9FlgLE+y1cmjd6nPDOK5Mo4NKzJkpO+nY=;
        b=Uc9Eq3gFDreyO0TiPr/A5WXeLxBpv9JnLBXcPtzcyMr8WspUbhjZMBtd7SCJQJoZ7X
         ByiLZyjSW6PNQRBmB5QVSz9bNDDee7+j3+4DtoGEVDfZ6mCJt7zpOKTScKJzoZZ4OxQI
         BYxfw0E+mmoMcKx9HrbLyDqSyA9MHTn80aTl4q/SWwCY6i+PyGenbYmuyWG3aRm61Pwm
         rwUfeD1EfJiDFyffZwHBFwdNXXEF/zAOGg1+wscPflwY4NWw2h3JDunafHYfmRpsto/j
         jHLMLBA0i/feX1cu4JUfcaBnzRBtMAN+N62fi9/Qse+UAawU4+xabsgqFc78yvnebVJT
         BClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YTbY1T0th9FlgLE+y1cmjd6nPDOK5Mo4NKzJkpO+nY=;
        b=LpDMUiddzsO9vLhGrbS3mUlJqgQWoWNZ6XYhbSEP5RYrXq6ezEjRk/Pr0a4J1PFgF6
         c1xcykdtB7F8Cty4qZIPlBafRsW1b3RHhdc/OMWm41zWZxoA9AJ/ReLEdubmSq8PGT0x
         U7CG1s87e/vtJdXIRcLiNuIlb0ijMFCfrR6YUKTo5QOTWNeB+FIfAMY5jGrHAU945sWz
         B1847VNbzXfQ5xck1t19ieiK1XFa+JQM9q68xPdedTs3f1XAC8cz1PVmt0B2jf95zwGn
         PxTxG1ZVtfPtEdYXPY1tNHHxgtCpxksaYGNWD7ZCFpjahSukttjDemN7cHS1jlbk272d
         fcHQ==
X-Gm-Message-State: AOAM532v5YgaUmLd8jVPNNgC3kTwcudbQuVEOFDcv7RLSRC6hcciigQ1
        HZGk5pzAfmOfDPX5OSTMDPBKD4HacUaRyWK/wdmdD2sD/UtLxA==
X-Google-Smtp-Source: ABdhPJwk/gzx6qo+6nl7Eu0aoZil8vPZuVhGJJZAl5vufe0kYyn9R5J2ofDTjDYQModnpNU5qy2MckXBBeP5GqKxaAU=
X-Received: by 2002:a17:907:9802:: with SMTP id ji2mr2886960ejc.44.1642760896412;
 Fri, 21 Jan 2022 02:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20220121093426.6336-1-grace.kao@intel.com>
In-Reply-To: <20220121093426.6336-1-grace.kao@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jan 2022 12:27:40 +0200
Message-ID: <CAHp75VfD72ZzTw4wc4Oteg+XvRqRipN-YjLqQjUGGy8f83By+w@mail.gmail.com>
Subject: Re: pinctrl: intel: Fix a glitch when updating IRQ flags on a
 preconfigured line
To:     Grace Kao <grace.kao@intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kane Chen <kane.chen@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:35 AM Grace Kao <grace.kao@intel.com> wrote:

> Tested-by: Grace Kao <grace.kao@intel.com>

Thanks for testing. I will apply the tag to the original patch. The
idea that you simply reply to the original message with the line above
and that's it, no need to resend a full patch.

> Change-Id: I6ff5cf0c42a76dce709a445c1820c8f3a84d6d89

I see it comes from the internal tree.


-- 
With Best Regards,
Andy Shevchenko
