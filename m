Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E524E2FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352021AbiCUSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352016AbiCUSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:11:28 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E37654AA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:09:59 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 50353121673;
        Mon, 21 Mar 2022 18:09:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 3A11531;
        Mon, 21 Mar 2022 18:09:57 +0000 (UTC)
Message-ID: <91f167b531f8485bb9dcb2e9febb84e091f7f45f.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Validate "Fixes:" references
From:   Joe Perches <joe@perches.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon, 21 Mar 2022 11:09:55 -0700
In-Reply-To: <20220321180709.1177684-1-bjorn.andersson@linaro.org>
References: <20220321180709.1177684-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: sckydc9wmbm7uarbuo1kaa6w7fw5uz59
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3A11531
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wSAwUqgWlzCq4UcKAtHvoYJmHyLyUM/Q=
X-HE-Tag: 1647886197-794169
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 11:07 -0700, Bjorn Andersson wrote:
> checkpatch guards about non-compliant or invalid commit references
> embedded in the commit message, but a similar set of mistakes can be
> made when referencing commits in "Fixes:".
> 
> Add sanity checks for references to missing commits, short hashes,
> improper spacing, improper case or issues with the commit description.

nak.

The idea is ok but:

This basically duplicates the commit test block so should this
should be either a function or integrated into the commit test.

> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  scripts/checkpatch.pl | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 577e02998701..b602ab50fc5c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3273,6 +3273,42 @@ sub process {
>  			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
>  		}
>  
> +# Check for valid Fixes:
> +		if ($line =~ /^fixes:\s*([0-9a-f]{5,})/i) {
> +			my $orig_commit = lc($1);
> +
> +			my $case = 1;
> +			my $short = 1;
> +			my $space = 1;
> +			my $has_quotes = 0;
> +			my $id = '0123456789ab';
> +			my $orig_desc = "commit description";
> +			my $description = "";
> +
> +			$case = 0 if ($line =~ /^Fixes:\s+[0-9a-f]{5,40}[^A-F]/);
> +			$short = 0 if ($line =~ /\bfixes:\s*[0-9a-f]{12,40}/i);
> +			$space = 0 if ($line =~ /\bfixes: [0-9a-f]{5,} \(/i);
> +
> +			if ($line =~ /\bfixes:\s+[0-9a-f]{5,}\s*($balanced_parens)/i) {
> +				$orig_desc = substr($1, 1, -1);
> +				if ($orig_desc =~ /^".*"$/) {
> +					$orig_desc = substr($orig_desc, 1, -1);
> +					$has_quotes = 1;
> +				}
> +			}
> +
> +			($id, $description) = git_commit_info($orig_commit,
> +							      $id, $orig_desc);
> +
> +			if (defined($id) && ($short || $space || $case || ($orig_desc ne $description) || !$has_quotes)) {
> +				ERROR("GIT_COMMIT_ID",
> +				      "Please use git commit description style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $id (\"$description\")'\n" . $herecurr);
> +			} elsif (!defined($id)) {
> +				WARN("UNKNOWN_COMMIT_ID",
> +				     "Unknown commit id '$orig_commit', maybe rebased or not pulled?\n" . $herecurr);
> +			}
> +		}
> +
>  # Check for added, moved or deleted files
>  		if (!$reported_maintainer_file && !$in_commit_log &&
>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||


