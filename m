Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3C4AC1B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383065AbiBGOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388880AbiBGOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:18:58 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4AC0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:18:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ka4so42412638ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfB/zROpbDPZLG78pKHBRJBlB4fwx1ChfM+AdqDD0XQ=;
        b=pZrIanIvKRIMLV+bqgMmQkAsSfEdQjqG63Ye9+OXXvUo5mqE8v11izZJtJda1PK7+y
         7dUdLZHu7+ps05pzUgXXziVTx/B+C5SYTQy7Mtdl2bSh8S6hK8vYAOeoACg7C9BEjZVF
         DDnRZOrPI/nBwGBoSNCPFlCoeGqebUkQ6hRVfs5yGr37QE1mx660jeZZZqXwcmjfzyO+
         Zy1Lg6XyeY3KHwgRf7NTnkJqqjoqF9uh9gn0hDQQ5vIJliA3KdF7xBHzyemNwSPa205p
         NWNwcYgRJFob+HF6mGY44iSeqxHn95L0ei8an5bBUSQFnzjneFsFg4copji/vtg//x/t
         Eydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfB/zROpbDPZLG78pKHBRJBlB4fwx1ChfM+AdqDD0XQ=;
        b=3t7HNRUIOBVoh5pOnaIcx0TSBerW6oug1sX3qZ1Ocww8eJL9/L+IqnBs5ltXuCMILg
         CdlLtph5Z6RLvaXMXFLUcc5NecF/w23FeNNCxnRHg11LaXl1UbJZCb836q8WRzYfxj0V
         BJ6xszfKBpvWn57Df0K9/3dlImEANtHB9oqXs7ilX9kDCrx4Fr4PX1a5IF1Y9HQnqaXJ
         eoC4HW4EzwoA1+eQy+YT/uinDjVx/ZJ6iXy0ZoRKsLA+7dDqtCyau3kiJXYWQEvCDC3O
         6Wz12egsSmEeOTRkYm8rmIdKgqaHyc89ofNPKRvVrhM0C+g4/GX0JCJggegHN3fL7caf
         oxwg==
X-Gm-Message-State: AOAM531XS3j9OLe5Iu87tyXGosc74pjThNkVhyuJlfzelsTYblkV41k2
        KP2Divc57LsTS1m9uNJbH5Y=
X-Google-Smtp-Source: ABdhPJwkSTlEuTXCOARVUrk633TbxK1cwiIaELgL69VZlxplrlhknCUA8PbZxadhJj5PxhPV5/OIJw==
X-Received: by 2002:a17:907:9622:: with SMTP id gb34mr10458178ejc.422.1644243535576;
        Mon, 07 Feb 2022 06:18:55 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id cb18sm2267625edb.25.2022.02.07.06.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:18:55 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        phil@philpotter.co.uk, larry.finger@lwfinger.net,
        julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@stud.uni-goettingen.de>,
        martin@kaiser.cx
Subject: Re: [RFC] staging: r8188eu: Sleeping in atomic context (SAC) bugs
Date:   Mon, 07 Feb 2022 15:18:52 +0100
Message-ID: <23161490.ouqheUzb2q@leap>
In-Reply-To: <20220207092133.GE1951@kadam>
References: <2111927.Icojqenx9y@leap> <20220207092133.GE1951@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 10:21:33 CET Dan Carpenter wrote:
> On Mon, Feb 07, 2022 at 01:02:17AM +0100, Fabio M. De Francesco wrote:

Hello Dan,

Thanks for your exhaustive reply.

> > My first question is whether or not msleep() can be called in atomic context.
> 
> You are not allowed to call msleep() in atomic context.

OK, well. You confirmed what I was suspecting.

> The Smatch
> check for sleeping in atomic did not look for msleep so I will update
> it.

I'm glad that my observations suggested you that update to Smatch :)

> > If
> > I understand its semantics and implementation it seems that it should be forbidden.

Said.

> > What about changing it to mdelay()? Again, it seems that mdelay() spins without 
> > sleeping so it should be safe. Isn't it?
> 
> mdelay() is does not sleep,

OK, again. It seems that I've been able to understand the different implementations 
and semantics of msleep() and mdelay().

> but it's not necessarily a good idea to
> delay for a long time while holding a spinlock.

Yeah, I agree with you. If I recall it well, somewhere I read a suggestion which
says that one should avoid mdelay() for more than 1 ms while under spinlocks.

Thus it looks like here we have a problem...

The disable of bottom halves and the acquire of a spinlock is performed in 
rtw_set_802_11_disassociate(). If "if (check_fwstate(pmlmepriv, _FW_LINKED))" 
evaluates true, rtw_pwr_wakeup() (that is a macro defined as _rtw_pwr_wakeup())
is invoked. In the latter function I see two conditional calls to msleep(10).

Thus it is 10 milliseconds and I suppose that it is a huge amount of time under 
spinlocks. Nevertheless, I think that we should use mdelay(10), unless with 
proper tests we find out that 10 ms can be reduced a bit.

A couple of months ago I made an analysis of a report by Syzbot that led to a 
patch in the tty line discipline. That ftrace analysis was necessary to prove 
that that SAC bug could hang an IOCTL for more than 8000 ms. 

Why am I saying this? Suppose that one of those msleep(10) cannot recover within
acceptable time, that 10 ms argument would behave like 100 ms, 1000 ms, or 
even hang the driver indefinitely.

I trust your words (as usually): "[] it's not necessarily a good idea to delay 
for a long time while holding a spinlock". But what are the alternatives?

1) Leave the code as-is with those msleep(10) and risk to hang the driver (or 
the whole kernel?).
2) Change msleep(10) to mdelay(10). It's a huge amount of time, but we are 
guaranteed that it is safe.
3) Change to mdelay() and try to figure out what's the minimum amount of time 
that suffice. I forgot to say that those msleep(10) are within "while" loops, 
therefore they are called an unknown amount of times.

If we choose the third option, how can we test the driver and see if shorter 
delays may work? Can you suggest a methodical approach for figure out the 
minimum amount of delay that can work? I have the hardware, therefore I can 
test the changes, but I'm not sure about how to do this work.

Any other solutions?

> > 
> > Furthermore, I noticed that _rtw_pwr_wakeup() calls ips_leave(). The latter 
> > acquires the "pwrpriv->lock" Mutex. Aren't we forbidden to call Mutexes while 
> > holding Spinlocks?
> 
> Correct.  You cannot take a mutex while holding a spinlock.

Again, thanks for confirming.

> Where is the spinlock in taken in the code you're talking about?  If
> it's rtw_set_802_11_disassociate() then that's fine.  The check for
> if (check_fwstate(pmlmepriv, _FW_LINKED)) { will prevent ips_leave()
> from being called.

You're right: "if (check_fwstate(pmlmepriv, _FW_LINKED))" in _rtw_pwr_wakeup() 
will prevent a call to ips_leave(). Therefore, it seems that we have no problems
with the mutex in ips_leave(). 

I had not noticed the above-mentioned "if" test. Sorry :(
So, let's leave the code as it is.

Thank you very much.

Regards,

Fabio M. De Francesco 

> 
> > My second question is: should we substitute that Mutex with a Spinlock and use 
> > it everywhere else the struct "pwrctrl_priv" must be protected in the driver?
> 
> Changing Mutexes to spinlocks is tricky.  I can't review your proposed
> patch before you send it.
> 
> regards,
> dan carpenter
> 
> 




