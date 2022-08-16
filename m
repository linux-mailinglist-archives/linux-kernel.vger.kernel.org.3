Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4410E596527
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiHPWJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiHPWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:08:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CC4BA55
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:08:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo134065pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Xy5yxh/I32wlGw5oKAxZXq3yjkNZl4S3110U7/IRHRY=;
        b=kL9Tid3TvpH+rvEDopq2GJcBPo8qrV7hNo7JG77jrEcvwdGudFYB8+z1TZ81V1TX+j
         RODXvkYxbAiaWw8s1uwBvSsXfTp4X7kzSkmYtCjZHtVDmJfcKC0RNN/4lZ88tZOxKmfE
         oWapAVbTPGJ1OtVcFq22cy3xJY/jSQwqNgWLU352COjHBqm50FT7EKABMiRG6ndRMrsB
         0i4Q+MM5uI7UA2KasjwFXn4qyULzsKEcECxU1BC3kCUP+do8KYF1xh2hs5XjBhTieIrg
         7+119ejQNEfntNvQxGYWqYDNA9whMwQUPAKyoeo99zWcBZMZZTnSqPJsclEAnjf1JELe
         /QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Xy5yxh/I32wlGw5oKAxZXq3yjkNZl4S3110U7/IRHRY=;
        b=cffmr7IfxR0WzYRi6KfN1ylJuQ6g0fTabYguyyst7SwR10qWTu07BgRCuVof5UGEUX
         mK99FlvEYbqp2h7iOfJMpCWKO9+wXq/6DcAjhGrAmgkduvILQFFvF1k5mIwc8BAviIgh
         bgW3njXgAWfdFybPNRjNjEHuZqbKB/3JFQk5R3kaRZ5Aw3A2LxN73uA2MkusLLOA9DZx
         jMR4nQi+j3NrUUhxZ6tukPz/ZJsNTqr8WEmKB1szWBiLJUq9ixO7IuBWdVKUpEDMowsM
         0kZWFaoK85dhlALYjw1OGCLejvhpuRrsc586jbWit8wX35OZgOyEHZfOczR5YbS4mHWx
         qawQ==
X-Gm-Message-State: ACgBeo3/SjGhTlMrR2sQ86n2FKwi3CkI0azVu54Q5x7kBV/1zLZbJwXW
        1eHmQbWE86nY57zVE28zjAIFiHX3tf4=
X-Google-Smtp-Source: AA6agR5oJ2beRfAmE3GdnMupoip3Pb+4B+NTLasW6h8cXAAHKVCZBAJTbMdE7bJJmeql+qxvPLCp2w==
X-Received: by 2002:a17:902:d2c8:b0:16e:ea4e:36e0 with SMTP id n8-20020a170902d2c800b0016eea4e36e0mr23994315plc.37.1660687727814;
        Tue, 16 Aug 2022 15:08:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id fh23-20020a17090b035700b001fab11cbc5esm29469pjb.43.2022.08.16.15.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:08:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 12:08:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [RFC PATCH 7/8] workqueue: Remove the outer loop in
 maybe_create_worker()
Message-ID: <YvwVbWfoV/bkFb6e@slm.duckdns.org>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-8-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804084135.92425-8-jiangshanlai@gmail.com>
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

On Thu, Aug 04, 2022 at 04:41:34PM +0800, Lai Jiangshan wrote:
> worker_thread() always does the recheck after getting the manager role,
> so the recheck in the maybe_create_worker() is unneeded and is removed.

So, before if multiple workers need to be created, a single manager would
create them all. After, we'd end up daisy chaining, right? One manager
creates one worker and goes to process one work item. The new worker wakes
up and becomes the manager and creates another worker and so on. That
doesn't seem like a desirable behavior.

Thanks.

-- 
tejun
