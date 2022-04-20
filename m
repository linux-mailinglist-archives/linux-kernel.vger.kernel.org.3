Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2790F508E66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381079AbiDTR35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381073AbiDTR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:29:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583946B03
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:27:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0FAA421110;
        Wed, 20 Apr 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650475627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wesuhMn6Pucn91tUc45Itm+IG8IZx5syxaXd4xKFZk=;
        b=jmbHbF0CNR8hxL1mtDNdKNblh6V1Sqp3TgyXToWCWjNoRgFhVbJ3FArqKMcShK/IH2+Z9P
        XIzXPp4Yud40yJp/H+f2ohURa1brJBnOehaaYKQKQDbFTFZp3GvXLIhy03lU8oMlruWNa2
        tAlkuuuqo37e/ZaGK7cAu/TudFTLv2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650475627;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wesuhMn6Pucn91tUc45Itm+IG8IZx5syxaXd4xKFZk=;
        b=VmaVUZKpgP2Yb8hBZ/kdZO8VT9Z7TFxet1EPOKYEQN0mNXe9lNdD5xUJ6JHqGSe8jXl+hU
        Reqk8QWws7FAVfAg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EACDF2C142;
        Wed, 20 Apr 2022 17:27:06 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:27:06 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/25] objtool: Interface overhaul
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2204201925320.1205@pobox.suse.cz>
References: <cover.1650300597.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> $ tools/objtool/objtool --help
> 
>  Usage: objtool <actions> [<options>] file.o
> 
> Actions:
>     -h, --hacks[=<jump_label,noinstr>]
>                           patch toolchain bugs/limitations
>     -i, --ibt             validate and annotate IBT
>     -l, --sls             validate straight-line-speculation mitigations
>     -m, --mcount          annotate mcount/fentry calls for ftrace
>     -n, --noinstr         validate noinstr rules
>     -o, --orc             generate ORC metadata
>     -r, --retpoline       validate and annotate retpoline usage
>     -s, --stackval        validate frame pointer rules
>     -t, --static-call     annotate static calls
>     -u, --uaccess         validate uaccess rules for SMAP
>         --dump[=<orc>]    dump metadata
> 
> Options:
>         --backtrace       unwind on error
>         --backup          create .orig files before modification
>         --dry-run         don't write modifications
>         --link            object is a linked object
>         --module          object is part of a kernel module
>         --no-unreachable  skip 'unreachable instruction' warnings
>         --sec-address     print section addresses in warnings
>         --stats           print statistics

Nice job! The outcome is much clearer now.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
