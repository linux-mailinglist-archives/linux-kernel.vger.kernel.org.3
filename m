Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2784BE138
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiBUInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:43:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiBUInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:43:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63BFD15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:42:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 07B18210F1;
        Mon, 21 Feb 2022 08:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645432960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKFt/N+8mBXiCo680jK/s9GGlKg4WZTYdNslDXFxjaY=;
        b=WerxlvgHjexW/2CKFS8CNWaeekIIAu9Uoo1rt4Ic1kUoC87Zx5nE3NQ/j9at9Vs/UUTj2f
        ifP4whASPJFx9wemCx4VczT0xSntWtAtX3pS1NL7F8HpJRAbRFUwDtHGIiYB3t5LXIYSvE
        vBQEWRunuFHRGGEYZqUNSE7h/tFyuYA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C61D5A3B87;
        Mon, 21 Feb 2022 08:42:39 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:42:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-ID: <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218212946.35441-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
[...]
> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
>  			}
>  			if (tmp >= nr_online_nodes)
>  				goto invalid;
> -			node = tmp;
> +			node = array_index_nospec(tmp, nr_online_nodes);
>  			p += count + 1;
>  			/* Parse hugepages */
>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>  			break;
>  
>  		if (s[count] == ':') {
> -			nid = tmp;
> -			if (nid < 0 || nid >= MAX_NUMNODES)
> +			if (tmp >= MAX_NUMNODES)
>  				break;
> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
>  
>  			s += count + 1;
>  			tmp = memparse(s, &s);

This is an early boot code, how is this supposed to be used as a side
channel?
-- 
Michal Hocko
SUSE Labs
