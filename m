Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DAE477450
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhLPOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhLPOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:19:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0041AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:19:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9300B61E29
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A34CC36AE4;
        Thu, 16 Dec 2021 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639664364;
        bh=wKHsqz91WCddzKrP46ncvvbVZX+nCSFm/h2HBLrwUxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1mjwXSuOTfiCe0sanzpt8wtyyZlzNwxQl0xPqCCVQrDHlYdMWO3BJ0EyaE+B0Njs
         Vgf1aaYu0ByoflhWmw0DYj2gW9NAxePFd3S2biP/3us1F/a2cLvakHl+owj8HPwP+P
         iSnE8JfY2JZnllg4jHztoGMi6Zn75JiIMrU885gUn7N4PvpQzSfQouUuGeKz3XmxLS
         ip/HZHdprQBbLa+/wymjI5fDpfhnlpRFA6Zk3HZHHDGo8eq6xM8U7m41pm0muD4oKo
         nhiRsf41Ki4ZIgynVaCRByIqJVx/i8SKPQRYbvVn9JN6/7492tqc+Z/IwWDYcL1hR5
         aqw9iXiiKiPKA==
Date:   Thu, 16 Dec 2021 16:19:15 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
Message-ID: <YbtK42WAk3aL/Zqr@kernel.org>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
 <20211215064559.2843555-2-peng.fan@oss.nxp.com>
 <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
 <DU0PR04MB94179C41295FF369E5D755D488769@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Ybm0MWDhzkkwAZoz@kernel.org>
 <DU0PR04MB9417A1DC98221DF4EF76CA7E88769@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Ybm7AcGJaanGVwkR@kernel.org>
 <DU0PR04MB941762839A98B9BB140876E688769@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941762839A98B9BB140876E688769@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:05:36PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
> > 
> > > > > > > If pass "mem=1024MB", the actually max addr will be
> > > > > > > 0x81000000.  However if need the max addr be 0x80000000,
> > > > > > > mem=1008MB should be used.
> > > > > > >
> 
> BTW, do you think max_addr would be an option be added to memblock
> common code mm/memblock.c?

You have a working solution with mem=1008MB, I don't see a need for
additional kernel parameter.

-- 
Sincerely yours,
Mike.
