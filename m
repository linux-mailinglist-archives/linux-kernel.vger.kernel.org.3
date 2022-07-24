Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09E57F71C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiGXUyJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 Jul 2022 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGXUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:54:07 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17857B850
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:54:06 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id C1EC480160;
        Sun, 24 Jul 2022 20:54:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 69AE06000D;
        Sun, 24 Jul 2022 20:54:00 +0000 (UTC)
Message-ID: <434188828f98c78d17cef4f62461b75f7197a67f.camel@perches.com>
Subject: Re: [PATCH] staging: r8188eu: make dump_chip_info() static
From:   Joe Perches <joe@perches.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sun, 24 Jul 2022 13:53:59 -0700
In-Reply-To: <bd498222-004a-9ac4-8c3c-4419f9ca9916@gmail.com>
References: <20220724182520.7794-1-straube.linux@gmail.com>
         <bd498222-004a-9ac4-8c3c-4419f9ca9916@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 69AE06000D
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: gzqoigbsw5mptkm5hqxrdux5ga4xycsk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18t/iqLMk8sM8i6cTxQKgHO0HPHK0FVGbo=
X-HE-Tag: 1658696040-396189
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-24 at 20:39 +0200, Philipp Hortmann wrote:
> On 7/24/22 20:25, Michael Straube wrote:
> > The function dump_chip_info() is only used in rtl8188e_hal_init.c.
> > Make it static to reduce the driver object file size by 281 bytes.
> > 
> > before:
> >    text    data     bss     dec     hex filename
> > 530606   43897    7072  581575   8dfc7 drivers/staging/r8188eu/r8188eu.o
> > 
> > after:
> >    text    data     bss     dec     hex filename
> > 530405   43817    7072  581294   8deae drivers/staging/r8188eu/r8188eu.o
[]
> > diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
[]
> > @@ -526,6 +526,45 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
> >   	Hal_EfuseReadEFuse88E(Adapter, 0, _size_byte, pbuf);
> >   }
> >   
> > +static void dump_chip_info(struct HAL_VERSION chip_vers)
> > +{
> > +	uint cnt = 0;
> > +	char buf[128];
> > +
> > +	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
> > +	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
> > +		       "Normal_Chip" : "Test_Chip");
> > +	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
> > +		       "TSMC" : "UMC");
> > +
> > +	switch (chip_vers.CUTVersion) {
> > +	case A_CUT_VERSION:
> > +		cnt += sprintf((buf + cnt), "A_CUT_");
> > +		break;
> > +	case B_CUT_VERSION:
> > +		cnt += sprintf((buf + cnt), "B_CUT_");
> > +		break;
> > +	case C_CUT_VERSION:
> > +		cnt += sprintf((buf + cnt), "C_CUT_");
> > +		break;
> > +	case D_CUT_VERSION:
> > +		cnt += sprintf((buf + cnt), "D_CUT_");
> > +		break;
> > +	case E_CUT_VERSION:
> > +		cnt += sprintf((buf + cnt), "E_CUT_");
> > +		break;
> > +	default:
> > +		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
> > +		break;
> > +	}
> > +
> > +	cnt += sprintf((buf + cnt), "1T1R_");
> > +
> > +	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
> > +
> > +	pr_info("%s", buf);
> > +}

Probably better and likely smaller without the temporary buffer
and the possibility of overrun.

Something like:

{
	char cut[25];
	char *v = NULL;

	switch (chip_vers.CUTVersion) {
	case A_CUT_VERSION:
		v = "A_CUT";
		break;
	case B_CUT_VERSION:
		v = "B_CUT";
		break;
	case C_CUT_VERSION:
		v = "C_CUT";
		break;
	case D_CUT_VERSION:
		v = "D_CUT";
		break;
	case E_CUT_VERSION:
		v = "E_CUT";
		break;
	default:
		snprintf(cut, sizeof(cut), "UNKNOWN_CUT(%d)", chip_vers.CUTVersion);
		v = cut;
		break;
	}
	
	pr_info("Chip Version Info: CHIP_8188E_%s__Chip_%s_%s_1T1R_RomVer(%d)\n",
		IS_NORMAL_CHIP(chip_vers) ? "Normal" : "Test",
		IS_CHIP_VENDOR_TSMC(chip_vers) ? "TSMC" : "UMC",
		v, 0);
}

