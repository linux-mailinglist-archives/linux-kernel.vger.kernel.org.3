Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455C74E5031
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiCWKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiCWKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE75676E06;
        Wed, 23 Mar 2022 03:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2278760E88;
        Wed, 23 Mar 2022 10:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9372C340E8;
        Wed, 23 Mar 2022 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648030671;
        bh=i6bjWAxhQ9B49HKiVKTYB2SDWHUVsRp7XHRLw7HgwN4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=esq8dpfpITUN07UMIcp4KzH9MJPHK/pQEpedcDfP5jr1dGnafPCcSmQkQ6UcqGr5I
         /ZyRdLbUxhQmKMgftgdFFROx17Q9ngy9wzXirCDW7ae2SVGf3/NX1LUNtfk5cnpm09
         lM8ufgd7Aumowg3VC0rs6nJhgoXSM7flxAkkTRzRapWhRZjF7t2wXFZFJR09z3RsPn
         4jofjsK/dT1MgDDKV+T1bjyymmfsJqpvAdweaPRSUOtynSam4VWIgaH6ptYCINV2+1
         30DiTvpQqZmyIp15VJMj/arWDmbq0pJuMs1+X5vAQ90RyUUD8oUQb2J7r2+UpVcIAX
         nyRmK7THW3hiQ==
Message-ID: <1407bfb44b60b3cdd704e48d85754c18693c925f.camel@kernel.org>
Subject: Re: [PATCH -next] ceph: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
From:   Jeff Layton <jlayton@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Wed, 23 Mar 2022 06:17:49 -0400
In-Reply-To: <20220322235308.9770-1-yang.lee@linux.alibaba.com>
References: <20220322235308.9770-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-23 at 07:53 +0800, Yang Li wrote:
> Fix the following coccicheck warning:
> ./fs/ceph/debugfs.c:389:0-23: WARNING: congestion_kb_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/ceph/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index bec3c4549c07..05d15a0bbd9b 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -386,7 +386,7 @@ static int congestion_kb_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> +DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
>  			congestion_kb_set, "%llu\n");
>  
>  

I think you're the 4th person to propose this patch. Here are the three
prior postings:

    https://lore.kernel.org/ceph-devel/1577111958-100981-1-git-send-email-chenwandun@huawei.com/
    https://lore.kernel.org/ceph-devel/1612165930-110076-1-git-send-email-jiapeng.chong@linux.alibaba.com/
    https://lore.kernel.org/ceph-devel/20211221143614.480385-1-deng.changcheng@zte.com.cn/

It's not as simple as doing a 1:1 conversion like this. Please look at
the threads above and offer a revised patch or let us know whether you
want us to drop this one.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
