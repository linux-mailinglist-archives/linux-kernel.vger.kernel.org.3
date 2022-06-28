Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4955D8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345090AbiF1MIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiF1MI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:08:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636524F11;
        Tue, 28 Jun 2022 05:08:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so1692105ljr.0;
        Tue, 28 Jun 2022 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOMPHZxTAXk49D3k8YxdoXS022ibQ+MZGCBPChiaDtU=;
        b=ZENmrFoCpujFuHEP87dUs9OH4WML1Oe2tGWPfEo3b0haXjrbvFCot7uCZr4qq57B3G
         Fw9GjhZ9fB4dwseVV7boti4KaPS3Y8GeLtuWe8ECnVdyOJDjRjuIWqkVXNlaMPQKJmmT
         4WFtxuNQIj5qvEeWXvIb2mkPk3nuQh+wspP2QQuVpgs49THdp494LnBmrmohQrYumEbF
         Je0rP0o12u69La13Il6SX0+L2kaCfFkl4oG9FJgEkFqSBVsEH8wPBYn2tgfmu+Q7ueoa
         ZGPhwlJl7wbYrWQSDGut82qFkT324ULuWILLlYWaIPShhgcVDQHX+CeXf0A2dtz0dod3
         TT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOMPHZxTAXk49D3k8YxdoXS022ibQ+MZGCBPChiaDtU=;
        b=KlxoiWCLMGBPIic4m5FN4fjs9B1Nv1iT0UVDd9XnZikKZKOL8Neti8hCXTb+BilOy0
         /dlABp7XwNSHjSmV7U5GEnhcI2eJoQrtwgeylO/4vZmTpZ5fX718wN/+AoHNCDu0pGrb
         a6xyByx9zC55TRCJKUAWZJs+jSs4BVvP1A7SzOcc9oRpQLb3c07Rw783S5DrS4upBN3c
         m8Q8l1ypzMEcmsO1o3EiqalQdd1FncnXL5l4xd3XSSJud/R7WBEZY3C3mxr1+5BFsma+
         mQz2qBTVeohMQu+sFmb5jXj0KQDlb2mZjBtvnAZpmpHxZ9UUaf4h2rT0U1g7SI0CmDd+
         zGQg==
X-Gm-Message-State: AJIora9z26osHqolET88KyGhVBxKSctWwgVic1h+/VcsJyWp4iw36+Ao
        +rHaddu+YOK1OAhRWdSEBMWBMMSNZ1jrvQ==
X-Google-Smtp-Source: AGRyM1vWGiUUC8PJAqaqyVLzlhx5Xr5O6ERuzpLNXemJwAmj8Ym3ze3lgJGTd40bOF/3PYR5t0ob8A==
X-Received: by 2002:a2e:a484:0:b0:25a:8c94:3763 with SMTP id h4-20020a2ea484000000b0025a8c943763mr9188084lji.64.1656418103542;
        Tue, 28 Jun 2022 05:08:23 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id i17-20020a2ea231000000b002555d6ca497sm1769938ljm.115.2022.06.28.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:08:22 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:08:20 +0300
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
Message-ID: <20220628120820.3nprogcpe2l3bcm4@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-13-Sergey.Semin@baikalelectronics.ru>
 <d06e9910-527e-cfa2-f2df-737fb4799fe5@opensource.wdc.com>
 <20220615205819.uiqptkqm5qfdvrbj@mobilestation>
 <903e273a-9dc5-f0df-5391-e96e63318323@opensource.wdc.com>
 <20220617203100.jg2o7ponolaenf6r@mobilestation>
 <f560ca8b-d921-d228-64f0-74e320f8af67@opensource.wdc.com>
 <20220618081055.grsrjxa5gqiuhy2i@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618081055.grsrjxa5gqiuhy2i@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Damien,
Any notes to the comments below?

-Sergey

On Sat, Jun 18, 2022 at 11:10:55AM +0300, Serge Semin wrote:
> On Sat, Jun 18, 2022 at 03:52:28PM +0900, Damien Le Moal wrote:
> > On 6/18/22 05:31, Serge Semin wrote:
> > > On Thu, Jun 16, 2022 at 09:28:18AM +0900, Damien Le Moal wrote:
> > >> On 2022/06/16 5:58, Serge Semin wrote:
> > >>> On Tue, Jun 14, 2022 at 05:32:41PM +0900, Damien Le Moal wrote:
> > >>>> On 6/10/22 17:17, Serge Semin wrote:
> > >>>>> Currently not all of the Port-specific capabilities listed in the
> > >>>>
> > >>>> s/listed/are listed
> > >>>>
> > >>>>> PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> > >>>>> Detection and Mechanical Presence Switch attached to the Port flags [1] so
> > >>>>> to closeup the set of the platform-specific port-capabilities flags.  Note
> > >>>>> these flags are supposed to be set by the platform firmware if there is
> > >>>>> one. Alternatively as we are about to do they can be set by means of the
> > >>>>> OF properties.
> > >>>>>
> > >>>>> While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
> > >>>>> comment there. In accordance with [2] that IRQ flag is supposed to
> > >>>>> indicate the state of the signal coming from the Mechanical Presence
> > >>>>> Switch.
> > >>>>>
> > >>>>> [1] Serial ATA AHCI 1.3.1 Specification, p.27
> > >>>>> [2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88
> > >>>>>
> > >>>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> > >>>>>
> > >>>>> ---
> > >>>>>
> > >>>>> Changelog v4:
> > >>>>> - Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)
> > >>>>> ---
> > >>>>>  drivers/ata/ahci.h | 7 ++++++-
> > >>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > >>>>> index 7d834deefeb9..f501531bd1b3 100644
> > >>>>> --- a/drivers/ata/ahci.h
> > >>>>> +++ b/drivers/ata/ahci.h
> > >>>>> @@ -138,7 +138,7 @@ enum {
> > >>>>>  	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
> > >>>>>  
> > >>>>>  	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
> > >>>>> -	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
> > >>>>> +	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
> > >>>>>  	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
> > >>>>>  	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
> > >>>>>  	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
> > >>>>> @@ -166,6 +166,8 @@ enum {
> > >>>>>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
> > >>>>>  	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
> > >>>>>  	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
> > >>>>> +	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
> > >>>>> +	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
> > >>>>>  	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
> > >>>>>  	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
> > >>>>>  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
> > >>>>> @@ -181,6 +183,9 @@ enum {
> > >>>>>  	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
> > >>>>>  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
> > >>>>>  
> > >>>>> +	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
> > >>>>> +				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
> > >>>>
> > >>>
> > >>>> What is this one for ? A comment above it would be nice.
> > >>>
> > >>> Isn't it obviously inferrable from the definition and the item name?
> > >>
> > > 
> > >> I am guessing from the name. Am I guessing OK ? A comment would still be nice.
> > >> Why just these bits ? There are more cap/support indicator bits in that port cmd
> > >> bitfield. So why this particular set of bits ? What do they mean all together ?
> > > 
> > > Normally the variable/constant name should be self-content (as the
> > > kernel coding style doc states and what the common sense suggests). So
> > > the reader could correctly guess its purpose/content/value. In this
> > > case PORT_CMD_CAP - means PORT CMD capabilities mask. All of the
> > > possible flags have been set in that mask. There are no more
> > > capabilities in the PORT CMD register left undeclared. That's why the
> > > name is selected the way it is and why I haven't added any comment in
> > > here (what the kernel coding style says about the over-commenting the
> > > code).
> > 
> 
> > Yes, I understood from the name what it is. What I do NOT understand is
> > why all the feature bits are not there. Why this subset only ? A comment
> > about that would be nice so that the reason for it is not lost.
> 
> Well, because it's indeed "PORT_CMD capabilities mask", and not features,
> not setups, not settings, not status flags, etc. As I said all the port
> Capabilities have been listed in that mask:
> PORT_CMD_FBSCP	BIT(22) - FIS-based Switching Capable Port
> PORT_CMD_ESP	BIT(21) - External SATA Port
> PORT_CMD_CPD	BIT(20) - Cold Presence Detect
> PORT_CMD_MPSP	BIT(19) - Mechanical Presence Switch Attached to Port
> PORT_CMD_HPCP	BIT(18) - Hot Plug Capable Port
> I've or'ed-them-up in a single mask => PORT_CMD_CAP in order to work
> with them independently from the rest of the PORT_CMD CSR fields.
> 
> Unlike the generic controller CAP/CAP2 registers, which consists of the
> device capabilities only, PORT_CMD contains various R/W settings (PM, LED
> driver, etc), RO status flags (CMD-list running, FIS recv running, etc)
> and amongst other the RO/Wo !port-specific capabilities!. The later ones
> indicate the platform-specific device features. Since the register
> contains flags with the intermixed nature, I need to have a mask to at
> least get the capabilities and preserve them between the device
> resets. That's why the PORT_CMD_CAP has been introduced in the
> framework of this patch. Its name was chosen with a reference to the
> CAP registers, see:
> HOST_CAP, HOST_CAP2, and finally my PORT_CMD_CAP.
> 
> > 
> > > 
> > >>
> > >> Sure I can go and read the specs to figure it out. But again, a comment would
> > >> avoid readers of the code to have to decrypt all that.
> > > 
> > > If you still insist on having an additional comment. I can add
> > > something like "/* PORT_CMD capabilities mask */". Are you ok with it?
> > 
> 
> > That does not help on its own. The macro name says that already. I would
> > like a note about why only these features are selected.
> 
> Please see the explanation above. I don't see what else to say about
> that mask, because in short what I said above really means "PORT_CMD
> capabilities mask". So should you have some more clever text, which
> would be more suitable here, please tell me and I'll add it to the
> patch.
> 
> Regarding what you said earlier. In order to fully understand the
> AHCI driver a hacker would always need to read the specs. There is
> just no way to do that effectively enough without the controller
> manual at hands. And the PORT_CMD capabilities isn't the most
> complicated part of the device.
> 
> -Sergey
> 
> > 
> > > 
> > > -Sergey
> > > 
> > >>
> > >>>
> > >>> -Sergey
> > >>>
> > >>>>
> > >>>>> +
> > >>>>>  	/* PORT_FBS bits */
> > >>>>>  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
> > >>>>>  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
> > >>>>
> > >>>>
> > >>>> -- 
> > >>>> Damien Le Moal
> > >>>> Western Digital Research
> > >>
> > >>
> > >> -- 
> > >> Damien Le Moal
> > >> Western Digital Research
> > 
> > 
> > -- 
> > Damien Le Moal
> > Western Digital Research
