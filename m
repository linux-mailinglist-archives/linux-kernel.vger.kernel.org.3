Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A704B18E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbiBJWzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:55:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbiBJWzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:55:18 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375A55B2;
        Thu, 10 Feb 2022 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qks3yg9iI4qDFGsh2BRdcXvx9gE+lfvznavyp5NtJdI=; b=Sf9q1WTPyhuB1tGsyP9dI+S2+F
        R/4nAXULzUgiIobtxd/OByP5KKiWeeAIebRkNrm5RTrk8hSi04MxZKhuufQUf9QpcnPKzyKCoKyex
        6BP8v+EMAJCDkR6gh4rZTxG+WP/GbljqR/oEJOtUgoSumfCxto77mdMWWfdMYaYCw/W0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55240 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIILH-0005sm-95; Thu, 10 Feb 2022 17:55:13 -0500
Date:   Thu, 10 Feb 2022 17:55:10 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20220210175510.c99eb77c6367d4df5d8bb9a2@hugovil.com>
In-Reply-To: <YgWSgGTKR63g+S9e@piout.net>
References: <20220125200009.900660-1-hugo@hugovil.com>
        <20220125200009.900660-11-hugo@hugovil.com>
        <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
        <20220210171234.4e317c8a5d5f91f358382b07@hugovil.com>
        <YgWSgGTKR63g+S9e@piout.net>
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

On Thu, 10 Feb 2022 23:32:32 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 10/02/2022 17:12:34-0500, Hugo Villeneuve wrote:
> > On Tue, 8 Feb 2022 21:20:28 -0600
> > Rob Herring <robh@kernel.org> wrote:
> > 
> > > On Tue, Jan 25, 2022 at 03:00:09PM -0500, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > The PCF2131 has two output interrupt pins, named INT_A and INT_B.
> > > > 
> > > > Add properties to identify onto which pin we want the alarm interrupt
> > > > to be routed. It can be either one, or both.
> > > > 
> > > > These properties are automatically set to false for variants other
> > > > than PCF2131 (ex: PCF2127).
> > > > 
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 23 +++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > > index 57eb0a58afa3..83656dd2f97f 100644
> > > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > > @@ -24,6 +24,16 @@ properties:
> > > >    interrupts:
> > > >      maxItems: 1
> > > >  
> > > > +  alarm-output-a:
> > > 
> > > nxp,alarm-output-a
> > 
> > Ok, this will be fixed for V2.
> > 
> 
> Actually, this property has to be made more generic and thought out.
> There are multiple RTCs that have multiple interrupt pins where one of
> the pin can be used for different interrupt or clock output.
> 
> With your binding, there is no way to separate which interrupt is going
> to which pin and so there is no way to get the alarm and BLF or the
> watchdog on different pins and we certainly don't want to have a
> property per interrupt type.

Hi,
can you please suggest how you would prefer it to be done?

> Also, the documentation is missing the fact that the driver makes having
> one of the property mandatory.

I will add it.

Thank you, Hugo.

-- 
Hugo Villeneuve <hugo@hugovil.com>
