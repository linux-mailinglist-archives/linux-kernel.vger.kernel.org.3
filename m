Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8018D4654B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbhLASIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhLASIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:08:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B55C061574;
        Wed,  1 Dec 2021 10:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F68ACE1FF6;
        Wed,  1 Dec 2021 18:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA669C53FCC;
        Wed,  1 Dec 2021 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638381907;
        bh=7ARMOv0JYmyP4dyOnKSkKMVEIthVeOwOP+jqPaiHohg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPY3deXdcTPGIDjef93OsHHJx5ywW6koWbdKzZgSg9pTSXoW+xnsL6EMxnsg58MVd
         SsKhMKdyyY8470wQWxMbSVhMEk/XmvashqR8DPg+7fAcr9WPTpjQfWm1lB6Qc8l0XK
         TESAlFca68VaTYrFRuH8v8jb4k8KOiwKCbpYhOXw=
Date:   Wed, 1 Dec 2021 19:05:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Boris Krasnovskiy <Boris.Krasnovskiy@lairdconnect.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Simo Sorce <simo@redhat.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
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
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <Yae5UMjybbr1+nj1@kroah.com>
References: <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
 <BY5PR14MB341621FBA9F7BD09B6D8C3FE86689@BY5PR14MB3416.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR14MB341621FBA9F7BD09B6D8C3FE86689@BY5PR14MB3416.namprd14.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:55:32PM +0000, Boris Krasnovskiy wrote:
> THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.

Now deleted.
