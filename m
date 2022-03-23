Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D34E56D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiCWQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbiCWQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:48:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922C4A3CB;
        Wed, 23 Mar 2022 09:47:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A1EE1F388;
        Wed, 23 Mar 2022 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648054020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/+VETRFO5PTDlIzRRIClit3aflm+jce01s1gMGXpJ0=;
        b=d6YPUKTB90VFKRJsQKtU90s/POZJMVD6N8/rJjk0XqcFyWq2KZ/91hGBjGy2q7DBrUxvts
        jvTunoqsZacd1/hsxbIKQtv8vD4XqTf998EGySEXbusFh7a5b2n4sfL9s2NITMvc2bTWKh
        o+9AJZePH2hFO9f1TzFGhVE/DLf0bb8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 683C3A3B83;
        Wed, 23 Mar 2022 16:47:00 +0000 (UTC)
Date:   Wed, 23 Mar 2022 17:46:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: undefined reference to `node_data'
Message-ID: <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
References: <202203232042.AS9SV1zv-lkp@intel.com>
 <Yjs0ausRy6/mLUFD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjs0ausRy6/mLUFD@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me CC MIPS maintainers

On Wed 23-03-22 15:53:31, Michal Hocko wrote:
> On Wed 23-03-22 20:58:10, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   6b1f86f8e9c7f9de7ca1cb987b2cf25e99b1ae3a
> > commit: 09f49dca570a917a8c6bccd7e8c61f5141534e3a mm: handle uninitialized numa nodes gracefully
> > date:   14 hours ago
> > config: mips-buildonly-randconfig-r004-20220323 (https://download.01.org/0day-ci/archive/20220323/202203232042.AS9SV1zv-lkp@intel.com/config)
> > compiler: mips64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f49dca570a917a8c6bccd7e8c61f5141534e3a
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 09f49dca570a917a8c6bccd7e8c61f5141534e3a
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> Didn't work for me
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
> > >> (.init.text+0x1680): undefined reference to `node_data'
> >    mips64-linux-ld: (.init.text+0x1690): undefined reference to `node_data'
> 
> OK, I can see what is going here. The page allocator normally
> uses NODE_DATA but arch_refresh_nodedata refers to node_data directly.
> This is a problem with
> arch/mips/include/asm/mach-loongson64/mmzone.h:
> extern struct pglist_data *__node_data[];
> 
> #define NODE_DATA(n)            (__node_data[n])
> 
> Unfortunately we cannot use NODE_DATA there because of header inclusion
> ordering. I will think about a solution.

Is there any reason why (some?) MIPS arches use __node_data rather than
node_data as most other architectures? Would it be acceptable to do the
renaming? It would help to cover the above compilation problem because
arch_refresh_nodedata could keep using node_data directly.

Thanks!
-- 
Michal Hocko
SUSE Labs
