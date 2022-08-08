Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF6958CAC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiHHOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiHHOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69CBFF16
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659970222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zA8npM3OywHm42HT0c3n4OurYu0szJDVE3++UGlXPIA=;
        b=TskIBFaX0UgeU83zovdn5Qb8Z+xOL24FAoYssuI9IxVc6DHIjmqIrjn77OhceMN5mdJuoW
        nZEgwVVS0kg1RFIPC82IPjjIzeL8SJp62W2HQ0KPaU2m4yfLBRUuWLAa9Lu6IT6Ur28f6P
        0B/T1jzWUMXsKO5f/RKiyWxFURZXqOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-htAu44AoOqG8R2UP2bdCDQ-1; Mon, 08 Aug 2022 10:50:19 -0400
X-MC-Unique: htAu44AoOqG8R2UP2bdCDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4D78858EED;
        Mon,  8 Aug 2022 14:50:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAD2E18ECC;
        Mon,  8 Aug 2022 14:50:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 278EoDG2013274;
        Mon, 8 Aug 2022 10:50:13 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 278EoAkb013269;
        Mon, 8 Aug 2022 10:50:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 8 Aug 2022 10:50:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        Mike Snitzer <snitzer@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-writecache: drop the lock on an 'impossible' path
In-Reply-To: <202208050301.roHRxc6O-lkp@intel.com>
Message-ID: <alpine.LRH.2.02.2208081034050.8160@file01.intranet.prod.int.rdu2.redhat.com>
References: <202208050301.roHRxc6O-lkp@intel.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Aug 2022, Dan Carpenter wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
> commit: df699cc16ea5ef93a917676dcdd4376e02860ad5 dm writecache: report invalid return from writecache_map helpers
> config: arc-randconfig-m041-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050301.roHRxc6O-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/md/dm-writecache.c:1554 writecache_map() warn: inconsistent returns '&wc->lock'.

Hi

Here I'm sending a patch for this warning.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

There's a smatch warning "inconsistent returns '&wc->lock'" in
dm-writecache. The reason for the warning is that the function
writecache_map doesn't drop the lock on the impossible path. This patch
adds wc_unlock after the BUG statement (so that it will be compiled-away
anyway) to fix the warning.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c
+++ linux-2.6/drivers/md/dm-writecache.c
@@ -1598,7 +1598,8 @@ done:
 
 	default:
 		BUG();
-		return -1;
+		wc_unlock(wc);
+		return DM_MAPIO_KILL;
 	}
 }
 

