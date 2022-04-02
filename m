Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D024EFEBD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 06:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiDBE5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 00:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiDBE5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 00:57:37 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6E12E155
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 21:55:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V8y5wgT_1648875340;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8y5wgT_1648875340)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 12:55:42 +0800
Date:   Sat, 2 Apr 2022 12:55:39 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Terrell <terrelln@fb.com>, Guo Xuenan <guoxuenan@huawei.com>,
        Chengyang Fan <cy.fan@huawei.com>, Yann Collet <cyan@fb.com>,
        "fangwei1@huawei.com" <fangwei1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com" 
        <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>,
        "wangli74@huawei.com" <wangli74@huawei.com>
Subject: Re: [PATCH v3] lz4: fix LZ4_decompress_safe_partial read out of bound
Message-ID: <YkfXSzePVEhlajCU@B-P7TQMD6M-0146.local>
References: <20211111085058.1940591-1-guoxuenan@huawei.com>
 <20211111105048.2006070-1-guoxuenan@huawei.com>
 <CCE83845-DC40-4E14-9105-6319C048FACB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CCE83845-DC40-4E14-9105-6319C048FACB@fb.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 06:23:24PM +0000, Nick Terrell wrote:
> 
> 
> > On Nov 11, 2021, at 2:50 AM, Guo Xuenan <guoxuenan@huawei.com> wrote:
> > 
> > When partialDecoding, it is EOF if we've either, filled the output
> > buffer or can't proceed with reading an offset for following match.
> > 
> > In some extreme corner cases when compressed data is crusted corrupted,
> > UAF will occur. As reported by KASAN [1], LZ4_decompress_safe_partial
> > may lead to read out of bound problem during decoding. lz4 upstream has
> > fixed it [2] and this issue has been disscussed here [3] before.
> > 
> > current decompression routine was ported from lz4 v1.8.3, bumping lib/lz4
> > to v1.9.+ is certainly a huge work to be done later, so, we'd better fix
> > it first.
> > 
> > [1] https://lore.kernel.org/all/000000000000830d1205cf7f0477@google.com/
> > [2] https://github.com/lz4/lz4/commit/c5d6f8a8be3927c0bec91bcc58667a6cfad244ad#
> > [3] https://lore.kernel.org/all/CC666AE8-4CA4-4951-B6FB-A2EFDE3AC03B@fb.com/
> > 
> > Reported-by: syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com
> > Cc: hsiangkao@linux.alibaba.com
> > Cc: terrelln@fb.com
> > Cc: cyan@fb.com
> > Cc: cy.fan@huawei.com
> > Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> 
> Sorry I’m a bit late to the party, but this looks good to me!
> 
> Reviewed-by: Nick Terrell <terrelln@fb.com>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Hi Andrew,

This patch has already been pending for 2 release cycles.. Would you
mind submitting it upstream? Or are there other concerns about this?

Many thanks!
Gao Xiang
