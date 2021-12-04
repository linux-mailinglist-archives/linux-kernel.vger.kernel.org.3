Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B484683F1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbhLDKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344347AbhLDKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:11:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C39C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:08:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so22060561edd.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V64/wZ8a1879T6XBHH3mfVC1ZWrAquNogb8L4Y71CGY=;
        b=mPgoaTnCXxSN1ptEeJS2G7KPNJZHAfxN4zcsJUc5pTIsMOTa1mo2IDTB0GH/D9w8+L
         h9gJUncHDLadJU+diOPKdBuHmWb4BYbaDh563UdUnWVgyow19LNlNF74ub2ijfeQnmdj
         KcKMjBJcbgGPQwEsWcpchU+gEiRcVeHbUFRRagbko5BB90LVSJnY4ru9VgVe75sbH0qZ
         FNCl5cFX3Gvg21Efs3ppSwNcXptD7QG23izfKRigiJLw4B22TnduIFuBARz8XaCMQt39
         vDb5aK2/CRuOHRmjmbH18+ZspqjczsopXALpQNrb1qI2F020z9golHkQx/ZU3Z4RQhv+
         m0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V64/wZ8a1879T6XBHH3mfVC1ZWrAquNogb8L4Y71CGY=;
        b=3sy1s1u93GPb2D/JQ0POJ/1hwJZgku/T6i/zQsa2ENWF2fx91WUu0LuvovxHG0JMUi
         DF1pLO8PvWaniAzqiClG62V3KlIWZti/oMnZVwqNYa1dxsu/BWkckktypYAnYjfuel9/
         8HKYOEDBKB5V1LCYrPEEbDYxRvGWqDOmV0rfSKrmeccxbVBNmLTH0gIOC3Mwz8qwqYbk
         pWWys/0TirNJ4CT9bpS+32J9Quc/WYzz2M5I/botRiatDaWA+kH/8oRY/R2EVVZWHhHE
         YAJvy256jiGQmmQt6blZSaYb5Pwe9I+5oVkDubLpTyj9yIPnTGKPhbAz7INlMRt0MY0Y
         VFMg==
X-Gm-Message-State: AOAM5321jH6yIZDVrIO9kqP3+vseSU3xDs3tTaNWGZBpIzboG6ViB8Bm
        DY//VuAEGlbUVTVuI2a9iJI=
X-Google-Smtp-Source: ABdhPJxobamFx+qBe+YrntNytqfyvQCK/MGCfKVHCoO9fxgm36kmv4nHizu7hIGAUI+7+DJWn+OQlQ==
X-Received: by 2002:a50:e18e:: with SMTP id k14mr34560858edl.147.1638612502449;
        Sat, 04 Dec 2021 02:08:22 -0800 (PST)
Received: from bulldog (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id sb19sm3558918ejc.120.2021.12.04.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:08:22 -0800 (PST)
Date:   Sat, 4 Dec 2021 11:08:20 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: refactor byMinChannel to min_channel
Message-ID: <20211204100820.GA3887246@bulldog>
References: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
 <e0fea904-1861-0003-1b04-6d2e966657da@gmail.com>
 <20211204090941.GA3805206@bulldog>
 <a10f1013-069e-7f56-8a5b-80621af8a158@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10f1013-069e-7f56-8a5b-80621af8a158@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think, it should be up to maintainers to decide, but them can be removed
> now and if somebody will need them later, he can bring them back without any
> pain. For now it's just useless memory usage.
Cool! I agree with you.

> I skimmed through priv fields usage and looks like many of them are just
> set, but never used. I guess, some kind of evolution removed all uses of
We can work on it.

Regards,
Alberto
