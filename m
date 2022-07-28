Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F30583C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiG1K5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiG1K5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:57:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06C61D95;
        Thu, 28 Jul 2022 03:57:48 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ltncq31LHzmVN3;
        Thu, 28 Jul 2022 18:55:55 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 18:57:46 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 18:57:45 +0800
Message-ID: <882a28de-3bd5-23e5-fbad-bfdc2a4a24e4@huawei.com>
Date:   Thu, 28 Jul 2022 18:57:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] xfs: fix NULL pointer dereference in xfs_getbmap()
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guoxuenan@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20220727085230.4073478-1-chenxiaosong2@huawei.com>
 <YuFW4OLWCuAhrC7R@magnolia>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <YuFW4OLWCuAhrC7R@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/7/27 23:16, Darrick J. Wong 写道:

> Heh.  Is this worth an fstest?  It probably is, since prior to 5.20 this
> would have been a UAF bug on top of a NULL deref.

I will try to add regression test to xfstests for this commit when it is 
merged into mainline.

> 
> Nit: it's ILOCK, not i_lock.  Otherwise... this looks correct to me --
> take the IOLOCK and ILOCK in shared mode before accessing the inode fork
> structures.
> 
> Do you have any suggestions for Fixes:?  I suspect this has been broken
> for quite some time.

The "Fixes:" label is: abbf9e8a4507 ("xfs: rewrite getbmap using the 
xfs_iext_* helpers")

> 
> No need to fix the nit, I'll do that when I commit this.
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
