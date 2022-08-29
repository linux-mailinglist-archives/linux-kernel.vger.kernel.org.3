Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8335A50F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiH2QGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2QGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:06:50 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0638683075;
        Mon, 29 Aug 2022 09:06:49 -0700 (PDT)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 0F348477556;
        Mon, 29 Aug 2022 11:05:07 -0500 (CDT)
Message-ID: <0ba12a13-6cc4-5f44-fa06-ead350f819d5@sandeen.net>
Date:   Mon, 29 Aug 2022 11:06:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Content-Language: en-US
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
References: <514e5e4b-e7c8-365f-8459-75974c067993@huawei.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] xfs: donot need to check return value of xlog_kvmalloc()
In-Reply-To: <514e5e4b-e7c8-365f-8459-75974c067993@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 6:46 AM, Zhiqiang Liu wrote:
> 
> In xfs_attri_log_nameval_alloc(), xlog_kvmalloc() is called
> to alloc memory, which will always return
> successfully, so we donot need to check return value.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

I think this is fine. xlog_kvmalloc loops until success, and its other
caller does not check the return value.

This isn't really strictly a fix (it's harmless) but it "fixes"

Fixes: commit 4183e4f27f402 ("xfs: share xattr name and value buffers when logging xattr updates")

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

That said, I think that xfs_attri_log_nameval_alloc() also cannot fail, so
perhaps its callers don't need checks either?

> ---
>  fs/xfs/xfs_attr_item.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
> index 5077a7ad5646..667e151a2bca 100644
> --- a/fs/xfs/xfs_attr_item.c
> +++ b/fs/xfs/xfs_attr_item.c
> @@ -86,8 +86,6 @@ xfs_attri_log_nameval_alloc(
>  	 */
>  	nv = xlog_kvmalloc(sizeof(struct xfs_attri_log_nameval) +
>  					name_len + value_len);
> -	if (!nv)
> -		return nv;
> 
>  	nv->name.i_addr = nv + 1;
>  	nv->name.i_len = name_len;
