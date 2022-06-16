Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7969254EE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379452AbiFPXve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378261AbiFPXv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:51:29 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A362BED
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:51:27 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id b142so2155380qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VvsYHZV69lXFKHxU35IHFouhNV0GsTOdd+tsc0jedec=;
        b=NSyPPJqkf4E8GM1TkPRhOk3IeFtq32FXrdZCYwXsL6Od0/m73qi6P56lLKYr/DAVkT
         5WoqvyRiEhFWsudDtO9EfSu5C+Vy+zFOcEMa+e/pamrIngMC+0HWNPtK5Ju9zt0nlkMk
         vFZsBhUv+3q0PtB335p+CmfWY9hQNYgoNlOc5v3mBcdil+mwxK5/H4CLuyRAwv4SX1B1
         vQc3HxwYsW2o1iMmRcP64IHD6qNZn0I1RQzxl1abG+aCgKgPvJpHgpFvHGLl0ZeoKhTR
         lQLq8RhfBv6fpWiLmyXHVMbbcQKZhOq26P3sHJFECNmQspkJzzyKoTRLWnzsDAqpAeXU
         cmBA==
X-Gm-Message-State: AJIora97RtMUSmn+RXnpF8KmkkfaHiowkKcNyKHl3H4QB6kmBDi04nj9
        m7BjsNmUv81te+l+tn8lYCWP
X-Google-Smtp-Source: AGRyM1t9bxR+t7IsKWcjfOVetTaASvkEGL2fu3oNotEOYCxszEJUhMFBtSamnZsLxgWM0nfsEMuVOQ==
X-Received: by 2002:a05:620a:22c3:b0:6a6:48f6:6ae7 with SMTP id o3-20020a05620a22c300b006a648f66ae7mr5477493qki.422.1655423487150;
        Thu, 16 Jun 2022 16:51:27 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l7-20020a378907000000b006a6ae636ce0sm3002736qkd.131.2022.06.16.16.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:51:26 -0700 (PDT)
Date:   Thu, 16 Jun 2022 19:51:25 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the device-mapper tree
Message-ID: <YqvB/d069wqS2Ayg@redhat.com>
References: <20220617084609.17ca0af3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617084609.17ca0af3@canb.auug.org.au>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16 2022 at  6:46P -0400,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   11199f406eb3 ("dm: fix narrow race for REQ_NOWAIT bios being issued despite no support")
> 
> Fixes tag
> 
>   Fixes: 63a225c9fd20 ("dm: introduce dm_{get,put}_live_table_bio called from dm_submit_bio")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 563a225c9fd2 ("dm: introduce dm_{get,put}_live_table_bio called from dm_submit_bio")

Yeap, now fixed, thanks!
