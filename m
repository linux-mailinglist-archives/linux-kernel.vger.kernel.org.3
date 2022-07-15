Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50B65762E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiGONhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiGONhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:37:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E37CB7A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0CK7/XiAMhupawfrWQ+PTIpUyjnKMaKIN+EBiTWXkTI=; b=QxwJQrPcPW70NuWTnf4RiTP9LX
        UDYXhDB3UkbyMMX+/LdgeOeMRAL7/POLJles7kptlaCIyrg1lm7+aAlp0AS8K9JX/dbVX+KRl2TVr
        clZz1P8G7OCvVrhtQBJwA62eVBKuUCBrArGlbeE78dOJhR7+rQnkdpnIqsZRcqt5isqKOG5uVoleH
        kc8UT8EaJpNO0aR2By51izwXeWUs17ON1796Zc8JNH/tCPh+2Of1Bsa3Er+qUqmNa3x3vhbxhbwAl
        EtQqBTLYAxSrRF0RZmHlGWVab9y3HD/5hvSzI9Tu1c1wGei9lsTWUGMZob02WmK5N0RmVDA1dyaQS
        uC5awWnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33356)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oCLV6-00074P-Qj; Fri, 15 Jul 2022 14:37:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oCLV5-0007aQ-69; Fri, 15 Jul 2022 14:36:59 +0100
Date:   Fri, 15 Jul 2022 14:36:59 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marc Zyngier <maz@kernel.org>, Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: spectre-v2: fix smp_processor_id() warning
Message-ID: <YtFte2mTbfkMkRpJ@shell.armlinux.org.uk>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
 <e5bdea6c767d3a8260360afaddab5f7c@kernel.org>
 <YrMhVAev9wMAA8tl@shell.armlinux.org.uk>
 <421c1ca9-f553-4c0a-d963-2fdeb270dbcc@I-love.SAKURA.ne.jp>
 <fa786d1c-db06-f7f1-9ac9-6a468c1e8d81@I-love.SAKURA.ne.jp>
 <3188347c-3375-b728-cd08-ea4421d823cd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3188347c-3375-b728-cd08-ea4421d823cd@I-love.SAKURA.ne.jp>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:09:01PM +0900, Tetsuo Handa wrote:
> syzbot is reporting that CONFIG_HARDEN_BRANCH_PREDICTOR=y +
> CONFIG_DEBUG_PREEMPT=y on ARM32 causes "BUG: using smp_processor_id() in
> preemptible code" message [1], for this check was not designed to handle
> attempts to access kernel memory like
> 
>   ----------
>   int main() { return *(char *) -1; }
>   ----------
> 
> . Although Russell King commented that this BUG: message might help finding
> possible exploit attempts [2], this is not a kernel's problem that worth
> giving up fuzz testing.

But shutting up a valid warning when the real problem is still there is
also not acceptable.

As I've said many times, the workaround needs to be run on the _same_
CPU that faulted. The warning is telling us that we're preemptible at
this point, which means that can't be guaranteed.

So bodging it by disabling preemption around here DOES NOT FIX THE
PROBLEM. It _SHUTS UP THE VALID WARNING_. And shutting up a valid
warning is A VERY BAD PRACTICE.

NAK. MAK. NAK. NAK. NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
