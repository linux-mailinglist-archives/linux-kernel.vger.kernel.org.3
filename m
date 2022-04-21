Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D350A888
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381300AbiDUS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391608AbiDUS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:57:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D04C41F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bLnVB+tVD2jOb/IzrnNs0kvAJIWBHT0xqP4MSQCF2/g=; b=FQeAXayWhnYNyiBkExcDn0AOpk
        ZUjYMdSMmpSkuBpxHbzmS/FooiikDmBpjoD+uM8yKpL31AfuTXrG2bKVvG+ofXe74EUUIhLFcp54B
        g7Gdtndy6UBqGFZ2bhz+qze/DEGk8vOwK1q1wdjovIqiV6G/nBQk7aNCXa1xDly8Cf7rkPKhLhL24
        xW7lmtgspqqYmnn8gzQPuQquD7Fvkg/cuV89b+CQLRij/Jvu6ANXQGUHM77IjA6s/LHm2EjorLNG2
        OHogJQzX+dz60MAdTLXeiz4TwUIaH1MHAU+087FSxlGHtQ4fNC/FK+aNzdljao/5+GUvoMUdZ3ZYB
        1Y7m8kJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhbwJ-00EiJB-VK; Thu, 21 Apr 2022 18:54:03 +0000
Date:   Thu, 21 Apr 2022 11:54:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        xiaowei66@huawei.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH sysctl-next] ftrace: fix building with SYSCTL=n but
 DYNAMIC_FTRACE=y
Message-ID: <YmGoS+5Ixaud2xkO@bombadil.infradead.org>
References: <YlnpfHuZGC8H0iNZ@bombadil.infradead.org>
 <20220420192807.75a70b44@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420192807.75a70b44@gandalf.local.home>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 07:28:07PM -0400, Steven Rostedt wrote:
> On Fri, 15 Apr 2022 14:54:04 -0700
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > Steven,
> > 
> > As with the other fixes I can take this in through sysctl-next if you
> > are OK with that, please let me know.
> 
> Honestly I would love to just nuke the ftrace_enabled sysctl, it's totally
> obsolete. Perhaps I should have it trigger some kind of warning message
> that it will be going away soon, and perhaps we can remove it?

I'm not sure if we can remove proc sysctls, that can break userpace
interaction. But deprecating it.. yeah I think it's fine to strive
for it, and just make the code do at least what it used to. In fact
sadly I don't see this documented well, we do have the documentation in
Documentation/admin-guide/sysctl/ but we don't really spell it out if
we can nuke some. Eric, do you have any thoughts on eventually
*removing* sysctls? Maybe we should document this.

BTW yeah another thing I noticed while looking at ftrace.c file was it could
probably use some spring cleaning by splitting the file up into multiple
files. Hey I'm not volunteering :) just an idea.

> Anyway, yeah, take this through your tree.

OK thanks, 0day found one last issue, I'll send a patch for that just
now. Let me know if you're OK for me to just squash that into this
patch.

> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

  Luis

