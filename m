Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86124CD7F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbiCDPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiCDPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:36:16 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1391C57FE;
        Fri,  4 Mar 2022 07:35:28 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nQ9xm-0008Sv-00; Fri, 04 Mar 2022 16:35:26 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3620EC0F8D; Fri,  4 Mar 2022 16:35:17 +0100 (CET)
Date:   Fri, 4 Mar 2022 16:35:17 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
Message-ID: <20220304153517.GA28487@alpha.franken.de>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn>
 <20220304151052.GA27642@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304151052.GA27642@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:10:52PM +0100, Thomas Bogendoerfer wrote:
> On Tue, Mar 01, 2022 at 12:28:58PM +0800, Tiezhu Yang wrote:
> > According to Documentation/admin-guide/kernel-parameters.txt,
> > the kernel command-line parameter mem= means "Force usage of
> > a specific amount of memory", but when add "mem=3G" to the
> > command-line, kernel boot hangs in sparse_init().
> > 
> > This commit is similar with the implementation of the other
> > archs such as arm64, powerpc and riscv, refactor the function
> > early_parse_mem() and then use memblock_enforce_memory_limit()
> > to limit the memory size.
> > 
> > With this patch, when add "mem=3G" to the command-line, the
> > kernel boots successfully, we can see the following messages:
> 
> unfortunately this patch would break platforms without memory detection,
> which simply use mem=32M for memory configuration. Not sure how many
> rely on this mechanism. If we can make sure nobody uses it, I'm fine
> with your patch.

maybe we could add a CONFIG option, which will be selected by
platforms, which don't need/want this usermem thing.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
