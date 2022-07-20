Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FA57AD75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiGTB7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiGTB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:59:52 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22DD501A8;
        Tue, 19 Jul 2022 18:59:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJuiYTA_1658282387;
Received: from 30.227.66.165(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VJuiYTA_1658282387)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 09:59:48 +0800
Message-ID: <07c924de-78bf-c993-ce73-635af71f4edd@linux.alibaba.com>
Date:   Wed, 20 Jul 2022 09:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ocfs2: Remove a useless spinlock
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
 <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
 <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/22 9:25 PM, Christophe JAILLET wrote:
> Le 19/07/2022 à 12:24, David Laight a écrit :
>> From: Christophe JAILLET
>>> Sent: 19 July 2022 11:02
>>>
>>> 'node_map_lock' is a spinlock only used to protect calls to set_bit(),
>>> clear_bit() and test_bit().
>>>
>>> {set|clear}_bit() are already atomic and don't need this extra spinlock.
>>> test_bit() only reads the bitmap for a given bit.
>>>
>>> Remove this useless spinlock.
>>
>> It looks to me like the calling code is racy
>> unless there is another lock in the callers.
> 
> The call chains are:
>   ocfs2_recover_orphans()
>     ocfs2_mark_recovering_orphan_dir()
>       spin_lock(&osb->osb_lock);        <-- osb_lock spinlock
>       ocfs2_node_map_set_bit()            <-- uses node_map_lock
>       ...
>       spin_unlock(&osb->osb_lock);
>     ...
>     ocfs2_clear_recovering_orphan_dir()
>       ocfs2_node_map_clear_bit()        <-- uses node_map_lock
>                             osb_lock is NOT taken
> 
> 
>   ocfs2_check_orphan_recovery_state()
>     spin_lock(&osb->osb_lock);            <-- osb_lock spinlock
>     ...
>     ocfs2_node_map_test_bit()            <-- uses node_map_lock
>     ...
>     spin_unlock(&osb->osb_lock);
> 
> 
> So the code looks already protected by the 'osb_lock' spinlock, but I don't know this code and ocfs2_mark_recovering_orphan_dir() looks tricky to me. (so some other eyes are much welcome)
 
osb_lock is to protect osb filed such as 'osb_orphan_wipes', while
node_map_lock is to protect the node map 'osb_recovering_orphan_dirs'
specifically.

Thanks,
Joseph

