Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072DA58EAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiHJLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiHJLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:01:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702F6BD46
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2E83B81B58
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E761C433C1;
        Wed, 10 Aug 2022 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660129277;
        bh=ftGtdYTnbszhVMwv2b+bcQbGmM5dxZNBf1hKIGP5B4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E4JevIsueSKK+QyR4BaGulFtqyzT2F5U4Qz6DbxV8BED5dlCQoYG2yk/RuxEOGVB1
         HtC6vCMpUNGAIn8v4hsrHq3HWaDWqFUbh9owzMP2YQPDQu61raN5ZnImwbaLzYo9bh
         K5Lcg7294Sq2E4C2Zg+Jax1vUcUqnHO3x6DKgm8AluC3CEoOrX+8rvrKA7rJlRmZD0
         qO6eFY59xIQwObf9nzRDNZEdEOc2ma/Y8f7q1KMObyN5aSBMVet4s1WuR46uXbgPzp
         Mzt8QTzeMZCw6H6WxcOypsDI46Kr5rqVDfjosxQnmKVFl5aVGHfAHrINvvaMiEqb0y
         uqebiUbG4jQCw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oLjSc-00273X-UW;
        Wed, 10 Aug 2022 12:01:15 +0100
MIME-Version: 1.0
Date:   Wed, 10 Aug 2022 12:01:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Fix the !CONFIG_SMP build for irqchip drivers
In-Reply-To: <20220810103156.1214996-1-chenhuacai@loongson.cn>
References: <20220810103156.1214996-1-chenhuacai@loongson.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f92fc4f34784217206b53a3709538d5c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenhuacai@loongson.cn, chenhuacai@kernel.org, tglx@linutronix.de, loongarch@lists.linux.dev, lixuefeng@loongson.cn, guoren@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-10 11:31, Huacai Chen wrote:
> 1, Guard get_ipi_irq() in CONFIG_SMP;
> 2, Define cpu_logical_map() for the EIOINTC driver;
> 3, Make eiointc_set_irq_affinity() return early for !CONFIG_SMP.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Frankly, the real question is why do you even bother? As far as
I can tell, LoongArch has no UP system.

arm64 crossed that bridge a long time ago, and we never looked
back, because these systems hardly exist.

I'd rather you simply have a CONFIG_SMP always set to 'y', and
be done with it forever.

         M.
-- 
Jazz is not dead. It just smells funny...
