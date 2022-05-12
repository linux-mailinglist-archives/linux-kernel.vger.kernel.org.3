Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE55252F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356661AbiELQrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiELQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:47:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F424F0FC;
        Thu, 12 May 2022 09:47:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so10214351lfb.0;
        Thu, 12 May 2022 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZkeVSJkmptp9qNf3NXGzCw01fTFE3/b+0l0GX9neAqk=;
        b=n7WaurAF6TaHWnFHl5YNZkxg460sfhrGuGaFN1mwenC6UaLF99GCjJI2LiEPky3A92
         fHJf6y9l+fzLxEahqM0iZ6iY0zKGRGkppGMH3aSPEPU1Ajom34iQtL8ZSqexBboSu38T
         7R/MWomkDyoPZIqlosFrChTl2cTk1xhSuXV3xAkv9/mMT9pTkLHmHO1Hx3jNPUqRJrlI
         70zyxPuc11D0mHHbGeTgVsSAOn1na/cL4uhkfLKDeOwMqkZSkb+u6LyQ8zFrQ/ymhVQ6
         PuV7w59WCvm/etpCasQZ7kD5h/CqkGztjMwfBhIqNdz+pxLg++HaadeC4+Te9sJiTlJ9
         rfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZkeVSJkmptp9qNf3NXGzCw01fTFE3/b+0l0GX9neAqk=;
        b=ooTC3Qwb6CPrKOmY03jX+GzKfWw4Z/ULu3nctZdSir3/PbtVo6xuY/8DeuBBdAW7Zo
         0DeahmDqTfBF6gOGlqzkxMEPRx1CjO2UQN4kh4yI8lpWorKrUbtEZHOs1qiJx4K3skex
         8HMTq8eXLmDUg1njGbl712QsD43whA55yA05IsUrjqWzOMkWDKtRvTOpiX91KGy99MhF
         1DbbdrSj3QHYW9UZW2AjUAjue7HLHAAmoPy8Lw8dmNNVbphCQ/TG1A/UJ3R7D0RbMS0X
         SYjia+66NZWegjLXJTp1HiVFRNPA9HbOsfQ5adPIK6qF3AcU9Etysj2Z3vIuJXcI/Twe
         zBhw==
X-Gm-Message-State: AOAM532ujaTwJYDwV46aUqtdJzmq3gkZk0cUGNmCv+zeXZZtOnCdHe6u
        kuiYafhka3e7hWYLecFcKXn1Nv6EorrahA==
X-Google-Smtp-Source: ABdhPJzqk5KmZ9a6wq/NaIpiHmX+MF1xFmmTzEyzFddNC52ar10S84jdxsr9ycFr+FGWAA9i/1GkSg==
X-Received: by 2002:a05:6512:25e:b0:472:251f:9611 with SMTP id b30-20020a056512025e00b00472251f9611mr487694lfo.164.1652374058071;
        Thu, 12 May 2022 09:47:38 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id g11-20020a2eb5cb000000b0024f3d1daeabsm962450ljn.51.2022.05.12.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:47:37 -0700 (PDT)
Date:   Thu, 12 May 2022 19:47:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 23/23] MAINTAINERS: Add maintainers for DWC AHCI SATA
 driver
Message-ID: <20220512164734.hmoeuyf3fscqcpts@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-24-Sergey.Semin@baikalelectronics.ru>
 <5b2b3f12-ba1f-45b5-cb05-6f5376e4e2c6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b2b3f12-ba1f-45b5-cb05-6f5376e4e2c6@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:16:19AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:18, Serge Semin wrote:
> > Add myself as a maintainer of the new DWC AHCI SATA driver and
> > its DT-bindings schema.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Use dlemoal/libata.git git tree for the LIBATA SATA AHCI SYNOPSYS
> >    DWC driver (@Damien).
> > ---
> >   MAINTAINERS | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 40fa1955ca3f..04f470519708 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11135,6 +11135,15 @@ F:	drivers/ata/ahci_platform.c
> >   F:	drivers/ata/libahci_platform.c
> >   F:	include/linux/ahci_platform.h
> > +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> > +M:	Serge Semin <fancer.lancer@gmail.com>
> > +L:	linux-ide@vger.kernel.org
> > +S:	Maintained
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
> > +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > +F:	drivers/ata/ahci_dwc.c
> > +
> >   LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
> >   M:	Mikael Pettersson <mikpelinux@gmail.com>
> >   L:	linux-ide@vger.kernel.org
> Tsk.
> 
> One would have thought that you'd be using the same email address for
> sending patches, and not specifying a different one for the maintainers
> file. There is this thing about proof of authenticity and all that ...
> 
> I'm not really comfortable with this. Please use the same email address for
> both the Maintainers file and for sending patches.

I am more comfortable with reviewing and emailing from my private
email box rather than from the corporate one. Moreover the corporate
email address tends to get changed much more frequent than the private
one while the person role still preserves. Keeping more stable address
in the MAINTAINERS file gives a benefit of providing better review
service and causes less consequent modifications. So to speak I'd stick
with keeping the email address as is here.

-Sergey

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
