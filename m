Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B548FA02
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiAPAip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiAPAio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:38:44 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED7C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:38:44 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w188so17980033oiw.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xq1STW/9GWXWNpMTgrEANORa+fFhQI5P1Xh1Ux8Ap7E=;
        b=S/WGipPOi+aDaNKPU2W8GTv/m3kK9LmuVfzsLaYXeLm0+2aUx9j3qiGyVfnNb86HO3
         uAu0/PqIedCkjPsAzuAB0DDPRocf48Qd+VQTKcHpEiopVFbzn/oep4vkXBhjpTncDTJ1
         NoySbok2W+5d3+E+3fxBMoYkxu7mXLgkEyyNTRZpCeXhvk89K9Ztsg4k0GUyM2r//Kzo
         LuvjlYorZ///4oXPV2ZQZLIt/pHCuKmkW/+jrE/j6V3Y7GOCDJc83dJDAepj1kqKVPjg
         psuJTy94gVNyOqb6HeCRzEgRpuRhokAs4WxDs1kuWyH7Ck0J1fQck9SoDFxoW9K/4VPB
         +xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xq1STW/9GWXWNpMTgrEANORa+fFhQI5P1Xh1Ux8Ap7E=;
        b=wudxsY3BIk8p/0ljbObQ7ERM/suKcs/wBCeExo3YIA9JJz/k1HbSNZoDL/NS3Zr0X0
         x7hZN+fCJuNug7pkXRPjLfVbotoFxqCKlYUEvCCCrTaXnw56lr9i++dYXCl/leHXTkm1
         GErB5TMgcQDnjZadwhb510ZrXizP5IkVdDLlTd4Ti5xfnnlU8ayZ3DhxMhe2msWyEent
         bt6kn81yasvA9Evh4SlynrE7s0bJDa58qyRC9am818zK9xaWjISVzPLv3ObkNRM/c15U
         MmyGLLbt7lj1iZc65lWrgxDQwvGXYc2Wk1/xN6rEPZUhDLotcSoC2wxxgjWAqmZGo7JR
         VtUQ==
X-Gm-Message-State: AOAM530673CoIs/jqKf+xttdynMDjWfRrEXr9ap/FkkUvhbRh+MXxh8Y
        YANrEp1FsFb9vqcQsp+bOhnDvAob0YPGVqeJsXH7Qw==
X-Google-Smtp-Source: ABdhPJz42hl7ypfOI7dDD092Ja9BAFGUUKC1+kMjBppzuKHX4HH94KrnMiQemb4kuGpj7lBiKnd/mFuhjgCZnQx/J0w=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr8315616oiw.132.1642293523401;
 Sat, 15 Jan 2022 16:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:38:32 +0100
Message-ID: <CACRpkdY+Jdn_Yr4BpuXssTn=6wjDPm9mMgz3yrjVGw8=UzKbzQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 6:34 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> This is version 4 of the WPCM450 pinctrl/GPIO driver patchset,
> with some small, (hopefully) final improvements and cleanups
> (see patches 4 and 5).

It looks good to me, but I'd like some confirmation that Andy
is happy with it.

> I'm targetting 5.18, it's now too close to the 5.17 merge window anyway.

Could you rebase it on v5.17-rc and resend it once that comes out?
It would help me a lot to have a known good baseline.

Thanks!
Linus Walleij
