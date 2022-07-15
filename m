Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B75575B71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGOGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiGOGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:20:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36F65D6E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:20:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso5240477pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Nj+Clt9ZkEOhilN6GICXjikzzBZghfnwZ/Dm9+HmTo=;
        b=mwJkMnLwTVy3fOxc9CUwVdBQ+JVYJgWfg0AJjJUXUuEwFZoFT56M7qE9Ww1IVf0IyQ
         GdbkY3+dIVefF6zQA/TzE2Cw15nEBQD6doXBwd1cC4+vxM9AU2jfL+dwzW3j5bJvMsBQ
         /7OsVK1hwO0XV7qXRFKabM9eoeY/7wW6ByTi1SyxdtgrPEwLLyu8Gk/dc7Nai7A//Fjf
         Lv1NWrXfgHkrwgSZsxnvIpmGd5c5s6evfbPlDJEAWj7Xb6vtPjL7Iau7Zoj1KR7jxgW+
         kEwM8+//HF0pf/OScF5XwMEbyLIesJVF/6nPHDN16+L3Y28HK3RKTlXC6Gb+ZZZy7z1P
         O7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Nj+Clt9ZkEOhilN6GICXjikzzBZghfnwZ/Dm9+HmTo=;
        b=YeDHwhQpMgGUdcoRyWzzrMW6GF48XhagmtyssouX9hKy64mNuktuTJvXCBE1qXiCic
         3BeJZLCuaPNLDN+vbEz1Y7uqkMDc1J6gkZ+S+hVZBg6+LiC/BMP58Rq8debDhWEZFaHY
         /DhR/vDbO70NJh9VgubwVR0lQDROFCEHdMdHfLPemAhdQ0vbMu0FghWLBmaP6KbIxj4l
         4e2yqUT0GldwV5ZWJ7a1Ay2lzxKJVxSM4z+uFFrQRvOyC2Hb4mo6lO8EDch00+v+tq6M
         rMOgwNhExnTGglNIXuv9ggvweY+Q7VcMhg6wcwnR+RX3RXZdVkE1WJ7A5CBU3n2xuPJr
         8Kgw==
X-Gm-Message-State: AJIora9ZKOlHfg2g+LwO9AC/bXlKwF98ffKmGl2zCGbiSe+B0Sd5YzqW
        QLf2PwpCdNOBNy3b5DjdHDA=
X-Google-Smtp-Source: AGRyM1sq1O/dROKcgW/RFJ8xEucSHXKkPva4WFF14qX+E+GPx5HaHZIGGrLmCeCSd00CPR8xFfXSdA==
X-Received: by 2002:a17:902:c40a:b0:16c:408:57d6 with SMTP id k10-20020a170902c40a00b0016c040857d6mr12190575plk.157.1657866037951;
        Thu, 14 Jul 2022 23:20:37 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b0016bdeb58611sm2578624plk.112.2022.07.14.23.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:20:37 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:22:01 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 02/16] erofs: clean up z_erofs_collector_begin()
Message-ID: <20220715142201.000030f1.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-3-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
        <20220714132051.46012-3-hsiangkao@linux.alibaba.com>
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

On Thu, 14 Jul 2022 21:20:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Rearrange the code and get rid of all gotos.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 1b6816dd235f..c7be447ac64d 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -521,7 +521,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  {
>  	struct erofs_map_blocks *map = &fe->map;
> -	struct erofs_workgroup *grp;
> +	struct erofs_workgroup *grp = NULL;
>  	int ret;
>  
>  	DBG_BUGON(fe->pcl);
> @@ -530,33 +530,31 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>  	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
>  
> -	if (map->m_flags & EROFS_MAP_META) {
> -		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> -			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> -		}
> -		goto tailpacking;
> +	if (!(map->m_flags & EROFS_MAP_META)) {
> +		grp = erofs_find_workgroup(fe->inode->i_sb,
> +					   map->m_pa >> PAGE_SHIFT);
> +	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
>  	}
>  
> -	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
>  	if (grp) {
>  		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> +		ret = -EEXIST;
>  	} else {
> -tailpacking:
>  		ret = z_erofs_register_pcluster(fe);
> -		if (!ret)
> -			goto out;
> -		if (ret != -EEXIST)
> -			return ret;
>  	}
>  
> -	ret = z_erofs_lookup_pcluster(fe);
> -	if (ret) {
> -		erofs_workgroup_put(&fe->pcl->obj);
> +	if (ret == -EEXIST) {
> +		ret = z_erofs_lookup_pcluster(fe);
> +		if (ret) {
> +			erofs_workgroup_put(&fe->pcl->obj);
> +			return ret;
> +		}
> +	} else if (ret) {
>  		return ret;
>  	}
>  
> -out:
>  	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
>  				  fe->pcl->pagevec, fe->pcl->vcnt);
>  	/* since file-backed online pages are traversed in reverse order */

Reviewed-by: Yue Hu <huyue2@coolpad.com>
