Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23857AD92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiGTCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGTCGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:06:20 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AB509E2;
        Tue, 19 Jul 2022 19:06:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJukRdZ_1658282775;
Received: from 30.227.66.165(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VJukRdZ_1658282775)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 10:06:16 +0800
Message-ID: <e6c41a71-7649-a182-bdcd-678803efd6cb@linux.alibaba.com>
Date:   Wed, 20 Jul 2022 10:06:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] ocfs2: use the bitmap API to simplify code
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <0a0d6e9bf9d10f67b7a0c1cdd6176cdd0ad2e1f6.1658224839.git.christophe.jaillet@wanadoo.fr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <0a0d6e9bf9d10f67b7a0c1cdd6176cdd0ad2e1f6.1658224839.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/22 6:05 PM, Christophe JAILLET wrote:
> Use bitmap_zero() instead of hand-writing it.
> It is less verbose.
> 
> While at it, add an explicit #include <linux/bitmap.h>.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/heartbeat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
> index 4863ad35c242..e243cd99e63f 100644
> --- a/fs/ocfs2/heartbeat.c
> +++ b/fs/ocfs2/heartbeat.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2002, 2004 Oracle.  All rights reserved.
>   */
>  
> +#include <linux/bitmap.h>
>  #include <linux/fs.h>
>  #include <linux/types.h>
>  #include <linux/highmem.h>
> @@ -29,8 +30,7 @@
>  static void ocfs2_node_map_init(struct ocfs2_node_map *map)
>  {
>  	map->num_nodes = OCFS2_NODE_MAP_MAX_NODES;
> -	memset(map->map, 0, BITS_TO_LONGS(OCFS2_NODE_MAP_MAX_NODES) *
> -	       sizeof(unsigned long));
> +	bitmap_zero(map->map, OCFS2_NODE_MAP_MAX_NODES);
>  }
>  
>  void ocfs2_init_node_maps(struct ocfs2_super *osb)
