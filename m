Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9717252A156
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbiEQMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiEQMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:16:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603E264B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:16:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id k2so14143751qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLF/Jj6XGtMs56rxYAeYQ7aazvooOov9erMd/9bEfPQ=;
        b=fiOi4pYO3Ucyf+7FuK4zet1/Jrh5FNueHMfQsBWQeNmM+oiOJyxTdNlbr1t9VLdyhg
         9nnuVkUKb83uryRngEDhnS5o94eiJe93lwhXp+wpS27xl4TkStjDfTZ715iptprz+jW3
         MpUxDvL0fKMOFtw9rmvkf7xeoYp8nB4XyP6+DfgmKDQAuDpUcTIYTMRdjg5ZPEHMLPFv
         vEHCKfmt8hSMAxR5k6e+5RnlwzI1nEYkjjupaI3/vYVZ5H1fV95C4RMgRL4Me2GUjMyf
         7zq9XS1+bSeDTII8ZcaHbw1b1aj1fuqGvo2v1P/BppYVXOnnl6DQleSxHipNy6pGcHvr
         UzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLF/Jj6XGtMs56rxYAeYQ7aazvooOov9erMd/9bEfPQ=;
        b=l4dXGRGSeQvT2+gSCZ3kxpJTUZrRMEtVMeheVfwTl0IRKwkhp3ucYwzM5ik2NnsXQ0
         OYeK9aUeDdPqA+vBky8RZM3xOaQeUEqZ8yicm0WQwdlqf0WfYXOW5nin2HfLkMqChgU2
         FpqUnYT9FyMYCGGVwGWZGRtEFFWmcv3qDOft2rFNUAjMHEMWBBLO34W/ralW8GxwzYrK
         KgFcZdvlTRJCOaJmruNp3HK3Gpn9PuzLTz+lWAXFS1hoWr+1PrIPK6DhhzK7jJ/JP38m
         5fy3Qy4DQflzE06zbwdEfKF1gly/ndoxndk2IMTN72JUn5PHzB1MbPtRROhmc13/elVF
         z+dg==
X-Gm-Message-State: AOAM531QGNbpDYnoaom/aeuBJR/iITcEO06Azbl0FIAsfhpp0WUKCmDP
        l5FYp6Ft0Y5vT27+Y3JO/X9yyQ==
X-Google-Smtp-Source: ABdhPJyM0PjqPIZlBBrcOc/L+rNk+S3zVViqLlxik9IW8PIxUqbzj0SfEK7pvUwiKoa9Oml5VkNn/A==
X-Received: by 2002:a05:622a:8d:b0:2f3:ba67:a0ba with SMTP id o13-20020a05622a008d00b002f3ba67a0bamr19347798qtw.129.1652789808588;
        Tue, 17 May 2022 05:16:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8554b000000b002f3ca56e6edsm625334qtr.8.2022.05.17.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:16:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nqw86-007z0H-QE; Tue, 17 May 2022 09:16:46 -0300
Date:   Tue, 17 May 2022 09:16:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: remove null check after call container_of()
Message-ID: <20220517121646.GE63055@ziepe.ca>
References: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:33:28AM +0800, Haowen Bai wrote:
> container_of() will never return NULL, so remove useless code.

It is confusing here, but it can be null. If you want to do this then
you have to split out the _ib_alloc_device call and check it
seperately.

Jason
