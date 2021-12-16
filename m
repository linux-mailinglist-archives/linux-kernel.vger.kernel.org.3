Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD131477C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbhLPTeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLPTeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:34:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F87C061574;
        Thu, 16 Dec 2021 11:34:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371AA61F3E;
        Thu, 16 Dec 2021 19:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B82C36AE2;
        Thu, 16 Dec 2021 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639683256;
        bh=lgGHjrtLPdvcwNTckAr7sscwionCHV5hIcqHkdrFjA8=;
        h=From:To:Cc:Subject:Date:From;
        b=pJJXY/mV5VsENX+LABzCAvLc7F1qijfiO11ZZbyGYQdj1Q+61paVfV6fAkkRhkIJN
         r0t17Y3LNxUf1VA4oLHnc8EqZKeV6e6b0wbxy1gKq92pS3l4Mgpa+HZb5bnblwEGcI
         rhra4SzhzWEJpmoMSVWoMc5tmTPC1wT32HHGWyC6+fqh28f9kea3/Dpw03mSL92Dza
         oSOphQWWvJA8x87Ak+19NbaUrHDN23STPSGtG04tR2KVaWTPSsjnbQUWqxq2Hw55Wi
         bTdFyF0OXhRIq3u/4zegFLevPoSth/8G2WF9eaSv+bL3sQ2beeyHwjqbJWKoQslgGn
         raLHpE7kzcJBA==
From:   broonie@kernel.org
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the userns tree with the cel tree
Date:   Thu, 16 Dec 2021 19:34:12 +0000
Message-Id: <20211216193412.2441434-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  fs/nfsd/nfssvc.c

between commit:

  cfb05a7336741 ("NFSD: narrow nfsd_mutex protection in nfsd thread")

from the cel tree and commit:

  ca3574bd653ab ("exit: Rename module_put_and_exit to module_put_and_kthread_exit")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/nfsd/nfssvc.c
index 14c1ef6f8cc74,5ce9f14318c4e..0000000000000
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@@ -977,25 -982,11 +977,25 @@@ out
  	/* Release the thread */
  	svc_exit_thread(rqstp);
  
 -	nfsd_destroy(net);
 +	/* We need to drop a ref, but may not drop the last reference
 +	 * without holding nfsd_mutex, and we cannot wait for nfsd_mutex as that
 +	 * could deadlock with nfsd_shutdown_threads() waiting for us.
 +	 * So three options are:
 +	 * - drop a non-final reference,
 +	 * - get the mutex without waiting
 +	 * - sleep briefly andd try the above again
 +	 */
 +	while (!svc_put_not_last(nn->nfsd_serv)) {
 +		if (mutex_trylock(&nfsd_mutex)) {
 +			nfsd_put(net);
 +			mutex_unlock(&nfsd_mutex);
 +			break;
 +		}
 +		msleep(20);
 +	}
  
  	/* Release module */
- 	module_put_and_exit(0);
 -	mutex_unlock(&nfsd_mutex);
+ 	module_put_and_kthread_exit(0);
  	return 0;
  }
  
