Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3500550D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiFSWmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiFSWmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA14E82
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60621B80D2E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC422C34114;
        Sun, 19 Jun 2022 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655678569;
        bh=LKj+hjcmncriELO8FOMPKf9vqLZbpkHOSGiET9fdxyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fJ6KtALWpuSmYp1x/Kae9laSbsH1dP/JuiDVo8KRATm0NRXCDLV71r9CBYM4wwutc
         QetUul1XxibbIBtg3hEaRB0rqwmjvwIiio4/ptsmMN+KcSv5D808e53PGZyfaupSta
         7HJGF4lRHMzrLaq5b7fniXcWQI/mXMkmJmk9WDxFkkDdG0DZvhrNyw22EPrsj4316w
         rE2PZ7XCucR3dyfTZxc6hBAD/j3s8T+vRVnwrofalz/PAa0rM5kGXArAh817TXvPXu
         BjnuqfJWg9XZHirRwappM/RACCfI0ShilwJiNl1VgQ8UEv08xFDdrgcNVpwbQTqwm0
         8RnBnD5L5sBIA==
Date:   Sun, 19 Jun 2022 15:42:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net, lib/once: Remove {net_}get_random_once_wait macro
Message-ID: <20220619154247.038d66f8@kernel.org>
In-Reply-To: <20220619074641.40916-1-wuchi.zero@gmail.com>
References: <20220619074641.40916-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 15:46:41 +0800 wuchi wrote:
> DO_ONCE(func, ...) will call func with spinlock which acquired by
> spin_lock_irqsave in __do_once_start. But the get_random_once_wait
> will sleep in get_random_bytes_wait -> wait_for_random_bytes.
> 
> Fortunately, there is no place to use {net_}get_random_once_wait,
> so we could remove them simply.
> 
> Signed-off-by: wuchi <wuchi.zero@gmail.com>

Yeah, sure, if it builds:

Acked-by: Jakub Kicinski <kuba@kernel.org>

If Andrew doesn't pick it you please repost CCing netdev.
