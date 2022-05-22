Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583695305BA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiEVUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiEVUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:03:14 -0400
Received: from relay3.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEC25E8E
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:03:13 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 2634260B55;
        Sun, 22 May 2022 20:03:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id A0F0D20025;
        Sun, 22 May 2022 20:03:10 +0000 (UTC)
Message-ID: <1cac230f14153984edd5f0d165e8a84b639a6796.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix placement of braces
From:   Joe Perches <joe@perches.com>
To:     Hannes Braun <hannesbraun@mail.de>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fabioaiuto83@gmail.com, dan.carpenter@oracle.com
Date:   Sun, 22 May 2022 13:03:09 -0700
In-Reply-To: <20220522160611.11568-1-hannesbraun@mail.de>
References: <20220522160611.11568-1-hannesbraun@mail.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: 6ua9cqmom4rs96sdb8ixp933xet65fsp
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A0F0D20025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18/nk59qmga1g3JBhfqW2j83L1m6xF5gPk=
X-HE-Tag: 1653249790-524552
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-22 at 18:06 +0200, Hannes Braun wrote:
> This patch should eliminate the following errors/warnings emitted by
> checkpatch.pl:
> - that open brace { should be on the previous line
> - else should follow close brace '}'
> - braces {} are not necessary for single statement blocks
[] 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
[]
> @@ -746,20 +719,17 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
[]
>  	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
>  	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
> -	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
> -	{
> +	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
>  		if (param->u.crypt.idx >= WEP_KEYS
>  			|| param->u.crypt.idx >= BIP_MAX_KEYID
> -		)
> -		{
> +		) {

This one's a bit of an oddity as the close paren and open brace
should be on the line above.

additional trivia:

The tests could be changed in a separate patch to something like:

	if (is_broadcast_ether_addr(param->sta_addr)) {
		if (param->u.crypt.idx >= WEP_KEYS ||
		    param->u.crypt.idx >= BIP_MAX_KEYID) {

or maybe

	if (is_broadcast_ether_addr(param->sta_addr)) {
		if (param->u.crypt.idx >= min(WEP_KEYS, BIP_MAX_KEYID)) {


