Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90A14C062E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiBWAcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiBWAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:32:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506EF5B3E9;
        Tue, 22 Feb 2022 16:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9flF1EsIZ1AmB362uTJ0yXxVNxJEpJ3eYvm3j/czl6g=; b=u5pN8FyctLZ4gYr/++VnFrLUYI
        bqJOoHb6yYnjLoAlonJBH6+7zLTB9FQQTkWYyMWn0Nx5qDMyEJGe5aTBCS2GT8/tEyStpheHgTs+t
        0hEfjkMFPLQezYsEgSS434WnhV7o1G37B78wMuykt0T/UcC6xvhegUi71yOLM42tY4mgVMF94ptf2
        v5ccFN0KVn7FLfuHnxJHueOUnI6BHdxs/gj9Bo5oPO+gSprOHeTTdEBq8FVvwoIBMnhqrhzMF0qi9
        j7TmbvM9A6iGu4pBdJgqbQiyCgBPcTuggWRSEtXzevUsDyFFSfA/AeyLIOgtyJ3pwBDaQSkyOfvTp
        SYpnly9A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMfZk-00C1GE-ET; Wed, 23 Feb 2022 00:32:12 +0000
Date:   Tue, 22 Feb 2022 16:32:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     broonie@kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the modules tree
Message-ID: <YhWAjCTPp3hhxEOG@bombadil.infradead.org>
References: <20220221160721.1627006-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221160721.1627006-1-broonie@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report Mark. Aaron, did you fix this issue on your latest
series?

  Luis

On Mon, Feb 21, 2022 at 04:07:21PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the modules tree, today's linux-next build (KCONFIG_NAME)
> failed like this:
> 
> In file included from /tmp/next/build/include/linux/build_bug.h:5,
>                  from /tmp/next/build/include/linux/container_of.h:5,
>                  from /tmp/next/build/include/linux/list.h:5,
>                  from /tmp/next/build/include/linux/module.h:12,
>                  from /tmp/next/build/kernel/module/strict_rwx.c:8:
> /tmp/next/build/kernel/module/strict_rwx.c: In function 'frob_rodata':
> /tmp/next/build/kernel/module/strict_rwx.c:16:10: error: implicit declaration of function 'PAGE_ALIGNED'; did you mean 'IS_ALIGNED'? [-Werror=implicit-function-declaration]
>    16 |  BUG_ON(!PAGE_ALIGNED(layout->base));
>       |          ^~~~~~~~~~~~
> /tmp/next/build/include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>       |                                          ^
> /tmp/next/build/kernel/module/strict_rwx.c:16:2: note: in expansion of macro 'BUG_ON'
>    16 |  BUG_ON(!PAGE_ALIGNED(layout->base));
>       |  ^~~~~~
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>   e5973a14d18 ("module: Move strict rwx support to a separate file")
> 
> I have used the -next tree from the 17th.
