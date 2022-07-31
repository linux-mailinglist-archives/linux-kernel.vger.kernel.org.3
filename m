Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DF2585E57
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiGaJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 05:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiGaJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:53:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10CB21208D;
        Sun, 31 Jul 2022 02:53:09 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26V9r7Nm012264;
        Sun, 31 Jul 2022 11:53:07 +0200
Date:   Sun, 31 Jul 2022 11:53:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Subject: Re: INFO: task hung in __floppy_read_block_0
Message-ID: <20220731095307.GA12211@1wt.eu>
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
 <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
 <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 01:20:33PM -0700, Dipanjan Das wrote:
> On Thu, Jul 28, 2022 at 7:23 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Dipanjan, are you really sure that you want to report a "INFO: task
> > hung" bug identified with your syzkaller instance? Especially for a
> > floppy driver, probably in your case even just an emulated one
> > (right?). Reading data from floppies was always very slow as far as I
> > remember those times...
> 
> >From the bugs reported by syzkaller in the past, we observed that
> several of these "INFO: task hung in... " reports were considered and
> acted on, for example, this:
> https://groups.google.com/g/syzkaller-bugs/c/L0SBaHZ5bYc. For the
> reported issue, we noticed the read task stays blocked for 143
> seconds, which seemed to be one the higher, especially given that it
> is an emulated floppy drive (yes, you are right). If it deems normal,
> then we do apologize for our misassesment.

FWIW I've been running the repro here on machine running 5.19-rc8 and
equipped with a real floppy drive. The code is still running as I type,
it sounds like it's destroying the floppy disk in it but after 12 minutes
of torture, nothing happens.

Thus I'm a bit confused about what to look for. It's very likely that
there are still bugs left in this driver, but trying to identify them
and to validate a fix will be difficult if they cannot be reproduced.
Maybe they only happen under emulation due to timing issues.

As such, any hint about the exact setup and how long to wait to get
the error would be much appreciated.

Thanks,
Willy
