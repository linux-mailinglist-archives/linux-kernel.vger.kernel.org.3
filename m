Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF64C8125
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiCACtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiCACtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:06 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4E434B1;
        Mon, 28 Feb 2022 18:48:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V5r3Dlx_1646102902;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V5r3Dlx_1646102902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Mar 2022 10:48:23 +0800
Date:   Tue, 1 Mar 2022 10:48:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: add missing cmap->br_state = XFS_EXT_NORM update
Message-ID: <Yh2Jc5DeF9D7jp8r@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220217095542.68085-1-hsiangkao@linux.alibaba.com>
 <20220218054032.GO8313@magnolia>
 <Yg802fTm0n31FC+T@B-P7TQMD6M-0146.local>
 <Yg+DYkuTayILe5YA@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg+DYkuTayILe5YA@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 07:30:42PM +0800, Gao Xiang wrote:
> On Fri, Feb 18, 2022 at 01:55:37PM +0800, Gao Xiang wrote:
> > Hi Darrick,
> > 
> > On Thu, Feb 17, 2022 at 09:40:32PM -0800, Darrick J. Wong wrote:
> > > On Thu, Feb 17, 2022 at 05:55:42PM +0800, Gao Xiang wrote:
> > > > COW extents are already converted into written real extents after
> > > > xfs_reflink_convert_cow_locked(), therefore cmap->br_state should
> > > > reflect it.
> > > > 
> > > > Otherwise, there is another necessary unwritten convertion
> > > > triggered in xfs_dio_write_end_io() for direct I/O cases.
> > > > 
> > > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > 
> > > I /think/ this looks ok.  Does it test ok too?  AFAICT nothing in the
> > > iomap/writeback machinery cares the incorrect state because we always
> > > set IOMAP_F_SHARED (which triggers COW) so I think this is simply a fix
> > > for directio, like you said?
> > 
> > Yeah, I think so, from the code logic buffered i/o seems no impacted...
> > And the unnecessary unwritten convertion under direct i/o takes
> > noticeable extra overhead in our workloads...
> > 
> > I checked my last night xfstests, it seems it stops unexpectedly (maybe
> > due to some environmental problem). I will rerun tests today and
> > feedback later.
> 
> On my test environment machine, with linux 5.17-rc4,
> both w/ and w/o the patch, it fails:
> 
> generic/594 generic/600 xfs/158 xfs/160
> 
> I think no issue with this patch.

ping.. it seems a simple fix for direct I/O..

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
