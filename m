Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E847D4ED2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiCaEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiCaEPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:15:18 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80044A19;
        Wed, 30 Mar 2022 20:47:48 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.8.64])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4KTTNP59wXzXq2m;
        Thu, 31 Mar 2022 11:31:01 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4KTTMb2Zk4zB5lqQ;
        Thu, 31 Mar 2022 11:30:19 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4KTTLy24h1zdmX8j;
        Thu, 31 Mar 2022 11:29:46 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4KTTLL3NNKz7jZxb;
        Thu, 31 Mar 2022 11:29:14 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 22V3SxJ5037956;
        Thu, 31 Mar 2022 11:28:59 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 31 Mar 2022 11:28:59 +0800 (CST)
Date:   Thu, 31 Mar 2022 11:28:59 +0800 (CST)
X-Zmail-TransId: 2b0462451ffbffffffffa16-b94ad
X-Mailer: Zmail v1.0
Message-ID: <202203311128598207170@zte.com.cn>
In-Reply-To: <20220331003826.GL27690@magnolia>
References: 20220331080256.1874-1-wang.yi59@zte.com.cn,20220331003826.GL27690@magnolia
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <djwong@kernel.org>
Cc:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xue.zhihong@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <cheng.lin130@zte.com.cn>
Subject: =?UTF-8?B?UmU6W1BBVENIXSB4ZnM6IGdldGF0dHIgaWdub3JlIGJsb2NrcyBiZXlvbmQgZW9m?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 22V3SxJ5037956
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 62452074.000 by FangMail milter!
X-FangMail-Envelope: 1648697461/4KTTNP59wXzXq2m/62452074.000/10.35.8.64/[10.35.8.64]/mxde.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62452074.000/4KTTNP59wXzXq2m
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: Cheng Lin <cheng.lin130@zte.com.cn>
>>
>> Blocks beyond EOF, which preallocated, will be reclaimed at some time.
>> These blocks can be ignored when getattr.
>>
>> This patch will optimize query accuracy for getattr blocks.
>Huh? This subtracts posteof blocks from the query results, which makes
>the results *less accurate*. Those blocks are mapped to the file, hence
>they are supposed to be counted in nblocks.
>--D
Yes, those blocks are mapped to the file. And the results including them are
absolutely real for xfs, at the moment of query.

But, those blocks are like the credit without consumption, are unstalbe, and
will be reclaimed at some time. This may cause trouble for the application.
e.g. in a case,
1. Firstly, write 100k data to file;
2. query the result;
3. close the file;
4. query the result.

fd stat wrt[96 @ 393216]: blks[896], size[397312].
fd stat wrt[97 @ 397312]: blks[896], size[401408].
fd stat wrt[98 @ 401408]: blks[896], size[405504].
fd stat wrt[99 @ 405504]: blks[896], size[409600].
lstat open: blks[896], size[409600].
lstat close: blks[800], size[409600].

Here two problems:
1. why the result different before between after file close?
2. why the result not change after writing data, or a big change?

The above problems can be explained by fs preallocation.
If the impact of preallocation are closed in fs, not visible to the outside, the result is stable and real for the application.

That is the reason for this patch.
Thanks very much.
