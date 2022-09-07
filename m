Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F375B084B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiIGPSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Sep 2022 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiIGPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:18:38 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E371BF6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:18:35 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 60C411C68A7;
        Wed,  7 Sep 2022 15:18:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id D326820028;
        Wed,  7 Sep 2022 15:18:32 +0000 (UTC)
Message-ID: <1125e8a68a709e18b594f74fc9b25b9992b1582f.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add check for fixes: tag
From:   Joe Perches <joe@perches.com>
To:     Philippe Schenker <dev@pschenker.ch>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>
Date:   Wed, 07 Sep 2022 08:18:31 -0700
In-Reply-To: <20220907123547.138646-1-dev@pschenker.ch>
References: <20220907123547.138646-1-dev@pschenker.ch>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: D326820028
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: zdys8kds7bey5hp9ft4grgzadyasbyf9
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+zyQf/rXFLnDazr9jzGp0+Aw/rk4VExtE=
X-HE-Tag: 1662563912-10451
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-07 at 14:35 +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> The page about submitting patches in
> Documentation/process/submitting-patches.rst is very specific on how that
> tag should be formatted: 'Fixes: <12+ chars of sha1> (\"<title line>\")'
> 
> Add a rule that warns if this format does not match. This commit is
> introduced as in the past commits have been sent multiple times with
> having the word commit also in the Fixes: tag which had to be corrected
> by the maintainers. [1]

I preferred your first patch that added the commit description match
as that's a fairly common defect.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3438,6 +3438,13 @@ sub process {
>  			}
>  		}
>  
> +# Check fixes tag format
> +		if ($in_commit_log && ($line =~ /^\s*Fixes:/i) &&
> +			!($line =~ /^\s*Fixes:\s[0-9a-f]{12,40}\s\(\".*\"\)/)) {

All fixes lines should start in the first column.

This allows spaces at the start of the line and the only white space
allowed after Fixes: and after the SHA1 should be a space not a tab.

I think the test better if it checks for a SHA1 after fixes.

And IMO

	!(foo =~ /bar.../)

is better written as

	foo !~ /bar.../

so

		if ($in_commit_log &&
		    $line =~ /^\s*Fixes:?\s*[0-9a-f]{5,}\b/i &&
		    $line !~ /^Fixes: [0-9a-f]{12,40} \(\".*\"\)/)) {

Though it's arguable that the SHA1 should _only_ be length 12
and not longer.

