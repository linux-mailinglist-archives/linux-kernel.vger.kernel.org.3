Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE24C45E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiBYNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbiBYNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:17:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4B1BF91C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1F15B830AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D25C340E7;
        Fri, 25 Feb 2022 13:17:20 +0000 (UTC)
Date:   Fri, 25 Feb 2022 08:17:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225081719.7710f62e@gandalf.local.home>
In-Reply-To: <20220225122546.GB18720@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
        <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
        <20220225063637.GA18039@1wt.eu>
        <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
        <20220225103239.GA18720@1wt.eu>
        <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
        <20220225122546.GB18720@1wt.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 13:25:46 +0100
Willy Tarreau <w@1wt.eu> wrote:

> > TnsTesOT s T sKTesOT sKTvsOTtsTtsKTtsT sKTesTesKT sKTesOT siT stTnsaTvsaTesKTnsOT s
> > TesKTnsT s TvsKTeslT sOTesT sKTtseTnseTvs_Tts_T sOTes TnsOT s T spTespTesdTesdTeseTtseTeseTt_rTe_rTv_oTes:T s:Tes:TnfwOTvfrKT fwT frTefpuTefpKTefpTvf:TnsOTvsOTnsoTvs Tvs TvsTtssTnsT sKTesTnsTvsTtsoTesmTnsgTesiTeslTtsTvsKTnsTvsOTtsT s_Tnsu
> > 
> > which really doesn't have enough different characters in it to be a fifo problem.
> > That looks like a UART struggling to find valid start and stop bits
> > on a continuous data stream that doesn't match the baud rate.
> > 
> > It may also be that whatever 'terminal' is being used is masking off the 0x80 bit.  
> 
> That could be one option I thought about but still, that sounds quite
> suspicious. You don't even get any #!:$/ etc. Or maybe the UART is
> configured in 6-bit mode (most 16550 support 5-8 bits), and maybe even
> the stop bit and/or parity participates.

One thing that's not easy to demonstrate here (I could try to video it), is
that this output is the final result. It shows a bunch of other characters
as it is displayed but then the cursor goes backwards and writes over it.

But the characters that are deleted still do not make sense. When watching
it, it reminds me of the Matrix characters, but running horizontal and not
vertical.

> 
> > Another possibility is that the count of characters is about right.
> > But the receiver is misaligned on the 10 bit async characters.
> > Because these is no line idle, it never synchronises properly.
> > ISTR a real async terminal behaving that way.
> > But I think that gives a much wider range of characters - just the wrong ones.
> >
> > There is also a third error pattern:
> > ^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[
> > which might be an 'even more wrong' baud rate.  
> 
> This one just looks like the Up arrow, that Steven might have pressed at
> some point during the capture.

Yeah, sorry about that. That was the mouse wheel over my console window and
I didn't quite hit "shift" in time. "shift-mouse-up" scrolls up the
terminal window, but just "mouse-up" is the same as "up arrow", and caused
that huge string of ^[[A to appear.

> 
> > So maybe we are both right - for different bits of the error.  
> 
> :-)
> ... and Steven having fun reading our proposals after having made this
> up entirely in preparation of the next April's fool :-)


I was thinking the same thing, but this output being the joke. Someone
planning on slipping in Matrix characters for printk?

-- Steve
