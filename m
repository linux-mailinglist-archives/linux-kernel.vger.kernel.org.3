Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DFA4B0925
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiBJJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:07:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBJJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:07:21 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E997103B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:07:22 -0800 (PST)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 500C621737;
        Thu, 10 Feb 2022 09:07:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 5283220024;
        Thu, 10 Feb 2022 09:07:20 +0000 (UTC)
Message-ID: <a940cf331d493c8755454e8557c2330901e30986.camel@perches.com>
Subject: Re: [PATCH] media: si21xx: use time_after_eq() instead of jiffies
 judgment
From:   Joe Perches <joe@perches.com>
To:     Qing Wang <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Feb 2022 01:07:19 -0800
In-Reply-To: <1644481917-14908-1-git-send-email-wangqing@vivo.com>
References: <1644481917-14908-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5283220024
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: k5czy5bajfy3ohaj8xg4h143sxiw5dfz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+L0e1w6UKfCZc20sVn7oLYC2iZ5VFaWrI=
X-HE-Tag: 1644484040-566136
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-10 at 00:31 -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> It is better to use time_xxx() directly instead of jiffies judgment
> for understanding.
[]
> diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
[]
> @@ -336,7 +336,7 @@ static int si21xx_wait_diseqc_idle(struct si21xx_state *state, int timeout)
>  	dprintk("%s\n", __func__);
>  
>  	while ((si21_readreg(state, LNB_CTRL_REG_1) & 0x8) == 8) {
> -		if (jiffies - start > timeout) {
> +		if (time_after(jiffies, start + timeout)) {
>  			dprintk("%s: timeout!!\n", __func__);
>  			return -ETIMEDOUT;
>  		}

Appreciate all the conversions (IMO it should have been sent as
a block of patches with a cover letter instead of independent
unrelated patches) but wouldn't all of these be simpler and more
consistent using a style where the addition is done once and the
timeout test is something like:

	unsigned long end = jiffies + timeout;

	while (foo) {
		if (time_after(jiffies, end)) {
			error_msg(...)
			return -ETIMEDOUT;
		}
		bar...;
	}


		

