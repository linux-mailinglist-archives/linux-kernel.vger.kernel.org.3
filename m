Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BB4482285
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbhLaGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:44:28 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:63455 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhLaGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:44:28 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1BV6i1LH031944;
        Fri, 31 Dec 2021 15:44:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BV6i1LH031944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1640933042;
        bh=GT91TcNIPBXDZB5upjF3cU0X71wUr8B4PKDoP48+hTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ARTZCU30+eWCX8tC8LXWGc8BC53uuZ/o1Gaku/GIgNBu6eNXL6/UUqcLQZAQLAvPY
         Tyqt+eEql7Dncia5JJg0m3B0WSJy7NSecr4WCqB26XsamdTvzMhyUb6zT02nwENqmH
         /OQLxyok7n/tbH848X6xycOWuelkP7tJiPnPA9qUo1E7xlDvZ4Tb093c13w8LKS+KC
         lR5jG1vPSGRNuvB4M/HOFC1IrOOU36E9qrDsFz1q6CXrHee6RlsuLONgErGEWHXHBe
         uduGI8Lc6nOX3OhHzCXzo7Puz5FjSNRsISU2q2cgPUskNwQ5VdYuIBQ70r2xVgcfVR
         wKPTyWJvUztfw==
X-Nifty-SrcIP: [209.85.215.170]
Received: by mail-pg1-f170.google.com with SMTP id a23so23191020pgm.4;
        Thu, 30 Dec 2021 22:44:02 -0800 (PST)
X-Gm-Message-State: AOAM531U53cLNTPmve74uBv8dvf0nOOoFGFTEZKri2MrlEf85F8eGLyO
        Y4uxeIZvwnwi51/DA/YrBXb9ngJ1eB4g57KGZeY=
X-Google-Smtp-Source: ABdhPJzWTpKMeT6Dto5fEr50qh7Nt1g71CJKnOhU7QPxjOiB0td/DuEXDtV2IWK40EOhoB6fayjUTi0OVU6uPmbkVvk=
X-Received: by 2002:a63:3753:: with SMTP id g19mr8666029pgn.126.1640933041443;
 Thu, 30 Dec 2021 22:44:01 -0800 (PST)
MIME-Version: 1.0
References: <1B559478-D266-4D77-B9D5-F6F21D9EFB83@gmail.com>
In-Reply-To: <1B559478-D266-4D77-B9D5-F6F21D9EFB83@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 31 Dec 2021 15:43:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_REk8M-DmCWBcfTBXfQcg=djnSeHRV9STh_SJGcEVbw@mail.gmail.com>
Message-ID: <CAK7LNAT_REk8M-DmCWBcfTBXfQcg=djnSeHRV9STh_SJGcEVbw@mail.gmail.com>
Subject: Re: Missing closing files in linux/scripts/kconfig/confdata.c
To:     Ryan Cai <ycaibb@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 12:11 PM Ryan Cai <ycaibb@gmail.com> wrote:
>
> Dear Kernel maintainers,
>
>           1. In linux/scripts/kconfig/confdata.c (conf_write_autoconf_cmd), the file opened at Line 946 may not closed when going to Line 981.
>           Location: https://github.com/torvalds/linux/blob/e851dfae4371d3c751f1e18e8eb5eba993de1467/scripts/kconfig/confdata.c#L964-L981
>
>          2. In linux/scripts/kconfig/confdata.c (__conf_write_autoconf), the file opened at Line1081 may not closed when going to Line 1095,
>            Location: https://github.com/torvalds/linux/blob/e851dfae4371d3c751f1e18e8eb5eba993de1467/scripts/kconfig/confdata.c#L1081-L1095
>
>            I think, the fix is inserting fclose before the returning. Should it be a bug? I can send a patch for these.
>

Yes, they are both bugs.
Thanks for catching them.



-- 
Best Regards
Masahiro Yamada
