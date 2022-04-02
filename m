Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFC4F02F8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiDBNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355795AbiDBNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:50:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D96C315;
        Sat,  2 Apr 2022 06:48:34 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D5D9392009C; Sat,  2 Apr 2022 15:48:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D308792009B;
        Sat,  2 Apr 2022 14:48:31 +0100 (BST)
Date:   Sat, 2 Apr 2022 14:48:31 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     yaliang.wang@windriver.com
cc:     rppt@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        huangpei@loongson.cn, Andrew Morton <akpm@linux-foundation.org>,
        kumba@gentoo.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
In-Reply-To: <20220310113116.2068859-1-yaliang.wang@windriver.com>
Message-ID: <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
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

On Thu, 10 Mar 2022, yaliang.wang@windriver.com wrote:

> pgd page is freed by generic implementation pgd_free() since commit
> f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()"),
> however, there are scenarios that the system uses more than one page as
> the pgd table, in such cases the generic implementation pgd_free() won't
> be applicable anymore. For example, when PAGE_SIZE_4KB is enabled and
> MIPS_VA_BITS_48 is not enabled in a 64bit system, the macro "PGD_ORDER"
> will be set as "1", which will cause allocating two pages as the pgd
> table. Well, at the same time, the generic implementation pgd_free()
> just free one pgd page, which will result in the memory leak.
> 
> The memory leak can be easily detected by executing shell command:
> "while true; do ls > /dev/null; grep MemFree /proc/meminfo; done"
> 
> Fixes: f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()")
> Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>

 As a critical regression shouldn't this have been marked for backporting 
to stable branches?

  Maciej
