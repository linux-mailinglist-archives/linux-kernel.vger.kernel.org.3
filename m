Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B041545B23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiFJEcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiFJEcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57334B1C7;
        Thu,  9 Jun 2022 21:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898E661DAD;
        Fri, 10 Jun 2022 04:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E9DC3411B;
        Fri, 10 Jun 2022 04:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654835556;
        bh=Q4mjg8PJAOOQ6q6x0lZ6Lio+9WvdvZuDWJII0lD+QGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWpkxCB61af31hbHA0tzbxnOaoyT8uLlypCzliz+cEdQSwzvd0gqetH6bKkap9WiC
         fwpEo/bYrnc77NstY4fuGnAK+HJG9Mon5vTxWNIBZwFbobR3bl2lMABCXHnZiFOerC
         FOwFCU1udFf3EPCUNqhLlX3QkTFJhUgn1ncRU75xldw33+EJGYmNi8mC+JsTEZA+iV
         +Uln+o/e/6Lm1UeIVS1jBr6wWdBw1Ebl66hw6GL7oxejEADME6KgK84spJUcZTMtrN
         bT4Qbei5Dtar9OZUm/Fzp/tIp2lTgHMZKn4rigYoSQdrKRk5xshFyGU2sJNDQBvRUz
         cayanERWUPIpg==
Date:   Fri, 10 Jun 2022 10:02:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the dmaengine tree
Message-ID: <YqLJYJglqmDnGZGP@matsya>
References: <20220610124626.141d5f61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610124626.141d5f61@canb.auug.org.au>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 12:46, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the dmaengine tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/printk.h:584,
>                  from include/linux/kernel.h:29,
>                  from arch/x86/include/asm/percpu.h:27,
>                  from arch/x86/include/asm/current.h:6,
>                  from include/linux/sched.h:12,
>                  from include/linux/ratelimit.h:6,
>                  from include/linux/dev_printk.h:16,
>                  from include/linux/device.h:15,
>                  from drivers/dma/apple-admac.c:10:
> drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
> drivers/dma/apple-admac.c:209:26: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'long unsigned int' [-Werror=format=]
>   209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",

Thanks for the report, I have fixed it up and send the patch to fix the
print format

https://lore.kernel.org/dmaengine/20220610043117.39337-1-vkoul@kernel.org/

-- 
~Vinod
