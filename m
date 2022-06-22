Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6360554955
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355755AbiFVJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357552AbiFVJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740062FF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE461619B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600ABC34114;
        Wed, 22 Jun 2022 09:28:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bRSs/AVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655890127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVnmJCBUJKAPqwoibTIejnNGbm66ojxv2vnN/zLU9XQ=;
        b=bRSs/AVIHRDdO4hHRjos3GdgSjRMbi3HOr9NL9fvRvEyp0rvY5WHj7vu8ir71GVHAnv9jz
        W/onECPc32ySeDu4qB89Z/LKOCicmS7WfT5cvmlzaMVfTtPWDl2Pn113riZCtWHTxgQwSL
        +vvY0ZtG2gzDqyEo2g4M3A6B5zpydQQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a27def2d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 22 Jun 2022 09:28:47 +0000 (UTC)
Date:   Wed, 22 Jun 2022 11:28:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
Subject: Re: [random]  31ac294037:
 BUG:kernel_reboot-without-warning_in_test_sta
Message-ID: <YrLgzJm7q3XbjXPQ@zx2c4.com>
References: <YrK7W4HebAqkpw+z@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrK7W4HebAqkpw+z@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:48:59PM +0800, kernel test robot wrote:
> [ 61.471397][ T855] random: get_random_u32 called from arch_align_stack+0x33/0x4e with crng_init=0 
> [ 61.471431][ T855] random: get_random_bytes called from create_elf_tables+0x14f/0x84c with crng_init=0 
> [ 61.471493][ T855] random: get_random_u64 called from randomize_page+0x7f/0x93 with crng_init=0 
> [ 61.474209][ T792] random: get_random_u32 called from arch_setup_additional_pages+0x9d/0xe1 with crng_init=0 
> [ 61.474251][ T792] random: get_random_u32 called from arch_align_stack+0x33/0x4e with crng_init=0 

If the DEBUG option, CONFIG_WARN_ALL_UNSEEDED_RANDOM=y, is set, then
this is exactly the intended behavior. Looking at your .config, it is
set. So no issue here.

Jason

