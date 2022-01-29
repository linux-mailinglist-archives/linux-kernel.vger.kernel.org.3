Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0224A3010
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiA2OlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiA2OlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:41:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410DC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:41:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o12so17474227lfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=TsD8UeueTttBbcCHC8xUyUOJgggM70vG6Ymhib31NHo=;
        b=ftqe9oZG5U1OUJ0e9KhaRfFuHuU9Eu6WA3j07WrvrgMoj/UzMxautnN6JROsf9jQ/7
         v/YoXeu8xtCEwcNPhQk4fJQweFUbwfHl+IpRP2E45LO7y80FDxNWksAmau35j1ZQRk+D
         apG9ZP8jOUWupOqdeZKux9FhmrbQNyoHUt04Y/X8VoB7rP8nyWIcoEAldmWps8wCWHns
         q1FWA6SgQNsorJOHWWPhONjV2JpR/8mUkIw/lEYbdHS67g8JPdZZshURaeET2W0o/Q0g
         HllmJzIf7HPFe75WVQlVLRfaRndBCe5zJdV9QOiSNVbUVihYveDLeDgMxj1GVKP0DAL+
         7ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=TsD8UeueTttBbcCHC8xUyUOJgggM70vG6Ymhib31NHo=;
        b=KsVQ9VIxJaJWtW0fFGpgZ+/7QAMVknSzucILsFv1fGt/ercYEzzcyMfkB+8oLGL49D
         /bKl2BO1xbJJk9fRjKl6hSkrWjWjVjseHIoMQaBPXZtqVhY8HIWPrLHdhBYJVCewPtC9
         KW98c9PnJTf/FtEPjbRxrAHrYZnFObJOvBMExnAhlJU262rY8yoxCXy8M/1IG//9EPY6
         c6R23LrSCKT5ToSKLRBuv1dbmNpA6KXigSZqXA99cfXd8E4fezf5oLxAyFdiby/M5ur8
         YHwzblPt/RFF8a2hD1ur0oaVlztlSnST+LfcWyiANwup/ir+qpehpoHzfVU4Srmd6h9/
         WkNg==
X-Gm-Message-State: AOAM5313+m71FBd6RUsbbxh5wOHHncYDlXkvtTvWO3UHwUY4YJWhMMgS
        vMlLxM/mCTpWyvRHfip27M0=
X-Google-Smtp-Source: ABdhPJzpBphGrUIiWnPY3CxLFskI7SIHm2vjLCVJp+05tqtgRZmpG77Qs6l33CRF6B63CpQC63D5eQ==
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr9681599lfm.33.1643467274226;
        Sat, 29 Jan 2022 06:41:14 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id j2sm2215811lfp.256.2022.01.29.06.41.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 29 Jan 2022 06:41:13 -0800 (PST)
Date:   Sat, 29 Jan 2022 17:47:04 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>, tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
User-Agent: mtt
References: <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
 <s5ha6fy46jt.wl-tiwai@suse.de>
 <20220114183720.n46wealclg6spxkp@localhost.localdomain>
 <s5hsftp3027.wl-tiwai@suse.de>
 <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
 <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
 <s5ho83yldu3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ho83yldu3.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:24:36PM +0100, Takashi Iwai wrote:
> > Given that the CPU number is the same in alc_update_coefex_idx(), it seems 
> > these calls execution is interrupted and interleaved on the same core.
> > And, actually, there are two LEDs to set (mute and micmute). Am I onto 
> > something here?
> That's an interesting finding, and yes, such a race is quite
> possible. Below is a quick fix as an attempt to cover it.
> Could you give it a try?

Well, results are somewhat mixed.

With the supplied patch (with a mutex), the original fixup 91502a9a0b0d ("ALSA: 
hda/realtek: fix speakers and micmute on HP 855 G8") is no longer needed for 
speakers to work. So, the original timing issue is identified now.

But unbind-bind problems with IO_PAGE_FAULT and "out of range cmd" are not 
eliminated. IO_PAGE_FAULT are often logged without accompanying "out of range 
cmd". And after adding debugging printk() I haven't managed to trigger "out of 
range cmd" yet. But IO_PAGE_FAULT are more easily triggered.

Are there ways to trace origins of IO_PAGE_FAULT itself?
