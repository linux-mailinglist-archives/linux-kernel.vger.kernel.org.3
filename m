Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F219C550D69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiFSWXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiFSWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:23:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A465C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:23:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655677396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwAUCtokRVgUgKEqVYDGl9QxhfxKi5oYdysOze3R9q8=;
        b=yfjwricVa6zmJkKVw7QNv0bp0p61zENcNZAKh5SmN6/kBA1viyqaRtRdV6yBRb+cG4oqga
        CF5XZxTHC4kP4U2zfmu/iJgQeZUaM8966fBXV2olEiwSA84S5SZEouchS3QHK77CZgQA3q
        R74pjf8oO33QHtiMNV24Eo6WosHhn4+6L/2K/pxn4hfzHKxv9HInDMXW+2uS/oUPc4qmyd
        hJfvr4FjoBk5lbI6wz5MHhLGMN6dQq7hODL3iZX2Hn0GH/UYMI+LpITFEcwPIIgfyyeGYc
        j76cAdKjW2oj4LKRMJzhNbQFuwS2ycVEkRROSzLsN8Xq8MQJvhYwWaeaH8Sjog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655677396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwAUCtokRVgUgKEqVYDGl9QxhfxKi5oYdysOze3R9q8=;
        b=/3ichqUf3U3dE8VDmiD1Y833MmXcCxePZZHppaqzAdSpyLVLrZOkGweOoWVr+fSpIXDtNV
        MqsnKCJ76EYcJFDg==
To:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
In-Reply-To: <20220619204949.50d9154d@thinkpad>
References: <20220619204949.50d9154d@thinkpad>
Date:   Mon, 20 Jun 2022 00:29:16 +0206
Message-ID: <87r13kwawb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2022-06-19, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> the series
> https://lore.kernel.org/linux-kernel/YouKQw72H7y9EJQK@alley/
> merged by commit 537e62c865dc ("Merge tag 'printk-for-5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")
>
> and in particular the commit 09c5ba0aa2fc ("printk: add kthread console
> printers")
>
> causes a regression on arm64 (Marvell CN9130-CRB board) where the
> system boot freezes in most cases (and is unusable until restarted by
> watchdog), or, in some cases boots, but the console output gets mangled
> for a while (the serial console spits garbage characters).

Could you provide your kernel config and a complete kernel boot log (at
least as much as you get)? I would like to investigate the serial
driver. What you are describing sounds more like a serial bug. The
kthread console series has already uncovered serial driver bugs in
multiple drivers.

Thanks for reporting this.

John Ogness
