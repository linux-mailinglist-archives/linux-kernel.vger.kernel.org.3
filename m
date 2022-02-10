Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0F4B17FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbiBJWMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:12:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbiBJWMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:12:48 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC90AF29;
        Thu, 10 Feb 2022 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=coFWpLgo9twhuhd3SR/cuK/VprSAE5aX5rs5mHJsNXI=; b=djfRqhgw0gZgNeFnURh3bsdHay
        KyVZ+rEFtFtC6KCjb2M61GBYo4vKm4G8ZDkYoIKqT5F4mfZtQtRSrH4dAIdVqjYhGTZMFjw9VwbQ5
        kWZWd1YSUctUhWqE+QtDQMkcBQmStj18rBlVhu2Z3n4jcgxiG5i58tNwB7ZnLdGRDcvY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55234 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIHg3-0005cI-9Z; Thu, 10 Feb 2022 17:12:36 -0500
Date:   Thu, 10 Feb 2022 17:12:34 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20220210171234.4e317c8a5d5f91f358382b07@hugovil.com>
In-Reply-To: <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
References: <20220125200009.900660-1-hugo@hugovil.com>
        <20220125200009.900660-11-hugo@hugovil.com>
        <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and
 INT_B support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 21:20:28 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jan 25, 2022 at 03:00:09PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The PCF2131 has two output interrupt pins, named INT_A and INT_B.
> > 
> > Add properties to identify onto which pin we want the alarm interrupt
> > to be routed. It can be either one, or both.
> > 
> > These properties are automatically set to false for variants other
> > than PCF2131 (ex: PCF2127).
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > index 57eb0a58afa3..83656dd2f97f 100644
> > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > @@ -24,6 +24,16 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >  
> > +  alarm-output-a:
> 
> nxp,alarm-output-a

Ok, this will be fixed for V2.

Thank you, Hugo.

-- 
Hugo Villeneuve <hugo@hugovil.com>
