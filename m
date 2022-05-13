Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812B2525B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353406AbiEMGR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377284AbiEMGPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:15:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0225E2A18B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so6901356pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09p7puOxbl364x9rMUnNG+V2yt+v411dIb0qKr8MrfI=;
        b=XMCp5eiDtw1mJXaYFYG+/zix8O+6KymmJULuyfdG8wYvDwPCn7st9fjSEoBaBl3qKg
         SzAtFTqmwAvdZx6+0+RLUxeL/rGVaIHXlLLCrG+5Hf0ppvs4XcqpRZ1F56cvpbtQG0j+
         uHk7XFltnPkUxClIgZLSNpCkyCH+fQiDYOaolzT89R9VwxiXTrid/5FnUDixkSgIgBOI
         FStfcsZkMEfbHdZYU4lyL64I08mmaeGtGLVuXgInkcrnXpMRm40GRXXSY59e9uLDXMsD
         Us/JkNOa9MSdPh1TH+7TxCTXauF1lYt1iSUP3epgO2Mw+5oT+paNntn94eAkoUk+qb0Z
         AnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09p7puOxbl364x9rMUnNG+V2yt+v411dIb0qKr8MrfI=;
        b=4GOtXMUFM7sFiUIBwaW8DxoUbqaxFrok8uH3xKiNAjX69Hl28Xz0+oRwMI4BMj9fs2
         QA8cH3xgCJMLQ/WLJHsFugLp5PSQ5j1kQVlKOqFsbq0ZbolxE8CEsICpE09bf89yEwmn
         GCUU1OIdaLWtyqVwf8uWB273EHDCrC1GXcUXYzdhtTP7bCDr4lHcqGOtijOhjUCvKBzD
         YgLmQnPRd7b45/p7DpF7VYysUzkgyH/PDcOfYBwvCJd2zuX5CgbdAehBjTm7hMqJ0Eth
         s9N/fHBWFDww0w5FAKMVMbzJShJjzu+oliUSVL3y/WR6Ucb7co2gpmlyLvh8xL72Zm2X
         OnXw==
X-Gm-Message-State: AOAM530WISrE/Ncy8J61oqqNcZCotrfuf6qKu3RJXl95XRYssgHLGOzR
        4AqZiUoQJuFxMRQ/DHFbXQEvfPhsmuBgDQ==
X-Google-Smtp-Source: ABdhPJw8jWPAzXwgSTN9HipBgH/eqkNTXmGvE/cpxZfY6fx4m9/fL2hYV47k+w7y9Kw+aynwsZ5Zag==
X-Received: by 2002:a17:902:854c:b0:159:a70:deca with SMTP id d12-20020a170902854c00b001590a70decamr3439541plo.142.1652422492484;
        Thu, 12 May 2022 23:14:52 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0015e8d4eb1c7sm980557plm.17.2022.05.12.23.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 May 2022 23:14:52 -0700 (PDT)
Date:   Fri, 13 May 2022 14:14:44 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@yulong.com>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com,
        huyue2@coolpad.com
Subject: Re: [PATCH] erofs: fix buffer copy overflow of ztailpacking feature
Message-ID: <20220513141444.00001a6d.zbestahu@gmail.com>
In-Reply-To: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
References: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 19:58:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> I got some KASAN report as below:
> 
> [   46.959738] ==================================================================
> [   46.960430] BUG: KASAN: use-after-free in z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430] Read of size 4074 at addr ffff8880300c2f8e by task fssum/188
> ...
> [   46.960430] Call Trace:
> [   46.960430]  <TASK>
> [   46.960430]  dump_stack_lvl+0x41/0x5e
> [   46.960430]  print_report.cold+0xb2/0x6b7
> [   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430]  kasan_report+0x8a/0x140
> [   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430]  kasan_check_range+0x14d/0x1d0
> [   46.960430]  memcpy+0x20/0x60
> [   46.960430]  z_erofs_shifted_transform+0x2bd/0x370
> [   46.960430]  z_erofs_decompress_pcluster+0xaae/0x1080
> 
> The root cause is that the tail pcluster won't be a complete filesystem
> block anymore. So if ztailpacking is used, the second part of an
> uncompresed tail pcluster may not be ``rq->pageofs_out``.

Yeah, since we have a 'pageofs_in' to the 'src' for ztailpacking.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Fixes: ab749badf9f4 ("erofs: support unaligned data decompression")
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 0f445f7e1df8..6dca1900c733 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -320,6 +320,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
>  	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
>  					     PAGE_SIZE - rq->pageofs_out);
> +	const unsigned int lefthalf = rq->outputsize - righthalf;
>  	unsigned char *src, *dst;
>  
>  	if (nrpages_out > 2) {
> @@ -342,10 +343,10 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
>  	if (nrpages_out == 2) {
>  		DBG_BUGON(!rq->out[1]);
>  		if (rq->out[1] == *rq->in) {
> -			memmove(src, src + righthalf, rq->pageofs_out);
> +			memmove(src, src + righthalf, lefthalf);
>  		} else {
>  			dst = kmap_atomic(rq->out[1]);
> -			memcpy(dst, src + righthalf, rq->pageofs_out);
> +			memcpy(dst, src + righthalf, lefthalf);
>  			kunmap_atomic(dst);
>  		}
>  	}

