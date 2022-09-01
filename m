Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC415A9FEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIAT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiIAT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:26:43 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830617B1C4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:26:39 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11ee4649dfcso27625115fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nUFKb0lwuoJnPBzhuuDRyGpS99t7DT6AsET+CKwieMQ=;
        b=kab0/IS7ZlINDcHCLmc50JrBFqemoC73endhL3ZpKsJ3xs4hicL9pGZtRgbHUVZHJ6
         9Np79qggyerdPcGnJ463kP4VGbE1WVilQH4gI8q2W09RSjHrThq5srLUj2g4yBnjXSbb
         kdcWybUERjlnw69YdIO9w2hmaYZltUrxsDfxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nUFKb0lwuoJnPBzhuuDRyGpS99t7DT6AsET+CKwieMQ=;
        b=4p/bfdpTGRtVQsryA3ApwX3jlo1fMvk77A/Ak/hV+y0wbqwqsY1WwGcOzJPIvYbzWC
         HS92CMcxZ+L6UKOi35eUqhXKuZcsZM//lkV09A6pyJoV64v3WrXh81z7s9XWjdciwdQH
         WRcCAxbzPRF5lyhLu17Igi4GmSjjUx+vD24LyCpAKWaxoqA/r2PBdfH/HviNKYtbpE6+
         zev5G8xn37EePiLC81hty5K8T7G5KcJUj8oe+wNuMKHzmZ501w93DUnQ6HCC9NEPZxYU
         pmK3d6fO468BMx1m5SJUOPOKHCwn6fHF0dfiRAOmE49FXunbVKIApiUN8MpBQHDuDlYo
         /V7A==
X-Gm-Message-State: ACgBeo0uH8fboBsPsgx5GUVJwRDckooI5+8ozHlZ3g8Ngyuoz4JP64dq
        PqwEmpzZ8L8h6g4ifbfIHF/JZlmhsc7RF4WqH5mMXg==
X-Google-Smtp-Source: AA6agR76Qx1UhZamCUF7S9TUTYDl6xeDAqqmTX5Bo6k+e7Hx34+fSOeUvrMaPFePMLZcsKk4Dq+ttY1jW3moMxdkm/k=
X-Received: by 2002:a54:448a:0:b0:344:99d1:1578 with SMTP id
 v10-20020a54448a000000b0034499d11578mr325859oiv.7.1662060398178; Thu, 01 Sep
 2022 12:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220830145004.430545-1-daniel.vetter@ffwll.ch> <YxCY57DmFfTuHs1q@alley>
In-Reply-To: <YxCY57DmFfTuHs1q@alley>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 1 Sep 2022 21:26:27 +0200
Message-ID: <CAKMK7uFwJumoLCddSxtd=tPoV1xLFw5uCWpY+WDtiRC=fiSedg@mail.gmail.com>
Subject: Re: [PATCH] kernel/panic: Drop unblank_screen call
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sept 2022 at 13:35, Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2022-08-30 16:50:04, Daniel Vetter wrote:
> > console_unblank() does this too (called in both places right after),
> > and with a lot more confidence inspiring approach to locking.
> >
> > Reconstructing this story is very strange:
> >
> > In b61312d353da ("oops handling: ensure that any oops is flushed to
> > the mtdoops console") it is claimed that a printk(" "); flushed out
> > the console buffer, which was removed in e3e8a75d2acf ("[PATCH]
> > Extract and use wake_up_klogd()"). In todays kernels this is done way
> > earlier in console_flush_on_panic with some really nasty tricks. I
> > didn't bother to fully reconstruct this all, least because the call to
> > bust_spinlock(0); gets moved every few years, depending upon how the
> > wind blows (or well, who screamed loudest about the various issue each
> > call site caused).
> >
> > Before that commit the only calls to console_unblank() where in s390
> > arch code.
> >
> > The other side here is the console->unblank callback, which was
> > introduced in 2.1.31 for the vt driver. Which predates the
> > console_unblank() function by a lot, which was added (without users)
> > in 2.4.14.3. So pretty much impossible to guess at any motivation
> > here. Also afaict the vt driver is the only (and always was the only)
> > console driver implementing the unblank callback, so no idea why a
> > call to console_unblank() was added for the mtdooops driver - the
> > action actually flushing out the console buffers is done from
> > console_unlock() only.
>
> My understanding is that mtdoops is not a real console. The commit
> 4b23aff083649eafa141 ("[MTD] oops and panic message logging to MTD
> device") suggests that it was just (mis)using the console
> infrastructure.
>
> The commit 2e386e4bac90554887e73d ("mtd: mtdoops: refactor as a
> kmsg_dumper") converted it to use the new kmsg_dumper API that
> was created for this use case.
>
> So, I would consider all the mtdoops-related changes as a misuse
> of the console API.

Ah, that's a good piece of information that I didn't figure out.

Greg, if you haven't baked in the patch yet, can you perhaps add the
above information from Petr to the commit message?

Thanks, Daniel

>
>
> > Note that as prep for the s390 users the locking was adjusted in
> > 2.5.22 (I couldn't figure out how to properly reference the BK commit
> > from the historical git trees) from a normal semaphore to a trylock.
> >
> > Note that a copy of the direct unblank_screen() call was added to
> > panic() in c7c3f05e341a ("panic: avoid deadlocks in re-entrant console
> > drivers"), which partially inlined the bust_spinlocks(0); call.
> >
> > Long story short, I have no idea why the direct call to unblank_screen
> > survived for so long (the infrastructure to do it properly existed for
> > years), nor why it wasn't removed when the console_unblank() call was
> > finally added. But it makes a ton more sense to finally do that than
> > not - it's just better encapsulation to go through the console
> > functions instead of doing a direct call, so let's dare. Plus it
> > really does not make much sense to call the only unblank
> > implementation there is twice, once without, and once with appropriate
> > locking.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> Nice analyze. The change makes perfect sense from my POV:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
