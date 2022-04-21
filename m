Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A2E509B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387023AbiDUIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbiDUIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:55:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810120F4E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5H5M+/nukyq+ClIyXnFYHWEZmwimqI4Y/2Onc+gYQxU=; b=gsjaTQGvOWmOn0vHz+72zmXEHr
        AYkDtYPJmAcOsS9lf7AVqAfme9yuQPkQkw/vi+dYFCPealXjIdSjwBgO6MI62inuPu6chfWjeRvGW
        9nk/cUwJJFa4vli7aGIOOLsn2CJWOi2NGaq3aopxw2ISsQ+Xj/5rk7Mdci1spKWyxgr5LQ+U+MisS
        EdHi76NZzn49tlhhQ4OVZCNgYx22TbO8BrH3es2IrPp0q/pxXMYy9BjqTWvU0WnBYhhlF2oK/PtLU
        uf8sOj+gPym7dLGXY+dvmtZAbs+uOOXHGTqkh0FfyavVrI6oCgUcuI2DdcJ+lhirJF3kRVgdxQmqJ
        dTkB5b0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhSYQ-004vhL-R3; Thu, 21 Apr 2022 08:52:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACFC19861C1; Thu, 21 Apr 2022 10:52:44 +0200 (CEST)
Date:   Thu, 21 Apr 2022 10:52:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] scripts: Create objdump-func helper script
Message-ID: <20220421085244.GL2731@worktop.programming.kicks-ass.net>
References: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:16:36AM -0700, Josh Poimboeuf wrote:

> +${OBJDUMP} -wdr $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f ">:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'

Two noteworthy changes:

 - $@ went missing, I've occasionally abused that to add extra argument
   to objdump.

 - you removed the glob after FUNC, I had that so that .cold and
   .constprop etc.. variants of the function also show up.

I don't suppose either one are super important, but esp. that latter one
has been convenient.

