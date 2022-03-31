Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BAA4ED5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiCaIeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiCaIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:34:11 -0400
X-Greylist: delayed 29513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 01:32:23 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5311A09;
        Thu, 31 Mar 2022 01:32:22 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4KTc4450k8zBCBjq;
        Thu, 31 Mar 2022 16:32:20 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 22V8W7XO084002;
        Thu, 31 Mar 2022 16:32:07 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 31 Mar 2022 16:32:07 +0800 (CST)
Date:   Thu, 31 Mar 2022 16:32:07 +0800 (CST)
X-Zmail-TransId: 2b0462456707ffffffff8d1-79fab
X-Mailer: Zmail v1.0
Message-ID: <202203311632074775168@zte.com.cn>
In-Reply-To: <20220331053340.GE1544202@dread.disaster.area>
References: 20220331003826.GL27690@magnolia,202203311128598207170@zte.com.cn,20220331053340.GE1544202@dread.disaster.area
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <cheng.lin130@zte.com.cn>
Subject: =?UTF-8?B?UmU6W1BBVENIXSB4ZnM6IGdldGF0dHIgaWdub3JlIGJsb2NrcyBiZXlvbmQgZW9m?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 22V8W7XO084002
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 62456714.003 by FangMail milter!
X-FangMail-Envelope: 1648715540/4KTc4450k8zBCBjq/62456714.003/10.30.14.238/[10.30.14.238]/mse-fl1.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62456714.003/4KTc4450k8zBCBjq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We do not, and have not ever tried to, hide allocation or block
> usage artifacts from userspace because any application that depends
> on specific block allocation patterns or accounting from the
> filesystem is broken by design.
>
> Every filesystem accounts blocks differently, and more often than
> not the block count exposed to userspace also includes metadata
> blocks (extent maps, xattr blocks, etc) and it might multiple count
> other blocks (e.g. shared extents). Hence so you can't actually
> use it for anything useful in userspace except reporting how many
> blocks this file *might* use.
>
> If your application is dependent on block counts exactly matching
> the file data space for waht ever reason, then what speculative
> preallocation does is the least of your problems.
>

Thanks for your explaination.

Unfortunately, the app I'm using evaluates diskusage by querying
the changes of the backend filesystem (XFS) file before and after
the operation. Without giving up the benefits of preallocation, the
app's statistics will become obsolete and no chance to correct it
at a small cost, because of the silence reclaim of posteof blocks.
That is the app's problem.

Posteof blocks will be reclaimed sooner or later, it seems reasonable
to ignore them directly during query. This is my humble opinion in
this patch. At the query moment, it's not real, but it will become so
eventually. It's a speculative result for query.
