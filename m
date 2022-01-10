Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D4489B14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiAJOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiAJOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:12:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F372C06173F;
        Mon, 10 Jan 2022 06:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F17F4612AB;
        Mon, 10 Jan 2022 14:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A1EC36AED;
        Mon, 10 Jan 2022 14:12:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k8NDemed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641823921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GX2k7uQXVQpUQl+kBLAGP4Opu2SoZDxZonCVnuuw5sM=;
        b=k8NDemedMIAgkZmLaJabs5JJ/pEnkbqf8QfV+Oo+IUeuy9Kaw948UwW53+fBvr2iJP5pCd
        LCPE69ebWzEuRdtgQTKnc6lCWKX4tnr8dwXkW+TUwnKGPKjSH9JrPexll80l1c3Ky2UeeA
        G2pYNsVdNYL3B83NEQe66Mp5K7GgbFE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cda53c52 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 10 Jan 2022 14:12:01 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id c6so36287339ybk.3;
        Mon, 10 Jan 2022 06:12:00 -0800 (PST)
X-Gm-Message-State: AOAM531ABhGEEZalY+Xwo82081WCqlClLUq0epBFVLb0BKzBFgTs/ijS
        2tOYdJssWk+Q07BbVZ5EPXQxBFJ4akkeIgtGxoU=
X-Google-Smtp-Source: ABdhPJzeA+FjAC2WVqODfgMXBLyh/ucFa3dZnR0nCU0ZyPW4ClAFyIj53nTFNHmggUJIhDDbbi+MtRBeZbpSpW9b8Ok=
X-Received: by 2002:a05:6902:150d:: with SMTP id q13mr56829072ybu.113.1641823917354;
 Mon, 10 Jan 2022 06:11:57 -0800 (PST)
MIME-Version: 1.0
References: <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor> <20220110132349.siplwka7yhe2tmwc@valinor>
In-Reply-To: <20220110132349.siplwka7yhe2tmwc@valinor>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 10 Jan 2022 15:11:46 +0100
X-Gmail-Original-Message-ID: <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
Message-ID: <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Mon, Jan 10, 2022 at 2:24 PM Marcelo Henrique Cerri
<marcelo.cerri@canonical.com> wrote:
> Hoping that might help with the discussion and to explain why I do
> consider those solutions a "hack", that's the patch we've been using
> so far to achieve SP 800-90B compliance:
>
> https://kernel.ubuntu.com/~mhcerri/0001-UBUNTU-SAUCE-random-Use-Crypto-API-DRBG-for-urandom-.patch

Thanks for sending this in response to my request for it in our private thread.

Just to confirm, this little patch here gives you FIPS certification?

Jason
