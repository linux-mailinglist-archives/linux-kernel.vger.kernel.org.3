Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F974D1168
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbiCHH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiCHH7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:59:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA70205C7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646726325; x=1678262325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VQNvcDVcyglSi/SgZclVCjS5AQucsWOUcgatQiv+Xng=;
  b=ihvFJayxvoEAoRc8xp3ipG5oAlbyjlnwy8Lebd5N3O4NnlWpTugdbhx7
   xYCREn0pEM/IuBaCc1ygjER29hRVNrtvTLVEPOyzQop/lEWODw5s+C7nh
   C5t2Nt7+Y7LNXFmQn2xlx95+IdsomNZeC45MJ8gUA0/tFxtwdGuIXjJoQ
   29OzLoqppiYDj6KD2HbGS5nfPCb3DVHUl+BE2teNFreHFO4cjkoYnMbC3
   SpdUQmdmrE6YupI4xv2tfgS0mp2FSIZ1xUflx5f05Aek5sBGELQ/Y3n3E
   WRjWezX+1AgRpcxkvQpNYkNDYPiwdya7vnfvbwQyxZbSZY7g1AcjqkP5S
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242058280"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="242058280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 23:58:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="687839821"
Received: from ejoldes-mobl1.ger.corp.intel.com (HELO [10.252.54.36]) ([10.252.54.36])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 23:58:40 -0800
Message-ID: <de1b0152-7521-db6f-355a-b906ecbe84dd@linux.intel.com>
Date:   Tue, 8 Mar 2022 09:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] checkpatch: use python3 to find codespell dictionary
Content-Language: en-US
To:     Sagar Patel <sagarmp@cs.unc.edu>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20220308025547.20412-1-sagarmp@cs.unc.edu>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220308025547.20412-1-sagarmp@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagar,

On 08/03/2022 04:55, Sagar Patel wrote:
> Commit 0ee3e7b8893e ("checkpatch: get default codespell dictionary path
> from package location") introduced the ability to search for the
> codespell dictionary rather than hardcoding its path.
> 
> codespell requires Python 3.6 or above, but on some systems, the python
> binary is a Python 2.7 interpreter. In this case, searching for the
> dictionary fails, subsequently making codespell fail:
> 
> No codespell typos will be found - file '/usr/share/codespell/dictionary.txt': No such file or directory
> 
> So, use python3 to remove ambiguity.
> 
> In addition, when searching for the dictionary, do not check if the
> codespell binary exists since codespell can be installed via a Python
> package manager. In this case, a codespell binary is not exported in
> $PATH, but a dictionary does exist.

Installing codespell via pip will place the 'codespell' executable under
the user's $HOME/.local/bin/ and it expects that it is in PATH:

# pip install codespell
Defaulting to user installation because normal site-packages is not writeable
Collecting codespell
  Downloading codespell-2.1.0-py3-none-any.whl (177 kB)
     |████████████████████████████████| 177 kB 1.9 MB/s            
Installing collected packages: codespell
  WARNING: The script codespell is installed in '/home/my_user/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.

Having said that, the executable itself is not used by checkpatch.pl, so

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> Signed-off-by: Sagar Patel <sagarmp@cs.unc.edu>
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

-- 
Péter
