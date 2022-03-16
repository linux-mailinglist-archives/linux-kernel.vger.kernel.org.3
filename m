Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49434DAEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355319AbiCPL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiCPL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B8652D7;
        Wed, 16 Mar 2022 04:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA8261675;
        Wed, 16 Mar 2022 11:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BFFC340E9;
        Wed, 16 Mar 2022 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430033;
        bh=g3R59Ud+4Lq9HFnMOaBBpAh56Ru1PjO+vZlKpzbV1s8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j2cOz4quxecrGn0bwwgDHNi/y4Kxz8zqU+ZUaraRtx0ybtGhItfluPr9USHzKgP0i
         5DsnWVJApaVjQggVUHku1hG9SLyDfRzNzqVDUCaCp/fUFQ0zIGI5gXllsdC6NJUoc8
         JAWzGFfzuAIInEaU2XD+LRQEX2Lv6ejgwfmd8vSo4D7Jj7rLGtpvgCRkcmrK8VKqmg
         2VUzCZuuM23ZroMRQdTMoOov3yYoBGPeDlGpuvYOhMDuYM4wF58nreSHDkAQuLlQJ5
         yNdFtorW7ARJGhoNrhaTqxcGGG2BUeQyJiZZYHZZq+t3oSYK/oPG1WN1hyGmtrvSLU
         +EvdlLlHi0oZQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nURo6-00Ethq-Sd; Wed, 16 Mar 2022 11:27:11 +0000
MIME-Version: 1.0
Date:   Wed, 16 Mar 2022 11:27:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix dtbs warnings for arch timer
In-Reply-To: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5521012e957efa3c4afe2de996a1b5ac@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: singh.kuldeep87k@gmail.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 09:54, Kuldeep Singh wrote:
> This patchset is an attempt to resolve 'make dtbs_check' warning for
> arch timer.
> 
> Patch 1 is done in preparation for following patches which defines
> compatibles order in more clear way.
> Patch 2 documents arm,cortex-a7-timer entry in bindings similar to an
> existing entry arm,cortex-a15-timer.
> Patch 3 adds above 2 properties in of_match list to bring them in
> use.
> 
> Please note, this patchset is based on
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, 
> master
> 
> Kuldeep Singh (3):
>   dt-bindings: timer: Rearrange compatible entries of arch timer
>   dt-bindings: timer: Document arm,cortex-a7-timer for arch timer
>   clocksource: arch_timer: Add arm,cortex-a7/15-timer in of_match list
> 
>  .../devicetree/bindings/timer/arm,arch_timer.yaml   | 13 +++++--------
>  drivers/clocksource/arm_arch_timer.c                |  2 ++
>  2 files changed, 7 insertions(+), 8 deletions(-)

Please use my @kernel.org address exclusively. My @arm.com
address stopped working over two years ago, and the MAINTAINERS
file shows the right addresses.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
