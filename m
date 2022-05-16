Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED131528D30
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiEPShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiEPShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:37:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E033E5D4;
        Mon, 16 May 2022 11:37:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so182899pjb.0;
        Mon, 16 May 2022 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucmDp5IzFuPRpFg8Mq5P7wooU1Npp+faC1DqXB9wtjE=;
        b=i5Yf/L0Z+vNQ7EdbispPOwLZNQIbBLcBjMrgWhq72LLHdSqB7/vDL24CrPd7yTBMPz
         fD3KqlKztR7v2v2613awCLQadniOsTIDByTpLUSvCr91wQ86TdYXeTk+nszOFn3jYjIZ
         4SF3D0P7KHJvWK8YhoV4fe4zu1lT/YmSZnxIGJ0NSMKv2543I1pdtjyFJ937LVeJECF1
         I51Iqf0LANjmy62M6HuhHVOShLBREAbEOA6O5pKxODz8a91OW3ioSGCQbcFqazi1FiZc
         YFc904cCMEZMNmrUKAVDM5e+5PmIBMhu7lBjBTrC0HwJwxPj3IpImKlYL5Izp2GwKEZ6
         bLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ucmDp5IzFuPRpFg8Mq5P7wooU1Npp+faC1DqXB9wtjE=;
        b=l7Eh1N/aVCcTXUWegSRSr9wvvhv1pwAYA+aCJ3WUgFYEb7Xkjta46DN8U7T/vk8iCs
         f2bokiUiMyGzw5Pi8QhZv/F4ljNvHTKBkR5mvb6jPEk50f84EE5+4k/a9ySqCoMMqCk3
         lfk+iAnrz+phXeeGP4aqNw5IeY05CWZjQhYLAKr1TnStDJNhaRIk4W4PPHa0+qKoUj/x
         Msi06wga8Az39TodVR6OMKnVC6YGLxaZ2VkBsEjeThQd63Vi9VI+dyNJlBVx6x5qY5Ie
         GDntbCD4b6iB7d/kOC/kWlRqowd9nVA8mtB6a1ak3vIcZKxGSRW1jh+WghnQIQgRF24Q
         uVNw==
X-Gm-Message-State: AOAM531QxYJysuF80xzrGHzAPdqjV8ax9cjqVSjZ2rNxGin5AjSKKmE0
        OkxGI3ie1ANo/PoKdiEVPWqaz5Pn+0I=
X-Google-Smtp-Source: ABdhPJyB3pQVPbA6/qaOrkePJzCcnpi3O4B1/naaPRe5FI8Nd7Y4LRR1ixKXS+FnQFw4HiGqhWqo7A==
X-Received: by 2002:a17:903:241:b0:15c:ee52:cbf2 with SMTP id j1-20020a170903024100b0015cee52cbf2mr18809518plh.10.1652726230437;
        Mon, 16 May 2022 11:37:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b0015e8d4eb271sm7508595plh.187.2022.05.16.11.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:37:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 08:37:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] blk-iocos: fix inuse clamp when iocg deactivate or free
Message-ID: <YoKZ1BnPjqYIUW1k@slm.duckdns.org>
References: <20220516101909.99768-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516101909.99768-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:19:09PM +0800, Chengming Zhou wrote:
> For an active leaf node, its inuse shouldn't be zero or exceed
> its active, but it's not true when deactivate idle iocg or delete
> iocg in ioc_pd_free().
> 
> Although inuse of 1 is very small, it could cause noticeable hwi
> decrease in the long running server. So we'd better fix it.
> 
> And check iocg->child_active_sum is enough for inner iocg, remove
> the needless list_empty check by the way.

Hey, so, I'm not a fan of these "I read code a bit and thought this could be
changed here and there" patches. There's no theme, overarching direction, or
comprehensive view of the structure. The suggested changes can often be
really subtle, which is likely why it may not seem immediately intuitive on
the first look and triggered the submitter to write up the patch. There's no
practical gain from these changes while there's substantical risk of subtle
breakages.

Here, setting inuse to 1 would cause divide by one in the donation logic and
there are comments about the in the code too. So, nack on the patch, and
plase reconsider your approach to sending patches. The current approach
costs more than helps.

Thanks.

-- 
tejun
