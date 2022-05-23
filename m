Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92564530793
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244901AbiEWCRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEWCRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:17:40 -0400
Received: from relay4.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E8F35843
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:17:39 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id EEE3C20DA1;
        Mon, 23 May 2022 02:17:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id D29F832;
        Mon, 23 May 2022 02:17:30 +0000 (UTC)
Message-ID: <9ff72e47bf89977efe00df6db6ebbdd7b22a9972.camel@perches.com>
Subject: Re: [PATCH v7 15/25] scripts: checkpatch: diagnose uses of `%pA` in
 the C side
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 22 May 2022 19:17:29 -0700
In-Reply-To: <20220523020209.11810-16-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
         <20220523020209.11810-16-ojeda@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D29F832
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: q5cg9ndqchhd36mejtbbn66o75x9rtm4
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18QYM5OZvxC4fQ9IN+Y6ZuuGaSYBekmtIs=
X-HE-Tag: 1653272250-608368
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 04:01 +0200, Miguel Ojeda wrote:
> The `%pA` format specifier is only intended to be used from Rust.
> 
> `checkpatch.pl` already gives a warning for invalid specificers:
> 
>     WARNING: Invalid vsprintf pointer extension '%pA'
> 
> With this change, we introduce an error message with further
> explanation:
> 
>     ERROR: '%pA' is only intended to be used from Rust code
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

How many developers are required for a trivial patch?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6784,6 +6784,10 @@ sub process {
>  					my $stat_real = get_stat_real($linenr, $lc);
>  					my $ext_type = "Invalid";
>  					my $use = "";
> +					if ($bad_specifier =~ /pA/) {
> +						ERROR("VSPRINTF_RUST",
> +							"'\%pA' is only intended to be used from Rust code\n" . "$here\n$stat_real\n");
> +					}
>  					if ($bad_specifier =~ /p[Ff]/) {

and this should now use elsif

>  						$use = " - use %pS instead";
>  						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);


