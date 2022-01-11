Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC848AD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiAKMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:05:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57844 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiAKMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:05:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7035E6160D;
        Tue, 11 Jan 2022 12:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370DCC36AE3;
        Tue, 11 Jan 2022 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641902745;
        bh=XWSY+DFW6VXDZ5S5vTsdWAWmSuDV4VU9C9Uf/1Ppn+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KP/WM15M5vPgevoKKzjXbZIzAy45IeS7bUPdHmwBxTBMmLjroWWsvD/9b3OOguhha
         jt3TfpAWeTeEbuH6pmNjo9m7VmTZ2kJqZOlTvMQwCEIBoMciduq5B7DGhUQb5g40gV
         Sw89Q5V5FsVZPAh2QiWCj07d1NZs3vb+h0NMgJmg=
Date:   Tue, 11 Jan 2022 13:05:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: n_gsm: Fix SW flow control encoding/handling
Message-ID: <Yd1yl2jrrCHB+3Ww@kroah.com>
References: <AM4PR1001MB137808D63F6C99698FA02DFFE0519@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR1001MB137808D63F6C99698FA02DFFE0519@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:54:01AM +0000, Starke, Daniel wrote:
> > > According to 3GPP 27.010 chapter 5.2.7.3 DC1 and DC3 (SW flow control)
> > 
> > What is all of that?  Do you have a link to the document that this is and where it says this?
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.2.7.3 states that DC1 and DC3 data bytes
> shall be quoted to ensure transparent transmission of these bytes without
> setting software flow control. This is partly already the case in the
> current n_gsm implementation. This chapter refers also to ISO/IEC 646
> regarding the encoding of DC1 and DC3.
> 
> > > are to
> > > be treated according to ISO/IEC 646.
> > 
> > What is "ISO/IEC 646"?
> 
> ISO/IEC 646 refers to the set of ISO standards described as the ISO 7-bit
> coded character set for information interchange. Its final version is also
> known as ITU T.50. See https://www.itu.int/rec/T-REC-T.50-199209-I/en
> 
> > > That means the MSB shall be ignored.
> > 
> > "MSB"?  Please spell it out, you have plenty of room here.
> 
> MSB stands for "most significant bit" in this context.

Please put all of the above in the changelog text when you resubmit
this.

> > > This patch applies the needed changes to handle this correctly.
> > 
> > What changes are needed?  Please talk about what you are doing, as the documentation asks you to so do.
> 
> To abide the standard it is needed to quote DC1 and DC3 correctly if these
> are seen as data bytes and not as control characters. The current code
> already tries to enforces this but fails to catch all defined cases.
> 3GPP 27.010 chapter 5.2.7.3 clearly states that the most significant bit
> shall be ignored for DC1 and DC3 handling. The current implementation
> handles only the case with the most significant bit was set 0. Cases in
> which DC1 and DC3 have the most significant bit set 1 are left unhandled.
> This patch fixes this by masking the data bytes with ASCII_MASK (only the
> 7 least significant bits set 1) before comparing them with XON (a.k.a. DC1)
> and XOFF (a.k.a. DC3).

Great, again, please put this in the changelog text so that we can
properly understand it.

> > > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > > ---
> > >  drivers/tty/n_gsm.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c index 
> > > 0b96b14bbfe1..9ee0643fc9e2 100644
> > > --- a/drivers/tty/n_gsm.c
> > > +++ b/drivers/tty/n_gsm.c
> > > @@ -322,6 +322,7 @@ static int addr_cnt;
> > >  #define GSM1_ESCAPE_BITS	0x20
> > >  #define XON			0x11
> > >  #define XOFF			0x13
> > > +#define ASCII_MASK		0x7F
> > 
> > Where did "ASCII" come from?  You didn't say anything about that in the changelog.
> 
> The original version (ISO 646 IRV) differed from ASCII only in the code
> point for the currency symbol. Therefore, I used ASCII_MASK here to define
> the mask for the significant bits. I believe that this is easier to
> understand than ISO_IEC_646_MASK for example.

If this really is for ISO 646 then please use that text here.

> > >  static const struct tty_port_operations gsm_port_ops;
> > >  
> > > @@ -521,7 +522,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
> > >   *	@output: output buffer
> > >   *	@len: length of input
> > >   *
> > > - *	Expand a buffer by bytestuffing it. The worst case size change
> > > + *	Expand a buffer by byte stuffing it. The worst case size change
> > 
> > This change is not described above, and is totally different and belongs in a different change.
> 
> You are absolutely right. Shall I create a new patch?

Yes please.

> > >   *	is doubling and the caller is responsible for handing out
> > >   *	suitable sized buffers.
> > >   */
> > > @@ -531,7 +532,8 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
> > >  	int olen = 0;
> > >  	while (len--) {
> > >  		if (*input == GSM1_SOF || *input == GSM1_ESCAPE
> > > -		    || *input == XON || *input == XOFF) {
> > > +		    || (*input & ASCII_MASK) == XON
> > > +		    || (*input & ASCII_MASK) == XOFF) {
> > >  			*output++ = GSM1_ESCAPE;
> > >  			*output++ = *input++ ^ GSM1_ESCAPE_BITS;
> > >  			olen++;
> > > --
> > > 2.25.1
> > > 
> > 
> > What commit does this fix?
> 
> It fixes the initial commit for the n_gsm:
> Commit e1eaea46bb40 (tty: n_gsm line discipline, 2010-03-26)

Great, please add that to the commit when you submit it.  Also it should
go to stable kernels so please add that marking as the documentation
asks for.

> However, this patch is based on the main branch from the TTY/Serial driver
> development tree.

That branch tracks Linus's tree, not the tty/serial driver changes, so
you might want to use a different branch if you think there are going to
be conflicts.

thanks,

greg k-h
