Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD9563C08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiGAVqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiGAVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:45:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5B70E41;
        Fri,  1 Jul 2022 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3cFpCkDcgwXTNgkLW8NYHD/uOpNoht3E07/8tRuvcQo=; b=xHHEVYUw+oDD1f15MIb4xRFhaB
        nQcsRlXshXyMal5foqMCb+pq4sYE0WdbJ8LdjtliGIRDjAB/tOPate1k8AslSGx0OpMy57B465SpX
        7mTgiScxlL/25vp135FkFBhTtc434NUOCdXtPWtdLbtXwNkaII47UDomjcJr17KkeUTI3c3eeXduC
        3muCcHsKMdyQCdtBsEoL7vLVhuvJWgEZsAuvvMzSbeR9Oc9XVyPgaTGkfw6xM7avoQ4WOPOMv2Kgi
        v6i832IF1nHSsZG1De6gOu7oiASX7TiH8VsI431r6v9IjYTiLr92OIO2YCVpAbGwsQ6JR2ADyzC7k
        +LO1LYGA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7OSJ-0074EC-B2; Fri, 01 Jul 2022 21:45:39 +0000
Date:   Fri, 1 Jul 2022 14:45:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] module: Fix selfAssignment cppcheck warning
Message-ID: <Yr9rA5U/Sa0Tamau@bombadil.infradead.org>
References: <3c3041d4815d6d6ad5f7ab78b202e192210f6694.1655047308.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3041d4815d6d6ad5f7ab78b202e192210f6694.1655047308.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 05:21:56PM +0200, Christophe Leroy wrote:
> cppcheck reports the following warnings:
> 
> kernel/module/main.c:1455:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
>    mod->core_layout.size = strict_align(mod->core_layout.size);
>                          ^
> kernel/module/main.c:1489:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
>    mod->init_layout.size = strict_align(mod->init_layout.size);
>                          ^
> kernel/module/main.c:1493:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
>    mod->init_layout.size = strict_align(mod->init_layout.size);
>                          ^
> kernel/module/main.c:1504:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
>    mod->init_layout.size = strict_align(mod->init_layout.size);
>                          ^
> kernel/module/main.c:1459:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
>    mod->data_layout.size = strict_align(mod->data_layout.size);
>                          ^
> kernel/module/main.c:1463:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
>    mod->data_layout.size = strict_align(mod->data_layout.size);
>                          ^
> kernel/module/main.c:1467:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
>    mod->data_layout.size = strict_align(mod->data_layout.size);
>                          ^
> 
> This is due to strict_align() being a no-op when
> CONFIG_STRICT_MODULE_RWX is not selected.
> 
> Transform strict_align() macro into an inline function. It will
> allow type checking and avoid the selfAssignment warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Queued up thanks!

  Luis
