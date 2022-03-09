Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC04D3AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiCIUDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiCIUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:03:10 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79E39B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:02:10 -0800 (PST)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id E258825032;
        Wed,  9 Mar 2022 20:02:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 7036820029;
        Wed,  9 Mar 2022 20:01:51 +0000 (UTC)
Message-ID: <7ffd475f04d4ec88a38f5e89fea13c79bd95ec2b.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: use python3 to find codespell dictionary
From:   Joe Perches <joe@perches.com>
To:     Sagar Patel <sagarmp@cs.unc.edu>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 12:02:06 -0800
In-Reply-To: <20220309180048.147672-1-sagarmp@cs.unc.edu>
References: <20220309180048.147672-1-sagarmp@cs.unc.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cpzgqbyf14dcr4yo4hgj99bzp4ozhjru
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 7036820029
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/sdQXxZg51Vh0dgyJTw0yju4Bu9Q25b3c=
X-HE-Tag: 1646856111-504217
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-09 at 13:00 -0500, Sagar Patel wrote:
> Commit 0ee3e7b8893e ("checkpatch: get default codespell dictionary path
> from package location") introduced the ability to search for the
> codespell dictionary rather than hardcoding its path.
> 
> codespell requires Python 3.6 or above, but on some systems, the python
> executable is a Python 2.7 interpreter. In this case, searching for the
> dictionary fails, subsequently making codespell fail:
> 
> No codespell typos will be found - file '/usr/share/codespell/dictionary.txt': No such file or directory
> 
> So, use python3 to remove ambiguity.

Seems sensible, thanks.

> 
> In addition, when searching for dictionary.txt, do not check if the
> codespell executable exists since,
> 
>   - checkpatch.pl only uses dictionary.txt, not the codespell
>     executable.
>   - codespell can be installed via a Python package manager, in which
>     case the codespell executable may not be present in a typical $PATH,
>     but a dictionary does exist.
> 
> Signed-off-by: Sagar Patel <sagarmp@cs.unc.edu>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hey,
> 
> Changes since v1:
> - reword commit message to clarify that the codespell executable is not used,
>   and that the executable may not be present in a *typical* $PATH.
> 
> ---Sagar Patel
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b01c36a15d9d..46302e074b18 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -334,7 +334,7 @@ if ($user_codespellfile) {
>  } elsif (!(-f $codespellfile)) {
>  	# If /usr/share/codespell/dictionary.txt is not present, try to find it
>  	# under codespell's install directory: <codespell_root>/data/dictionary.txt
> -	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
> +	if (($codespell || $help) && which("python3") ne "") {
>  		my $python_codespell_dict = << "EOF";
>  
>  import os.path as op
> @@ -344,7 +344,7 @@ codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
>  print(codespell_file, end='')
>  EOF
>  
> -		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
> +		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
>  		$codespellfile = $codespell_dict if (-f $codespell_dict);
>  	}
>  }


