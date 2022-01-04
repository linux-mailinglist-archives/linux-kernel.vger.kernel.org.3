Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87875484976
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiADUvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiADUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:51:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E976BC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:51:07 -0800 (PST)
Received: from dslb-084-059-253-200.084.059.pools.vodafone-ip.de ([84.59.253.200] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n4qlp-0001Au-6E; Tue, 04 Jan 2022 21:51:01 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n4qlo-000cOR-Hx; Tue, 04 Jan 2022 21:51:00 +0100
Date:   Tue, 4 Jan 2022 21:51:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: r8188eu: turbo scan is always off for
 r8188eu
Message-ID: <YdSzNFZ+DXX6gemR@martin-debian-1.paytec.ch>
References: <20220102175932.89127-1-martin@kaiser.cx>
 <20220102175932.89127-6-martin@kaiser.cx>
 <6d33d346-b797-aeb3-8b1b-64332e05fb87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d33d346-b797-aeb3-8b1b-64332e05fb87@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thus wrote Pavel Skripkin (paskripkin@gmail.com):

> It's a bit unrelated to the patch, but I found it while reviewing this. It's
> in the same function rtl8188e_PHY_RF6052SetCckTxPower():

> 89: 	u32 TxAGC[2] = {0, 0};
> ...
> 92	u8 *ptr;
> ...
> 129	for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
> 130		ptr = (u8 *)(&TxAGC[idx1]);
> 131		for (idx2 = 0; idx2 < 4; idx2++) {
> 132			if (*ptr > RF6052_MAX_TX_PWR)
> 133				*ptr = RF6052_MAX_TX_PWR;
> 134			ptr++;
> 135		}
> 136	}


> What is going on here? Code just checks and writes to random place on stack
> outside TxAGC array? I might be missing something, but it looks wrong...

TxAGC is two 32-bit values, i.e. 2 x 4 Bytes. The outer loop selects a
32-bit array entry, the inner loop iterates over each byte of this entry
and checks that it is <= RF6052_MAX_TX_PWR. I don't think this writes past
the end of the TxAGC[] array.

The rtlwifi driver contains a similar check in
rtl92ce_phy_rf6052_set_cck_txpower().

Best regards,
Martin
