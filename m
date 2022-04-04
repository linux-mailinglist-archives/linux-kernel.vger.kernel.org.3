Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABB4F1702
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377571AbiDDOcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbiDDOby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:31:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7952183A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:29:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A85E210F4;
        Mon,  4 Apr 2022 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649082596;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPiUTo9lCTl5ISvpZbNriTdQZu3g/7UZohSIiQkqB4w=;
        b=JJWwItHpGFehO3NiUm4aSQcuB6Wl3QUlNcluP55rhZQXFkstNAXpbcqI6StbzvtTGn7Nau
        WfCgWqiXiVGtz2ZaROlrrUxCQfO9t1jqPsQqjhgPKruFkSS/uikn9YqX+bqmi5S7wF4T1W
        +QWvZCcsSSwhNVFfxbHFncxNY3kbf3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649082596;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPiUTo9lCTl5ISvpZbNriTdQZu3g/7UZohSIiQkqB4w=;
        b=oOYm9G9BJqvc6pJCwjHLdI4QIZF1IdISKW1AWGc2FuqsoxKySBlHWn4457AzMbwqUXtpWW
        cbLqaeJTuEMxdcDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EB600A3B89;
        Mon,  4 Apr 2022 14:29:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4708DDA80E; Mon,  4 Apr 2022 16:25:55 +0200 (CEST)
Date:   Mon, 4 Apr 2022 16:25:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Stefan Roesch <shr@fb.com>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [kdave-btrfs-devel:for-next-20220401 96/102]
 fs/btrfs/sysfs.c:830 btrfs_force_chunk_alloc_store() warn: passing zero to
 'PTR_ERR'
Message-ID: <20220404142554.GO15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild@lists.01.org, Stefan Roesch <shr@fb.com>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <202204030841.qWK5rMDU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204030841.qWK5rMDU-lkp@intel.com>
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

On Mon, Apr 04, 2022 at 04:40:17PM +0300, Dan Carpenter wrote:
> tree:   https://github.com/kdave/btrfs-devel.git for-next-20220401
> head:   0c593f04d2f520a720c5c618ba9fe0355d08bba8
> commit: 6e115adef2b6a9b9a7cc25414e1b8f4414e02044 [96/102] btrfs: add force_chunk_alloc sysfs entry to force allocation
> config: nios2-randconfig-m031-20220403 (https://download.01.org/0day-ci/archive/20220403/202204030841.qWK5rMDU-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> fs/btrfs/sysfs.c:830 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'

Thanks for the report, I've found more problems in the patches so there
will be another update, also fixing this problem.
