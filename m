Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E19493AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354602AbiASNCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:02:12 -0500
Received: from outbound5b.eu.mailhop.org ([3.125.66.160]:24796 "EHLO
        outbound5b.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354523AbiASNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:02:05 -0500
X-Greylist: delayed 96044 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jan 2022 08:02:05 EST
ARC-Seal: i=1; a=rsa-sha256; t=1642597321; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=vHfpup2E1DbwqmhQeJ8+jlFBwORwx9h1K0RnM35cSzH9LGCJtqb4owzJTszkx6M+C74AhrqmEwBA0
         rcmXeC8hJUkgbRqTXKAGv0jh7q3NdLhgsJR9u2k7CvDIq76pb97rp+8BTBGPG6IGMmwxggwPAohvRZ
         hPFnnaJpQ7fCqGFJgN5pJhSLTp1gtFAyre9rX7HOfj464zxNdSkaoCNX6la/j5L2zczuepZYCxeonF
         /apQOYl+BB65A8OrOpRTsFDMZFte7m4w2KTxdla8IKzABjRjPo7DT2Lv5KJSYBzKwjbuGccuoB7Pw0
         vHMxc6b6sljzPcBTqm/D7TOSdabCbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=c8r/igF5LndnA9H2CDXLuB0h9ElFTJCRkVRmiM0JaA8=;
        b=JxDfVeb8uO8dxeKWNAZcU/5jtrgJYLrZ5fSqhEWx0bsDeC0wXoefR0hQtyhDRTPnsPS146sc77npz
         bh1/CUSgdNxI1odZvk/iF3sJX/9PdzaDsx1D3N+jZ3CGWNW1kmjrney3mMJHuiW7YYzv9lgqpitD59
         Cq2YnEfco8QHnjomcIM4DDyvhKKxklE9rB8eQqLN5FMLIhVngIeThYrmEkPVONLVTTdABb4Q6kdLaF
         12oXIBPY5l4jlOmO1lyCzzTrkai7+MWj2IGBY8Po9Tu3K9qZELzTEOQVwGrVr90Y1kv2+DAzttlKuN
         JO1bKJB8+ZABAq32zuwZae0Jh+NSZKA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=c8r/igF5LndnA9H2CDXLuB0h9ElFTJCRkVRmiM0JaA8=;
        b=cIW020Kx5LLQrpVaGkWAZPwtPYraTHmndoUBbKJ59e9o/dQx4hdayXuyMPssZMGHB+NeN9C7dVHnR
         l5XTnxAE6+iCwAdYHFcpV5zowI0G1rVk1q899PCLlmcvFQOHHZNeR9qXnwzpoZnd4mXQ0FVEhYYBnk
         8OnY0sBrNG8IkKcE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=c8r/igF5LndnA9H2CDXLuB0h9ElFTJCRkVRmiM0JaA8=;
        b=cB4CSqr0ylyQGLc1mYdPbZm/5YDJPww2xfo+Rp9noVOgwxTr18QZ73OIsEEJm0Rz3RiCZAkpDF/3R
         F/6dwEW/QoBTtoo0q9vvT/LXGKw/QXHSG7l/kkfP90UqPGqYuZvIVkJr/EuIZjiUnf5j/fdpQtvS3p
         NfkIfOTafc0o8zRwV3Yz29zJKTjwTYHwyWbSsuWMNvBj3TFJs2MKXx9EZefKcSsZgadKkGEkJlW1y9
         QlH9WAuSV+mRu33peEJ2sJ2ZOlxA7RgodKTp5JfSArV15lG6wk1amYahA7xXb1GCcMsMg/9CQ7KRd4
         Lyt/7EKYJ1xFHOuF4N1ha8LmKFy8Gfw==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f6021dd5-7927-11ec-954c-95b64d6800c5
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound3.eu.mailhop.org (Halon) with ESMTPSA
        id f6021dd5-7927-11ec-954c-95b64d6800c5;
        Wed, 19 Jan 2022 13:01:50 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1nAAaw-0058WT-Pr; Wed, 19 Jan 2022 15:01:47 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
References: <20220119110839.33187-1-deller@gmx.de>
        <20220119110839.33187-3-deller@gmx.de> <Yef0j8+DBbwC7Kjv@kroah.com>
        <Yef15k2GtC40aJEu@kroah.com>
Date:   Wed, 19 Jan 2022 14:01:44 +0100
In-Reply-To: <Yef15k2GtC40aJEu@kroah.com> (Greg Kroah-Hartman's message of
        "Wed, 19 Jan 2022 12:28:38 +0100")
Message-ID: <87o847khfr.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Jan 19, 2022 at 12:22:55PM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Jan 19, 2022 at 12:08:39PM +0100, Helge Deller wrote:
>> > This reverts commit 39aead8373b3c20bb5965c024dfb51a94e526151.
>> > 
>> > Revert this patch.  This patch started to introduce the regression that
>> > all hardware acceleration of more than 35 existing fbdev drivers were
>> > bypassed and thus fbcon console output for those was dramatically slowed
>> > down by factor of 10 and more.
>> > 
>> > Reverting this commit has no impact on DRM, since none of the DRM drivers are
>> > tagged with the acceleration flags FBINFO_HWACCEL_COPYAREA,
>> > FBINFO_HWACCEL_FILLRECT or others.
>> > 
>> > Signed-off-by: Helge Deller <deller@gmx.de>
>> > Cc: stable@vger.kernel.org # v5.16
>> 
>> Why just 5.16?  This commit came in on 5.11 and was backported to
>> 5.10.5.
>> 
>> As for "why", I think there was a number of private bugs that were
>> reported in this code, which is why it was removed.  I do not think it
>> can be safely added back in without addressing them first.  Let me go
>> dig through my email to see if I can find them...
>
> Ah, no, that was just the soft scrollback code I was thinking of, which
> was a different revert and is still gone, thankfully :)
>
> This one was just removed because Daniel noticed that only 3 drivers
> used this (nouveau, omapdrm, and gma600), so this shouldn't have caused
> any regressions in any other drivers like you are reporting here.

I'm counting more than 3 drivers using this. I think one of the reasons
why it was reverted was that no one is actively maintaining fbdev. With
Helge now volunteering i don't see a reason why it should stay reverted.
If there are issues coming up i'm pretty sure Helge would care, and i
would probably also take a look.

/Sven
