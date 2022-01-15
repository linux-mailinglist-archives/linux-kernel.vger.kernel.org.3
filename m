Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790C48F7C4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiAOQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiAOQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:26:29 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:26:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x7so40878481lfu.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xnnkY/0N7vitggBHBYyS2U/q+4IqBCzhx6kWTZjGxw=;
        b=DFLIY5qvAceQd6eNdBXxvpVJFkF/1amxaCDjTsCXWvZv3f+yz4gz6EJXJRrlnLdcs6
         1yFfCIwuz8a4tluCjQrvtSChlWgk2L+rBBmiIHGUhaDZUqhWl1Kwf+29b2ssptS4eRvn
         L55UyaRl0eIFHWMH14JXMCJi9Nb3Z1t/DF77RdwurVr9CFIrM9Sod4bPaltxSTLNFlQD
         UZXz0SVdi8UUW8H1p9NKo6e70BcmwTahPZo7CQVWnKQmXpN8tOxRTInZEfjXPbdN8kpj
         PyBZmqb5DNywbSXYcvK+ZFLlymQ4EceTWle5V0ELPg7SAZjoBTUITJ17qxhxccSb0Jgd
         fv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=4xnnkY/0N7vitggBHBYyS2U/q+4IqBCzhx6kWTZjGxw=;
        b=7ztZ4A2P1EODNclivWjpJhVgPd6nim/aNmzjKipk76OnaioUfOa+LSdF4fgMeZ/9bh
         6JEivdVxeOgoX28Q9kiWSBJlhZqhz9U4+DGIVVa15jZQ/FleEKzTvuq/nnpAlVDKZImu
         L9gr/gB0ltZpbHCFb2nwj5WoMTCSEmXpGsKMrhlLZagJsZ8CLaSO81rMX09Jx/ymd7Bp
         Cin/z+c7BDTP5H+mv7/u6dTTtljEVKLNzmjIVhi9jMrnQKxZnDQmPHctX0UoSg/+CDhw
         nVTFQ9jktePcb+LYNuNUBQs6mYojG6ybd1/aA3giaX5CkCr+2Osjzcvt/VS8lZjP9hpA
         42Uw==
X-Gm-Message-State: AOAM532qkMKrRBA/O5nsWuldXnEwO2F6KNqIZ8s2hCWG3yWW1YQF5YKR
        OikK3uwuuvucfrIOB+B1D1o=
X-Google-Smtp-Source: ABdhPJyE6L8fzGlQGy/ier4fQfMSK2AuzP91lK0y4ZIb+Fm1j7k/Ep/M8wewAgqI+E5fn5Bd3pdLIw==
X-Received: by 2002:a2e:3508:: with SMTP id z8mr9974618ljz.37.1642263986739;
        Sat, 15 Jan 2022 08:26:26 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id x6sm902368lfn.144.2022.01.15.08.26.26
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 15 Jan 2022 08:26:26 -0800 (PST)
Date:   Sat, 15 Jan 2022 19:32:08 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ALSA: hda/realtek: fix speakers and micmute on HP
 855 G8
Message-ID: <20220115163208.xmvum6ehqcadonj7@localhost.localdomain>
User-Agent: mtt
References: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
 <20220114165050.ouw2nknuspclynro@localhost.localdomain>
 <CAAd53p6KXD2mEHgkU_TpTrsU-vQ9Vxdip+6sPfDaVoSOkmaz-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6KXD2mEHgkU_TpTrsU-vQ9Vxdip+6sPfDaVoSOkmaz-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 11:47:40PM +0800, Kai-Heng Feng wrote:
> > Note that the device can boot up with working speakers and micmute LED
> > without this patch, but the success rate would be quite low (order of
> > 16 working boots across 709 boots) at least for the built-in drivers
> > scenario. This also means that there are some timing issues during early
> > boot and this patch is a workaround.
>
> Does this issue happen to warm boot (reboot) or cold boot?

The issue is definitely not limited to warm boots only. I can confirm cold 
boots with no sound and also warm boots with functioning sound. With this in 
mind, the provided numbers (16 good boots across 709 boots) are largely coming 
from reboots since the testing was scripted and driven by SSH.

> If the issue only happen to warm boot, please try reverting commit
> 9d3fcb28f9b9 "Revert "PM: ACPI: reboot: Use S5 for reboot"".
> Many HP systems requires it to have a functional reboot.

Interesting. I haven't noticed anything breaking with reboots on this 
particular system (at least so far).
