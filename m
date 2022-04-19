Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CAC506988
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350940AbiDSLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240937AbiDSLSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:18:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41CB15813
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+T7NqF6/cRpeqLTjnKQGsYUj/qWAJ0JiGzVJuAqgZKc=; b=NLM0J+iuLWHKNpKCGCeEkDju3W
        PDkQdkbLIlBXas0Nakn3n7fSu48s5ZDUW6QpOBpQ6DdbQnS19dC9nv8GF14cw5CS13mZ5qjd7dK60
        8w7HFmptfY6DZ9Va/WAG6CzJUVpVeQKJ1Rgx0Z4q6njNtL1jTXYEJhSvOjt634deH72Kw/UbZXmgu
        VZpe3Rlf8E7pJvdyyRuIQLuU8q1x5A118h1rUTeAoLMTGt6ZyP/VOCFZZPujBtsq3WNC8K9vG6abi
        MkFWdAAID7AWh+CaFqYcwr2N+807tAUYKQrYBSrBlWwztjAcy0NN9WBQrObTgZfb0mtr9FV9wVIT0
        CLTLh7Zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nglpt-006nyQ-BA; Tue, 19 Apr 2022 11:15:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36DC7986195; Tue, 19 Apr 2022 13:15:55 +0200 (CEST)
Date:   Tue, 19 Apr 2022 13:15:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 13/25] scripts: Create objdump-func helper script
Message-ID: <20220419111555.GR2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <ab37c23d28a8b9cf7a6707cc5af5e1aef80ba4a3.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab37c23d28a8b9cf7a6707cc5af5e1aef80ba4a3.1650300597.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:50:32AM -0700, Josh Poimboeuf wrote:
> Add a simple script which disassembles a single function from an object
> file.  Comes in handy for objtool warnings and kernel stack traces.
> 
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  scripts/objdump-func | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100755 scripts/objdump-func
> 
> diff --git a/scripts/objdump-func b/scripts/objdump-func
> new file mode 100755
> index 000000000000..140646c456fc
> --- /dev/null
> +++ b/scripts/objdump-func
> @@ -0,0 +1,18 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Disassemble a single function.
> +#
> +# usage: objdump-func <file> <func>
> +
> +set -o errexit
> +set -o nounset
> +
> +OBJDUMP="${CROSS_COMPILE:-}objdump"
> +
> +command -v awk >/dev/null 2>&1 || die "awk isn't installed"
> +
> +OBJ=$1; shift
> +FUNC=$1; shift
> +
> +${OBJDUMP} -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"
> -- 
> 2.34.1
> 

This might rely on awk being gawk, I'm never very careful about those
things.
