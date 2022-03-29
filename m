Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9149A4EB1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiC2Qdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiC2Qdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:33:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBB7242210
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:32:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EEBF22199A;
        Tue, 29 Mar 2022 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648571524;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qn99NQsgecfSy/cduhbF8O5zmnc21CQyFrWDmqawHNQ=;
        b=nHQJWZl8j/fkHtNs9difUcSzxbjiKPSRVSbW+NAGBg7RcAYZYk+cmxlQKD2Clsjyg8ZiUo
        jJOm8Hd3kzDu+Akf2ftCqi2kVFR25xwMeYrweckmtL5YXHXV/N4yJ4qsSoGEuiBhGhghA3
        cnhA4ZBTXkSWhNowFArJj+UlL1wyua0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648571524;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qn99NQsgecfSy/cduhbF8O5zmnc21CQyFrWDmqawHNQ=;
        b=61tl8YB8egqQtRaMpdydB/DW2E28VmGTy3MB9wQYKGFejOlQhLdadcAu/T3AvM59c58qEf
        MDdNDlX85YnR3YAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DD19AA3CF3;
        Tue, 29 Mar 2022 16:32:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DB08DA7F3; Tue, 29 Mar 2022 18:28:07 +0200 (CEST)
Date:   Tue, 29 Mar 2022 18:28:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [fs] 37da949345: xfstests.generic.374.fail
Message-ID: <20220329162806.GY2237@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Bruno Goncalves <bgoncalv@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20220311032233.GD18612@xsang-OptiPlex-9020>
 <CA+QYu4osuzA+V5Th29SOsS1FnAZgdsaTc_qNPyPp=GH+q1LZYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4osuzA+V5Th29SOsS1FnAZgdsaTc_qNPyPp=GH+q1LZYQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 12:26:43PM +0200, Bruno Goncalves wrote:
> On Fri, Mar 11, 2022 at 4:23 AM kernel test robot <oliver.sang@intel.com> wrote:
> >      Mount otherdir
> >      Create file
> >      Dedupe one file to another
> >     -XFS_IOC_FILE_EXTENT_SAME: Invalid cross-device link
> >     +deduped 65536/65536 bytes at offset 0
> >     +64 KiB, 1 ops; 0.0018 sec (33.967 MiB/sec and 543.4783 ops/sec)
> >      Check output
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/374.out /lkp/benchmarks/xfstests/results//generic/374.out.bad'  to see the entire diff)
> > generic/375      1s
> > generic/376      2s
> > generic/377      1s
> > generic/378      1s
> > generic/379     [not run] disk quotas not supported by this filesystem type: btrfs
> > Ran: generic/360 generic/361 generic/362 generic/363 generic/364 generic/365 generic/366 generic/367 generic/368 generic/369 generic/370 generic/371 generic/372 generic/373 generic/374 generic/375 generic/376 generic/377 generic/378 generic/379
> > Not run: generic/362 generic/363 generic/364 generic/365 generic/366 generic/367 generic/368 generic/369 generic/370 generic/372 generic/379
> > Failures: generic/373 generic/374
> > Failed 2 of 20 tests
> >
> >
> 
> We are also able to reproduce this on mainline kernel with gcc12, the
> problem seems to have been introduced by [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5191290407668028179f2544a11ae9b57f0bcf07

I think you need to update fstests once the patches from
https://lore.kernel.org/linux-btrfs/bad40a464e1728309e185a031e8d3652c22b68cf.1648153387.git.josef@toxicpanda.com/
are merged.
