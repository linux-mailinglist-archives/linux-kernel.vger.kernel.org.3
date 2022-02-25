Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D704C463D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiBYN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiBYN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:26:37 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31A8C202890
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:26:04 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21PDPfo3019237;
        Fri, 25 Feb 2022 14:25:41 +0100
Date:   Fri, 25 Feb 2022 14:25:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225132541.GD18720@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
 <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
 <20220225103239.GA18720@1wt.eu>
 <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
 <20220225122546.GB18720@1wt.eu>
 <20220225081719.7710f62e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225081719.7710f62e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:17:19AM -0500, Steven Rostedt wrote:
> On Fri, 25 Feb 2022 13:25:46 +0100
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > > TnsTesOT s T sKTesOT sKTvsOTtsTtsKTtsT sKTesTesKT sKTesOT siT stTnsaTvsaTesKTnsOT s
> > > TesKTnsT s TvsKTeslT sOTesT sKTtseTnseTvs_Tts_T sOTes TnsOT s T spTespTesdTesdTeseTtseTeseTt_rTe_rTv_oTes:T s:Tes:TnfwOTvfrKT fwT frTefpuTefpKTefpTvf:TnsOTvsOTnsoTvs Tvs TvsTtssTnsT sKTesTnsTvsTtsoTesmTnsgTesiTeslTtsTvsKTnsTvsOTtsT s_Tnsu
> > > 
> > > which really doesn't have enough different characters in it to be a fifo problem.
> > > That looks like a UART struggling to find valid start and stop bits
> > > on a continuous data stream that doesn't match the baud rate.
> > > 
> > > It may also be that whatever 'terminal' is being used is masking off the 0x80 bit.  
> > 
> > That could be one option I thought about but still, that sounds quite
> > suspicious. You don't even get any #!:$/ etc. Or maybe the UART is
> > configured in 6-bit mode (most 16550 support 5-8 bits), and maybe even
> > the stop bit and/or parity participates.
> 
> One thing that's not easy to demonstrate here (I could try to video it), is
> that this output is the final result. It shows a bunch of other characters
> as it is displayed but then the cursor goes backwards and writes over it.
> 
> But the characters that are deleted still do not make sense. When watching
> it, it reminds me of the Matrix characters, but running horizontal and not
> vertical.

Ah, so 6-bit might definitely make sense.

> > ... and Steven having fun reading our proposals after having made this
> > up entirely in preparation of the next April's fool :-)
> 
> 
> I was thinking the same thing, but this output being the joke. Someone
> planning on slipping in Matrix characters for printk?

;-)

Willy
