Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F084F604B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiDFNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiDFNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:42:30 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2B50D257
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:49:34 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 05BE2872;
        Wed,  6 Apr 2022 09:54:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id B021B32;
        Wed,  6 Apr 2022 09:54:31 +0000 (UTC)
Message-ID: <e56d9ca89544ad015c6cfabaf2859027c0dd50e5.camel@perches.com>
Subject: Re: [PATCH 1/5] staging: r8188eu: use round_up() instead of RND4()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 06 Apr 2022 02:54:30 -0700
In-Reply-To: <20220406061859.9011-2-straube.linux@gmail.com>
References: <20220406061859.9011-1-straube.linux@gmail.com>
         <20220406061859.9011-2-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B021B32
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: 9p4n6hp4bwzyho9dbps5m731my6skqgq
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18hEanTJvaHZuwtmlEzInomiVMehvlXBqI=
X-HE-Tag: 1649238871-371560
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 08:18 +0200, Michael Straube wrote:
> Use in-kernel round_up() instead of custom RND4().
[]
> diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
[]
> @@ -63,7 +63,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  				arc4_crypt(ctx, payload + length, crc.f1, 4);
>  
>  				pframe += pxmitpriv->frag_len;
> -				pframe = (u8 *)RND4((size_t)(pframe));
> +				pframe = (u8 *)round_up((size_t)pframe, 4);

Perhaps use PTR_ALIGN

				pframe = PTR_ALIGN(pframe, 4);

etc...


