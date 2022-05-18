Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC8F52BDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiERPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiERPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:24:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003619C755
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA441B8200E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B140C385A9;
        Wed, 18 May 2022 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652887436;
        bh=YRg8FOBF474wcLMD9+vFBXzah90HH8wz+sqNu2oCaNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=te9UTYWfbDP+aEEzSFMVtBWdMhj9JyQInKJmsyPAEoDaJFq9imNhql/v4hiXI3Aid
         GzjBjZYocPzxtCcW15jDPs+3ebJOSFbRxmyKIIJ4hlEKf1+fLSM9/krLSEMMv1ZfKl
         YXFKPshaOa72Yo6fDN2OCnyAKPzPeEkT3dL/Uop2NyElDncWX7uIN3scQeBFQFhpon
         dzH23MiqDNv9P/dH0OBS0QJ/z8rYkHNZFy7E0499RIHmX0OI5OrGGgJK954ii5Rhf+
         +tsPDR8T7sBBalagXIZhWYYlVUiKyKCfkzA2GC06Ixw/w1Phrcd5+dcvB9ktSmnWpz
         a9iO+rgh8sBUg==
Message-ID: <7d1878ef-e1ae-0550-7d6d-2a2ff858586c@kernel.org>
Date:   Wed, 18 May 2022 23:23:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] f2fs: make f2fs_read_inline_data() more readable
Content-Language: en-US
To:     Chao Liu <liuchao@coolpad.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <chaoliu719@gmail.com>
References: <20220518023123.2455827-1-liuchao@coolpad.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220518023123.2455827-1-liuchao@coolpad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/18 10:33, Chao Liu wrote:
> In f2fs_read_inline_data(), it is confused with checking of
> inline_data flag, as we checked it before calling. So this
> patch add some comments for f2fs_has_inline_data().
> 
> Signed-off-by: Chao Liu

It looks email address is missing, but it shows after I can apply this
patch to my local git repo...

Could you please check your email client configuration?

Thanks,

> ---
> fs/f2fs/f2fs.h | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f579e2ed0f14..5071f6636e41 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3167,6 +3167,10 @@ static inline int inline_xattr_size(struct inode *inode)
> return 0;
> }
> 
> +/*
> + * Notice: check inline_data flag without inode page lock is unsafe.
> + * It could change at any time by f2fs_convert_inline_page().
> + */
> static inline int f2fs_has_inline_data(struct inode *inode)
> {
> return is_inode_flag_set(inode, FI_INLINE_DATA);
> -- 
> 2.25.1
> 
