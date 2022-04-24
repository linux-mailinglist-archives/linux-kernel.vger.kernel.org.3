Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF050D170
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiDXLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiDXLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:20:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF41738E8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:17:17 -0700 (PDT)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmQb12W3FzhYRH;
        Sun, 24 Apr 2022 19:17:01 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 19:17:15 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 19:17:14 +0800
From:   Guo Xuenan <guoxuenan@huawei.com>
To:     <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <fangwei1@huawei.com>, <guoxuenan@huawei.com>
Subject: Questions about folio allocation.
Date:   Sun, 24 Apr 2022 19:35:43 +0800
Message-ID: <20220424113543.456342-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

You have done a lot of work on folio, many folio related patches have been
incorporated into the mainline. I'm very interested in your excellent work
and did some sequential read test (using fixed read length, testing on a
10G file), and found something.
1. different read length may effect folio order
   using 100KB read length during sequentital read, when readahead folio
   order may always 0, so there always allocate folios with 0 or 2. 
2. folio order can not reach MAX_PAGECACHE_ORDER, when read length is small.
   (eg, less than 32KB)

As you have mentationed here[1],
"The heuristic for choosing which folio sizes will surely need some tuning"
I wonder (1) why the folio order need align with page index. is this
necessary or there are some certain restrictions?
(2) for pagecache, by using large folio, it saving loops for allocating pages,
and i also did some test on dropcache, it shows that dropcache costs less time.
there are twenty times performance improvement when drop the 10G file's cache.
so, can i concluded that pagecache should tend to use large order of folio?

[1] https://lore.kernel.org/linux-mm/20220204195852.1751729-72-willy@infradead.org/,

Thanks,
Guo Xuenan
