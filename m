Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4B46ADCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356640AbhLFW7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347563AbhLFW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:59:20 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387AC061746;
        Mon,  6 Dec 2021 14:55:51 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F284A60A;
        Mon,  6 Dec 2021 22:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F284A60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638831351; bh=LuBhzR7FOxfb7YPaVwP4X0uDjEZMXDsoXzc1WIvbeL8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Qrb6Zk02LqufGsjRjhPu0aeP7eCYhJnT596rWdLQDdjBphOWEUscArze6XEy0Ptnk
         VfcZKpn708HfzPOM24AAx6CYF72wUUmwa8koTRACt2L2lHJCMXbu26L0CXFslRkNBf
         ImbYVOQ4+z+2MgoZIfB+kbnnQJrkSNXkfq3EF6dMTHQj1LX3PJHgdvWGTdEtpKFFox
         plC5Em5rijZCs8FQqxfc3NFF/PUnxLuiMBRUumhqWrBYSv/ApWQCwQO8wI70mwfbWa
         QRZObkfx5BczodKv3ze6qPJ6yPvDf3jEAQFYbjwcBf3OwnI11umI92PalFB0gXjHyr
         X5qGkwQBLtCbA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
In-Reply-To: <20211206211421.6eeb990d@coco.lan>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
 <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
 <878rwx35v7.fsf@meer.lwn.net> <20211206211421.6eeb990d@coco.lan>
Date:   Mon, 06 Dec 2021 15:55:50 -0700
Message-ID: <87mtld1gy1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Mon, 06 Dec 2021 12:12:12 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> 
>> > Instead of having RTD as an almost mandatory theme, allow the
>> > user to select other themes via a THEMES environment var.
>> >
>> > There's a catch, though: as the current theme override logic is
>> > dependent of the RTD theme, we need to move the code which
>> > adds the CSS overrides to be inside the RTD theme logic.
>> >
>> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> > ---
>> >
>> > See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/
>> >
>> >  Documentation/Makefile             |  3 ++
>> >  Documentation/conf.py              | 52 +++++++++++++++++-------------
>> >  Documentation/doc-guide/sphinx.rst |  8 +++++
>> >  3 files changed, 41 insertions(+), 22 deletions(-)  
>> 
>> So I'm playing with this now, and definitely want to apply it.  I do
>> have one little worry, though...  THEME seems like an overly general
>> name to use here, and seems relatively likely to conflict with other
>> uses.  THEME= on the command line is fine, but what do you think about
>> something like DOCS_THEME for the environment variable?  Or even
>> HTML_THEME as Sphinx uses?
>
> I'm not sure if we will ever consider a "THEME" environment var for anything
> but docs and html stuff. That's why I ended taking the shortest name (for
> both THEME and CSS make vars).
>
> Yet, I'm OK if to use whatever name you think it would work best.

I don't doubt we'll have BPF themes one of these years...:)

Seriously, though, I was thinking about uses beyond building kernels.
If I, say, always want to build with the alabaster theme, and so set
THEME to effect that, will it then mess with my desktop environment or
some such?

A quick search doesn't turn up anything, so probably I'm worrying too
much.  Maybe I should just apply it as-is, and we can change it if a
conflict turns up.

Thanks,

jon
