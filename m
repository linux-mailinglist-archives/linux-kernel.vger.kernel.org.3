Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E865A4F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiH2Orv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiH2Orr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:47:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488546B149;
        Mon, 29 Aug 2022 07:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9A5EB81082;
        Mon, 29 Aug 2022 14:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A591CC433D6;
        Mon, 29 Aug 2022 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661784464;
        bh=rlvF1qPpe73oTYCMnsDsflOsWrgFu+HURhcGaeEcpgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmuUsXopHrX03B5zDadBEN89XJdrR1u09GGZeAnxzMT53a9eCd/Cs8+dfKkg7SX/w
         0awPBqpL8h+sJAQ0koYFg38UB67KqDWhR7FpNcU7PZ9pVfJDIh7kqogNGnVd5ODtkp
         ODQMVdJIsauCARfF16PgFeEHKarYZqUN6tLeFjdEFULGD9Z7PGzoLAILacn7JitS+B
         nncPZ92NtbzJPjhjWOCPkJZwN8IJpGnSID9+Sk/Dy1ZBsSMAaeZvX6io6IfsMzLWh/
         Iii554a17LnXk2ojHfK0U+U3m0SdkAPJPj7eijQuEjMmKpFF8Gfv+YJQE38Jc02r1G
         +c4aOHCfb5VYA==
Date:   Mon, 29 Aug 2022 07:47:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] xfs: replace unnecessary seq_printf with
 seq_puts
Message-ID: <YwzRkC0lfp5zMaCQ@magnolia>
References: <20220829034217.732635-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829034217.732635-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:42:17AM +0800, Zeng Heng wrote:
> Replace seq_printf with seq_puts when const string
> in reference, which would avoid to deal with
> unnecessary string format.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
> index 20e0534a772c..70d38b77682b 100644
> --- a/fs/xfs/xfs_stats.c
> +++ b/fs/xfs/xfs_stats.c
> @@ -125,7 +125,7 @@ static int xqmstat_proc_show(struct seq_file *m, void *v)
>  {
>  	int j;
>  
> -	seq_printf(m, "qm");
> +	seq_puts(m, "qm");
>  	for (j = XFSSTAT_START_XQMSTAT; j < XFSSTAT_END_XQMSTAT; j++)
>  		seq_printf(m, " %u", counter_val(xfsstats.xs_stats, j));
>  	seq_putc(m, '\n');
> -- 
> 2.25.1
> 
