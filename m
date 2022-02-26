Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE44C5358
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 03:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiBZCVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 21:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZCVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:21:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBABC46143
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:21:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so6439328pjw.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LVx2Sgx3Uey6cinUD9sMnwcdDXIpFfi7NKSddzh5F5A=;
        b=MgkfcBYC2hgXx9X2CcsC3AnyJCiXla5DlZjhJPNL9EIkNyKPSAhhMO0be+kj/jDlG5
         Uh+b7nKBtrpyJb59vWf5PDdHVIi9+pd0LyF9WFzXz/yNLyRnxMPaSl2SX2I58gReEoXB
         ix+qsN35XrbmzMQQykYmvkSRqynUto0im0Gy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVx2Sgx3Uey6cinUD9sMnwcdDXIpFfi7NKSddzh5F5A=;
        b=0Gwf8dm//YtyBkS6hNGGLGLDV0kG/dtUZT3x2W9LFhTIUgyAm1Bq/YjiPThlxLDVv1
         3/8tb4W9sz2SndnlY0yp+O4OIV7sd5DTx3RQ56WT3nLhjxnrLhnpeUPZkWIhSP6OVWqy
         DkjgkQtIZrGtAYyXUe6FTrSqY021dQFKStuNZGiX7TxS3CG5TKZfuvns+jo+O0tUP/iJ
         c5EqHgHpbF3kkufyzl2qV8k4D26Cmah7f7T4Yd4l86ZAzbUV1Dw3gR9aG8jVNDmxkeVN
         k3zDjWsVRCDtKwFUuZlM5wTH6RW4dobZf5wmu74itlzBZWfNnvP9iNf9Vkp1x+33ZnR/
         WrtQ==
X-Gm-Message-State: AOAM532dKPWD61VvJ093km4xs3qPlhuOWyQr/1HplxD75Rc3pGyRvURP
        NjHd4i4QVphhNPpqN9hncqWmdQ==
X-Google-Smtp-Source: ABdhPJyF4RqZNQp4GPg1I0kpGz0bHVs34UC/ZUUqPWUBsLge+VOm1OgGtIr+4udOKYD8KP4OBhHyiQ==
X-Received: by 2002:a17:902:694c:b0:14f:bb61:e7bf with SMTP id k12-20020a170902694c00b0014fbb61e7bfmr9733187plt.159.1645842063293;
        Fri, 25 Feb 2022 18:21:03 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d7ef:f0a2:708b:c03e])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b004f1063290basm4776269pfu.15.2022.02.25.18.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 18:21:02 -0800 (PST)
Date:   Sat, 26 Feb 2022 02:20:57 +0000
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Willy Tarreau <w@1wt.eu>,
        David Laight <David.Laight@aculab.com>
Subject: Re: Strange output on the console
Message-ID: <YhmOifZcbbxVHPr9@google.com>
References: <20220224230035.36547137@gandalf.local.home>
 <Yhhh730RX1HpdXp2@google.com>
 <Yhhj9MLZTrhjSWUE@google.com>
 <20220225083209.24bafe2c@gandalf.local.home>
 <20220225084256.071dcf82@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225084256.071dcf82@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/25 08:42), Steven Rostedt wrote:
> On Fri, 25 Feb 2022 08:32:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 25 Feb 2022 14:07:00 +0900
> > Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > 
> > > > Steven, did you notice this recently?
> > > > May I perhaps suggest git bisect? (sorry)    
> > > 
> > > On the off chance - do you have this revert in your kernel?
> > > 
> > > commit 6a7b9f002eca6788d346c16a6ff0c218b41f8d1d
> > > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Date:   Wed Jan 26 14:33:58 2022 +0100
> > > 
> > >     Revert "tty: serial: Use fifo in 8250 console driver"
> > > 
> > >     This reverts commit 5021d709b31b8a14317998a33cbc78be0de9ab30.
> > > 
> > >     The patch is still a bit buggy, and this breaks some other hardware
> > >     types.  It needs to be resubmitted in a non-buggy way, and make sure the
> > >     other hardware types also continue to work properly.  
> > 
> > My tree does not have this.
> > 
> > I just applied it and I'm building now. I'll let you know if this fixes the
> > issue or not.
> 
> Mystery solved. Thanks Sergey!

Awesome!
