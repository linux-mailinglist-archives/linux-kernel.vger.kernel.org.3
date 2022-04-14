Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F68500810
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiDNIQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiDNIQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:16:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5C852E74
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oGf+VbZ7yz3JlLWOYZEQS3B62pJulysAHFGQT+Z5RAY=; b=S7zzTsi3b4dZBkzKksT8VSkjbR
        NrhtcX/Sc/iafRhh7skLhzk7yQl3QJ7gud/Ykiv1IuxpvGZPdG53WIcdvi4xjzX5dW7ApMYrsNkjU
        TPTPwqfmG5FRUYIGxU4D+489ZRSc0N6a+XTTJ5BZj+b5YB9Wqivzc2cDq8PBWzk8/MZKfWLfet2wa
        TunF5XGg6GSIqcjLZUG5SfEzquACF2zJRJAUxejStj/PPnlF0JiGU3dewG7kqaRoKH2Yy81Ll3QUK
        HiRHb07XOczee5OIIVJxacRdMylrn3jmd/40I1U1iMvF/inHIudD0JEy5geIiCh7xyV2ZJxeAxEL9
        vAdcCw/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neubw-00ExC7-Cj; Thu, 14 Apr 2022 08:13:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C4393000E3;
        Thu, 14 Apr 2022 10:13:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 758AE2C5BC384; Thu, 14 Apr 2022 10:13:50 +0200 (CEST)
Date:   Thu, 14 Apr 2022 10:13:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 17/18] objtool: Remove --lto and --vmlinux
Message-ID: <YlfXvlvNmCYFIq0w@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <b64b57896eaedf69f53d54c7d9ea373834aef069.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64b57896eaedf69f53d54c7d9ea373834aef069.1649891421.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:52PM -0700, Josh Poimboeuf wrote:

> @@ -131,6 +131,12 @@ static inline u32 reloc_hash(struct reloc *reloc)
>  	return sec_offset_hash(reloc->sec, reloc->offset);
>  }
>  
> +/* is it a whole archive (vmlinux.o or module)? */
> +static inline bool is_linked_object(struct elf *elf)
> +{
> +	return elf->num_files > 1;
> +}
> +
>  struct elf *elf_open_read(const char *name, int flags);
>  struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);

Ooh, nice... yes, that was the entire point of --lto.
