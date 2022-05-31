Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB7538B91
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbiEaGuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbiEaGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:50:49 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82870922
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:50:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEu7moQ_1653979844;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEu7moQ_1653979844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 14:50:46 +0800
Date:   Tue, 31 May 2022 14:50:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] erofs: random decompression cleanups
Message-ID: <YpW6xNPXHig7Djee@B-P7TQMD6M-0146.local>
References: <20220529055425.226363-1-xiang@kernel.org>
 <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 02:45:38PM +0800, Chao Yu wrote:
> Acked-by: Chao Yu <chao@kernel.org>

Thanks Chao! It'd be much helpful for me if we apply these cleanups
so I can have a new folio rework+cleanup+rolling hash 5.20 cycle.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> On 2022/5/29 13:54, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Hi folks,
> > 
> > Now I'm working on cleanuping decompression code and doing some
> > folio adaption for the next 5.20 cycle, see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios
> > 
> > This cleanup work completely gets rid of PageError usage finally
> > and tries to prepare for introducing rolling hashing for EROFS
> > since EROFS supports compressing variable-sized data instead of
> > fixed-sized clusters.
> > 
> > Therefore, EROFS can support rolling hash easily and our mechanism
> > can make full use of filesystem interfaces (byte-addressed) naturally.
> > 
> > Before that, I'd like to submit some trivial cleanups in advance for
> > the 5.19 cycle. All patches are without any logical change, so I can
> > have a more recent codebase for the next rework cycle.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > Gao Xiang (3):
> >    erofs: get rid of `struct z_erofs_collection'
> >    erofs: get rid of label `restart_now'
> >    erofs: simplify z_erofs_pcluster_readmore()
> > 
> >   fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
> >   fs/erofs/zdata.h |  50 +++++++-------
> >   2 files changed, 88 insertions(+), 127 deletions(-)
> > 
