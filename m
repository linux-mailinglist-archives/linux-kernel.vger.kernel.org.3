Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C584D0BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbiCGXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiCGXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:10:25 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC22DFD08;
        Mon,  7 Mar 2022 15:09:30 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BCAF992009C; Tue,  8 Mar 2022 00:09:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B5C4A92009B;
        Mon,  7 Mar 2022 23:09:28 +0000 (GMT)
Date:   Mon, 7 Mar 2022 23:09:28 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Mike Rapoport <rppt@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
In-Reply-To: <YiaCH6UsQZSbnNHd@kernel.org>
Message-ID: <alpine.DEB.2.21.2203072252300.47558@angie.orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn> <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn> <20220304151052.GA27642@alpha.franken.de> <20220304153517.GA28487@alpha.franken.de> <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
 <20220307162909.GA18728@alpha.franken.de> <YiaCH6UsQZSbnNHd@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022, Mike Rapoport wrote:

> > So can I just limit amount of memory without interfering with normal
> > memory detection ?
> 
> Maybe it's better to add a new encoding to mem= that will have the semantics
> of limiting amount of memory?
> 
> E.g.
> 
> mem=384M@
> 
> would mean "only use 384M of memory that firmware reported" while
> 
> mem=384M would mean "set memory to 0 - 384M" as it does now.

 I think you're going in the right direction, we'd just need to sort out 
the most reasonable syntax for the new semantics; `mem=384M@' just seems 
too analogous to me to `mem=384M@0'.  Maybe `mem=384M-'?

 NB that would have to work with the existing overrides, for e.g.:

`mem=192M@0 mem=192M@256M mem=384M-'

to produce the following memory ranges available for use:

  Normal   [mem 0x0000000000000000-0x000000000bffffff]
  Normal   [mem 0x0000000010000000-0x0000000017ffffff]

(so that you can paste the final cap at some command prompt and still have 
earlier parameters respected that may have been passed by the firmware or 
bootloader, or built in).

  Maciej
