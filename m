Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658BA485A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbiAEUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:35:01 -0500
Received: from mail.hugovil.com ([162.243.120.170]:38914 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiAEUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H3KgQEFEzlVSWZjCPwUV0O4gZ4vCXsaEZeVb9qiIW98=; b=yggFvQM/T9Q/PSZUyyeD4fhgNt
        svyrJJ7Laasc4TvmS6WOrceYKymjzNDSadnTiR0q/77L4krS6av5vsUGr5NsT+xJge+bmCtnGUqPv
        xD/KSpkb19Nz+D44/gtuU8wxN2wcpEd2afqlW7+A2O0b+F2sKD6l2labD0Oy+Qpv10CQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53878 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1n5Cze-0002I5-Ob; Wed, 05 Jan 2022 15:34:47 -0500
Date:   Wed, 5 Jan 2022 15:34:46 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20220105153446.82214b48a4c77ec960ce03f3@hugovil.com>
In-Reply-To: <YdX5BocOfHE/0twa@piout.net>
References: <20220105193440.151359-1-hugo@hugovil.com>
        <YdX5BocOfHE/0twa@piout.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: bootlin.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.1 NICE_REPLY_A Looks like a legit reply (A)
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] rtc: isl1208: avoid unnecessary rc variable tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 21:01:10 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 05/01/2022 14:34:39-0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The rc variable doesn't need to be tested a second time when the <if> block
> > evaluates to false.
> > 
> 
> rc is not tested a second time, here is the relevant listing:
> 
> -	if (client->irq > 0)
> +	if (client->irq > 0) {
>  ffffffff81aef647:	41 8b b5 bc 01 00 00 	mov    0x1bc(%r13),%esi
>  ffffffff81aef64e:	85 f6                	test   %esi,%esi
>  ffffffff81aef650:	0f 8f 35 01 00 00    	jg     ffffffff81aef78b <isl1208_probe+0x314>
>  		rc = isl1208_setup_irq(client, client->irq);
>  	if (rc)
>  		return rc;
> +	}
>  
> -	if (evdet_irq > 0 && evdet_irq != client->irq)
> +	if (evdet_irq > 0 && evdet_irq != client->irq) {
>  ffffffff81aef656:	85 db                	test   %ebx,%ebx
>  ffffffff81aef658:	7e 0d                	jle    ffffffff81aef667 <isl1208_probe+0x1f0>
>  ffffffff81aef65a:	41 39 9d bc 01 00 00 	cmp    %ebx,0x1bc(%r13)
> @@ -1663,6 +1664,7 @@ ffffffff81aef661:	0f 85 0a 01 00 00
>  		rc = isl1208_setup_irq(client, evdet_irq);
>  	if (rc)
>  		return rc;
> +	}
> 
> As you can see, no change in assembly but it is worse to read. gcc on
> arm behaves the same way.

Hi Alexandre,
I am not sure that I fully understand your assembly code analysis. Maybe my patch comment was misleading, because I am not talking about a redundant test inside the if block, but ouside of it (after it).

Here is the original code with my annotations. Let's assume that the variable client->irq = 0:

---
/* If client->irq = 0, then function isl1208_setup_irq() will not be called, and rc will not be modified: */
if (client->irq > 0)
	rc = isl1208_setup_irq(client, client->irq);

/* If rc hasn't been modified, there is no need to re-test its value here: */
if (rc)
	return rc;
---

After the patch, this code section becomes:

---
if (client->irq > 0) {
	rc = isl1208_setup_irq(client, client->irq);
	if (rc)
		return rc;
}
---

For me it is more logical and clearer like this. Moreover, you can see that at line 873 of the original driver, the same kind of mechanism is used:

---
if (isl1208->config->has_timestamp) {
	rc = rtc_add_group(isl1208->rtc, &isl1219_rtc_sysfs_files);
	if (rc)
		return rc;
}
---

Regards,
Hugo.


> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-isl1208.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> > index 182dfa605515..c7f04df5a0b6 100644
> > --- a/drivers/rtc/rtc-isl1208.c
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -880,15 +880,17 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (client->irq > 0)
> > +	if (client->irq > 0) {
> >  		rc = isl1208_setup_irq(client, client->irq);
> > -	if (rc)
> > -		return rc;
> > +		if (rc)
> > +			return rc;
> > +	}
> >  
> > -	if (evdet_irq > 0 && evdet_irq != client->irq)
> > +	if (evdet_irq > 0 && evdet_irq != client->irq) {
> >  		rc = isl1208_setup_irq(client, evdet_irq);
> > -	if (rc)
> > -		return rc;
> > +		if (rc)
> > +			return rc;
> > +	}
> >  
> >  	rc = devm_rtc_nvmem_register(isl1208->rtc, &isl1208->nvmem_config);
> >  	if (rc)
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
