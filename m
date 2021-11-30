Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4249F463D02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbhK3Rol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbhK3Roi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:44:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC16C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:41:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 137so18184304wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgi8hVAxJ2TC6lAQZcV7YIf3cslbDjz/FU37PQWsli0=;
        b=qWcEKjhS9fZxpthQ0sYoRA1mHDvYqBvtUfeqHNrQ0BDIg+02mH3WwN77xCgRzB6MaD
         5o8FaxMnn5F/sb1kB6F27fIvo46TINJc2gOF5b24aWGcHLnsGw/giiveZYRv/HAgGhYz
         onXo6RokHNdVlOmefDIehZFEaoll2Qzl5BhdnnPhvXqHWjaPB5ApiusiCxRvx1050UVh
         TSuSRVxM9G5SHMwr99VECJtZ1h8dMO5i2qOZbNgI69Zvo6AFPLjZd3GjE4ENeJ5kSOZK
         9s+q5LMrCpmEnXbYzHy2UdE+loIRJCza0Kkp5xFK6fT9bBIgat6CWGHmPJ6eFzqYmWuP
         PMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgi8hVAxJ2TC6lAQZcV7YIf3cslbDjz/FU37PQWsli0=;
        b=laEw3S0w8stV/tfRwjk1G1IGrhbGo6l0Tn4oZSeAJVyu+TinS5uiaLyZ5430ou/OZl
         B/pr6484xhX/on3/lxCRAmTTFdzUEE/2MIQhpQbhrJBWkdceiF0ifi17yiP0h6CPemUE
         80I850a1PeQ89sZphEtpfxndsGenkJdxWL3l8f1OdqHOogfyygngYg3pKBujn7OgdB2E
         uJ8TqkfXfUTE5gDFe2NqfEilTNdP6675GpUluOqm2pox8t8YfNPPEUFCeCWlqGsvWmch
         6OHWP8YhMyONQncIAlWt+9coxjQxNxpUXPBi0VU4ArzLJ6w5s3e0E9qZVS3nBjX4M8VO
         4XFw==
X-Gm-Message-State: AOAM532chyRTsQLNn0nglECXAaIY5vkvtTvuE/0W1gPxLoACIXohSDkH
        traJlWcMq+WiGRko4ceIOcti1HCIb9pVAdBMN3Q=
X-Google-Smtp-Source: ABdhPJwhnV01V8gG6iYtFPGsQ5YkF+4GQRLPbqDPYOVqcxI9xtzW4TnJhFihxZBeGpP0rt5m8BM4SaONGY5cZSsG3WM=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr54768wmf.177.1638294077177;
 Tue, 30 Nov 2021 09:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-8-daniel.baluta@oss.nxp.com> <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
 <bdbea252-09e4-eb60-acf8-4ea8a1d924c4@linux.intel.com> <YaZZzSPQDz0vHRQY@sirena.org.uk>
In-Reply-To: <YaZZzSPQDz0vHRQY@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 30 Nov 2021 19:41:05 +0200
Message-ID: <CAEnQRZA7Nr+MMP7v+4T8G2y4L4HvSPVdoy4zekBFgynXJ16tCg@mail.gmail.com>
Subject: Re: [PATCH 07/21] ASoC: amd: Add module to determine ACP configuration
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        AjitKumar.Pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Julian.Schroeder@amd.com, linux-mediatek@lists.infradead.org,
        Balakishore.pati@amd.com,
        =?UTF-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        vishnuvardhanrao.ravulapati@amd.com, vsreddy@amd.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 10:49:30AM -0600, Pierre-Louis Bossart wrote:
>
> > To Geert's point, there may be an additional need to add a
>
> > depends on SND_SOC_AMD_ACP
>
> > There are also a set of
>
> > SND_SOC_AMD_ACPyx options, not sure if any applies as a dependency here?
>
> Or put them in an if block (IIRC I thought they were which was why the
> dependency wasn't needed but I don't know what I was looking at if I did
> check that).

There will be some delays in handling this as I'm in vacation until next Monday.
