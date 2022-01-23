Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0780497575
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 21:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiAWULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 15:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbiAWULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 15:11:32 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014EFC06173B;
        Sun, 23 Jan 2022 12:11:31 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id j14so8175440lja.3;
        Sun, 23 Jan 2022 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAuSW76FCl1WuSKP7vtc/an1Ea7E8ZlL23+ctJBk8p4=;
        b=f2eX4QXX0XC4GPUIKoGs+4XWYSAraFc2eY4WvbDyCJB5w66GuqIbNS9VFeYHUinww6
         Gv0xXSFuxh7Y81UBmOSK6FR+r4G/BROZ5ZuRuCHOfznCS/Ga6jfvLfyksgYqPu6qpjdg
         wLBWxrnAWzU7SRK0z/6cbXfKByKXBgMAvTHGKTRO1zNlX4rNJbIs2cu5cV38ySXi56hh
         rYtdlSCWdEkCcoql0YzUMXK+XIdRqzRkB23fX0/dDNYXLyWsURwqXx8gtQxkjQXanObb
         xRTcXkYVRSo4odAsoO9TPbJgeBLfGCswYiyUTRgjvKC4t/cUHyyQH0ogxb53nFBJQFOo
         Gs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAuSW76FCl1WuSKP7vtc/an1Ea7E8ZlL23+ctJBk8p4=;
        b=hdv53b1WmLtu9XM5w53Pa56nI6Tc9P3EeQCKnCyxk+WNPnTD2M3UGXTjlK7xjySPDv
         FNXEIZOuFggA6NiB2J9FsKEGiCViNh3Df26ZlOFGO+luvedpBcyWKjEgzy17URvrKNQG
         PUKBpLHkvk0ENlerXP3lSJT+K4u1Dy+7V/bCy9TFgGGR8yuFiOI5BAdU9TKxaZdLlbSz
         vqTu5+H6JDnGD+8Zkcn++mPfh9DY9r2r9BplWuzGlzyGZVe3jnxRVX+uzpUplt4RbLFv
         F7FENasCWbERYjAjeP/rPrj+CaDZTt8ATqGttFSAvz3DQn5CvIW/5hRAvJNk7910PfEp
         NXNQ==
X-Gm-Message-State: AOAM531asDlBEuIA8XoemoPX+1t1fuZYTm7NeaBubYDlKxJcpLrnxcDc
        GluwuKRBdwbK9+v67mHP08wLgoFV0wYhKX7FZR8oi/NiNuw=
X-Google-Smtp-Source: ABdhPJwrtieEckXwZbEL96znLSpfLom4rbY/6xPKYoIttPzuAlUPOJA0Y7Osr6LQRKqNx/8JWoeT60Umuw7akm7eOUM=
X-Received: by 2002:a2e:91cd:: with SMTP id u13mr2969610ljg.427.1642968689771;
 Sun, 23 Jan 2022 12:11:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com>
 <fbc36e8ebdd9222f84322d54d9114f58c225547e.camel@intel.com>
 <e3e7147e-dd4c-59a9-5dba-5ddcd2e3130f@leemhuis.info> <38b569e4-2e9f-0155-4a5c-52876e8ca38a@leemhuis.info>
 <7672718f-b34e-225d-ff53-1199026728b7@leemhuis.info>
In-Reply-To: <7672718f-b34e-225d-ff53-1199026728b7@leemhuis.info>
From:   coldolt <andypalmadi@gmail.com>
Date:   Sun, 23 Jan 2022 22:11:19 +0200
Message-ID: <CAJvGw+CKz_tZXKkuzrPURLJsh1JBkO1ge7V_owa0htk9pEJsZw@mail.gmail.com>
Subject: Re: [REGRESSION] Bluetooth not working on 5.15+ since "Bluetooth:
 Move shutdown callback before flushing tx and rx queue"
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "An, Tedd" <tedd.an@intel.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 11:28 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Top-posting for once, to make this easy accessible to everyone.
>
> Coldolt, could you please check if this regression is still in 5.17-rc1
> or 5.16.2? I wonder if this patch fixed things:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=8e8cae520210139aab4b701a822bbefb13b8f007
>
> Ciao, Thorsten

Yes, that commit fixes it for me. This same issue seems to have come
up many times in the past months, it is a duplicate of

#regzbot dup-of:
https://lore.kernel.org/lkml/b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch/
#regzbot dup-of:
https://lore.kernel.org/lkml/20211202162256.31837-1-tiwai@suse.de/
#regzbot fixed-by: 95655456e7ce
