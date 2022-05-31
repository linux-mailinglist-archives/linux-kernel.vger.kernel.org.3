Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4953983D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347879AbiEaUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347877AbiEaUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B53517FB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11AC612FD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7333C385A9;
        Tue, 31 May 2022 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654030090;
        bh=ysy0TefitjEGZN/cpuj1jy1DC0AsC3nMzkC1TZQoJA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mI3a0M2JvTvh3EKbICw3GdfOV/NwYO3Wuzq3OPGLHFYTVOoom6OAoKDIvN63xzYWp
         qZG8Yb3djUJRrmNZXwSRlSUqyaCr54hm9rs3Bo64ao7QhWFZ037eetzoLl9uRTWwSp
         kcqTUtym8YOCtTjk0+Y0MViqyTFFUO4xhFQpvdYU=
Date:   Tue, 31 May 2022 13:48:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] squashfs: implement readahead
Message-Id: <20220531134809.c69b711dc8cd584b3a5163f7@linux-foundation.org>
In-Reply-To: <CAJMQK-isVhkhGu3=QAWaDvOd9sXgNep3ZrZ6jjoa2j+h6Uc45w@mail.gmail.com>
References: <20220523065909.883444-1-hsinyi@chromium.org>
        <20220523065909.883444-4-hsinyi@chromium.org>
        <CAJMQK-isVhkhGu3=QAWaDvOd9sXgNep3ZrZ6jjoa2j+h6Uc45w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 17:51:11 +0800 Hsin-Yi Wang <hsinyi@chromium.org> wrote:

> On Mon, May 23, 2022 at 3:00 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Implement readahead callback for squashfs. It will read datablocks
> > which cover pages in readahead request. For a few cases it will
> > not mark page as uptodate, including:
> > - file end is 0.
> > - zero filled blocks.
> > - current batch of pages isn't in the same datablock or not enough in a
> >   datablock.
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
> Kindly ping on the thread. Conversations on v2:
> https://patchwork.kernel.org/project/linux-mm/patch/20220517082650.2005840-4-hsinyi@chromium.org/#24869037
> This version mainly addressed the error handling.

Yes, some reviewer input would be helpful please.
