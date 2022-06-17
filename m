Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245754FE65
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbiFQUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:31:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D605C740;
        Fri, 17 Jun 2022 13:31:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h23so5871814ljl.3;
        Fri, 17 Jun 2022 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7nGakZJxQXZKPcPy+VOb5gCeQUsCg6Cmp5BsLtz0ZEg=;
        b=V+CeIs+X7EbQen2649oLySuIcZZy/70d3iwfIO3HV8dvNrxh4huHI5BKcAZqjOyW39
         R+oVm+4XV5yC+B+hSoJ5WvRF6/dTv9Tva43rW1pGJc5L9sPGdwDFFbx1pHlzzjWQdkRn
         8a4LBY3w3ZIb54U9W9xAh663OntWWyEqM4ubKTY5o8sdFiQsKSIrdza2NOnK2LvbbWmy
         YmStfXq9xRaxIvDAeMv+kRU810Duydzwfkfg/tkzF9Ay8AQ4aOvZYbezjccAlxzsf67H
         weXeI2jR3ibxarBv/RSEC+T/41WjeGvYKPr4PGKs/00MUTqeEibn3BMXda/L3udclTrb
         1SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nGakZJxQXZKPcPy+VOb5gCeQUsCg6Cmp5BsLtz0ZEg=;
        b=t5qwhy7ig1A99X8+Rj9CbEzJh/4IYhe54fD+GOw477otl/MrdVwtND4ziSq0pzcodK
         oPNTsR91VNLj8kFzFACxn9SgR/c0vTOySrgWyQTiLBpqN3GnSYV6F8hw+ldZbGZtF2UK
         dRXbzBOELn7o3n0cc1rKVmRH+7rUBkNM3qyqFAVK7IKx3byRUid/Jb/Yh/x9ufykQsme
         mo4WziwJCaHvbFEYEfqygB76kKSA3seoKUz0itZgZduMG7aK8T6YRKoVYQ+hFNKhEDzD
         NjdqpK92Nf9oMgr8TxVOLbyS/YwZYWt+g6uO9KJabF9etW+v3Y1OnY3CaQXsUwFYJ3T/
         pmcw==
X-Gm-Message-State: AJIora/Zr6eDHEQazEFwHxAxDS4rcaf2wc7BYouowyFGK5ZmJthZwHWK
        +kT1SID+WlKwNrU9rqYwYuo=
X-Google-Smtp-Source: AGRyM1u5enOCrssguLCkcYTXhPXubqKR3gfQ9XqPZS+m0o5UTd8X0N2UxqlADmuHWv28qOoGPeiS8w==
X-Received: by 2002:a2e:9ece:0:b0:25a:4d0f:1540 with SMTP id h14-20020a2e9ece000000b0025a4d0f1540mr3893920ljk.481.1655497863284;
        Fri, 17 Jun 2022 13:31:03 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id b9-20020a196449000000b00478ee191091sm752205lfj.153.2022.06.17.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:31:02 -0700 (PDT)
Date:   Fri, 17 Jun 2022 23:31:00 +0300
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
Message-ID: <20220617203100.jg2o7ponolaenf6r@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-13-Sergey.Semin@baikalelectronics.ru>
 <d06e9910-527e-cfa2-f2df-737fb4799fe5@opensource.wdc.com>
 <20220615205819.uiqptkqm5qfdvrbj@mobilestation>
 <903e273a-9dc5-f0df-5391-e96e63318323@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903e273a-9dc5-f0df-5391-e96e63318323@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:28:18AM +0900, Damien Le Moal wrote:
> On 2022/06/16 5:58, Serge Semin wrote:
> > On Tue, Jun 14, 2022 at 05:32:41PM +0900, Damien Le Moal wrote:
> >> On 6/10/22 17:17, Serge Semin wrote:
> >>> Currently not all of the Port-specific capabilities listed in the
> >>
> >> s/listed/are listed
> >>
> >>> PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> >>> Detection and Mechanical Presence Switch attached to the Port flags [1] so
> >>> to closeup the set of the platform-specific port-capabilities flags.  Note
> >>> these flags are supposed to be set by the platform firmware if there is
> >>> one. Alternatively as we are about to do they can be set by means of the
> >>> OF properties.
> >>>
> >>> While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
> >>> comment there. In accordance with [2] that IRQ flag is supposed to
> >>> indicate the state of the signal coming from the Mechanical Presence
> >>> Switch.
> >>>
> >>> [1] Serial ATA AHCI 1.3.1 Specification, p.27
> >>> [2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>
> >>> ---
> >>>
> >>> Changelog v4:
> >>> - Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)
> >>> ---
> >>>  drivers/ata/ahci.h | 7 ++++++-
> >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> >>> index 7d834deefeb9..f501531bd1b3 100644
> >>> --- a/drivers/ata/ahci.h
> >>> +++ b/drivers/ata/ahci.h
> >>> @@ -138,7 +138,7 @@ enum {
> >>>  	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
> >>>  
> >>>  	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
> >>> -	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
> >>> +	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
> >>>  	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
> >>>  	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
> >>>  	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
> >>> @@ -166,6 +166,8 @@ enum {
> >>>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
> >>>  	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
> >>>  	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
> >>> +	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
> >>> +	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
> >>>  	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
> >>>  	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
> >>>  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
> >>> @@ -181,6 +183,9 @@ enum {
> >>>  	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
> >>>  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
> >>>  
> >>> +	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
> >>> +				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
> >>
> > 
> >> What is this one for ? A comment above it would be nice.
> > 
> > Isn't it obviously inferrable from the definition and the item name?
> 

> I am guessing from the name. Am I guessing OK ? A comment would still be nice.
> Why just these bits ? There are more cap/support indicator bits in that port cmd
> bitfield. So why this particular set of bits ? What do they mean all together ?

Normally the variable/constant name should be self-content (as the
kernel coding style doc states and what the common sense suggests). So
the reader could correctly guess its purpose/content/value. In this
case PORT_CMD_CAP - means PORT CMD capabilities mask. All of the
possible flags have been set in that mask. There are no more
capabilities in the PORT CMD register left undeclared. That's why the
name is selected the way it is and why I haven't added any comment in
here (what the kernel coding style says about the over-commenting the
code).

> 
> Sure I can go and read the specs to figure it out. But again, a comment would
> avoid readers of the code to have to decrypt all that.

If you still insist on having an additional comment. I can add
something like "/* PORT_CMD capabilities mask */". Are you ok with it?

-Sergey

> 
> > 
> > -Sergey
> > 
> >>
> >>> +
> >>>  	/* PORT_FBS bits */
> >>>  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
> >>>  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
> >>
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
