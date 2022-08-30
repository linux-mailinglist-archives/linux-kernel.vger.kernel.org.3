Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF69D5A6751
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiH3PY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiH3PYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79E10D4EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB84615E2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8147DC433C1;
        Tue, 30 Aug 2022 15:24:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NlF3HcLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661873077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xZuNzWTZ1CBdOMWdOgDK3tszHLRIh7WNhf8ToG2ixL4=;
        b=NlF3HcLeRmVH+Ix2asWoFCOLVkvmlFPlVcfbo5SmKkJKRFEfeIDJ0UCps+Urx6pZYEoFMW
        cU0cd6P2YEKFHOJAFNTfYby+jsN3/Ac7qN4MQHJc7E8T13C9pkzkoM5AdnsMi7qhZdwRIf
        /YUguIGju4T4XmOiBpGWHjYhgTs5IHQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ce9b7591 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 30 Aug 2022 15:24:37 +0000 (UTC)
Date:   Tue, 30 Aug 2022 11:24:33 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <Yw4rsdA7xu4+UrLi@zx2c4.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
 <Yw0XRtgh2dmSM+T1@linutronix.de>
 <Yw0Z1jvwHEQQq8Zw@zx2c4.com>
 <Yw3i2N8J7yz3jnyt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yw3i2N8J7yz3jnyt@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, Aug 30, 2022 at 12:13:44PM +0200, Sebastian Andrzej Siewior wrote:
> The first patch did so yes. The second simply retried in two secs and
> this shouldn't be problematic.

This seemed pretty bad too, because now you potentially miss up to 2
seconds of messages AND it adds more complexity.

I'm fine with changing things up to accommodate RT, but not when the
result is so obviously worse than before.

In my tests I can't see any latency difference with using raw spinlocks
in random.c. Maybe I'm doing things wrong? But I'm not seeing anything
change...

Jason
