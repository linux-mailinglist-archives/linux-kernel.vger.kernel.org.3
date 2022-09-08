Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3BE5B21A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiIHPJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Sep 2022 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiIHPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:09:15 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E8E7F91;
        Thu,  8 Sep 2022 08:09:08 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id B0B861C27AC;
        Thu,  8 Sep 2022 15:09:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 19DE420010;
        Thu,  8 Sep 2022 15:09:02 +0000 (UTC)
Message-ID: <2e3295bca268c37aa57fb5b14da9a4c1795ac067.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: warn for non-standard fixes tag style
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
Date:   Thu, 08 Sep 2022 08:09:01 -0700
In-Reply-To: <20220908114325.4153436-1-niklas.soderlund@corigine.com>
References: <20220908114325.4153436-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 19DE420010
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: demmofq5fa5y1b57z81y98bdn6pn575q
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19x4WVO6Dxvs4HzzmeCe+NDeqANcEHshgg=
X-HE-Tag: 1662649742-413860
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 13:43 +0200, Niklas Söderlund wrote:
> Add a warning for fixes tags that does not fall in line with the
> standards specified by the community.

Thanks.  Good on you for adding the .rst block too.

This seems OK but maybe:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3140,6 +3140,47 @@ sub process {
>  			}
>  		}
>  
> +# Check Fixes: styles is correct
> +		if (!$in_header_lines && $line =~ /^fixes:?/i) {
> +			my $orig_commit = "";
> +			my $id = "0123456789ab";
> +			my $title = "commit title";
> +			my $tag_case = 1;
> +			my $tag_space = 1;
> +			my $id_length = 1;
> +			my $id_case = 1;
> +			my $title_has_quotes = 0;
> +
> +			if ($line =~ /(fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> +				my $tag = $1;
> +				$orig_commit = $2;
> +				$title = $3;
> +
> +				$tag_case = 0 if $tag eq "Fixes:";
> +				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
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

Maybe add another test for the title being different from the commit.

Something like:

			my ($cid, $ctitle) = git_commit_info($orig_commit, $id, $title);

> +
> +			if ($tag_case || $tag_space || $id_length || $id_case ||

			    $ctitle != $title ||

> +			    !$title_has_quotes) {
> +				WARN("BAD_FIXES_TAG",
> +				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $id (\"$title\")'\n" . $herecurr);

				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $id (\"$ctitle\")'\n" . $herecurr);


