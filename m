Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F35A59BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiH3DHV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Aug 2022 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiH3DHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:07:05 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C167A3D38;
        Mon, 29 Aug 2022 20:06:47 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 457231A0878;
        Tue, 30 Aug 2022 03:06:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 7FA992F;
        Tue, 30 Aug 2022 03:06:44 +0000 (UTC)
Message-ID: <dc45a7021bb765ea34c5b9228454f255764c7bc9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Date:   Mon, 29 Aug 2022 23:06:43 -0400
In-Reply-To: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
References: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7FA992F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: xrgf38phz7kpaak68mirho4fc968wqy3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19e9kf4kUAZg/cANrnHGmIsQgBksQYMOM0=
X-HE-Tag: 1661828804-275761
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-29 at 17:53 +0200, Niklas Söderlund wrote:
> Add a warning for fixes tags that does not fall in line with the
> standards specified by the community.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Louis Peens <louis.peens@corigine.com>
> ---
>  Documentation/dev-tools/checkpatch.rst |  6 ++++
>  scripts/checkpatch.pl                  | 41 ++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index b52452bc2963..8164f362a2fc 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -612,6 +612,12 @@ Commit message
>  
>      See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>  
> +  **BAD_FIXES_TAG**
> +    The fixes line does not fall in line with the standards specified by the
> +    community.
> +
> +    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> +
>  
>  Comparison style
>  ----------------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 79e759aac543..9b8cdc582fb5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3140,6 +3140,47 @@ sub process {
>  			}
>  		}
>  
> +# Check Fixes: styles is correct
> +		if (!$in_header_lines && $line =~ /^fixes:/i) {
> +			my $orig_commit = "";
> +			my $id = "0123456789ab";
> +			my $title = "commit title";
> +			my $tag_case = 1;
> +			my $tag_space = 1;
> +			my $id_length = 1;
> +			my $id_case = 1;
> +			my $title_has_quotes = 0;
> +
> +			if ($line =~ /(fixes:)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {

Maybe use fixes:? so the colon is not required in poorly formed uses

> +				my $tag = $1;
> +				$orig_commit = $2;
> +				$title = $3;
> +
> +				$tag_case = 0 if $tag eq "Fixes:";
> +				$tag_space = 0 if ($line =~ /^fixes: [0-9a-f]{5,} ($balanced_parens)/i);

fixes:? here too

Pity there's no simple way to consolidate this git commit test block
with the existing git id commit block.

> +
> +				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
> +				$id_case = 0 if ($orig_commit !~ /[A-F]/);
> +
> +				# Always strip leading/trailing parens then double quotes if existing
> +				$title = substr($title, 1, -1);
> +				if ($title =~ /^".*"$/) {
> +					$title = substr($title, 1, -1);
> +					$title_has_quotes = 1;
> +				}
> +			}
> +
> +			($id, $title) = git_commit_info($orig_commit, $id,
> +							$title);
> +
> +			if ($tag_case || $tag_space || $id_length || $id_case ||
> +			    !$title_has_quotes) {
> +				WARN("BAD_FIXES_TAG",
> +				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $id (\"$title\")'\n" . $herecurr);
> +
> +			}
> +		}
> +
>  # Check email subject for common tools that don't need to be mentioned
>  		if ($in_header_lines &&
>  		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {

