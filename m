Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623464FBBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbiDKMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiDKMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:19:13 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046C27CD9;
        Mon, 11 Apr 2022 05:16:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so19824671ljr.9;
        Mon, 11 Apr 2022 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SwlzXZe5gV8+pFvJZHXYo05mqSjtl8vaF4Cm8yRdmF4=;
        b=EqhE4evILFPuJAW/tZZdb5l3kkuSl2VPpas+U7WJiRz3rePHdobkUXUUfYoD7zRd3N
         bfy2xD7eyepIebPuUZ+mGgZhMtsGj/oeb+Pv/QeVgZ8d4E7oyc+G5bCUBrs3NtNvGGCA
         VdpmI4zBJXWbkbj6gIaDXn8vNPBIOXnLp7pcMpDoeNAo35LXkgqCBPDiFLsvV3Hlllkc
         AQJtERViwG8Dku/9f0jDfltR6zaXtoTJuWH8cZ6PsBhK7XlLUa+T8+p+r1KJBpj+klrd
         +ggN6mklstQiE+q/TltyHMq4fp868htmvnuKvmtiF4Y0k3iKYfwEKfYyvOKj6MAO9ZKe
         1QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SwlzXZe5gV8+pFvJZHXYo05mqSjtl8vaF4Cm8yRdmF4=;
        b=QubnabigrAHdsVwkBkbDGQKSUy//i0sXgZLOEqhy0J/ZyqE5JjB9v4GEV1WgmDadXq
         q0qT+cquQW6tV2dxoSCQoTClDHuS8HPOq5FXryoCuaDLxTiJm91iCiQJfltwHJSWKbso
         0AEBRAvK2v1mEAHhCnG80Ge1e+4A+wCTRMDVHIuUpDktZ1WuFyNIuHmGSJDEeUiTUKGB
         uWRvPcjvG/n9jwkMkTPSekK8dR3kqFonzGfmOvj5neFRd0Lrk1h1a2xUGW0GAnlk1qej
         D7csVOTWPieaH1LDxbx4zKgUS28Ujfi+mAARb1/5QtE3lRYfR6N7zqQPE0EeY7pQFVFZ
         yUIQ==
X-Gm-Message-State: AOAM531U3tq/OsD+WuSy6ZcYLJ3QlhD7UqvKXckKZjssWOV8l3UqB2zZ
        dawEE+xojerGw6/fKqbbgExlPF78NCimZg==
X-Google-Smtp-Source: ABdhPJz9nwi9knLMn0iSU+PoTmNxSzwRTgJoB66bIKUM2XJsrtI/A0vEgQCLxsVPNP+zsHSxx1KxLQ==
X-Received: by 2002:a05:651c:54c:b0:249:9d06:24ef with SMTP id q12-20020a05651c054c00b002499d0624efmr20279739ljp.331.1649679417317;
        Mon, 11 Apr 2022 05:16:57 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id g36-20020a0565123ba400b0044a2a1ccd99sm3314311lfv.20.2022.04.11.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 05:16:56 -0700 (PDT)
Date:   Mon, 11 Apr 2022 15:16:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 21/21] MAINTAINERS: Add maintainers for DWC AHCI SATA
 driver
Message-ID: <20220411121655.l5ft7r6bywg2nxcp@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-22-Sergey.Semin@baikalelectronics.ru>
 <eb79ee49-53aa-57eb-94af-90997aa6cbed@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb79ee49-53aa-57eb-94af-90997aa6cbed@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:17:12AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > Add myself as a maintainer of the new DWC AHCI SATA driver and
> > its DT-bindings schema.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd0f68d4a34a..19c9ea0758cc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10919,6 +10919,15 @@ F:	drivers/ata/ahci_platform.c
> >  F:	drivers/ata/libahci_platform.c
> >  F:	include/linux/ahci_platform.h
> >  
> > +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> > +M:	Serge Semin <fancer.lancer@gmail.com>
> > +L:	linux-ide@vger.kernel.org
> > +S:	Maintained
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 

> Wrong tree. This should be libata tree.

Got it. Thanks.

-Sergey

> 
> > +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > +F:	drivers/ata/ahci_dwc.c
> > +
> >  LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
> >  M:	Mikael Pettersson <mikpelinux@gmail.com>
> >  L:	linux-ide@vger.kernel.org
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
