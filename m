Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58748C273
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352596AbiALKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiALKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:42:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B347C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:42:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g11so6626537lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=3j1Wm1WQHCFUig/uDRHfmIv5SpKzeQw7chJmfSgR5q4=;
        b=p6aMaiUfS2aFhdIKJPAp2V+Fqmt1X+rIAr9B+Tw4cAQ4NP8x/Zj5ahuADz0UcFv0hP
         oq2c9SNmQC7m6l64shXc+g4y4P8vo7bPa6k/ZcjdN+c1Rvt2BfNrtPRdWPo+0NMBSVFw
         /siyfCx6ycstGXvnNgUw2BdK7jtXToYPEXpVpYmiBwDXvp0Oi4T/Y34Q+hiblZ6n7s5N
         B255jnSuCK76xNMMNWVTROkQ9RVT05pZmf6wM9a97+UwkESi5aVwdl3QIm4l2p5Uh+Mt
         W7lczBqwp0ifCOR/QdpdKYlMRVu1++T+dPXB+VPkQfU94vsND7zDkkTq63qN7qbNYo8l
         Odiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=3j1Wm1WQHCFUig/uDRHfmIv5SpKzeQw7chJmfSgR5q4=;
        b=ZgqohMY6dnd4THcLRnMSTN+fomrrjP42LhirTHsz5XeqjyrBRjnSeRcnBC974PKDkm
         H3uMzZ+OIW/CQ6x497F53TVb4n+xZdrxTJJ3G+KbA3TTfJDU7Nxy11wmIcxD+9650Fkk
         AdOfAAsHsc9XhIwkKsTsScLTqH11tZfjJdhevMGP9/UvIoxqozVCOi2CzkYcIYzMOTtW
         4BKgrKTBO6MWk47DXN3j5roGINCQDEYCVp82FhZyBcg3rWPTOlxg2DNYF7PA8ORzfrbE
         fT/txXZKF4PTcNcOT6z3vERLTtcN57lDTRWFineiBxNptFYuHFm588MtmP64BsHtHD7f
         L2AQ==
X-Gm-Message-State: AOAM5326wO76o4pEMT6SWRyPuW4EI2UCNhzKJslEPfgFJQo0eljT+MJL
        yjVBaD6k9H+MMFRB2E6nlyo=
X-Google-Smtp-Source: ABdhPJzuABYWWIrH4rMkTpYkDL8tqn5CpBW1tgufB/0QrijxkPTAcuh6r5G5g8hpT6v3go9dhN08Ig==
X-Received: by 2002:a2e:9245:: with SMTP id v5mr6203793ljg.149.1641984168048;
        Wed, 12 Jan 2022 02:42:48 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id r6sm1604322lfm.114.2022.01.12.02.42.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 12 Jan 2022 02:42:47 -0800 (PST)
Date:   Wed, 12 Jan 2022 13:48:27 +0300
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
Message-ID: <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <s5hilup9s87.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:13:44AM +0100, Takashi Iwai wrote:
>Sounds like some timing issue, then. It's pretty hard to debug, unfortunately.

I can imagine. Is it possible that initcall_debug logs could help? Or is it 
timing issues within the same module?

>You may try to get the codec proc dump with COEF by passing 
>snd_hda_codec.dump_coef=1 module option for both working and non-working 
>cases.
>You can unbind and re-bind the PCI (HD-audio controller) device via sysfs.

I'll try both options later today when able, thank you!
