Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18A53F1B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiFFVb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiFFVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9861A394;
        Mon,  6 Jun 2022 14:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF5406164F;
        Mon,  6 Jun 2022 21:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E556C385A9;
        Mon,  6 Jun 2022 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654551086;
        bh=4Xm0R5P+VrCwOW+zqQpekghTWxOqCtFkCmzjB4kSLss=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KWhSttqILWZQreWlBFVuXFUfmoWeA03sUhkuDma+WHXl+RsxZKH9sPKk4HER0NQpq
         L7U5/g9NjmANfX8Qq17db5Ts3HoT/9oJ8ci1ib7MprRxMQaWHFAjAnbAtcBNLAEWeB
         ipzIE3KsDU3rvyGKrOCIHhmT8CTGQe0Tv8f7IMN9FKTzaB70tBy2EGwDioYy58Yqs+
         fFnKQGoZkEUWAlx0S/uP8NHqCrdpg8SDzE48vz/hS9sIxCEzzKkI4LtWcDZs407KwG
         Qy3LGVy68t5qT23k8giQiRfzCmaf5rWUszvUtNOhpo9Od3x01SknQxu46OatVYVaJ8
         RE+IxjFj+5Nbg==
Date:   Mon, 6 Jun 2022 23:31:19 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
In-Reply-To: <20220606194850.26122-1-vegard.nossum@oracle.com>
Message-ID: <nycvar.YFH.7.76.2206062326230.10851@cbobk.fhfr.pm>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, Vegard Nossum wrote:

> The current instructions for reporting security vulnerabilities in the
> kernel are not clear enough, in particular the process of disclosure
> and requesting CVEs, and what the roles of the different lists are and
> how exactly to report to each of them.
> 
> Let's give this document an overhaul. Goals are stated as a comment at
> the bottom of the document; these will not appear in the rendered HTML
> document.
> 
> v2: address feedback from Willy Tarreau and Jonathan Corbet
> 
> Link: https://seclists.org/oss-sec/2022/q2/133
> Cc: Amit Shah <aams@amazon.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Solar Designer <solar@openwall.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/admin-guide/security-bugs.rst | 252 +++++++++++++-------
>  1 file changed, 167 insertions(+), 85 deletions(-)
> 
> v1 thread:
> https://lore.kernel.org/all/20220531230309.9290-1-vegard.nossum@oracle.com/T/#u
> 
> Updated rendered HTML:
> https://vegard.github.io/security/Documentation/output/admin-guide/security-bugs-v2.html
> 
> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> index 82e29837d5898..c63eeb1e89ffd 100644
> --- a/Documentation/admin-guide/security-bugs.rst
> +++ b/Documentation/admin-guide/security-bugs.rst

Thanks for investing time into fixing this aged document.

Two rather minor things come to my mind, but as you are touching that 
document anyway ...

- what sense does it make to have embargoed-hardware-issues.rst and 
  security-bugs.rst live in different Documentation/ subdirectories 
  (admin-guide/ vs process/)? It'd seem to make sense to me to have them 
  in one common place?

- would it make sense to briefly reference embargoed-hardware-issues.rst 
  somewhere in this text, to make the distinction as obvious as possible? 
  It's referenced the other way around.

Thanks,

-- 
Jiri Kosina
SUSE Labs

