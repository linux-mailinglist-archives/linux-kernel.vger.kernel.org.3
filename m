Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903CB54D325
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350147AbiFOU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349740AbiFOU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:58:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783EE01C;
        Wed, 15 Jun 2022 13:58:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w20so20719741lfa.11;
        Wed, 15 Jun 2022 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHkVcZcapgrq+x05D7RsWPsdaTufeMbFq41xO3naPPo=;
        b=fw27TONpdNc68v0SIqqXR74uavoS0smeRRHwI/m7lMWREdY+KTy4GA3YFBoo9QSIqw
         oOOuGS9VWVmUa/lj/HFdJsPsA5tDkr0fvdIGRaMJP97qw3jeE0GJ8IUKNomxEexcoENH
         BeLnJJ95rc5BkT+NsMcqLUdxLX9Tk+FSl8xk/kqdrR4D97M8BVtpr0Kv+uSLIKWu1jRf
         h3c0U/bA0LVsZPARWudbPkeHqcCwwg0ybAvj4Z9UwIz+wyc/6/RSpW4gIk/TgBq3Kbuf
         TEsm2/k0DflGOVvbWMIk3FfrZqAheovTj9v0PFO0lim/CrjjmmZ/N4Y464SH6eIYayKm
         j1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHkVcZcapgrq+x05D7RsWPsdaTufeMbFq41xO3naPPo=;
        b=H7FHOmMtur0dukCxyuTI6tGrCFuESU0h/etMvXBWVRUuqanElm17SJE19rOtJ+JX58
         E0ExxueflW0WtUtv7/ooYA8ItHA57Ljyc/oMO4rQxYJYfVioR1Po1zmlK/s1WMQxGPzb
         nYZxZtDns/IyBmka9ytJjBLoMCqHGTuvKo7xv5m63T14seIUX3ELO3SQHS7Xh+IXusF7
         LR0140ncW/oL9POuWKUm/2pHhD6iiQm6IZ/uVRr9Z8nGzly/q8xfPCc3EO0I+gmQh0gA
         xre7BMT/CuVNFEvggeZ/CA25Oukz0C91hBD6WzLUmwOYvMeaLchJT+sQChEO35gYjZya
         EQnA==
X-Gm-Message-State: AJIora9JG51jw7pBQK/1GGFivU5KRtCIOf7bgvb79QkKaXFVfkA7TYwX
        MbHKc7zpza62fhmGH34v3sg=
X-Google-Smtp-Source: AGRyM1vTVX7Wn1vQHuKb0FjphhadAW3sNTj+3aQQu2P/WhWKfnU42vseAltEUbX1dYROiudbz0X9Jg==
X-Received: by 2002:a05:6512:68e:b0:47d:ae64:fcf4 with SMTP id t14-20020a056512068e00b0047dae64fcf4mr747871lfe.685.1655326702146;
        Wed, 15 Jun 2022 13:58:22 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a11-20020a2eb16b000000b00253d4db8a92sm1743441ljm.63.2022.06.15.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:58:21 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:58:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 12/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
Message-ID: <20220615205819.uiqptkqm5qfdvrbj@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-13-Sergey.Semin@baikalelectronics.ru>
 <d06e9910-527e-cfa2-f2df-737fb4799fe5@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06e9910-527e-cfa2-f2df-737fb4799fe5@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:32:41PM +0900, Damien Le Moal wrote:
> On 6/10/22 17:17, Serge Semin wrote:
> > Currently not all of the Port-specific capabilities listed in the
> 
> s/listed/are listed
> 
> > PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> > Detection and Mechanical Presence Switch attached to the Port flags [1] so
> > to closeup the set of the platform-specific port-capabilities flags.  Note
> > these flags are supposed to be set by the platform firmware if there is
> > one. Alternatively as we are about to do they can be set by means of the
> > OF properties.
> > 
> > While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
> > comment there. In accordance with [2] that IRQ flag is supposed to
> > indicate the state of the signal coming from the Mechanical Presence
> > Switch.
> > 
> > [1] Serial ATA AHCI 1.3.1 Specification, p.27
> > [2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > 
> > ---
> > 
> > Changelog v4:
> > - Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)
> > ---
> >  drivers/ata/ahci.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index 7d834deefeb9..f501531bd1b3 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -138,7 +138,7 @@ enum {
> >  	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
> >  
> >  	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
> > -	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
> > +	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
> >  	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
> >  	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
> >  	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
> > @@ -166,6 +166,8 @@ enum {
> >  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
> >  	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
> >  	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
> > +	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
> > +	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
> >  	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
> >  	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
> >  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
> > @@ -181,6 +183,9 @@ enum {
> >  	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
> >  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
> >  
> > +	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
> > +				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
> 

> What is this one for ? A comment above it would be nice.

Isn't it obviously inferrable from the definition and the item name?

-Sergey

> 
> > +
> >  	/* PORT_FBS bits */
> >  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
> >  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
