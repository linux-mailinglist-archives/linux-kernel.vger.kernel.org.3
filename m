Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31AE4CD9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiCDRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiCDRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:12:33 -0500
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 09:11:45 PST
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C64A71CD9EF;
        Fri,  4 Mar 2022 09:11:45 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F09E792009D; Fri,  4 Mar 2022 18:11:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id EA18792009B;
        Fri,  4 Mar 2022 17:11:44 +0000 (GMT)
Date:   Fri, 4 Mar 2022 17:11:44 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
In-Reply-To: <20220304153517.GA28487@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn> <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn> <20220304151052.GA27642@alpha.franken.de> <20220304153517.GA28487@alpha.franken.de>
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

On Fri, 4 Mar 2022, Thomas Bogendoerfer wrote:

> > > With this patch, when add "mem=3G" to the command-line, the
> > > kernel boots successfully, we can see the following messages:
> > 
> > unfortunately this patch would break platforms without memory detection,
> > which simply use mem=32M for memory configuration. Not sure how many
> > rely on this mechanism. If we can make sure nobody uses it, I'm fine
> > with your patch.
> 
> maybe we could add a CONFIG option, which will be selected by
> platforms, which don't need/want this usermem thing.

 FWIW I don't understand what the issue is here beyond that we have a bug 
that causes a system to hang when "mem=3G" is passed on the kernel command 
line.  That is assuming that system does have contiguous RAM available for 
the kernel to use from address 0 up to 3GiB; otherwise it's a user error 
to tell the kernel it has that memory available (I did get bitten by that 
myself too): garbage in, garbage out.

 I think having a CONFIG option automatically selected to disable the 
ability to give a memory map override would handicap people in debugging 
their systems or working around firmware bugs, so I would rather be 
against it.

  Maciej
