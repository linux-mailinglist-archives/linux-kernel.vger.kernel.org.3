Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C87483454
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiACPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiACPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:37:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D961C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2rvm6qkF2yjiWMUiWrgV9/Oy0B2FX+hlXe02f5DRO9w=;
        t=1641224222; x=1642433822; b=TZ1iFqsoFQv+ME/PYfTDLci2pbsKpa9zrBGkw2oJRGkkqec
        qwFZFjNb6Gd2cgt/bOgAbBqxWlBCKy8vwVuFZeZA4IKK2FcdvPRiKp4v/eGfYD3TaN397XuEDAjmu
        W4Se/NK/vnAuGMDKBj3soVYdjDhevLO1cUokhO3hH3NVL+KMFoj4I+ohG9h4nxyUXaBds1bMUlsgW
        XAPJ4RdiKPh/lXH48d9WDwVcEdh6E5gySWMV71NvD75Qb+Tzj5SHDuV0L73+qpg25jWxlO4P9g8WN
        u2AhyrzSNa0B13T4yrKigBtQ4b0KZ2Q4pBXjV2ebsKnib4nbbQ5Kvgq6EFUpIXMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4POJ-001R9P-GS;
        Mon, 03 Jan 2022 16:36:55 +0100
Message-ID: <f86494dfec02e41e6897e8a9617d66b2d7674698.camel@sipsolutions.net>
Subject: Re: Reference to non-existing config LOGIC_IOMEM_FALLBACK
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Jan 2022 16:36:54 +0100
In-Reply-To: <CAKXUXMxKj_d+Nb25rsukj0u2_06KB3+OVWfkYqNzWQG67S=rgw@mail.gmail.com>
References: <CAKXUXMxKj_d+Nb25rsukj0u2_06KB3+OVWfkYqNzWQG67S=rgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-30 at 12:45 +0000, Lukas Bulwahn wrote:
> Dear Johannes, dear Richard,
> 
> In commit ca2e334232b6 ("lib: add iomem emulation (logic_iomem)"), you
> have added an ifdef on the non-existing config LOGIC_IOMEM_FALLBACK in
> ./lib/logic_iomem.c.
> 
> In the commit message, you note:
> 
>     To use, an architecture must 'select LOGIC_IOMEM' in Kconfig
>     and then include <asm-generic/logic_io.h> into asm/io.h to get
>     the __raw_read*/__raw_write* functions.
> 
>     Optionally, an architecture may 'select LOGIC_IOMEM_FALLBACK'
>     in which case non-emulated regions will 'fall back' to the
>     various real_* functions that must then be provided.
> 
> This config LOGIC_IOMEM and config LOGIC_IOMEM_FALLBACK is however not
> defined in any Kconfig file in the current repository.

Yeah, umm. Artifact of renaming things ...

> Did you mean that the architecture shall select INDIRECT_IOMEM and
> INDIRECT_IOMEM_FALLBACK, which were defined in your commit, and the
> questionable ifdef in ./lib/logic_iomem.c needs to be changed to
> INDIRECT_IOMEM_FALLBACK?

Yes. I'll send a fix, thanks for reporting.

johannes

