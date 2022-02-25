Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78534C3D82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiBYFHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBYFHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:07:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E9216F956
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:07:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c9so3873731pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JbA4uogSRFlFWYCTaeCRBG+DmJ6BBRvbCTJcEPNgbT4=;
        b=Ha/ZeC9h2KHOqwZ/jX/IYs/hGEk24Oxp0x8qRDPzcYKn3mbQr9Z83PeLTH5c+kTlcI
         s84kbd/kpe1nGhtbDsbbxf5XYTAJC6M4okwxxJcYr91962ivmJBkJtr8onNSdqiVCGIX
         Quyujg1J8nwaZFhjsJLpTjIhYCjdZsyP37RO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JbA4uogSRFlFWYCTaeCRBG+DmJ6BBRvbCTJcEPNgbT4=;
        b=sC2JlR8v5WvkO5hFRahjJ1IVdYsm9/gtBFxcXFemAToD8G0K0Fppd59/bkT1Ay4MfQ
         X4vCjbvrJTYeX8vUqntLoCUcoVJkn2+2WkLvYTVPuUj48dqcGj9lh19ZoCrSmhCHF+3e
         kPgzWDvmPZOi6Ndsovvi0iDNNRWsQMEqQu23qwo2f7ej1coz3657+Vho09MFvSVDswYD
         bDfB6s4KRCde3qGJ4c9W/LmtRQAVZN/wl058PpR+XoXkFgxvfBjK9a2xlCEBpHBKGN4J
         shg1Yz80Jp/po11djKS5xeuTuUewkI+7Lv8DQvdLWNEVnlz2P8f48eh/fZOC7HxBKt+2
         5HGg==
X-Gm-Message-State: AOAM532TycNRgHmvdPprQAl9w0FRwGklMvm5c/3QJf+sg01T9DDT27a5
        6PyEjnBbyhsAHLfarkH8lYiXuA==
X-Google-Smtp-Source: ABdhPJzx/VcXI5LCD6w+mRHT/iJBc+sp3EjRUNKol+ePPfnN0x1if1vvs1rM+9smOW5F2aWY/nWsfg==
X-Received: by 2002:a17:902:ef4c:b0:14f:7548:dae3 with SMTP id e12-20020a170902ef4c00b0014f7548dae3mr5843206plx.92.1645765625389;
        Thu, 24 Feb 2022 21:07:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e94f:9f5e:13f6:a198])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7615801pjc.56.2022.02.24.21.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:07:04 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:07:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: Strange output on the console
Message-ID: <Yhhj9MLZTrhjSWUE@google.com>
References: <20220224230035.36547137@gandalf.local.home>
 <Yhhh730RX1HpdXp2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhhh730RX1HpdXp2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/25 13:58), Sergey Senozhatsky wrote:
> On (22/02/24 23:00), Steven Rostedt wrote:
> > I've been noticing that my tests have been spitting out strange output on
> > the console. It would happen at boot up and then clear up. It looks like
> > something screwed up with the serial timing.
> > 
> > Attached is a dmesg of one of my test runs as an example.
> > 
> > I've noticed this on both 32 bit and 64 bit x86.
> > 
> > I haven't had time to look deeper into this, but I figured I let you know
> > about it.
> > 
> > And it always seems to happen right after:
> > 
> >   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > 
> > Maybe this is a serial issue and not a printk one? :-/
> 
> Steven, did you notice this recently?
> May I perhaps suggest git bisect? (sorry)

On the off chance - do you have this revert in your kernel?

commit 6a7b9f002eca6788d346c16a6ff0c218b41f8d1d
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Jan 26 14:33:58 2022 +0100

    Revert "tty: serial: Use fifo in 8250 console driver"

    This reverts commit 5021d709b31b8a14317998a33cbc78be0de9ab30.

    The patch is still a bit buggy, and this breaks some other hardware
    types.  It needs to be resubmitted in a non-buggy way, and make sure the
    other hardware types also continue to work properly.

