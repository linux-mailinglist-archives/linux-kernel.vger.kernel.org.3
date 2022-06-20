Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5255158C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiFTKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbiFTKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:13:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB113DEC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:13:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso9882029pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z21gJDBz+/e/yL0nifaa2vwAc9o2edhVlm8S1yTu95I=;
        b=kcHTLg7RgJMawzs3S7C4B4EqaDwaQPnG43f+MF/r3Nbvp4D0tiyEPbITC3ta7I7o9I
         9NXbOU7Jlqk7NbGLQzM/l/NcYVMP+0rwY2NVWafT/iY6aA7aONkwq/azSUiX//OGFCK7
         Bdd/Elkc+sBGiWwFtChg5zS1k84HCK3HOurBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z21gJDBz+/e/yL0nifaa2vwAc9o2edhVlm8S1yTu95I=;
        b=T6u/UiUA3S3HzQpv1l+8FRFgvSicrzciUnVl0Fed7Z1f65WiOcfpIrN6ym+UDo6BNw
         CbJuImZyj+lrFt7WKaBRJkYqwSA7dBOnAFtJCCD2VwSZT3IkQeJLTKiJdvp/GTL08m6B
         6/spwQZU+A+qYqKe3Ir3k5fwfadjL7ftyA/3QcHwPNzWkF+aXn4oeCTz0ySUIvpezJj1
         SIvg9+5AyGSlZaheGc1qN9ZY0Tk2JBrBzVam/d45n7pBs3eFS6iPplejvByadyePnsrK
         bDdalJkkFgVL1q9ZWdJG2KnTYpYtDDtKofREnBwIwcHXN7AKbCUkoyYRw1tfQz/YTozu
         ertQ==
X-Gm-Message-State: AJIora/lLGuGdnR+45rHOwH05CQByrdWItdpuCHptHgOChDYnlsaX1aR
        jnA4dB1JShYY9mJUL5zMW8WYoQ==
X-Google-Smtp-Source: AGRyM1vCJHuC2W4v8uRR42/q9Ryt22IoRnv4kwt7mVdSaglOa1POvPq65FmX0P0an779Z6e44wtZeg==
X-Received: by 2002:a17:90b:33d2:b0:1ea:b599:9e89 with SMTP id lk18-20020a17090b33d200b001eab5999e89mr25913130pjb.88.1655720022020;
        Mon, 20 Jun 2022 03:13:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7080:f919:392f:bc5c])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902680400b001640aad2f71sm8294955plk.180.2022.06.20.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 03:13:41 -0700 (PDT)
Date:   Mon, 20 Jun 2022 19:13:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
Message-ID: <YrBIURn7lxykWghw@google.com>
References: <20220619204949.50d9154d@thinkpad>
 <YrAEUM20n3Rc4aOn@google.com>
 <20220620120234.5a65ac97@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620120234.5a65ac97@thinkpad>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/20 12:02), Marek Behún wrote:
> > On (22/06/19 20:49), Marek Behún wrote:
> > [..]
> > > causes a regression on arm64 (Marvell CN9130-CRB board) where the
> > > system boot freezes in most cases (and is unusable until restarted by
> > > watchdog), or, in some cases boots, but the console output gets mangled
> > > for a while (the serial console spits garbage characters).  
> > 
> > Can you please try disabling console kthreads and see how the boot
> > process goes? Just `return 0` from printk_activate_kthreads() (I think
> > this should do the trick).
> 
> This indeed makes the problem go away...

Oh... OK. Didn't expect that :)

> > > The garbage example:
> > > 
> > >   ...
> > >   [    0.920951] raid6: using neon recovery algorithm
> > >   [    0.921228] iommu: Default domain type: Translated
> > >   %
> > > 
> > >           gb@k+cFL/[    4.954974] DSA: tree 0 setup
> > >   [    4.955286] cfg80211: Loading compiled-in X.509 certificates for regulatory database  
> > 
> > This is pretty suspicious. I don't see how console kthreads would
> > corrupt the output. I suspect that something else is going on, some
> > memory corruption, etc.
> 
> Maybe multiple threads are writing to serial registers, or something...

That's possible. Console drivers usually should grab port->lock for
write(), but maybe something is missing in the driver you use. What
console driver are you using?
