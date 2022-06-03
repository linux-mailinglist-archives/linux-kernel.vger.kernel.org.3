Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFB53CA4C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbiFCM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiFCM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC831514
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cLtR22X2YMGBRu4CJqe5w4vOiyDa2dkTADcsreL0J6Y=; b=fro3tgYwYJIMFutExfLTy2/NTc
        enNFhHBR3bjAlqnjKfkPTxarHHM2BoYPWgwsvy6c5GRj1sKQEw4Dba7t/np1TQF0YM/REBrGPa28X
        jbBSEuPmGxkO1ruVzQmWkKMvLU0V2TuwhJdXRilN6fAk0zo3ptEDSanCN1R47AsAO4r9ErH6Zktjr
        2lZK68C04tg1pXmG+LfJDMR3Hs7dl6Ono6nXbhghfzNVfTsaTjfFk2CpwGwGxcFKrd8uZ6vrHprNa
        9NgjQPVxCEoCy02ZQBLuIT3b+7LRWGkIdowBk9lEWqxZqUpW3Z+oHG3d+N+gBWMSRcW6Zd7qv8Ysm
        YSdyraDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx6tR-007uOt-KY; Fri, 03 Jun 2022 12:59:09 +0000
Date:   Fri, 3 Jun 2022 13:59:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Message-ID: <YpoFnROxAwdSScuV@casper.infradead.org>
References: <20220601103922.1338320-1-hsinyi@chromium.org>
 <20220601103922.1338320-4-hsinyi@chromium.org>
 <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
 <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
> Hi,
> 
> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
> > Implement readahead callback for squashfs. It will read datablocks
> > which cover pages in readahead request. For a few cases it will
> > not mark page as uptodate, including:
> > - file end is 0.
> > - zero filled blocks.
> > - current batch of pages isn't in the same datablock or not enough in a
> >    datablock.
> > - decompressor error.
> > Otherwise pages will be marked as uptodate. The unhandled pages will be
> > updated by readpage later.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> > Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> > ---
> 
> This patch landed recently in linux-next as commit 95f7a26191de 
> ("squashfs: implement readahead"). I've noticed that it causes serious 
> issues on my test systems (various ARM 32bit and 64bit based boards). 
> The easiest way to observe is udev timeout 'waiting for /dev to be fully 
> populated' and prolonged booting time. I'm using squashfs for deploying 
> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on 
> top of the next-20220603 fixes the issue.

How large are these files?  Just a few kilobytes?

