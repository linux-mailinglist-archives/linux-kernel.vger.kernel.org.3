Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D874C4430
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiBYMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbiBYMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:04:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C1C1B84E9;
        Fri, 25 Feb 2022 04:03:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02E941F380;
        Fri, 25 Feb 2022 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645790614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xtE+k70TidQoWi4j72BLWUm5533B5JQEZRp6zQv++Vg=;
        b=cqGbabtspkxrbOc1xI1LRqg89EFUz/W0dSxa1Arw46Ca0MCA2fTnD+xwzfxtgNYJwkt3sN
        8mKl13lL4fwVSmE39D4b/vLhXsaWaxVUm697H3HKe8yTUA2wprUwy1Z972p1n/yqjxfQ8x
        LhZkHL7TKJrf4xIDI2mFy9KXfnrEMo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645790614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xtE+k70TidQoWi4j72BLWUm5533B5JQEZRp6zQv++Vg=;
        b=05jhUNWeAHGEyV3bFElcwMeV3zL2RiSqWWzpzY9DNFCSiEzkBf9mGtAciG0ymfNofs6paf
        7UALELV7SVI00aDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EBBC4A3B8D;
        Fri, 25 Feb 2022 12:03:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B74FDA818; Fri, 25 Feb 2022 12:59:44 +0100 (CET)
Date:   Fri, 25 Feb 2022 12:59:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     broonie@kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Subject: Re: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20220225115944.GF12643@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, broonie@kernel.org,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
References: <20220224134427.3208381-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224134427.3208381-1-broonie@kernel.org>
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

On Thu, Feb 24, 2022 at 01:44:27PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the btrfs tree got conflicts in:
> 
>   fs/btrfs/ctree.h
>   fs/btrfs/file.c
>   fs/btrfs/inode.c
>   fs/btrfs/ioctl.c
>   fs/btrfs/lzo.c
> 
> between commit:
> 
>   2ac3e062af024 ("btrfs: reduce extent threshold for autodefrag")
>   741b23a970a79 ("btrfs: prevent copying too big compressed lzo segment")
>   26fbac2517fca ("btrfs: autodefrag: only scan one inode once")
>   966d879bafaaf ("btrfs: defrag: allow defrag_one_cluster() to skip large extent which is not a target")
>   d5633b0dee02d ("btrfs: defrag: bring back the old file extent search behavior")
> 
> from the btrfs-fixes tree and commit:
> 
>   13b2f7ab699a5 ("btrfs: close the gap between inode_should_defrag() and autodefrag extent size threshold")
>   48b433a2ef82a ("btrfs: add lzo workspace buffer length constants")
>   db360c49d476f ("btrfs: autodefrag: only scan one inode once")
>   e6c69fcbee7ef ("btrfs: defrag: use control structure in btrfs_defrag_file()")
>   6b17743d934ec ("btrfs: defrag: bring back the old file extent search behavior")
> 
> from the btrfs tree.

The fixes and for-next snapshot branches got out of sync a bit, I've
checked that they merge without conflicts as of yesterday.
