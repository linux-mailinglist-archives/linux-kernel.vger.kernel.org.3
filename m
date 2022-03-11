Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9414D5C13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiCKHOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbiCKHOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:14:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFCF115963
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:13:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q13so6973643plk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Xe/TObzCyIpMz+gsrdFN4FAYpTVbp6ttT/yAt6pqXM=;
        b=WYBrp34ZMpvN3EqOVtxjQPlFUSwiquPN+sa04OJ/pXjQBR65wj651cRBi1+ffL4KWV
         sJPiV/Be/MOEkOsZHVRF/OLpO0C/mQDVZ8REsfucG7lBIukeRY3P78OkjAvKkwuqgVhx
         pkMOcEwvpyNy5BS48CilZUN52WT97Cf9YERJPKaLydgzq5/Ar06Qni9Zl2kkbD1lnelX
         HgSmifYb9DQ27tCiq97eao3hMrpoawRtKAGMMyVr9Z5wfhjYbExF4ynn9IOmkKCfZJrF
         7T575iMvtSl0MUGAj8Nv7zEipoJgG8fjWSfMTDuWLQf1acpyVX2dL9I7b6udtnRlha5U
         3N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Xe/TObzCyIpMz+gsrdFN4FAYpTVbp6ttT/yAt6pqXM=;
        b=wd0T8OMdEvyTo8WNEOrOki7UrxnJ6Y/Z0yD/lQVjX1ZWSRvDxnq0MbgUXUgbSyZypH
         GKT6+/DDDobMK4csU10sTLCq9aLMcMd3z+KC+kKW7HwO7e+zpJHHrIcwDcB0dlrgJSwA
         +wCen9tl+iHXZ02oUlZ6zJbpnysFrg2qWCvLR4dIfcyNvUXSqvEFolQMqc6O6FyN7SJ5
         7QR1/xjR1wVinWDx/nIovuMqm36h58gVZYKkniLLWdXdQK/2gZ71MlvqKqtg07bGAy40
         kjWIwAxVV01Sl0OqrsN7VIublSqxTznSeghKUQDZsi8bddmU9p9pE8gQU8W0kaRzn9Bt
         xDBg==
X-Gm-Message-State: AOAM531DXUvYe6BTZhzuxlQnNwJDYRWlSIyTdK/sxzPWqWgdzYjbyiOy
        E9bP62pXH3B+oZxEVOyP0k4=
X-Google-Smtp-Source: ABdhPJzeqNVd2RpiWv8lFamefHdENq7LaJXmZHk/a7AlhSCshyhMDvRPfvchcD6409XA9sVL4cqPfg==
X-Received: by 2002:a17:90b:1811:b0:1bf:582e:443c with SMTP id lw17-20020a17090b181100b001bf582e443cmr20459312pjb.0.1646982827181;
        Thu, 10 Mar 2022 23:13:47 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id o5-20020a655bc5000000b00372f7ecfcecsm7381854pgr.37.2022.03.10.23.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Mar 2022 23:13:46 -0800 (PST)
Date:   Fri, 11 Mar 2022 15:12:32 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com,
        huyue2@coolpad.com
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Message-ID: <20220311151232.00003619.zbestahu@gmail.com>
In-Reply-To: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
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

On Fri, 11 Mar 2022 02:27:42 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Avoid the unnecessary tail recursion since it can be converted into
> a loop directly in order to prevent potential stack overflow.
> 
> It's a pretty straightforward conversion.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index b4059b9c3bac..572f0b8151ba 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  				   unsigned int lookback_distance)
>  {
>  	struct erofs_inode *const vi = EROFS_I(m->inode);
> -	struct erofs_map_blocks *const map = m->map;
>  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> -	unsigned long lcn = m->lcn;
> -	int err;
>  
> -	if (lcn < lookback_distance) {
> -		erofs_err(m->inode->i_sb,
> -			  "bogus lookback distance @ nid %llu", vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> +	while (m->lcn >= lookback_distance) {
> +		unsigned long lcn = m->lcn - lookback_distance;
> +		int err;

may better to declare variable 'lclusterbits' in loop just like 'err' usage?

>  
> -	/* load extent head logical cluster if needed */
> -	lcn -= lookback_distance;
> -	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> -	if (err)
> -		return err;
> +		/* load extent head logical cluster if needed */
> +		err = z_erofs_load_cluster_from_disk(m, lcn, false);
> +		if (err)
> +			return err;
>  
> -	switch (m->type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> -		if (!m->delta[0]) {
> +		switch (m->type) {
> +		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +			if (!m->delta[0]) {
> +				erofs_err(m->inode->i_sb,
> +					  "invalid lookback distance 0 @ nid %llu",
> +					  vi->nid);
> +				DBG_BUGON(1);
> +				return -EFSCORRUPTED;
> +			}
> +			lookback_distance = m->delta[0];
> +			continue;
> +		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> +		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
> +			m->headtype = m->type;
> +			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
> +			return 0;
> +		default:
>  			erofs_err(m->inode->i_sb,
> -				  "invalid lookback distance 0 @ nid %llu",
> -				  vi->nid);
> +				  "unknown type %u @ lcn %lu of nid %llu",
> +				  m->type, lcn, vi->nid);
>  			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> +			return -EOPNOTSUPP;
>  		}
> -		return z_erofs_extent_lookback(m, m->delta[0]);
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
> -		m->headtype = m->type;
> -		map->m_la = (lcn << lclusterbits) | m->clusterofs;
> -		break;
> -	default:
> -		erofs_err(m->inode->i_sb,
> -			  "unknown type %u @ lcn %lu of nid %llu",
> -			  m->type, lcn, vi->nid);
> -		DBG_BUGON(1);
> -		return -EOPNOTSUPP;
>  	}
> -	return 0;
> +
> +	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
> +		  vi->nid);
> +	DBG_BUGON(1);
> +	return -EFSCORRUPTED;
>  }
>  
>  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
