Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69748C1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349595AbiALKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiALKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:07:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68348C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:07:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k21so6453711lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=GerQkM1D1/dtyEjqZ2IhcUhmklKFjm+Rp3i7RHnixt4=;
        b=g51pKtYy3n2X3cjA0vkZhWSvlnGSr9kigKTQ7qDEnhQho7zpS/e8HgntFCIy1VpWs5
         pphSrcDFAZnc/+UE9nFNJOQnDKVl+QEq/u9+7V5knHCzY1/elsE3sF789w8px7d5vPGj
         ef7BWooEl5EftaecqIhFZndwc6OSyIwh6plZcoQLBqmLDiyMTy8zJD18+fUX8F83POez
         z45rvIjiiEkss8wAI+EBNbnDLN53jZq4WmX1oyqawvVdL9vt0kzza+i247MTNyz2yep0
         H15V/GeT+ko4K2V+beHSWAZZ+F3s86XpPAgLk9F3TgXt5fEDIOcSquKzK0GPocRCJMnO
         bI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=GerQkM1D1/dtyEjqZ2IhcUhmklKFjm+Rp3i7RHnixt4=;
        b=Qaf2JErniENGPGQ1pqLrZkUTi3ssURBAYp5pu4CclJnT/HxCuQ3K/WYeSX4USWlpm5
         OdqyfDSB1qTqX8DvLy9BwQ7qwfmmnhKt1dZNMEFIsb/sza1Wv2eOlF4ORH7YcoMWCCMS
         3GEHhysLjGfqE0366axpeXo718C0Ss3a2Rtbgi3+eFcJ9z0NgJCWC8hhSeMxo+TPb0Eg
         cp3ElnXS/JdisqsqGKLii5qgux+Ea0Sx3qMRiYpzm0trbPXSD50250ECrdhuUesFGqPn
         JOGZKhEtIvYH6feizSLoCHiDLAIxRE4CMAf5ygOhj4YHdtk7G9iYic4l1brE9oWTr66u
         EnEg==
X-Gm-Message-State: AOAM530406K3h/+iMKuo0gRH+5el6T5v+peEX4GBOBAxvo25yc/Ntjmd
        +F2fqOVmypWlX5WsPBu6q6o=
X-Google-Smtp-Source: ABdhPJxVOClSrkFNSsDrkgnpv3GX6Jm5wp4/8uESYtlYdOwFu5Gi1NwJ6uTENYE6lOF4O+As6PzVdw==
X-Received: by 2002:a05:6512:114e:: with SMTP id m14mr6662011lfg.414.1641982029764;
        Wed, 12 Jan 2022 02:07:09 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id y9sm1597964lfl.235.2022.01.12.02.07.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 12 Jan 2022 02:07:09 -0800 (PST)
Date:   Wed, 12 Jan 2022 13:12:49 +0300
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
Message-ID: <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <s5ho84h9tit.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:45:46AM +0100, Takashi Iwai wrote:
>The problem is about the built-in drivers, or do you see the very same 
>problem even with modules?

The problem is definitely there for the built-in drivers which I've tested 
quite a lot. It's the primary usecase for me, as I tend to build minimal 
device-specific and self-contained kernels in Gentoo.

For builds with modules things are not very consistent. Live Ubuntu with an 
older (and probably vendor-patched) kernel works just fine, but when I pull 
Ubuntu kernel sources and build it with the mostly same config (including 
modules) it boots with no sound in Gentoo. Mostly same -- because I need nvme 
drivers to be built-in as I don't use initrd.

>AFAIK, quite a few AMD platforms tend to have some issues with various devices 
>showing initialization problems at the early boot. Just reloading / rebinding 
>the device later often helps.

Is it possible to do with the built-in drivers?
