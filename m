Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1E5958D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiHPKrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiHPKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:47:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA610DF70;
        Tue, 16 Aug 2022 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BlpTwVx92rbeofMgr6BndByubfCRJy+MP8PnqkqRTU=; b=eYxw3R0fddjtO4kCgfEOWZVfd4
        Bx85zGpyU007xVdxqdsTrh3JXX3JK1cgrmg70Wz6sGC8i/d9q8gJEfp1DtTeuTQ9Il3lUQ/XvwjA1
        /3HU+UcdQmp3GBF3rJLD8fc2D4qWckYf2mQtu32UL8r38MUc6hg3s71RoWogX/UCHIkPOlAL185ja
        3L3DLjB0hft7JKww/ZZOeRagnXyMIleVsy6kLAshN4mNw8YeC76FOnWM7p3vOaNwteQrFjGa9zLdI
        +9VaJJO7z8eh9BEzwJJWNS/20DaMCC/pOgnadM0yFkCgw1fdU8+KWMFyhhrrfRqCymOCdtwpHXwqb
        LldqktVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNtVJ-006oGs-Sn; Tue, 16 Aug 2022 10:08:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3109980083; Tue, 16 Aug 2022 12:08:55 +0200 (CEST)
Date:   Tue, 16 Aug 2022 12:08:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH V2 1/8] perf/x86/intel/P4: Fix smp_num_siblings usage
Message-ID: <Yvtst7ga6TaMsHeb@worktop.programming.kicks-ass.net>
References: <20220816051633.17775-1-rui.zhang@intel.com>
 <20220816051633.17775-2-rui.zhang@intel.com>
 <YvtU2VKtpGCIOes4@worktop.programming.kicks-ass.net>
 <8496afee057d63b83a7ff02ec7f1de8c2d0e97ae.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8496afee057d63b83a7ff02ec7f1de8c2d0e97ae.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:47:14PM +0800, Zhang Rui wrote:
> On Tue, 2022-08-16 at 10:27 +0200, Peter Zijlstra wrote:
> > On Tue, Aug 16, 2022 at 01:16:26PM +0800, Zhang Rui wrote:
> > > smp_num_siblings can be larger than 2.
> > > 
> > > Any value larger than 1 suggests HT is supported.
> > 
> > Subject and Changelog are still utterly insane.
> 
> what about this one, do I need to resend the full series?
> 
> thanks,
> rui
> 
> From 2e368e6afa83cb73e44ac8c3cf8339207097d9e1 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Tue, 28 Jun 2022 11:02:12 +0800
> Subject: [PATCH V3 1/8] perf/x86/intel/P4: unify logic for detecting HT
> 
> Any value larger than 1 suggests HT is supported.
> 
> Although smp_num_siblings cannot be larger than 2 on P4 platform, it is
> better to keep this logic consistent across the kernel.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Yes that works for me; thanks!
