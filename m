Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3E4735A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbhLMUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbhLMUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:13:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:13:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m6so21225921lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Inc9uwWHZAbgsb1N/697Z2eLvfAIiFt1soOcNLmt1G8=;
        b=6oLIom7ZwqLYzavR342gVTMOEeigQLXjS/ORPSdo8LbI1Ju5TKXSt6zhKtnE5z1oLS
         BQ//Klh6xjFKlwXLZidL92utkY0TXuskOdTNfPlk46UWBTTW6r3MPJr9wwKtzDqnqUKC
         wYR6ErbJ/+o+NsVwPXDeB1e7R4bVPNtVtwSNYtB2u26jNokH4hsEbKyLKH7o/WVahfz+
         qCq1T0KvZYjItdNpSi984BtjT+/7b8YD+GshHdfBea8ASzdrUUaJH23FMf0McSQVTH/c
         ByA9jyKgFBaH5vGI3qYzlC7tXBrA1h1r9qMXEBI7Szke/j3RtPPPIjhKCZF1ycM2z47q
         8h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Inc9uwWHZAbgsb1N/697Z2eLvfAIiFt1soOcNLmt1G8=;
        b=TTPOfVo220swW8FLEDFijg0Kj34NaBF3pd41fDPhDy0OIfMMI9mWC8ks6/Zc5FoVhb
         N0xmfWCl+SZiQFgp8AdCohuaI/Hyr9mRWQTRnQ42cxugtDCcV1YwesoG31LgFQiyargT
         Te6iMQ+LaIg4Dd8mehSw5lkVquFCcsGe60X5nbRvSBOg9EctaTey72657p6gUoZZBRwD
         b6o3o/2YxjDT06MN52m4haHboIjYa6Um7GgAzlzgfKI4dAVVP/vpk7+O1ZzipZHgnext
         yjIZ5l0kSA7aXybrKB2n0UJPbyGtkRDDsyIiVUpJbbOkr8LjGXHQIxAtRBxHVEE9fiZB
         rbVQ==
X-Gm-Message-State: AOAM533vwpCK0mjT1Tw0hxG+79N/zLRetpOlNnrmYR76zyTG9V2iXajV
        g0SGfQZUC/vXzKQifOO1ZHy6qw==
X-Google-Smtp-Source: ABdhPJy5+hI4Th1rzQy0VsBWT6017dzMDLjnH12PdagwvSjIvTACVRclon2FTbZbTDF5VNQ9LzTcyw==
X-Received: by 2002:a05:6512:23a7:: with SMTP id c39mr470971lfv.655.1639426432419;
        Mon, 13 Dec 2021 12:13:52 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id g26sm1528888ljn.107.2021.12.13.12.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 12:13:51 -0800 (PST)
Subject: Re: [PATCH] media: vsp1: mask interrupts before enabling
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>
References: <20210926155356.23861-1-nikita.yoush@cogentembedded.com>
 <163455832550.1371157.18009256492359430197@Monstersaurus>
 <f91c4f16-fd81-5d70-0146-e9aa2d128da9@cogentembedded.com>
 <163585162705.1097798.16604551366893944884@Monstersaurus>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <4f2a2dc5-f145-ce20-eebe-08a6e084ef66@cogentembedded.com>
Date:   Mon, 13 Dec 2021 23:13:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <163585162705.1097798.16604551366893944884@Monstersaurus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Now I'm finally looking at this again.

> I think I would rather see the code to reset them done in
> vsp1_reset_wpf(), rather than in probe directly as that is what we are
> doing, and is I believe already in the call path.

Could you please explain, how that is intended to be called on the probe path?

As far as can read from the code, vsp1_reset_wpf() is only called from vsp1_device_init(), which in turn 
is called only from PM resume hook and only if vsp1->info is already set. However, in the probe path, 
pm_runtime_enable() is called before vsp1->info is set.

Nikita
