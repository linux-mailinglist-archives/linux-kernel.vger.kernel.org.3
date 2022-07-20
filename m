Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B602A57AD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiGTCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGTCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:03:49 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1C4D156;
        Tue, 19 Jul 2022 19:03:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJuib0B_1658282623;
Received: from 30.227.66.165(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VJuib0B_1658282623)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 10:03:44 +0800
Message-ID: <d49c6cca-2980-41b1-0f59-32ddcbb1dfa2@linux.alibaba.com>
Date:   Wed, 20 Jul 2022 10:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] ocfs2: Remove some useless functions
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/22 6:01 PM, Christophe JAILLET wrote:
> __ocfs2_node_map_set_bit() and __ocfs2_node_map_set_bit() are just
> wrapper around set_bit() and clear_bit().
> 
> The leading __ also makes think that these functions are non-atomic just
> like __set_bit() and __clear_bit().
> 
> So, just remove these wrappers and call set_bit() and clear_bit()
> directly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/heartbeat.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
> index 9099d8fc7599..1d72e0788943 100644
> --- a/fs/ocfs2/heartbeat.c
> +++ b/fs/ocfs2/heartbeat.c
> @@ -24,11 +24,6 @@
>  
>  #include "buffer_head_io.h"
>  
> -static inline void __ocfs2_node_map_set_bit(struct ocfs2_node_map *map,
> -					    int bit);
> -static inline void __ocfs2_node_map_clear_bit(struct ocfs2_node_map *map,
> -					      int bit);
> -
>  /* special case -1 for now
>   * TODO: should *really* make sure the calling func never passes -1!!  */
>  static void ocfs2_node_map_init(struct ocfs2_node_map *map)
> @@ -65,12 +60,6 @@ void ocfs2_do_node_down(int node_num, void *data)
>  	ocfs2_recovery_thread(osb, node_num);
>  }
>  
> -static inline void __ocfs2_node_map_set_bit(struct ocfs2_node_map *map,
> -					    int bit)
> -{
> -	set_bit(bit, map->map);
> -}
> -
>  void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
>  			    struct ocfs2_node_map *map,
>  			    int bit)
> @@ -79,16 +68,10 @@ void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
>  		return;
>  	BUG_ON(bit >= map->num_nodes);
>  	spin_lock(&osb->node_map_lock);
> -	__ocfs2_node_map_set_bit(map, bit);
> +	set_bit(bit, map->map);
>  	spin_unlock(&osb->node_map_lock);
>  }
>  
> -static inline void __ocfs2_node_map_clear_bit(struct ocfs2_node_map *map,
> -					      int bit)
> -{
> -	clear_bit(bit, map->map);
> -}
> -
>  void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
>  			      struct ocfs2_node_map *map,
>  			      int bit)
> @@ -97,7 +80,7 @@ void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
>  		return;
>  	BUG_ON(bit >= map->num_nodes);
>  	spin_lock(&osb->node_map_lock);
> -	__ocfs2_node_map_clear_bit(map, bit);
> +	clear_bit(bit, map->map);
>  	spin_unlock(&osb->node_map_lock);
>  }
>  
