Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CEC4678EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbhLCOBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhLCOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:01:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE3C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC6B662AEA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A57C53FAD;
        Fri,  3 Dec 2021 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638539863;
        bh=GkZK7CjGJ62tcATLLT9E8sNeTIf3fZA3Xl+jf6Wf6y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQcyp4Hmmn/oUjF10ZQdW/iRg9E+SCbUq63s7GI0c0tKXyPuWzcna3+0r8HcrNn4c
         H/rg4Ca+tS6XaNSTrhyquSK3HJAPHVyb7sgkZLoU/DwLCsiC9HP2X5YXvMsMyCvgUB
         c4bBsYkksDuQYdUzaphPUcsfTKcXjEkSKSGy5pVeE9mrQ5vDqMu9J9gVY5lKHzAAlt
         DWne3eO4cWHd4AFgYBDqnY9lfH9u21lJ0jTjOpzUFHAbIgvrg1ABzEIpP/sH3vmAYA
         6CdQPo1rjeLpTcumMCocOz5Qs+wEu5INrU4geZqMKp7Rf1xu9Bck2G+aZ5EJtphMpY
         Ae8mFGalKmS+w==
Date:   Fri, 3 Dec 2021 14:57:38 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>, lkp@intel.com,
        kbuild-all@lists.01.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v1 2/2] ucounts: Move rlimit max values from ucounts max
Message-ID: <20211203135738.ywxjw63ljskzfp2e@example.org>
References: <bcc85eae4f5e3799f9efdf2d73572bb88616ebac.1637934917.git.legion@kernel.org>
 <202111280022.ugxpiKpA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111280022.ugxpiKpA-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:33:25PM +0300, Dan Carpenter wrote:
> Hi Alexey,
> 
> url:    https://github.com/0day-ci/linux/commits/Alexey-Gladkov/ucounts-Fix-rlimit-max-values-check/20211126-224059
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
> config: i386-randconfig-m021-20211126 (https://download.01.org/0day-ci/archive/20211128/202111280022.ugxpiKpA-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> kernel/ucount.c:109 setup_userns_sysctls() error: buffer overflow 'ns->ucount_max' 10 <= 13
> 
> vim +109 kernel/ucount.c
> 
> dbec28460a89aa Eric W. Biederman 2016-07-30   98  bool setup_userns_sysctls(struct user_namespace *ns)
> dbec28460a89aa Eric W. Biederman 2016-07-30   99  {
> dbec28460a89aa Eric W. Biederman 2016-07-30  100  #ifdef CONFIG_SYSCTL
> dbec28460a89aa Eric W. Biederman 2016-07-30  101  	struct ctl_table *tbl;
> 0f538e3e712a51 Jan Kara          2020-04-07  102  
> 0f538e3e712a51 Jan Kara          2020-04-07  103  	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
> dbec28460a89aa Eric W. Biederman 2016-07-30  104  	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
> f6b2db1a3e8d14 Eric W. Biederman 2016-08-08  105  	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
> dbec28460a89aa Eric W. Biederman 2016-07-30  106  	if (tbl) {
> 25f9c0817c535a Eric W. Biederman 2016-08-08  107  		int i;
> 25f9c0817c535a Eric W. Biederman 2016-08-08  108  		for (i = 0; i < UCOUNT_COUNTS; i++) {
> 25f9c0817c535a Eric W. Biederman 2016-08-08 @109  			tbl[i].data = &ns->ucount_max[i];
> 
> The patch changes the size of ->ucount_max[] to MAX_PER_NAMESPACE_UCOUNTS
> but this loop still goes up to UCOUNT_COUNTS.
> 
> 25f9c0817c535a Eric W. Biederman 2016-08-08  110  		}
> f6b2db1a3e8d14 Eric W. Biederman 2016-08-08  111  		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl);
> dbec28460a89aa Eric W. Biederman 2016-07-30  112  	}
> dbec28460a89aa Eric W. Biederman 2016-07-30  113  	if (!ns->sysctls) {
> dbec28460a89aa Eric W. Biederman 2016-07-30  114  		kfree(tbl);
> dbec28460a89aa Eric W. Biederman 2016-07-30  115  		retire_sysctl_set(&ns->set);
> dbec28460a89aa Eric W. Biederman 2016-07-30  116  		return false;
> dbec28460a89aa Eric W. Biederman 2016-07-30  117  	}
> dbec28460a89aa Eric W. Biederman 2016-07-30  118  #endif
> dbec28460a89aa Eric W. Biederman 2016-07-30  119  	return true;
> dbec28460a89aa Eric W. Biederman 2016-07-30  120  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

Thanks! But a few days ago I already post a new version of this changeset
with fix:

https://lore.kernel.org/containers/24c87e225c7950bf2ea1ff4b4a8f237348808241.1638218242.git.legion@kernel.org/

-- 
Rgrds, legion

