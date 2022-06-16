Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284B54DB27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiFPHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiFPHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:00:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A35A5BA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:00:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNtLB2TVCz1KB2f;
        Thu, 16 Jun 2022 14:58:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:00:24 +0800
Subject: Re: [PATCH v2 2/2] mm/swapfile: release swap info when swap device is
 unpluged
To:     Christoph Hellwig <hch@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <surenb@google.com>,
        <peterx@redhat.com>, <neilb@suse.de>, <naoya.horiguchi@nec.com>,
        <minchan@kernel.org>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, liubo <liubo254@huawei.com>
References: <20220615070228.2858170-1-liubo254@huawei.com>
 <20220615070228.2858170-3-liubo254@huawei.com>
 <YqnA+nZzkPYsw6CI@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <94b554c5-50cc-141c-c494-14005425930a@huawei.com>
Date:   Thu, 16 Jun 2022 15:00:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YqnA+nZzkPYsw6CI@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 19:22, Christoph Hellwig wrote:
> Sorry, but this is simply broken.  We can't just do d_path magic
> here.  That being said the problem is real, and I think the right
> answer is to offer a swapoff variant that doesn't need to open the
> underlying device or file, but useѕ some kind of handle.  I'm just

When swap device is unplugged, the swap_file->f_path.dentry will be in the
d_unlinked() status. Could we use it to detect the problem instead? IMHO, we
can found the unplugged swap devices this way and further get the right swap
device to swapoff through comparing the swap device name with @specialfile.
Or am I miss something?

> not sure what would be a good handle here.

Using handle sounds like a good idea too. :) But can the above solution be acceptable?

> .
> 

Thanks!


