Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1A4EC4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiC3MoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbiC3MmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:42:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E66E4DE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LmTGCelx2jCPJ3v8aFOpIN1t47jbgWpwiAwt0LJKB1k=;
        t=1648643608; x=1649853208; b=SqiIMhLDOk6+WmvUaMMHTaO4AAOfgb/2GivY2dGNd7EDYXX
        BO6mtVz2eBQK2UuQClGbrMuEMR4fRuhUgazLVJgbYPUY5wOwYRaug7rbWqf5nI35ofpz8Ri3nb7sM
        DkLled9pLKVOYN+FI9QEYWuJ17eUAmtRFdwViIPV/QSMF/KDyjGeqsboySw8BG23/N7lpg/wpzy59
        HF21xH4amz6suUeKFwl3jJBKpikTQcTEMmUnVIIY3/zz/Qw6B+1HM+ah7iVTaFVeHRwAoMABJbndB
        Iqa/TwD/2LYZJuTaqSOzwYV/se24XZyo5Lq8Y/tZRNpCcyPElbfmH9fkP2M5wrcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nZXVs-002RPh-4V;
        Wed, 30 Mar 2022 14:33:24 +0200
Message-ID: <c1ff43de7d64831d8f40e8e11177f005b9940050.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 14:33:23 +0200
In-Reply-To: <20220330110156.GA9250@axis.com>
References: <20220330110156.GA9250@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-30 at 13:01 +0200, Vincent Whitchurch wrote:
> Hello Johannes,
> 
> As requested in the roadtest thread[0], here is some information about
> reproducing the warnings I'm seeing from the timekeeping code with time
> travel in UML, after about 10-20 wall time seconds of idling.
> 
> [0] https://lore.kernel.org/lkml/5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net/
> 
> The warning is the WARN_ON_ONCE(!levels && !base->next_expiry_recalc) in
> __run_timers().  The log and the config generated with savedefconfig are
> below.  The full .config is attached.
> 
> The kernel version is v5.17, but the splats are seen on older kernels
> and on latest mainline also.
> 

So interestingly, I cannot reproduce it with my config (it's already
March 2023), but I can with yours ...

johannes
