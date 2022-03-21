Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4594D4E2A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiCUO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348845AbiCUO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:29:04 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68360554A5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:24:57 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 09385192A;
        Mon, 21 Mar 2022 14:24:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id D6AA52002C;
        Mon, 21 Mar 2022 14:24:54 +0000 (UTC)
Message-ID: <fbd86774f021ada289918916ae17b7530e13ec4f.camel@perches.com>
Subject: Re: [RFC PATCH 1/1] checkpatch: don't suggest else is not useful
 with chained
From:   Joe Perches <joe@perches.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Mar 2022 07:24:53 -0700
In-Reply-To: <5a7bace5-eb8e-6e91-ae89-e4e47ab53a90@linux.intel.com>
References: <5a7bace5-eb8e-6e91-ae89-e4e47ab53a90@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D6AA52002C
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: m58d1sym58pkyqzyecewowye4dbd1hrc
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Dkx9lnKEuqwJjoHAKXSETBbLMcZje8Is=
X-HE-Tag: 1647872694-330695
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 11:18 +0200, Ilpo Järvinen wrote:
> When if blocks are chained with "else if" like this:
> 
> 	if (a)
> 		c = 0;
> 	else if (b)
> 		break;
> 	else
> 		c = 1;
> 
> checkpatch recommends removing else:
> 
> WARNING: else is not generally useful after a break or return
> 
> Removing else will easily introduce logic errors in this situation
> so it's better to check if the preceding line has "else if" before
> issuing that warning.
> 
> Fixes: 032a4c0f9a77 ("checkpatch: warn on unnecessary else after return or break")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> I was only able to solve this case for single line if blocks but
> it would be useful to address also multi-line if blocks but it is
> beyond my understanding about checkpatch internals.
> 
>  scripts/checkpatch.pl | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4037,14 +4037,17 @@ sub process {
>  # check indentation of any line with a bare else
>  # (but not if it is a multiple line "if (foo) return bar; else return baz;")
>  # if the previous line is a break or return and is indented 1 tab more...
> +# but don't warn when there is "else if" on before that line to avoid logic errors
>  		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
>  			my $tabs = length($1) + 1;
> -			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> -			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
> -			     defined $lines[$linenr] &&
> -			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
> +			if ($linenr >= 3 &&
> +			    $lines[$linenr - 3] !~ /[} \t]else\s+if\s*\(/ &&
> +			    ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> +			     ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
> +			      defined $lines[$linenr] &&
> +			      $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/))) {
>  				WARN("UNNECESSARY_ELSE",
> -				     "else is not generally useful after a break or return\n" . $hereprev);
> +				     "else is not generally useful after a break or return\n" . $hereprev . "\n");

I believe this wouldn't work on patches if the lines above
are deletions.


