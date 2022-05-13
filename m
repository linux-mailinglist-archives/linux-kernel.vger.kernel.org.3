Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F852619A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380156AbiEMMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377242AbiEMMNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:13:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3854D297408;
        Fri, 13 May 2022 05:13:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v4so10023361ljd.10;
        Fri, 13 May 2022 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jj7Rs1g0MNpjNJfKdXCTRCNUSnWA3K/oljieoDy3W/w=;
        b=FGJb9YJ/ZVSRn4GNLy4avnEvWR5rz0hnysr1Y53EwJ7xJkFFzFKZ8a93MzzyzFF/0p
         hr0ucvemplh5G9ztSYKMGr/IZbg4aRywkvZ9UruCwyW61rFsh45/6wEg6SD93LaJrJ4X
         iisEaw5e21pw9Wte/Ruqy1E+SAruT9ajpPXLiWot/mxE15nrXDSlS8/iOubvGOigKYBU
         s+EOUiIy0Mb+DM471ACutgI5Qq9wcw12HCK9AWUSWVg68gNMAtsGhKTAFN57iyN0k2ll
         RRhT5tpOgE5l/wytlUNZ3IinBZiYBsc0sRWX3zX7FnQush5BkYBCpkYl6T52E0RLWlaD
         YHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jj7Rs1g0MNpjNJfKdXCTRCNUSnWA3K/oljieoDy3W/w=;
        b=W1dqg3J7qKKdSpwi0DSYQpUClE4DHMq5FgKqYbkRP8nxPdimfqiDpaKtSJxZDuIYhV
         NtRDvdnz57bvErNk+LVyagkhhz6gS4YBM/DE5Zyx2jMVPuF4f8TLu36PDCUVETJAf89c
         K2GvaEKZjCGcRA9sxNDS5L7ajIoY7C3YXMt6agmCfKX6w3jwM6BPh0bKCjGjLii7g6SO
         YUGtN4sxkiLA4fG8xj+gbaibcGbZk0D3k+Bp/aEzUnRLWesgPRPluJ/ve2J6yQKnT3wt
         Hz20Uhc6qMv6qh4HzvGqyjkpodYpj7HmsYM7zQPv0AiToMddlmpral970cmSuN+Jmvma
         ywAA==
X-Gm-Message-State: AOAM533mt8hFc9qB1H1mzbR5kL3av1PxktM+MA24yXPZXZ9lSt/KqKYj
        LvKaBr2qeJJ8Jzz3qe1wkio=
X-Google-Smtp-Source: ABdhPJx2R7IIV3xBoJry0mvLrGHeam25T8S/SX2vfM7C+G3R9p3F3R+oNTpqHFZ063/FHjz2H46jJg==
X-Received: by 2002:a05:651c:4cb:b0:24f:517c:ff9b with SMTP id e11-20020a05651c04cb00b0024f517cff9bmr2989880lji.2.1652444014904;
        Fri, 13 May 2022 05:13:34 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id i5-20020a2e8645000000b0024f3d1daed8sm413381ljj.96.2022.05.13.05.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:13:34 -0700 (PDT)
Date:   Fri, 13 May 2022 15:13:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 13/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
Message-ID: <20220513121332.lt7ezeqskwoxprkf@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-14-Sergey.Semin@baikalelectronics.ru>
 <887a7537-5400-f3e2-235c-033871d413bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887a7537-5400-f3e2-235c-033871d413bc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 11:22:44AM +0300, Sergei Shtylyov wrote:
> On 5/12/22 2:18 AM, Serge Semin wrote:
> 
> > Currently not all of the Port-specific capabilities listed in the
> > PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> > Detection and Mechanical Presence Switch attached to the Port flags [1] so
> > to closeup the set of the platform-specific port-capabilities flags.  Note
> > these flags are supposed to be set by the platform firmware if there is
> > one. Alternatively as we are about to do they can be set by means of the
> > OF properties.
> > 
> > While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DEV_MPS and fix the
> 

>    Your code has PORT_IRQ_DMPS instead...

Right. The correct macro name is used in the patch body. I'll fix the
log. Thanks.

-Sergey

> 
> > comment there. In accordance with [2] that IRQ flag is supposed to
> > indicate the state of the signal coming from the Mechanical Presence
> > Switch.
> > 
> > [1] Serial ATA AHCI 1.3.1 Specification, p.27
> > [2] Serial ATA AHCI 1.3.1 Specification, p.7
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
> [...]
> 
> MBR, Sergey
