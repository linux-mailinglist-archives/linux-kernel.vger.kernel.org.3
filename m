Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4254F374
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381296AbiFQIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381315AbiFQIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:46:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BC76A029
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:45:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g7so5290143eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KL12GUSIFsOr7y2Ew6vSfP//iAGJZNB8vXdWl9WySdg=;
        b=VKQcrgU1e/BuoJL3/E/5xdtZZtAX+n2mc7kyaVWi3ECp3tVOj0Vfu9FYpaut/duuSz
         6quk8RAdcinthu3Op0BiyogjCOBrkHsN7yA4pBImVsGaob+usMkV4F2bfriOC70/7j4p
         wXf1+6FMMtVbDDJOqQtwFZdclvB6hK494nGqIqbmuAQ5NmsngkmxOYw5sSdo6GZ0PaCv
         WTdiqDsZoDvqzeHRbs+97VwWR+VjfoYaPbM1zixz13z1OTd/D0m87M1VQe3D5PLkADjA
         OX3MaZP/ie9tSfd5/r6LCVfr/CnVpU71Du8UqovEDC/LUMpUaoI0m2UpLe+5b8tieE9V
         WJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KL12GUSIFsOr7y2Ew6vSfP//iAGJZNB8vXdWl9WySdg=;
        b=akBXGKaO6pdpt6KPYuCfEQjO3y/i8mH8x+4gmEwQXTwKxprwom7kwgXxXRa1mYtxvu
         nMxB4OR0diRsti3yzfa5F0n2TPcbBW99eqUrkf25WYTBhK89ouR+vtO0Y0l4vBlLTHVP
         DjJdGqwp+ChXjQTFkKdJmakyWtTU/jt1lgDiuovumnPlBthX2AdoBsAHdsoS1LXmdI48
         IGPmgCdrMi5qChAW00m2O3tFnl38xx5GAd1zyUPMKlzKam50W5VfVQJKo1/3EIqPoU1V
         NFUg3EPzW64tdqXO1KLiv1xSoxlgiYwxSRyfUmdSdAo6DzfIOzpys6dut8j8mfKmd9tX
         aXcA==
X-Gm-Message-State: AJIora+NrD1r/aI6m6n7Ft+j0697aLix3hg79UdZu5ROjNM4TydlyWex
        yLZVR1Qg/k4vZmEeAF+bqSZfig==
X-Google-Smtp-Source: AGRyM1v74Y86WCSwTs0mbpz8Uzc1XzusOKJp8Iwa3L1KmKQVX66F7ytavdX7JhAvnMDW75wpmw8weA==
X-Received: by 2002:a05:6402:2687:b0:430:328f:e46b with SMTP id w7-20020a056402268700b00430328fe46bmr10949958edd.33.1655455551764;
        Fri, 17 Jun 2022 01:45:51 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906538800b006ff05d4726esm1888657ejo.50.2022.06.17.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:45:51 -0700 (PDT)
Date:   Fri, 17 Jun 2022 08:45:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
Message-ID: <Yqw/PI6jF5HZTvxB@google.com>
References: <20220616161135.3997786-1-qperret@google.com>
 <165545408679.771055.5076080259874437048.b4-ty@kernel.org>
 <Yqw9dou3qgpAKQkZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqw9dou3qgpAKQkZ@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 Jun 2022 at 11:38:14 (+0300), Mike Rapoport wrote:
> On Fri, Jun 17, 2022 at 09:21:31AM +0100, Marc Zyngier wrote:
> > On Thu, 16 Jun 2022 16:11:34 +0000, Quentin Perret wrote:
> > > Commit a7259df76702 ("memblock: make memblock_find_in_range method
> > > private") changed the API using which memory is reserved for the pKVM
> > > hypervisor. However, it seems that memblock_phys_alloc() differs
> > > from the original API in terms of kmemleak semantics -- the old one
> > > excluded the reserved regions from kmemleak scans when the new one
> > > doesn't seem to. Unfortunately, when protected KVM is enabled, all
> > > kernel accesses to pKVM-private memory result in a fatal exception,
> > > which can now happen because of kmemleak scans:
> > > 
> > > [...]
> > 
> > Applied to fixes, thanks!
> > 
> > [1/1] KVM: arm64: Prevent kmemleak from accessing pKVM memory
> >       commit: 9e5afa8a537f742bccc2cd91bc0bef4b6483ee98
> 
> I'd really like to update the changelog to this:
> 
> Commit a7259df76702 ("memblock: make memblock_find_in_range method
> private") changed the API using which memory is reserved for the pKVM
> hypervisor. However, memblock_phys_alloc() differs from the original API in
> terms of kmemleak semantics -- the old one didn't report the reserved
> regions to kmemleak while the new one does. Unfortunately, when protected
> KVM is enabled, all kernel accesses to pKVM-private memory result in a
> fatal exception, which can now happen because of kmemleak scans:
> 
> $ echo scan > /sys/kernel/debug/kmemleak
> [   34.991354] kvm [304]: nVHE hyp BUG at: [<ffff800008fa3750>] __kvm_nvhe_handle_host_mem_abort+0x270/0x290!
> ...
> 
> Fix this by explicitly excluding the hypervisor's memory pool from
> kmemleak like we already do for the hyp BSS.

Looks good to me, thanks.

Quentin
