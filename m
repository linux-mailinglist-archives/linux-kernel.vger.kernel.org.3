Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31D56B384
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiGHH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiGHH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:29:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C597B371;
        Fri,  8 Jul 2022 00:29:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s128so11351727oie.10;
        Fri, 08 Jul 2022 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqDGYB2ZlAdYkNMvFd6Ayqwfz0mqZucM34tUZPUG1Us=;
        b=R6vyxjgrOBxJy/RCXfqquYq/iCG4Gn10idHi9TUCPWWes5QMNS2UsZ3drdbbtrlSHm
         t+ZIBDy0VsbmnMsrt+tBTsZVc8rBm+xMu8vKKx2dzBSYeTJ9lCzr/JmGFfZ91IUMEzEg
         HzbUElzis4lq8RQVp85gieJZijBrn+rYPKCaiWuv6NyeiTGP/ay++fDwUE3xwJnp1Y5i
         oiUmOZcIKdvdazLV35kcPC1VEUXce0tNro8WJaqMfc8/d8q5V2HIXGLCrlE41WI/Doq0
         9BOh7jAhd0PQS+VyARpbZn/rBjr0wasgkFDEoTvDTPjioLr6mqNfgeW75YBN0Agw3aR1
         a1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqDGYB2ZlAdYkNMvFd6Ayqwfz0mqZucM34tUZPUG1Us=;
        b=SBuQv5oEnGdv7cuIMbT/n0QhCHn1o8BKLR7M71qGaWOSXcXb9AsMy/dcuPoX14Qvlc
         TTdOOmB6y/cr/fSm7mFXNKIkCf4QAz7dDSOFzFBnSmrxAgXkFJ+0p87v1od8b6qz0ihJ
         9fLlFsLsRqQ7sG3rLcw4hNWDQyTYlA1jlIIafknjAwBZ/B2wpVJG3WMG8lHGIkRgW5Ko
         Tl31B7ljqzBRE6nx0YMjrfiTPFsfzVA685yGukhJJkvBJ7IdycgJHiQWvrRCzgBcLW9h
         QahkbauCFmVdS4JblwufB6Qv6PNp0zboJmKaOIyDCplGZ4Bsk4TtXaMJmEnjYOI7lqiI
         5+iw==
X-Gm-Message-State: AJIora+EjJ5lvUfQ+ujyj8PZhVHuTK8fNB43q5YpTAHZJoYUImU5YBLe
        ebzU1jFucTc0aaz7bteB2JRtcBATJv4eaGPWNAQ=
X-Google-Smtp-Source: AGRyM1t7P4KOphW//PbZ3donZNYvZfjhA3SSuSfTX1plQv2+xKHqyHnud79z1+8clasW0VDOoFzl0Q7NuaEqWsoxJDw=
X-Received: by 2002:a05:6808:148b:b0:335:8f41:3ab0 with SMTP id
 e11-20020a056808148b00b003358f413ab0mr1061698oiw.172.1657265379601; Fri, 08
 Jul 2022 00:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220708070645.6130-1-jomajm@gmail.com> <YsfacfpE+h/GLTC4@kroah.com>
In-Reply-To: <YsfacfpE+h/GLTC4@kroah.com>
From:   "Jozo M." <jomajm@gmail.com>
Date:   Fri, 8 Jul 2022 09:29:28 +0200
Message-ID: <CA+BOZ0vfn_qcinsiKgpLxLKCzEMJHt9DP9Y8S9ONe8z_D80JuQ@mail.gmail.com>
Subject: Re: [PATCH] gadgetfs: ep_io - wait until IRQ finishes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>, Hangyu Hua <hbh25y@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

pi 8. 7. 2022 o 9:19 Greg Kroah-Hartman <gregkh@linuxfoundation.org> nap=C3=
=ADsal(a):
>
> On Fri, Jul 08, 2022 at 09:06:44AM +0200, Jozef Martiniak wrote:
> > after usb_ep_queue() if wait_for_completion_interruptible() is
> > interrupted we need to wait until IRQ gets finished.
> >
> > Otherwise complete() from epio_complete() can corrupt stack.
> >
> > Signed-off-by: Jozef Martiniak <jomajm@gmail.com>
>
> What commit id does this fix?
>
> thanks,
>
> greg k-h
