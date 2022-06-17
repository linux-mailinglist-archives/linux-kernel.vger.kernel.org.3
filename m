Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96A54FE24
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbiFQULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbiFQULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD61ADA2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A023061FE2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4A8C3411B;
        Fri, 17 Jun 2022 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655496705;
        bh=tCzSoDt5SPAPOgd5MF8hpN/0j/R+8BkgPqE7vJS45J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jz6HfYsMaC5YxdljUmcP3rZa7xOA07GFdQVlYxWGHILrxH7FfFBEkycOKsfRNG+k2
         jYypvyIv4br/toIhRXlfz3fNK6VJveRz4bUK/uT+wB2vLdTfP4RRh4EyShgkSch+ZB
         KHAb4TG8kYphjWUS24o2HBg21LYZrQmpU+0uOqpuotKyFL1wGnM/m5588oulR208H6
         k+GY6TGikTBGcTLSE4kd111VwGE543lAqzceDioMvQKf2BU+R23Df8oSroE4HPPl4B
         AimhGh3oqPxYI+r3rkyalODWAfIEiPqiGSfiV8SxkWp9cYVW5HV8loqYgpz51G6SaB
         o67cYi3wAwacg==
Date:   Fri, 17 Jun 2022 13:11:42 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <20220617201142.yea5ze7od43fat4o@treble>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:24:53PM +0200, Peter Zijlstra wrote:
> 
> Hi,
> 
> I recently noticed that __mcount_loc is 64bit wide, containing absolute
> addresses. Since __mcount_loc is a permanent section (not one we drop
> after boot), this bloats the kernel memory usage for no real purpose.
> 
> The below patch adds __mcount_loc_32 and objtool support to generate it.
> This saves, on an x86_64-defconfig + FTRACE, 23975*4 ~= 94K of permanent
> storage.
> 
> XXX hobbled sorttable for now
> XXX compile tested only
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Nice!

Some nits:

- No need for renaming the section, it can still be called
  '__mcount_loc' regardless?

- No need for a new FTRACE_MCOUNT32_USE_OBJTOOL config option or
  '--mcount32' cmdline option, just change the old ones to be pc32?

- change "32" to "PC32": CC_USING_MCOUNT_LOC_PC32

That will shrink this patch down quite a bit.

-- 
Josh
