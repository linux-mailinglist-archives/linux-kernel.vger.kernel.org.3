Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6A4AB8B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbiBGKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354316AbiBGKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:15:51 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F5C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:15:50 -0800 (PST)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 6CB1080BF7;
        Mon,  7 Feb 2022 10:15:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 2436320032;
        Mon,  7 Feb 2022 10:15:48 +0000 (UTC)
Message-ID: <a630d8381cee0f543e0d77614052e1d04ab162a5.camel@perches.com>
Subject: Re: [PATCH] staging: pi433: remove need to recompile code to debug
 fifo content
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 02:15:47 -0800
In-Reply-To: <20220207100601.GF1951@kadam>
References: <YgCj2P59AbFFmnbA@mail.google.com> <20220207100601.GF1951@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gdaiunhuo3cpojycaapn86b5yftu8f9m
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2436320032
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19ZvojUN0p0AY+LywIizjHrx1ajHsjTdOc=
X-HE-Tag: 1644228948-472664
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 13:06 +0300, Dan Carpenter wrote:
> On Mon, Feb 07, 2022 at 05:45:12PM +1300, Paulo Miguel Almeida wrote:
> > Debugging content present in the FIFO register is tricky as when we read
> > the FIFO register that changes the content of fifo struct which reduces
> > number of possible ways of debugging it. Rf69 uC has the possibility of
> > triggering certain IRQs depending on how many items are in the FIFO
> > queue, so being able to know what's in there is an important way to
> > troubleshoot certain problems.
> > 
> > This patch removes the requirement of having to compile pi433 driver
> > with DEBUG_FIFO_ACCESS set and let that be driven by printk verbositity
> > level and/or dynamic debug config instead.
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> > Meta-comments:
> > 
> > #1
> > In my mind, I didn't like the idea of having to change the code and then 
> > echo "module pi433 +p" > <debugfs>/dynamic_debug/control to only then
> > be able to read stuff being sent/retrieved from fifo. It felt somewhat
> > redundant at a certain level. On the other hand, I understand that
> > removing the conditional compilation will force a for-loop to iterate
> > for no real reason most of the time (max 66 iterations)... so I made a 
> > trade-off and in case anyone disagrees with that, just let me know and I
> > will be happy to change to a different approach.
> > 
> 
> This is fine.  It's useful information to you.  It's makes the code
> nicer by removing ifdefs.  It's not going to show up in benchmarking.
> 
> > #2
> > In the past, it's been pointed out to me during code review that I tend
> > to add code comments which could be omitted. In this case, the for-loop
> > seemed a bit odd without explaining why it's in there. Let me know if
> > you think I should keep/remove it.
> 
> Remove.  Everyone knows what dev_dbg() does and the "read from fifo"
> vs "written from[sic] fifo" is built into the function name.
> 
> >  int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
> >  {
[]
> > @@ -851,10 +844,9 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
> >  
> >  	retval = spi_sync_transfer(spi, &transfer, 1);
> >  
> > -#ifdef DEBUG_FIFO_ACCESS
> > +	/* print content read from fifo for debugging purposes */
> >  	for (i = 0; i < size; i++)
> >  		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
> > -#endif

If you use

	print_hex_dump_debug

perhaps the DEBUG_FIFO_ACCESS could be removed.


