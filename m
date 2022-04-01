Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7980A4EF8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbiDAR23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346717AbiDAR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:28:28 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7838C1DDFEC;
        Fri,  1 Apr 2022 10:26:37 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 50DEFC0003;
        Fri,  1 Apr 2022 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648833995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/HOAWD9NQve0+L1ZUrgJcxvj4WZhxF2ITTY20w8QMk=;
        b=jkzztuWaNF9oeDSwd2ZW7StnstfMLQ+rd4rUWYvZ42+pxWpliYsgtBaPMfFqPLlvj1OV5U
        Qn5bCU5FotcshvJSeQBON8jMdI4XPJgZthg3SRv1QGzWo4tgchx0hKbNExew8MonW66wez
        ywxaqmLAXy9QxWrE1Kad+Ewci+U15uhhV+UYXFXF23AtRMuhTtqft7VQAWnfy1hDU5dpsm
        R7UnSmBzVx5EqN0vIlDyDN/J0CM1rOzvBe4dBy+cGAL9b8gDYrqv43pHN1OAN0gxtdlSlD
        4f8SnvNdWRXfv6HerillumQH6a+D+ni1IUSPJBQlUjSwUXlGszyUk4FB/KQ+ig==
Date:   Fri, 1 Apr 2022 19:26:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTC for 5.18
Message-ID: <Ykc1y1yQC3Z059Uo@mail.local>
References: <YkYpfK5ubwafd+Rw@mail.local>
 <CAHk-=wjuUZWMeUaTGtfivNQYeuqsQb2C4HnbbPLe+qFXU5Y70Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuUZWMeUaTGtfivNQYeuqsQb2C4HnbbPLe+qFXU5Y70Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 09:50:30-0700, Linus Torvalds wrote:
> On Thu, Mar 31, 2022 at 3:21 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Here is the RTC subsystem pull request for 5.18. The bulk of the patches
> > are about replacing the uie_unsupported struct rtc_device member by a
> > feature bit.
> 
> Hmm.
> 
> I've pulled this, but I don't see the point of the ALARM_RES_2S bit.
> 
> In particular, I don't see it used anywhere, and the two drivers that
> now set it clear both the UPDATE_INTERRUPT and ALARM features.
> 
> So what's the point of that feature bit?
> 

The features member is exposed to userspace which will be the main
consumer in order to know what to expect from a particular RTC.

ALARM_RES_2S could also be used to forbid setting the alarm for two
consecutive seconds but this is not yet implemented as you observed.
This is not the most pressing issue but currently it is allowed and you
will not get any interrupt from the RTC for the second alarm so this is
silently ignored.
Note that these two are probably not the only ones that are affected,
those are the ones I did test.

Regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
