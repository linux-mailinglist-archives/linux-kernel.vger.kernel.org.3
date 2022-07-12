Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196615720D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiGLQ3F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiGLQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:29:04 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61812186E0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:29:03 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id E30C820B3C;
        Tue, 12 Jul 2022 16:29:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 4B43920028;
        Tue, 12 Jul 2022 16:29:00 +0000 (UTC)
Message-ID: <ae73d34782af7863e4b18495c0588a8cc2162612.camel@perches.com>
Subject: Re: [PATCH 07/14] staging: r8188eu: use memcpy for fallback mac
 address
From:   Joe Perches <joe@perches.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 09:28:59 -0700
In-Reply-To: <20220709171000.180481-8-martin@kaiser.cx>
References: <20220709171000.180481-1-martin@kaiser.cx>
         <20220709171000.180481-8-martin@kaiser.cx>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4B43920028
X-Stat-Signature: oj7uq6uyeisa5r3gw86hiydg97epe8g8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19xz+taaDiYxlTIHETqVSygWk1WwRKmgZk=
X-HE-Tag: 1657643340-379244
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-09 at 19:09 +0200, Martin Kaiser wrote:
> Use memcpy to store the fallback mac address in eeprom->mac_addr. Do not
> copy byte by byte.
[]
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
[]
> @@ -912,13 +912,11 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
>  
>  static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
>  {
> -	u16 i;
>  	u8 sMacAddr[6] = {0x00, 0xE0, 0x4C, 0x81, 0x88, 0x02};

static const sMacAddr[ETH_ALEN] = {...};

But maybe this should use eth_random_addr instead as there might
be more than one of these in a network.

>  	struct eeprom_priv *eeprom = &adapt->eeprompriv;
>  
>  	if (AutoLoadFail) {
> -		for (i = 0; i < 6; i++)
> -			eeprom->mac_addr[i] = sMacAddr[i];
> +		memcpy(eeprom->mac_addr, sMacAddr, ETH_ALEN);
>  	} else {
>  		/* Read Permanent MAC address */
>  		memcpy(eeprom->mac_addr, &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);

So perhaps something like:

{
	static const u8 sMacAddr[ETH_ALEN] = {
		0x00, 0xE0, 0x4C, 0x81, 0x88, 0x02
	};

	/* Not ether_addr_copy - EEPROM_MAC_ADDR_88EU isn't __aligned(2) */

	memcpy(adapt->eeprompriv.mac_addr,
	       AutoLoadFail ? sMacAddr : &hwinfo[EEPROM_MAC_ADDR_88EU],
	       ETH_ALEN);
}

or maybe:

{
	if (AutoLoadFail)
		eth_random_addr(adapt->eeprompriv.mac_addr);
	else
		memcpy(adapt->eeprompriv.mac_addr,
		       &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);

