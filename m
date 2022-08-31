Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B345A8374
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiHaQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiHaQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:47:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81076D83DA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:47:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 73so5626190pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fZoi3p3476nwHsYBDa4XTnSE2m3eJYPB3/6zUX1N3co=;
        b=MNNk2M7Rd8IZwujALXwYdexGhMVh0a3g5yNMDQxIajaK7VUbyG5v4pPNyKSLeJxG2E
         C62GAUeKX1bc8mtz1WyAJkZtayMZDtuyFY0HaJnC+rqCDePcfU9vfopylZiHoVIgK/H7
         ufaTsobDW2z12sdUZWdTnRnBqWKkAQpiLMNFrcIYWAsQvjJ5KrZZ3bXMLYOxVDj/XiTn
         XJ9rx4a8lq22iZAu8fSXv3SgaQN3YfmaWkXXUJE4mAUiojo7qeqKwOUT1TlLxAYnM78/
         0br2LQH8SIbgFVolJu35MgahLlvOMsf+ggX4yrnWkbAZlkjIau2SnP2WeyQBxzc6dCYR
         cQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fZoi3p3476nwHsYBDa4XTnSE2m3eJYPB3/6zUX1N3co=;
        b=690VPQBn3HZL5YoDvCBCjPp8WVfRp5Vhkcn96wcCU9PyMiaR3mR+bhk9mYEyrXpzDO
         8klpfZjuA1WPcnsj4Uu5F3fNZqPEZpluRXJyAxuunQkMgTXBq95/jTHhQQ0Se1jEK8lg
         gViHcqL/4QqZlqChK/C2qIgXFg2MOLYWGpdTxLRQ+86Dlo7Y55QOtFSG3xgFeCbzJqsO
         K4CXBtDUZ8GxBp5Hib/hSvV/zli5LYQm0KMST3il/9rrsNuGVzJ3MNac7Og6QqAFPR6p
         zkVzZFgDovW95iTYyfpX85mSSoW1OLhBMLDn+hOjNYptvkcRb6cdEcQMweuIBi/GJM7W
         KD+A==
X-Gm-Message-State: ACgBeo0Nflr0VV9zvRsnJ5vUGpEBaFhBXYrKZFIsPzZD7iMgGNl4jRa+
        WNKgoF1xwPULvO1kRObfFx2b/nhe2MJ7rQ==
X-Google-Smtp-Source: AA6agR6l6Gx05I14b1x1kX7vZr9f8vzqO532weKY3nU629ltrcGvZlbRbJvHn9N2HDKY/6jLzV4ucA==
X-Received: by 2002:a63:8048:0:b0:42b:73ef:ac8f with SMTP id j69-20020a638048000000b0042b73efac8fmr21867879pgd.446.1661964449973;
        Wed, 31 Aug 2022 09:47:29 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a4dce00b001fde4a4c28csm1501668pjl.37.2022.08.31.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:47:29 -0700 (PDT)
Date:   Wed, 31 Aug 2022 16:47:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 15/19] KVM: x86: Explicitly skip optimized logical map
 setup if vCPU's LDR==0
Message-ID: <Yw+QnR8xu23ToD9g@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-16-seanjc@google.com>
 <0459cd1568afdbb451190518c2bdaa5a821987df.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0459cd1568afdbb451190518c2bdaa5a821987df.camel@redhat.com>
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

On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 00:35 +0000, Sean Christopherson wrote:
> > Explicitly skip the optimized map setup if the vCPU's LDR is '0', i.e. if
> > the vCPU will never response to logical mode interrupts.  KVM already
> > skips setup in this case, but relies on kvm_apic_map_get_logical_dest()
> > to generate mask==0.  KVM still needs the mask=0 check as a non-zero LDR
> > can yield mask==0 depending on the mode, but explicitly handling the LDR
> > will make it simpler to clean up the logical mode tracking in the future.
> 
> If I am not mistaken, the commit description is a bit misleading - in this
> case we just don't add the vCPU to the map since it is unreachable, but we do
> continue creating the map.

I'll reword.  I intended that to mean "skip the optimized setup for the vCPU", but
even that is unnecessarily confusing.
