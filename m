Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095334E8CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiC1Dmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiC1Dmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:42:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6450E27
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648438868; x=1679974868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vNa/+4Ol0UPdg0NZGj99l5sQwTLSa0rUt8USwrWDWCo=;
  b=O4JJfN/mdj9IdpRtLrapzZ8gEn8+qnLkWzcN+Lrs3nijFFTAXZIz6L9X
   ITOcZ3fU7OVeA12jYqy06L5NAvCLINCeCUDxF5ckDGBAyCngcsB+3ZciM
   cjFVvnLHCHESl68LI9VaiMdG4QxguXW71NUvIMioq6G68v9dG9UsH7wF9
   fu8ScMrWsfsCvJ31bJDXjqofrkiG05BdNmu8MvXmnYgVcj4H9OAD/YZqZ
   r877IcRQNNolSjjYgLgDyLujwqF8gV2Az8WLWfXe9+litHwMJiqGNwXZL
   iwui6//zMFTSmtqM70fLerJtuyjKjYdvTu6GimlNWAr/vuyvuJ3/BmOwq
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="195300270"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 11:41:04 +0800
IronPort-SDR: e9yKlZhmI9Sfk/8AOPOl2SM9eoC+UIMB4ohLVFEnGMd5Pxo+sPeIzMnoqgSk59xqyhI4gRKiW/
 BTRnZlTaansds0zxg8m/LHqXJeCsTG5MCzApdz8OC0Igzc0qC/BmEsJC8HW3acg5LsNpIOd6mR
 o+wZT73eddIaRLoshTcxiWQtdbi8JUs/PHfJn88JAselJO/m7sVCXCZPPJ48VQF+l4qQQJkWh/
 LYEb0QkbjdQXnSxBeAdNmWD3a3ONHAbMe1EMfqaX7Gn0ZMjeux3fmdLsbMuH82p8Z/41prPf+9
 H/8I0RazhWW7omd5JTj1UbN7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 20:12:50 -0700
IronPort-SDR: XBfSGblxvsJ6mwfD5DwwMqqN1h9w35DPHLWUQtTdsdRkDNrIoA/p7wc5WQxzmwAqifynnRfbhM
 SJ3YeiauBIfQ2zcdbm2FNV8bq8upPMqCJC+kOFBCC3zSioFmuzKOqNzXmPvo/MkS3dP82TEGuh
 7MhprQ3cEie5L2fLPqlxgzJQ3Nb059qv1gT8xIMkjRBowXJQXlEi9T84slwlbeaNfHeRVqdWZj
 yDrbT2xA6U3PdYhEI1l8BwadAUJ/IhoiYV+nKZEhVumA+Hxypyjq6v1kemtObXijx8z7GHDB0d
 A8A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 20:41:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRdlM6hqlz1SHwl
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:41:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648438863; x=1651030864; bh=vNa/+4Ol0UPdg0NZGj99l5sQwTLSa0rUt8U
        SwrWDWCo=; b=PNVz0Qdua/1wRBW6XX/ZVv5RkqEqzeHuMtiuhj447HS/8ObYyUM
        9oj9FD7+1012gMAiv63Zo+HNJ0Mn8GqzZqNpKf7bBMB253s7yrOItGdsEtTqomt2
        36yg+tSTQuPellE7GGXmifKScBc1G/HOZnBZkuQDtfbJRHrzDrKNsxMuGedDzWqs
        tecC3wjwEKkLuUfIJ/HzM7TY17IvvF+mdxU86OLU/pGbrIUI4+uOrbS1V1BYxXhe
        9OM/1e97v5S5aamGn/fGQ6uKUA4LnF1qoZxZsEHVH3mgleKF6UHHZUUoSiBM618V
        k+X1DNGVF8KCBn39XP78jdeEnaKJXQXyD1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DZQd3yERTH6X for <linux-kernel@vger.kernel.org>;
        Sun, 27 Mar 2022 20:41:03 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRdlK2XPFz1Rvlx;
        Sun, 27 Mar 2022 20:41:01 -0700 (PDT)
Message-ID: <32fad707-fdab-75a6-f7e5-d356a0b86983@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 12:40:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fs: xfs: add NULL pointer check
Content-Language: en-US
To:     cgel.zte@gmail.com, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, dchinner@redhat.com,
        chandan.babu@oracle.com, bfoster@redhat.com,
        allison.henderson@oracle.com, lv.ruyi@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20220328032642.2371596-1-lv.ruyi@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220328032642.2371596-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 12:26, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kmem_zalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. It is safer to check NULL pointer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  fs/xfs/libxfs/xfs_attr_leaf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index 014daa8c542d..e6694f49f563 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -1571,6 +1571,8 @@ xfs_attr3_leaf_compact(
>  	trace_xfs_attr_leaf_compact(args);
>  
>  	tmpbuffer = kmem_alloc(args->geo->blksize, 0);

See kmem_alloc() code: this function cannot fail (it retries the
allocation until success). So checking for NULL pointer does not make sense.

> +	if (!tmpbuffer)
> +		return;
>  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
>  	memset(bp->b_addr, 0, args->geo->blksize);
>  	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
> @@ -2290,6 +2292,8 @@ xfs_attr3_leaf_unbalance(
>  		struct xfs_attr3_icleaf_hdr tmphdr;
>  
>  		tmp_leaf = kmem_zalloc(state->args->geo->blksize, 0);
> +		if (!tmp_leaf)
> +			return;
>  
>  		/*
>  		 * Copy the header into the temp leaf so that all the stuff


-- 
Damien Le Moal
Western Digital Research
