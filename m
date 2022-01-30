Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216954A35D7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbiA3LEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242270AbiA3LEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:04:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBBCC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:04:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id n8so20964965lfq.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=bxlyxF/EC8bTAR3d0TLEeaeVlQi35TqmVD7n3vCbavI=;
        b=Rb+lSRxHbxob/Ic74S73x7dboMK/vjsrOhLRmlHXTY0UcvDe+A01djucQTLJ5aF0ee
         xaJgTd18lCL2S8NbZijvYwTjO8qchTw30veISMMMDYNrugj94BEtCr15/4cPBQWS+4gU
         tcauokmFlOU8h724lMEBMYYiRfvei97Sdk61ECGSY1+BmRvyJban3pz4329P7NNUTUF4
         sVVzfmUYpidWtqVlrS8fKR8LvLk2TqINYr1FU6qvbgRJs3Igr1BcVMcVBtPHlVrMhsLW
         f3eoZ8ev9id5iL7KT4BWNbCoj5uS+FZO0JUXc8Jd0l0osPFfN7A9UsH5kVWogfQHxXeF
         8S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=bxlyxF/EC8bTAR3d0TLEeaeVlQi35TqmVD7n3vCbavI=;
        b=2iuK/29Eq4zoiBdUpeJqNZ9yNQvmXDA8Ttz6JBpeCv3gb6R4zHGWeNCPWmZmLvuRLM
         KAYLEG1t48zeQy4qNTNyavctQgTjeVmsWgYqMwbFpJl7tSitlYOajCMU6dYdU381tCRR
         H8vN7UZ8YJlXF576AzWa2bJBtaV4PMZ9kmbDFlH/o4yykYZpehA+0K6lMVzdSZwtrSOD
         tslB8SENrbpXKy0iFB8Sw74faWB8j020hlYD95aBvx9M12u7HxSL+8XSy/6LLB+2fHka
         rFFLlNrmhmyvPbEZjrto7yW1INaAXVij0T+/poNgHKYFdmNq2EZF6jOOxk1LYLxfwohH
         QNwA==
X-Gm-Message-State: AOAM533/DMCMYDXN+Bj1dMCUlvNMn8ghJ7UAsGvdanFYf32JvDPo4kau
        jkl5dza4tz6MXMFkUTzWZmQ=
X-Google-Smtp-Source: ABdhPJwjyY27OzuJcBoolWvFSnRfBiH5kr2z5VBWsTElJy1GUg5fFtub5fpPbFklnrBgvEpgTiJrfw==
X-Received: by 2002:a05:6512:3223:: with SMTP id f3mr11654547lfe.203.1643540668159;
        Sun, 30 Jan 2022 03:04:28 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id z3sm3247459lfu.8.2022.01.30.03.04.26
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Jan 2022 03:04:27 -0800 (PST)
Date:   Sun, 30 Jan 2022 14:10:20 +0300
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
Message-ID: <20220130111020.44gzrm5ckrakjta2@localhost.localdomain>
User-Agent: mtt
References: <s5ha6fy46jt.wl-tiwai@suse.de>
 <20220114183720.n46wealclg6spxkp@localhost.localdomain>
 <s5hsftp3027.wl-tiwai@suse.de>
 <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
 <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
 <s5ho83yldu3.wl-tiwai@suse.de>
 <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 05:47:07PM +0300, Alexander Sergeyev wrote:
> But unbind-bind problems with IO_PAGE_FAULT and "out of range cmd" are not 
> eliminated. IO_PAGE_FAULT are often logged without accompanying "out of range 
> cmd". And after adding debugging printk() I haven't managed to trigger "out 
> of range cmd" yet. But IO_PAGE_FAULT are more easily triggered.

IO_PAGE_FAULTs go away with CONFIG_IOMMU_DEFAULT_PASSTHROUGH enabled. As I 
understand, this leads to reduced DMA device isolation which is generally not 
desirable. I was initially thinking about races between some delayed code and 
io-memory pages unmapping, but first IO_PAGE_FAULTs (running non-passthrough 
iommu) happen during bind operations as well.

What is also interesting, unbind & bind consistently fails on 31th bind:

echo -n '0000:05:00.6' > /sys/bus/pci/drivers/snd_hda_intel/bind
-bash: echo: write error: No such device

And does not recover from there until a reboot.
