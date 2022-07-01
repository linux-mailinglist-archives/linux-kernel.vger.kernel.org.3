Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E656344E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGANYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGANYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530365D55;
        Fri,  1 Jul 2022 06:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A098061BD4;
        Fri,  1 Jul 2022 13:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920CAC3411E;
        Fri,  1 Jul 2022 13:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656681877;
        bh=AB1moI492HfefygLu4A3x4hIpNObzlN7G4uBSSpjw7k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PYDBb8/GKL8sqVlHibUIiJ+IgtlG5P6gokVJ+TqCxuRw8wDE7rI3mxdeFff3I7XYz
         8TDyNkGBGMpljUzAFYq54ZkW5/kBNJUzysdrdZdUCJoybwEU2qB4GIQ+otjdlPOC9h
         sieq62dydjUyuB1GXB6uV2eSe6di4owVUdWxKP6t6IGfCLJOovgGavb69Av4NAlpxJ
         FN5y9hme+AYw/cgndhsQ7lf6yf95knOEupWVKG16/+xSz2f5af5250sJkIvkqLIqqv
         SA08NjrehFpgAMOP0P5j6dA7zSOEKXslE31m0LcIBTOES2e8a2bn31MyF9tbogRjPB
         PkBPHX2i0A3Cg==
Message-ID: <ec9a37a6-4584-695c-8ed9-15e94f13781a@kernel.org>
Date:   Fri, 1 Jul 2022 15:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <87tu8bmh2s.fsf@stealth>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <87tu8bmh2s.fsf@stealth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit!

On 6/23/22 19:21, Punit Agrawal wrote:
> Hi Daniel,
> 
> A few flyby issues I noticed while going through the patches to
> understand what RV offers.
> 
> For the typos, I wonder if it isn't better to use a spellcheck - they
> unnecessarily detract from the review. Sorry for the annoyance!

I do appreciate this kind of review. I run a spell checker, but sometimes I
forget a patch here or there. I will add your changes and check the other
patches.

Thanks!
-- Daniel
