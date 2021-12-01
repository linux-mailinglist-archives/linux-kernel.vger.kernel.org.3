Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFAD465571
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbhLASc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:32:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56630 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbhLAScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:32:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24A9CCE206F;
        Wed,  1 Dec 2021 18:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10C0C53FCC;
        Wed,  1 Dec 2021 18:29:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PCSpO+RW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638383356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfa3NlfCdsYdxGFH80CwGI0Vu8ELsod+Z2I76aPC3tY=;
        b=PCSpO+RWCY1yAULHSHBN4H8UeXWCz+hhlQ4mA0jmalquWo3Eqg+G5AUGJRMC3WEgm96iuL
        wu6vZ+YRk2o6lDcnMCRqqghE0uv73eZJbmY5P60YH3M6AWZ5vqqKA+1hpntnuEGOTuf+/C
        CRCSC/hUMdK0UZg+vHaZ79JlkbFui50=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e75226bb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 1 Dec 2021 18:29:16 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id d10so66152687ybe.3;
        Wed, 01 Dec 2021 10:29:14 -0800 (PST)
X-Gm-Message-State: AOAM533MYg13xgIp/ogNDanQFF1dek5banrKrjFlJHVmL0vPqcwj2Ftv
        Tc6TAImVE4kaPkbbLQjap3oiVurk9XXAE18BK8Q=
X-Google-Smtp-Source: ABdhPJzm64appqzjA4aYAH5eWAoxWSsIlQMIYaA4A4gxImaaHPmVuTevg1qUdzUUZ3LSV64gI9xYizxTSbGMR8WlHKU=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr8854584ybe.32.1638383353056;
 Wed, 01 Dec 2021 10:29:13 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com> <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
In-Reply-To: <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 1 Dec 2021 13:29:01 -0500
X-Gmail-Original-Message-ID: <CAHmME9rTT+V0X1hv1=DiVnQFomLRcPRkymmTGjDY7+EDEuw9UQ@mail.gmail.com>
Message-ID: <CAHmME9rTT+V0X1hv1=DiVnQFomLRcPRkymmTGjDY7+EDEuw9UQ@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Simo Sorce <simo@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
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

On Wed, Dec 1, 2021 at 12:19 PM Simo Sorce <simo@redhat.com> wrote:
> Unfortunately userspace is not an option for kernel's own cryptography.

I'm actually sort of curious to learn which specific uses of
get_random_bytes you're concerned about. ECC keygen? What else?
