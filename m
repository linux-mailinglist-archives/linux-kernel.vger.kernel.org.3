Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7FE514F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378367AbiD2P3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378364AbiD2P2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:28:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84D66F8E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F7C620C4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C66C385A4;
        Fri, 29 Apr 2022 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651245931;
        bh=6oCuAEcvZ0yhbJwQ7jyHi2u+TfSAibN9CRI9KgdDZLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbA/91b/bixgBip8JXKmzzDVLtkGjXEeFZExM97aJe2n0MyxDGJp8DRcwHKbIT2z/
         pyBIOFx+ZGHKEN132CICnveJa17nDMzxTxXanrTTU0vNUdePdl2lQAOlN1GxmLB/tT
         hEJfYfQDdw0/Nav+7bdKPzj0Z2TP/1DijHRTYWB8=
Date:   Fri, 29 Apr 2022 17:25:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Message-ID: <YmwDZi3mmWRHzKAT@kroah.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com>
 <b3d6b773-4ca1-a72e-933b-455c5d2b91c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3d6b773-4ca1-a72e-933b-455c5d2b91c9@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:18:28PM +0200, Philipp Hortmann wrote:
> On 4/27/22 07:55, Greg Kroah-Hartman wrote:
> > > MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
> > >   	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
> > > @@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
> > >   	}
> > >   	if (ww == W_MAX_TIMEOUT)
> > >   		return false;
> > > -	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
> > > -	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
> > > +	low = ioread32(iobase + MAC_REG_TSFCNTR);
> > > +	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> > > +	*pqwCurrTSF = low + ((u64)high << 32);
> > Are you_sure_  this is doing the same thing?
> > 
> 
> To compare I used the following code:
> VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
> VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
> dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: %llx",
> *pqwCurrTSF);
> low = ioread32(iobase + MAC_REG_TSFCNTR);
> high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF low/high: %llx", low +
> ((u64)high << 32));
> 
> Output:
> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 1155ba
> vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    1155ba
> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 35d7cbd7c
> vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    35d7cbd7c
> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 35d7cbd8a
> vt6655 0000:01:05.0: CARDbGetCurrentTSF low/high:    35d7cbd8a
> 
> So no different results for numbers larger than 32 Bit.

And for a big endian system?  Do you get the same result?

> The pqwCurrTSF is a microsecond counter running in the WLAN Router:
> At a later Measurement I got the following values:
> 269 seconds later: 0x3 6d89 fd91 -> 269.30 seconds
> 15 minutes later: 0x3 6d89 fd91 -> 15.54 minutes
> 8:38 hours later: 0xa 9787 ad91 -> 8.62 hours
> 
> So both methods work on a AMD64 processor.
> 
> > Adding 1 to a u64 pointer increments it by a full u64.  So I guess the
> > cast to u32 * moves it only by a u32?  Hopefully?  That's messy.
> 
> That is the reason why I wanted to change this.
> 
> > Why not keep the current mess and do:
> > 	pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
> > 	((u32 *)pqwCurTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> > Or does that not compile?
> 
> drivers/staging/vt6655/card.c:760:13: warning: assignment to ‘u64 *’ {aka
> ‘long long unsigned int *’} from ‘unsigned int’ makes pointer from integer
> without a cast [-Wint-conversion]
>   760 |  pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
>       |             ^
> drivers/staging/vt6655/card.c:761:26: error: lvalue required as left operand
> of assignment
>   761 |  ((u32 *)pqwCurrTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);
>       |                          ^
> 
> This compiles:
> 	*(u32 *)pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
> 	*((u32 *)pqwCurrTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);

Heh, I just guessed :)

> Log:
> vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 178f41d90
> vt6655 0000:01:05.0: CARDbGetCurrentTSF with ioread: 178f41d90
> 
> Ick, how about:
> > 	u32 *temp = (u32 *)pqwCurTSF;
> > 
> > 	temp = ioread32(iobase + MAC_REG_TSFCNTR);
> > 	temp++;
> > 	temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> 
> This is working:
> 	u32 *temp = (u32 *)pqwCurrTSF;
> 
> 	*temp = ioread32(iobase + MAC_REG_TSFCNTR);
> 	temp++;
> 	*temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);

Nice!

thanks for testing,

greg k-h
