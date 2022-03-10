Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A54D42A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiCJIft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiCJIfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:35:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752846C953
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:34:38 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDj0p1RvYzcb1c;
        Thu, 10 Mar 2022 16:29:46 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 16:34:36 +0800
Subject: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount jffs2
To:     <richard@nod.at>, <dwmw2@infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20220114102854.3399585-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <c0d05cca-2827-481c-f534-d4fb30b91533@huawei.com>
Date:   Thu, 10 Mar 2022 16:34:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220114102854.3399585-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping, sorry for the noise.

在 2022/1/14 18:28, Baokun Li 写道:
> V1->V2:
> 	In jffs2_scan_medium,
> 	if s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
> 	returns error, go to "out" to do clear. Null pointer dereference
> 	occurs when if (s->sum_list_head) is executed in "out".
>
> V2->V3:
> 	Sorry for the noise, but there seems to be a more elegant way to
> 	fix the memory leak in jffs2_scan_medium. When memory allocation
> 	fails or CONFIG_JFFS2_SUMMARY is N, s is NULL.For the former case,
> 	add the new tag "out_buf" to avoid it.In the latter case,
> 	jffs2_sum_reset_collected is also an empty function and does nothing.
>
> Baokun Li (2):
>    jffs2: fix memory leak in jffs2_do_mount_fs
>    jffs2: fix memory leak in jffs2_scan_medium
>
>   fs/jffs2/build.c | 4 +++-
>   fs/jffs2/scan.c  | 6 ++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
-- 
With Best Regards,
Baokun Li

