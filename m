Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35014EF692
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353981AbiDAPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350525AbiDAPAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C351F5AEF0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648824442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ubFWiDA1LlelDhe80vrrUD2k2vJd+0aq256Lv6ITnp4=;
        b=RlKYnYhcK5zO29WVZX8cPiqpVW80Grgb/ZH3M4nQDlKMFFzFMinVbzxtltcaoGRepEnUQz
        Lne5iTGy2ov/MID17JnGax24YGJsY9pj7BdmpY1Q+VNEP2gIZGl4vXnWhRE6w3w8jw0AMp
        19fLlSCBOquDwepvsl+0QHehnGJnemU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-b0y3CB8LOmu9a4TKtzpTiQ-1; Fri, 01 Apr 2022 10:47:20 -0400
X-MC-Unique: b0y3CB8LOmu9a4TKtzpTiQ-1
Received: by mail-qt1-f200.google.com with SMTP id g22-20020ac870d6000000b002e20a1508ecso2108341qtp.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubFWiDA1LlelDhe80vrrUD2k2vJd+0aq256Lv6ITnp4=;
        b=DJeA9Z9/mSVZhVjBwgD+jBKjP7WZHW9YqlWMV3Blf5pTe/0ykWMnq6VgCXUSR8HEXj
         lO2QzJkI6PItvoFBEul8SfXsqpLTv/Qp3hm5EAb26bbAg96pI7CFKW7zcuyy7uCIYc1y
         zKMb/jxLgsGO6+saEPtNchY+d/ZLc0frqYBUAfAEMurvuGqOdqXY4TISU6WKh7WU1IiU
         XYoYpZtvvqR52wL/Qj9fxxv2UJM52K+XdhoIKTuJ9Incv39yrzVnBlI2F8rhgVu+Q/QD
         MLzrNo2xY6N1uc/sNXq6sWMtrp7SbC2U+roSbxoCwjotv29mzFQGWqtr1rAwptfVCohv
         q+xA==
X-Gm-Message-State: AOAM531dDJS8rFBhVYiQMA3HcNmq3l+j8uZp9P5hktGpZH9aFCw0S4VL
        q7b3mGck6tcTMeSKYJseLQrX2JWL+QKUhRTZqdeiv2a/sMqYJPtc+Izyo2GotFTPC5/K/jCI8kr
        gBQl6E2RQmFbUfhaoL+qui9s=
X-Received: by 2002:a05:620a:24c7:b0:67f:9270:4b6a with SMTP id m7-20020a05620a24c700b0067f92704b6amr6635673qkn.52.1648824440263;
        Fri, 01 Apr 2022 07:47:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQRpmdsYnSYXtR8AnJ7zoL6DR0xqqC0MlDkItb7ArARcr3IO6CN0vjf0PcccOnDEIXfYu9qA==
X-Received: by 2002:a05:620a:24c7:b0:67f:9270:4b6a with SMTP id m7-20020a05620a24c700b0067f92704b6amr6635649qkn.52.1648824439903;
        Fri, 01 Apr 2022 07:47:19 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q204-20020a3743d5000000b0067ece232979sm1374993qka.116.2022.04.01.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:47:19 -0700 (PDT)
Date:   Fri, 1 Apr 2022 10:47:18 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: md: fix missing check on list iterator
Message-ID: <YkcQdjE6uTfScyEy@redhat.com>
References: <20220327053742.2942-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327053742.2942-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27 2022 at  1:37P -0400,
Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:

> The bug is here:
>     bypass_pg(m, pg, bypassed);
> 
> The list iterator 'pg' will point to a bogus position containing
> HEAD if the list is empty or no element is found. This case must
> be checked before any use of the iterator, otherwise it will lead
> to a invalid memory access.
> 
> To fix this bug, run bypass_pg(m, pg, bypassed); and return 0
> when found, otherwise return -EINVAL.
> 
> Cc: stable@vger.kernel.org
> Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/md/dm-mpath.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
> index f4719b65e5e3..6ba8f1133564 100644
> --- a/drivers/md/dm-mpath.c
> +++ b/drivers/md/dm-mpath.c
> @@ -1496,12 +1496,13 @@ static int bypass_pg_num(struct multipath *m, const char *pgstr, bool bypassed)
>  	}
>  
>  	list_for_each_entry(pg, &m->priority_groups, list) {
> -		if (!--pgnum)
> -			break;
> +		if (!--pgnum) {
> +			bypass_pg(m, pg, bypassed);
> +			return 0;
> +		}
>  	}
>  
> -	bypass_pg(m, pg, bypassed);
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  /*
> -- 
> 2.17.1
> 

Did you acually hit a bug (invalid memory access)?

I cannot see how given the checks prior to iterating m->priority_groups:

        if (!pgstr || (sscanf(pgstr, "%u%c", &pgnum, &dummy) != 1) || !pgnum ||
            !m->nr_priority_groups || (pgnum > m->nr_priority_groups)) {
                DMWARN("invalid PG number supplied to bypass_pg");
                return -EINVAL;
        }

So I have _not_ taken your "fix".

