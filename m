Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EF580492
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiGYTj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiGYTjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:39:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A9205CC;
        Mon, 25 Jul 2022 12:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFF03B810E5;
        Mon, 25 Jul 2022 19:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24445C341C6;
        Mon, 25 Jul 2022 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658777989;
        bh=cuudPE0wtvbxElXfQCMzPg0O3xDu7MgSPTnAUbd2BI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lnm0tSCCxjmphQNW5NriYcH19FeO0pMC/0MZl19jo18xWrIdpmYjjReLjZrbQc3nV
         M3OCLSW3PO1gZvubU1+zIdU9EZbB6ratbRpHX/aNA2dD8ZrjXLNedUC8xa5hrDNMbu
         lcZp1M+CGZGybihQDDnCvRc7tTtqd8IELi5v8huc=
Date:   Mon, 25 Jul 2022 12:39:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, openrisc@lists.librecores.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH] profile: setup_profiling_timer() is moslty not
 implemented
Message-Id: <20220725123948.f16674b10022404814161d4a@linux-foundation.org>
In-Reply-To: <20220721195509.418205-1-ben-linux@fluff.org>
References: <20220721195509.418205-1-ben-linux@fluff.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 20:55:09 +0100 Ben Dooks <ben-linux@fluff.org> wrote:

> The setup_profiling_timer() is mostly un-implemented by many
> architectures. In many places it isn't guarded by CONFIG_PROFILE
> which is needed for it to be used. Make it a weak symbol in
> kernel/profile.c and remove the 'return -EINVAL' implementations
> from the kenrel.
> 
> There are a couple of architectures which do return 0 from
> the setup_profiling_timer() function but they don't seem to
> do anything else with it. To keep the /proc compatibility for
> now, leave these for a future update or removal.
> 
> On ARM, this fixes the following sparse warning:
> arch/arm/kernel/smp.c:793:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?

I'll grab this.

We have had some problems with weak functions lately.  See

https://lore.kernel.org/all/87ee0q7b92.fsf@email.froward.int.ebiederm.org/T/#u

Hopefully that was a rare corner case.
