Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6212D5250D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355704AbiELPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiELPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:05:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549B255098;
        Thu, 12 May 2022 08:05:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y19so6886628ljd.4;
        Thu, 12 May 2022 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NbrPLO5f80Fgr4pkih0UW7c1y1en5FoEIT51dqIUABU=;
        b=T4/pRiB0gG8qKpHvxG5wzXi041AjJ7RNXcavuodhvKhL0St/j2CypCgv0hj1pBROYW
         ahm+lGdGKqlVR7raalF632or3hCWzCGXZAiy2R4DFdBIQBVDmXQU4JepA8A9DvhpJXPT
         N/ytJrV4csCfL+okod6dqA1BuDRCgCpparBYVza2N7mepP6PgzRjf32X3yptDVGkrzXZ
         X5qG2Py5CzaM2o2Bkpl52daEYAvQMm2vImmF0UHpZ2Xs6zAKGBrZ6eU+UDZ985SP9O4Y
         KzwHU3IVTv+hnaIdsayBTAuZ+iwuAIVxQqOm8YFAjZvwL8j2l2O8GOtp8YUN7irGemQr
         cQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NbrPLO5f80Fgr4pkih0UW7c1y1en5FoEIT51dqIUABU=;
        b=iL5J/sX0o+H4Jhae4pLtiL4Hogq1+J/0ZEY2A2cFblhebSM1oRQU4fujbeErbNcpf8
         84QJzxoXwFceHPJteKrJhoJjoe6m3bILfwaFiUrYUsyUabzl5LzOA01Usj8/b8YIwXwR
         XWXOjBh6+T2UKHevozr1IF9kwZ5aeEurCRsln7NNkXo+E0INenNpgugdLGKkTnIRvQyS
         YnlEoyiWkI5glTWyyrPpCzE42TzpW8iFCcljOJUD89169YaTnRK4SYSbPQ2wip8h3QL7
         keYt2/7PFldhV7T20b6BJGm8abp21Mk0MqRnZu5AwGqqZMHpacde7k9kZhXd5PzDhgrs
         jksg==
X-Gm-Message-State: AOAM531T8x7plOFEp711PcxxYsTf0iFTjcI8QEbshl74D2q2TG/u+3Jm
        tqpQKhzCNPOp7kMyW5WJlJI=
X-Google-Smtp-Source: ABdhPJwu5RZKqoup6YD08X1MAMMVsO9re9t/o4FDDvNu0taMK00x3Mc0VisaC962QTBtonmG2ZVFTg==
X-Received: by 2002:a05:651c:1502:b0:250:2328:d127 with SMTP id e2-20020a05651c150200b002502328d127mr267441ljf.183.1652367905862;
        Thu, 12 May 2022 08:05:05 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e5813000000b0024f3d1daef0sm911302ljb.120.2022.05.12.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:05:04 -0700 (PDT)
Date:   Thu, 12 May 2022 18:05:02 +0300
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
Subject: Re: [PATCH v3 13/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
Message-ID: <20220512150502.l6gmh3d4uosmvxwg@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-14-Sergey.Semin@baikalelectronics.ru>
 <7fd1c122-12b2-adff-856f-50ffc5fc6bd1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fd1c122-12b2-adff-856f-50ffc5fc6bd1@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:57:55AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:18, Serge Semin wrote:
> > Currently not all of the Port-specific capabilities listed in the
> > PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> > Detection and Mechanical Presence Switch attached to the Port flags [1] so
> > to closeup the set of the platform-specific port-capabilities flags.  Note
> > these flags are supposed to be set by the platform firmware if there is
> > one. Alternatively as we are about to do they can be set by means of the
> > OF properties.
> > 
> > While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DEV_MPS and fix the
> > comment there. In accordance with [2] that IRQ flag is supposed to
> > indicate the state of the signal coming from the Mechanical Presence
> > Switch.
> > 
> > [1] Serial ATA AHCI 1.3.1 Specification, p.27
> > [2] Serial ATA AHCI 1.3.1 Specification, p.7
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >   drivers/ata/ahci.h | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 

> You might want to adapt the subject line, as this patch doesn't touch
> libahci at all.

AFAICS ahci.h is mainly (if not to say only) the header file of the
libahci.c module interface. Modifying ahci.h I basically update the
libahci interface. So based on that the subject is fully correct.

> Other than that:
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks.

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
