Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0DB492701
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbiARNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiARNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:20:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:20:36 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642512034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z12u0w6fAY7FHqVf7017C56C1dz5WjBJjh9eodhDoO8=;
        b=HTn3oMLkcHfjhMKhg7aaSP6f5yz3ejOejInfbikFUXjcUFt8ifFLjRqovubjEdFeBAcCQH
        twCkLF7bDouHJXl0jpXhyIV4CLNVDUSlQ+GL6V/47EIg3FZLg1vIJ/Mo+KJPSgxOPfFg3r
        w830vVDX1X8iXfDq5arPNWHV1Zh6v6vsG2hU4DnfxDKqoCqHPFwWcoSJRwBU5jjSCf8Z6c
        TasKsS5raUkRyGeQotErji8fRx2FOvbImxpsiF5RpZhO53z4ISn/Gdv7yfVHh+X6h9elXX
        hSRmLnwrvDao7YlXaO6qshKbAMrcokpkSbTWrMXsGSt7GFD5mzNvRxvXO1xNlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642512034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z12u0w6fAY7FHqVf7017C56C1dz5WjBJjh9eodhDoO8=;
        b=V5nBxiwypOOikErQtsFKyznzQuotkKMppxpdYMh4jT9cBoZTOwyDqMCmZjnsqv1so57K34
        p2H8Vm3yMuqWIJAQ==
To:     Mukesh Ojha <quic_mojha@quicinc.com>, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org, pmladek@suse.com,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH] printk: Fix seq check inside devkmsg_read()
In-Reply-To: <1642505688-1194-1-git-send-email-quic_mojha@quicinc.com>
References: <1642505688-1194-1-git-send-email-quic_mojha@quicinc.com>
Date:   Tue, 18 Jan 2022 14:26:34 +0106
Message-ID: <874k61xjrx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-18, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> prb_read_valid() could return a record whose seq number can be
> newer than the requested one. In that case, we allow the reading
> of the data instead of erroring out.

The EPIPE error is intentional. It informs the devkmsg reader that a
record was missed.

For simple readers, like cat(1), this means that the kernel messages
cannot be read completely reliably. We talked about this a while back
[0] because initially I wanted to do what your patch does. In the end it
was agreed that readers of /dev/kmsg must implement EPIPE handling for
missed records.

John Ogness

[0] https://lore.kernel.org/all/87pneiyv12.fsf@linutronix.de
