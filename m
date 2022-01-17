Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143334910B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiAQTdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:33:53 -0500
Received: from outbound5f.eu.mailhop.org ([3.127.8.113]:41150 "EHLO
        outbound5f.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiAQTdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:33:52 -0500
X-Greylist: delayed 2764 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 14:33:52 EST
ARC-Seal: i=1; a=rsa-sha256; t=1642445267; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=pIHjzBmtiQ9rHAaLvY6M8M4Ac9yPgBl/9lBEGDgzDXPn1yzV7hXPfxWnATDA7eP9IkHhZu/yWsxzF
         aQ3b97pNsgT1W8wP2kPGEHMP3Yvt94glN8I2lLC8KwBH7Hx7gw05UUByRpEg9yL0xrlJn3/X2K13z5
         cRrHE0EA9XiPAHqU1OJgyE2CifQZQl0UMeUml0HvfeNFTAa2ffZP6uJ1D8fnNt51A45Do3SOcrxCVa
         mFqSbuF2BWaYtujKxNBPjAEtdrDC7DyKk/gCGVMoBlNzeHQFVb1/7PiDifHaNihhWlnMOEPRG8hdpJ
         XHPRUYiuSvdLNr5Yf9u6jbkAqxCXZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=yBj8BcMjuQP7qiuUZ0Q+5lJ8U1bkxW1KcdbdfaDZJCs=;
        b=tl8w3QDXq+1rFO9iaDXHjMCS85TsX+fOhUxr1WVqw3eS3oo/xPCGBe9WX4lwi6FImhpG870ipFRXM
         0/KyoOA0nbuucxjPqPiWy7zZp32401PvGOjmNe6dYG0+qqvE1NKfcxpIAcJ8oPqk3EhS7mQi3Uxvtm
         R7RMyCTxZZKtAwHX0lBynsaKaPlXOP/zgNgeFW/H9GF7gQ9ouNE26/EJUT/YQviE/kp2wmRGHTr0vy
         PAyPuX2rmqEEOCAVWQ4xYbmYyv8JhOm7cJ83KGj4Jfskry/syPa/3JjoYq3HJTnXhRVkes6BxMHpJg
         uEkEtt8rwk8K9Orx3qvGh4+aBVfGT3A==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=yBj8BcMjuQP7qiuUZ0Q+5lJ8U1bkxW1KcdbdfaDZJCs=;
        b=s9ML5L0z92NzIsS4QFi2KB5mtBvi+EqqldoMDBpy3GoHBDZswWetvhrCI2q0cJgIg023wjqw4uZN/
         4O+gt8i6ScYSLSdrkBDv7+ol61hY+vGYyHBb13KImaxW2a3RRX1gsfM/pggH8Dod4dzXRUIPbp4FQD
         YMPDITtMsUJN1KVs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=yBj8BcMjuQP7qiuUZ0Q+5lJ8U1bkxW1KcdbdfaDZJCs=;
        b=GeFFBHSevQ4+Oh4u5i0vISbf7dUMtLIqml6fjNRSDzL2Te1n3vHZPqQb6IjiNMYwQ6V+yjrDC5aMe
         Itp0hTh061WJvtpNyPWewO+u4YuI/UVeX1r/seGIap6r7SKHVEn47Bfw7K8mTzJUHGuFLMT27pYtUD
         +H1ok8AU6u/tRctVy6x5inSWaQiwbYPqYcIZYYKP+/vku2YdT9exLHhAtJZRNAW6mGv5ArP/pbj+11
         WjJsGF+IE6vS/vgd00S4hCD/vRZd0TYSJszfhsADwMNBSUVFXq+v355T8GDYS4Jta5UCZDEgvalAA2
         hLJhTk2iL8AqvRNUzyWC//4gImvBqYg==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f3b49032-77c5-11ec-a077-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id f3b49032-77c5-11ec-a077-973b52397bcb;
        Mon, 17 Jan 2022 18:47:43 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1n9X2b-004tzm-Jh; Mon, 17 Jan 2022 20:47:41 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
References: <YeG8ydoJNWWkGrTb@ls3530>
        <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
Date:   Mon, 17 Jan 2022 19:47:39 +0100
In-Reply-To: <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de> (Thomas
        Zimmermann's message of "Mon, 17 Jan 2022 12:16:22 +0100")
Message-ID: <87bl0amc6s.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 14.01.22 um 19:11 schrieb Helge Deller:
>> The fbdev layer is orphaned, but seems to need some care.
>> So I'd like to step up as new maintainer.
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> First of all, thank you for stepping up to maintain the fbdev
> codebase. It really needs someone actively looking after it.
>
> And now comes the BUT.
>
> I want to second everything said by Danial and Javier. In addition to
> purely organizational topics (trees, PRs, etc), there are a number of
> inherit problems with fbdev.
>
>  * It's 90s technology. Neither does it fit today's userspace, not
>    hardware. If you have more than just the most trivial of graphical
>    output fbdev isn't for you.
>
>  * There's no new development in fbdev and there are no new
>    drivers. Everyone works on DRM, which is better in most
>    regards. The consequence is that userspace is slowly loosing the
>   ability to use fbdev.

That might be caused by the fact that no new drivers are accepted for
fbdev. I wrote a driver for the HP Visualize FX5/10 cards end of last
year which was rejected for inclusion into fbdev[1].

Based on your recommendation i re-wrote the whole thing in DRM. This
works but has several drawbacks:

- no modesetting. With fbdev, i can nicely switch resolutions with
  fbset. That doesn't work, and i've been told that this is not supported[2]

- It is *much* slower than fbset with hardware blitting. I would have to
  dig out the numbers, but it's in the ratio of 1:15. The nice thing
  with fbdev blitting is that i get an array of pixels and the
  foreground/background colors all of these these pixels should have.
  With the help of the hardware blitting, i can write 32 pixels at once
  with every 32-bit transfer.

  With DRM, the closest i could find was DRM_FORMAT_C8, which means one
  byte per pixel. So i can put 4 pixels into one 32-bit transfer.

  fbdev also clears the lines with hardware blitting, which is much
  faster than clearing it with memcpy.

  Based on your recommendation i also verified that pci coalescing is
  enabled.

  These numbers are with DRM's unnatural scrolling behaviour - it seems
  to scroll several (text)lines at once if it takes to much time. I
  guess if DRM would scroll line by line it would be even slower.

  If DRM would add those things - hardware clearing of memory regions,
  hw blitting for text with a FG/BG color and modesetting i wouldn't
  care about fbdev at all. But right now, it's working way faster for me.

I also tested the speed on my Thinkpad X1 with Intel graphics, and there
a dmesg with 919 lines one the text console took about 2s to display. In
x11, i measure 22ms. This might be unfair because encoding might be
different, but i cannot confirm the 'memcpy' is faster than hardware
blitting' point. I think if that would be the case, no-one would care
about 2D acceleration.

Don't get me wrong, i'm not saying there's no reason for DRM. I fully
understand why it exists and think it's a good way to go. But for system
where a (fast) local console is required without X11, fbdev might be the
better choice at the moment.

Regards
Sven

[1] https://lore.kernel.org/all/87ee7qvcc7.fsf@x1.stackframe.org/T/#m57cdea83608fc78bfc6c2e76eb037bf82017b302
[2] https://lore.kernel.org/all/87ee7qvcc7.fsf@x1.stackframe.org/T/#m46a52815036a958f6a11d2f3f62e1340a09bd981

