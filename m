Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE257EBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiGWDMs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jul 2022 23:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWDMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:12:45 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842F820D3;
        Fri, 22 Jul 2022 20:12:43 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id EB98E80E78;
        Sat, 23 Jul 2022 03:12:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 4EA3B60009;
        Sat, 23 Jul 2022 03:12:40 +0000 (UTC)
Message-ID: <c4cf82073cccd574aa75b3a8e1f15748929c7621.camel@perches.com>
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
From:   Joe Perches <joe@perches.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, Yu Kuai <yukuai3@huawei.com>,
        josef@toxicpanda.com, axboe@kernel.dk, houtao1@huawei.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Date:   Fri, 22 Jul 2022 20:12:39 -0700
In-Reply-To: <ec031ff1-3936-92ce-b66b-59e3e6a289ab@huaweicloud.com>
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
         <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
         <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
         <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
         <ec031ff1-3936-92ce-b66b-59e3e6a289ab@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: xfaxua7y53z6efctdo35e56im6uo765i
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4EA3B60009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19vOmEdMuAg3rJ8m6FNkvIgGhqamKHXogU=
X-HE-Tag: 1658545960-341427
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-23 at 10:15 +0800, Yu Kuai wrote:
> Hi!

Hello.

> 在 2022/07/20 19:46, Yu Kuai 写道:
> > 在 2022/07/18 22:32, Joe Perches 写道:
> > > On Mon, 2022-07-18 at 21:52 +0800, Yu Kuai wrote:
> > > > 在 2022/07/06 17:33, Yu Kuai 写道:
> > > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > > 
> > > > > commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> > > > > to define pr_fmt and use short pr_err() to output error message,
> > > > > however, the definition is missed.
> > > > friendly ping ...
> > > []
> > > > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > []
> > > > > @@ -44,6 +44,9 @@
> > > > >    #include <linux/nbd-netlink.h>
> > > > >    #include <net/genetlink.h>
> > > > > +#undef pr_fmt
> > > > > +#define pr_fmt(fmt) "nbd: " fmt
> > > > > +
> > > Typically, this #define is place before all #include lines
> > > so there is no need for an #undef
> 
> I tried to remove the #undef:

I'll repeat my message.

Move the #define before _any_ #include.

Also, there are some message that would need existing "nbd: " output
prefixes removed.
---
 drivers/block/nbd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f5d098a148cbf..222f26ac5e96a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -11,6 +11,8 @@
  * (part of code stolen from loop.c)
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/major.h>
 
 #include <linux/blkdev.h>
@@ -1950,8 +1952,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			     test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) ||
 			    !refcount_inc_not_zero(&nbd->refs)) {
 				mutex_unlock(&nbd_index_mutex);
-				pr_err("nbd: device at index %d is going down\n",
-					index);
+				pr_err("device at index %d is going down\n",
+				       index);
 				return -EINVAL;
 			}
 		}
@@ -1961,7 +1963,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (!nbd) {
 		nbd = nbd_dev_add(index, 2);
 		if (IS_ERR(nbd)) {
-			pr_err("nbd: failed to add new device\n");
+			pr_err("failed to add new device\n");
 			return PTR_ERR(nbd);
 		}
 	}

