Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B44C4499
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbiBYM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiBYM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:26:43 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 410E2214FAB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:26:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21PCPkfL019061;
        Fri, 25 Feb 2022 13:25:46 +0100
Date:   Fri, 25 Feb 2022 13:25:46 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Steven Rostedt'" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225122546.GB18720@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
 <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
 <20220225103239.GA18720@1wt.eu>
 <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:11:49AM +0000, David Laight wrote:
> > > But the earlier output doesn't have many different characters in it.
> > > Which is typical of the baud rate being wrong.
> > 
> > I don't think so, here's the beginning of the capture:
> > 
> >   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> >   0SI 15Nto
> >   LgtAsri[dnei00ieC nm
> >   i:0eom:Soce
> >   [ad000Ade s:ii SSLtbueludAis002h00 1)ASrPn
> >   Ars004h00 7ARrPn
> > 
> > All of these chars are within the printable set, so there's a probability
> > of ~37% per char, so even for a short string of 9 chars like the first
> > line, that's a 0.01% chance of it respecting the set. That's why for me
> > it definitely doesn't correspond to a baud rate issue. With wrong baud
> > rates you get lots of garbage in the full 8-bit range.
> > 
> > In addition there are even upper case at the beginning of the lines which
> > probably correspond to the ones that are printed on these lines.
> 
> Ok, that bit is probably output after the fifo is disabled.
> 
> But a few lines later you get:
> 
> TntiTet_TetkT t:TetyTvt:TntaTttTet TeteTvtnTntnTvtnT teT teTettTettKTeteTttnTnteTttaTttaTetKTttOTet:TvtnTvtltTntw Tnt:T tOTvt_Tnt:TvtKTntnT tsTvtsTttsTttsTttosTvtotTtt:TntrTntOTet T ttTvtKT tKT teTnttTettTntaTntdTttaT taTeteT tTtt TttrTntlTvt:TetkT tTtttTnteTttOTetkTvtsTeteT tlTttoTntoTetpTvtpTetsTvtvTvteTntOTet
> TttTetsTetsTntsTetKT t TttiTttT tnT tOTnt_TttrTtttTntKTetOTtteTnt:T tKTttpTvdoT dxTvdnTtd TedtTedoTvdiTedaTedT d Ttd:TedtTtd TeddTvdKTediTndgTednTtdgTtd TedKT snTesTtsOTesKTnstTvsOTvsTnsKTvs:Tts:TesTvs:Tns Tes T sdTts TtsoTesOTtslTesnTesKTesOTns
> TnsTesOT s T sKTesOT sKTvsOTtsTtsKTtsT sKTesTesKT sKTesOT siT stTnsaTvsaTesKTnsOT s
> TesKTnsT s TvsKTeslT sOTesT sKTtseTnseTvs_Tts_T sOTes TnsOT s T spTespTesdTesdTeseTtseTeseTt_rTe_rTv_oTes:T s:Tes:TnfwOTvfrKT fwT frTefpuTefpKTefpTvf:TnsOTvsOTnsoTvs Tvs TvsTtssTnsT sKTesTnsTvsTtsoTesmTnsgTesiTeslTtsTvsKTnsTvsOTtsT s_Tnsu
> 
> which really doesn't have enough different characters in it to be a fifo problem.
> That looks like a UART struggling to find valid start and stop bits
> on a continuous data stream that doesn't match the baud rate.
> 
> It may also be that whatever 'terminal' is being used is masking off the 0x80 bit.

That could be one option I thought about but still, that sounds quite
suspicious. You don't even get any #!:$/ etc. Or maybe the UART is
configured in 6-bit mode (most 16550 support 5-8 bits), and maybe even
the stop bit and/or parity participates.

> Another possibility is that the count of characters is about right.
> But the receiver is misaligned on the 10 bit async characters.
> Because these is no line idle, it never synchronises properly.
> ISTR a real async terminal behaving that way.
> But I think that gives a much wider range of characters - just the wrong ones.
>
> There is also a third error pattern:
> ^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[A^[[
> which might be an 'even more wrong' baud rate.

This one just looks like the Up arrow, that Steven might have pressed at
some point during the capture.

> So maybe we are both right - for different bits of the error.

:-)
... and Steven having fun reading our proposals after having made this
up entirely in preparation of the next April's fool :-)

Willy
