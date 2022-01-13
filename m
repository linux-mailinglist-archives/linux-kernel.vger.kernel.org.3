Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1526C48DF70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiAMVN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiAMVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:13:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE87CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:13:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s30so23992106lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=HmqAYxgpA0scTJAvK7dTWukaikRwll6NfdHgV3FJwSE=;
        b=cWMt40jsjwER7A5AR26Fw81PawiMyOYQkOmbMQK1h/V+J+quNTA61VI1dxXtxjbbx7
         L5PIuCaAqT1XPrREVjJF3uUNG5mzo4aC/H1zafdm6YssoUdpoUeQPdsOE+7b4/iBxkDr
         R/CT05wxx2wWFLPjp2wjkr6/kFhXHFlQueks08IbprrsgEgBZ7msVKjHOE3nXLaM4jL4
         QunC41morUIb54/tnsr4lqy2O1OuDFpQj7l8YIuoJr7nJ45L5rkC4531rmK95RCYiLAp
         Im4CNh1Gu3FTpD602hrlF6JFmzxq6VvkBcgAVot06/L+8cdvJ9hXCUbqqWMLdNWExkAd
         Uacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=HmqAYxgpA0scTJAvK7dTWukaikRwll6NfdHgV3FJwSE=;
        b=QZX5fiCjSRCi6HRd1KpPt4qU3jtROUpwD41QRE+JbZxpoRVZk5ge2Bg4fK0oGy7a15
         Et/MpwnowLxbEa0cUxFPXzKn/nKGdJRrgdbrcbjeDgUJ360DjQeX1yDlTjvJtSXOuOGT
         fcLYMhQRM26l79txdXFdHtxIX887bbeOAOn7KbCHbYdrE+28XTktp4YOaFPdshPySjVx
         uZJMoebaTblb5CKU/QhpmV9WSIKrjFAuX4yoR8jjelvqa/ccPe9/galgyK5qXub831yY
         gIvDNvz4GHFraiRJgz9G0spGVnI8xDkuzvXHZEtAeoNZXNZwh7vfdkQvgetKF0zXrfIF
         pCiw==
X-Gm-Message-State: AOAM530spmusueTy1+YaPPOz5dVD3VjGAWVZpbtHMCzvjPn2iGIbsqHp
        vj1FTsypRy3OAP/G1znXmXE=
X-Google-Smtp-Source: ABdhPJzo2yBEzqR+x98qeSJ+QK3EJNKY4unSx1UssoA3XS3l68P0mc2CwWCtakAy4/Egc5F8Zn2GHg==
X-Received: by 2002:a05:6512:33d0:: with SMTP id d16mr4050141lfg.28.1642108403326;
        Thu, 13 Jan 2022 13:13:23 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id p9sm391807lfu.83.2022.01.13.13.13.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 13 Jan 2022 13:13:22 -0800 (PST)
Date:   Fri, 14 Jan 2022 00:19:03 +0300
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
Message-ID: <20220113211903.tnzyqxb47lf3uw7z@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
 <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
 <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
 <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:31:43PM +0300, Alexander Sergeyev wrote:
>This is the only change in /proc/asound after the first arecord run. Overall, 
>seems like a small annoyance, but I'm curious -- is it how it's supposed to 
>work?

Just to clarify, this particular Digital control behavior is the same on live 
Ubuntu (which uses modules and supposedly works correctly).

Also, I've posted a patch for review. It adds the quirk for my PCI subdevice id 
which is not present in the current set of SND_PCI_QUIRK. The former micmute 
quirk was picked up by the codec SSID and not PCI id. The patch fixes the 
speakers problem for me (including the built-in drivers usecase).
