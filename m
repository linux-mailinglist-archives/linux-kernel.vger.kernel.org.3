Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82F5B0DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIGUM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIGUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE56D9CC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662581542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PR8WUalLy9btDZgRxhhifmVZcWnjA5H+Lwe7MIcntxQ=;
        b=CurDqP6sVg91sxGCDy3nODFdjIEXowMKRoCLLCnCpSbY9QsFeh1Pcu/6VxbGea0domdkPl
        VbgCXF/QCS6wfGeCvsw8x0RzVKW57MP+639WoP7Kwx1giG87qadcB6mlHwnVR+eIHhJdhq
        o4prULIwoaXBUH1ABpc/NN58asVHxpU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-urpvnBA1PXKtazV2fFTjKQ-1; Wed, 07 Sep 2022 16:12:21 -0400
X-MC-Unique: urpvnBA1PXKtazV2fFTjKQ-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so12952946qkp.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PR8WUalLy9btDZgRxhhifmVZcWnjA5H+Lwe7MIcntxQ=;
        b=J7cOzLS9oQCPjOGCdqfXjgjNTjDJQDludlTYd9WJbP3qyLk3DUtTtcGH6Wx6v/OXl9
         iRD+CLD9CBOmtQt38JOFARO2x7/K6B8wCWcRvmzHlTulLgXnL+aB+resHPKovqrVcui7
         oMBQj9WCEHQJvkCFuTETGNTULawSpfYasS6tOWFMoK5fNwWlafY4QLsAUUKN/kKL4ATm
         /fA1oj6ip8V1mGYKZbly6emmgidWAzmb0XG/kC/5A2+bae5+c+bL4TYwTGMuPpFdLz/j
         kV1JXCsGsg2p87STq40yz9ukqBgpG2wiGM6eYkg0BGbW+PASiT3WnFOWYGcViHA7TGVr
         G6AQ==
X-Gm-Message-State: ACgBeo33eokRmo+6eNygdvuAQy1YNzMjj8Xmnn6/OgDD4YTBzHxF+EwU
        wrzG+rmLTHIt3KtnwIr36h09wQh+g5joX1HHA9Fb3odD28vm2tM+fwjAikI51ARzp69hLamn3f5
        dX/XrQVaZXxQWwM3ryyHcqLVR
X-Received: by 2002:a37:794:0:b0:6ba:c4c6:5772 with SMTP id 142-20020a370794000000b006bac4c65772mr3899658qkh.257.1662581540287;
        Wed, 07 Sep 2022 13:12:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73M0W+Epq5dj5LsV52688VKEeeZ/nLsno9QEVhJpOlqX9zO7Psv2NZ0/u62ChoHi1bpiJOoA==
X-Received: by 2002:a37:794:0:b0:6ba:c4c6:5772 with SMTP id 142-20020a370794000000b006bac4c65772mr3899630qkh.257.1662581539926;
        Wed, 07 Sep 2022 13:12:19 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a0f0200b006bb0e5ca4bbsm16343485qkl.85.2022.09.07.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:12:18 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:12:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] powerpc/64s/radix: don't need to broadcast IPI
 for radix pmd collapse flush
Message-ID: <Yxj7INfcagKu1nH9@xz-m1.local>
References: <20220907180144.555485-1-shy828301@gmail.com>
 <20220907180144.555485-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220907180144.555485-2-shy828301@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:01:44AM -0700, Yang Shi wrote:
> The IPI broadcast is used to serialize against fast-GUP, but fast-GUP
> will move to use RCU instead of disabling local interrupts in fast-GUP.
> Using an IPI is the old-styled way of serializing against fast-GUP
> although it still works as expected now.
> 
> And fast-GUP now fixed the potential race with THP collapse by checking
> whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
> flush is not necessary anymore.  But it is still needed for hash TLB.
> 
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

