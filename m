Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2648CD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiALVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiALVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:02:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74117C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:02:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q25so15027691edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0y8/DCgq5hZnDJBZZ+unJQ7Ag/9BizfTiSabuR5qJc=;
        b=D5yTq1A/5pRzAQkh38F/fitw9MKfBwSLUBnuqP3TMABFR5E2bfYBaKTkxkuHFZxh+W
         qCPbEdgCAb8npafSnXmf3ElOSiav1Yzph4Iu0/aMQ3ax1lWitYkW3rDQi+N3GDhiurVX
         LDvbHpQwtxo3gE8ztI9ImhSEThcoEL24ZbsCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0y8/DCgq5hZnDJBZZ+unJQ7Ag/9BizfTiSabuR5qJc=;
        b=HhjDq56CrLRj1HiFzhW+fnLsgIW0LikA3WSmoDB+tijYOf7ZnOQJKiSsaW052YNjmX
         +EdLVH/6TE5En5AdzqDuIBcqq+R9Z4p1cVh6Z6Ue6aOg5mrnKiBzhphzf+iXr7uoQQci
         EAmPi0cbElw31PTnkOm+jMDIt1VTR7SYDzcILjvZ29y6yqmeBwlRzBphnloV1P0igjP8
         5+PeULWXUaNJ3KpQu9RwK39OqfUNYo6veTO4DfKtuIbdSjzXS252p1M5m1KOI/uOD1Hj
         N5tCi8i1e4G1DohbcbUuRdI1xC0NFxLnHn8CV+in9I/3jdgWYdzkIhtZki/k2rYNcemQ
         SMZw==
X-Gm-Message-State: AOAM532dWu9nYilaLN/stU9AKuJ5IVW5hOw/p5vXYpZOHTZVmsk3eWP8
        GviG3qlXUV5idqHBF6LMquVxgFgCJ1EsUFN6
X-Google-Smtp-Source: ABdhPJw7mKNepRA04MbjYukEUzLaTwMpEPXQVeuLXS8EN4jxMfNyGtEgOI3ZECG92ltmHWG9tyFEsQ==
X-Received: by 2002:a50:8d16:: with SMTP id s22mr1274064eds.141.1642021372627;
        Wed, 12 Jan 2022 13:02:52 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id bc13sm333364edb.23.2022.01.12.13.02.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 13:02:51 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id o3so6437169wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:02:51 -0800 (PST)
X-Received: by 2002:a05:6000:14e:: with SMTP id r14mr1261616wrx.442.1642021370787;
 Wed, 12 Jan 2022 13:02:50 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
 <CAHk-=whcTsfaQWjNKP+DUSqfo+3rf1o8-N9CpjpogMhAxiJZ=Q@mail.gmail.com>
 <Yd88UBp9uaDSc2qW@smile.fi.intel.com> <Yd9AbO+Id7y1+IY+@smile.fi.intel.com>
In-Reply-To: <Yd9AbO+Id7y1+IY+@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jan 2022 13:02:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJe8Z7-C23Cn6CWE=zYEO0AazfTohSkpVLJo1SffPgzQ@mail.gmail.com>
Message-ID: <CAHk-=wgJe8Z7-C23Cn6CWE=zYEO0AazfTohSkpVLJo1SffPgzQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control changes for v5.17
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Now you may easily see what happened.

I still have no idea how any sort wouldn't sort that CONFIG_PINCTRL_ST
line first, since even if it's about the following characters, both
')' and '.' would normally sort before any letters at least in ASCII.

So I can only assume it's something that takes  the locale into
account in odd ways, or just has some special rules for non-alpha
sorting.

But I don't find it in myself to care apart from noting the
strangeness of it all.

            Linus
