Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93F48B79B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiAKTqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiAKTqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:46:53 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED25C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:46:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id k21so592069lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=apllgcjqBKhHcPY4Sq8NPNisypZi4criwNIiRJZhedQ=;
        b=DXpNeyKuZmuLb0+7GiV1ndEf+fbOh4LSggvF/lB4mjqSyH/QPDWvHKtW8+wfmRxaba
         CMRbxQZXneFCfwegj3BP/5oSBWQReCyHOyGxajdzvQUBoc/sTr26Mziw45CgHIozWfbU
         lxpsYR6UzLe9x1TAsegfCo9bZRPnIE6G6pQhLcO7CJTwjzQ457+Nhrkm/RVSlqtMK2VM
         dK39vrS51bbgseP5/FX7eb/Z+dZxg009dY3os8jvlSn6J8p6UC3FJeRoQLnfCRCrijJI
         YdG2tMitceKSqcEnJy5NTmwqx+p0WTFDeq24g7NLLLO4/LlAjF4KahWVH8c4X1I/QYZL
         VGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=apllgcjqBKhHcPY4Sq8NPNisypZi4criwNIiRJZhedQ=;
        b=Cv0c44WrVc/LPlKM7sij6Xu+BdD6pMwqZ/+dtSSWeqrP2YFnBSGjiocK6m42hsklOv
         4k8dPhlAxdP/CmiJ4mMRFTPk8KRniiRtYvlBQZ86GATTkzUaRgH1tzmjpAkcdvqeKsmd
         oc1zr4vAFiyYorZi3Yz7ayvS+PsQSuVcI1KuD20ryZc9qgpf/+WFrHs2bwFbVMpBMy1/
         sH3JZHbIBPouMDY+Fghde3KzgQkSdh9c3zwHomJuqDk4QZYzsuLsoblATWirwKzoEenb
         wUuhj0RIF6sHDZ2MwQGCQjEgc26MgrKOVkzauzjyS4jl+40N5h/S+0NOKGRpJt/ZhIou
         pmfg==
X-Gm-Message-State: AOAM533I/Fx0Nca8/ML66U20uMzfTVvoHXbwOX+GcARINrrvt0AfmKIQ
        U29HxhFlTTAk8QqgySBBIN0=
X-Google-Smtp-Source: ABdhPJwoxw5c19Gb3/UWLAH/Kj/4pGO1pTvvZ3zzqg+dVKHuPS8luPJvCmfXz9PXtbHVwDmXmeLV8w==
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr4319120lfr.187.1641930410857;
        Tue, 11 Jan 2022 11:46:50 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id k12sm1372993ljq.91.2022.01.11.11.46.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 11 Jan 2022 11:46:50 -0800 (PST)
Date:   Tue, 11 Jan 2022 22:52:29 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Jeremy Szu <jeremy.szu@canonical.com>
Cc:     tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210519170357.58410-1-jeremy.szu@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 20, 2021 at 01:03:53AM +0800, Jeremy Szu wrote:
>The HP EliteBook 855 G8 Notebook PC is using ALC285 codec which needs
>ALC285_FIXUP_HP_MUTE_LED fixup to make it works. After applying the
>fixup, the mute/micmute LEDs work good.

I've recently got HP EliteBook 855 G8 and it happens that neither micmute LED 
nor speakers work (except rare cases, more on that later) in 5.16.0. The 
corresponding ALC285_FIXUP_HP_MUTE_LED fixup is definitely applied (verified by 
adding a printk into alc285_fixup_hp_mute_led).

What is the most interesting, both micmute LED and speakers do work on rare 
boots. I've written some scripts to pick up sound from speakers using a 
known-good USB microphone. Out of 709 boots today only 16 ended up with working 
micmute LED and speakers.

Is there anything I can do to help with debugging of this problem?

Initially reported at https://bugzilla.kernel.org/show_bug.cgi?id=215466
