Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7148322C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiACOZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:25:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:19045 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbiACOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641219921; x=1672755921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ZtKX9nQeEy2Ilo4GD8eCynXClwBOnQHs3aucaY4xaA=;
  b=Ovd1HtDnhQfADioHXTlXl42dTwE39fG9N6E2ArYQiX+91RlsO7D+bQeq
   dHWyiBJGPdNBtdLSbQM7HBQc9GIpaaboFJxTDyJt3NgEqNp/cz4uw9OZ8
   buJm0jRtwZ9Ekl+eZ3/y5+LRISoNWbYAzrI+08j2hwEwI0EgWvlJTElkm
   J1oDHUsjVeJe3qkzwhAv+TC3lbp/FRBmHg+FItxmNibR2kZFylYkh8wVD
   9PvzO138vd9B6onm9U6lcdpblo1MSTwM0agKJfIOmdjYIy75xOGXAw0Hu
   mDdCB66MWKYx6feuH4KfGxr7NSEFPXdNfKXVo+m0FpXJVF7bFNl1uLx1U
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="239610212"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="239610212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 06:24:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="487859227"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2022 06:24:00 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 203ENxcQ002999;
        Mon, 3 Jan 2022 14:23:59 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: explicitly require python3 for codespell
Date:   Mon,  3 Jan 2022 15:22:51 +0100
Message-Id: <20220103142251.4658-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211207211316.566692-1-alexandr.lobakin@intel.com>
References: <20211207211316.566692-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue,  7 Dec 2021 22:13:16 +0100

> Fix a bug where checkpatch couldn't automatically find
> dictionary.txt.
> "Unversioned" `which python` might be not present in a system
> with Python 3 and codespell installed and working. SPDX check
> already refers to `which python3`, do the same for codespell.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping?

> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1784921c645d..6943f1e507f1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -334,7 +334,7 @@ if ($user_codespellfile) {
>  } elsif (!(-f $codespellfile)) {
>  	# If /usr/share/codespell/dictionary.txt is not present, try to find it
>  	# under codespell's install directory: <codespell_root>/data/dictionary.txt
> -	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
> +	if (($codespell || $help) && which("codespell") ne "" && which("python3") ne "") {
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
> -- 
> 2.33.1

Al
