Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41535A78EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiHaIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHaIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:21:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A586C6FDE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:20:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 72so13713806pfx.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=tpUhGp+/TcjTBnxv5sQ0z4PHoyY+irmj8KbJJl11ccM=;
        b=iMAwBFaw6EdZxqqed1nCkV30ufKckKqtfv14GQkzuHkbeID8fP1+8ejU2Gx+oSor8M
         G2GYEc/NZ4m3uJzVpyTR2vhlTtIKicq6vDq4BkUp0FFWFyAfFb7Wr/k+HyrFDhdLbLWL
         5V8JvYuBZaXq3y18OD0IZrmli+wHRmEbmk30GQwVw125ye6O3lHJ9khpCt5Nnbh5g5af
         ypJawaSYknzfwGwCQ0x7zWZzzQ78GhtJq89wSdEArHJNK5N/BSnuSeIpxhv2YE3/8akU
         DUOC2vsEDMB9kz1x9G+QeKtLnPq8xKhUy6eXis3YE61oB9X5Skzt3uHCs+AEw47LDC41
         z07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=tpUhGp+/TcjTBnxv5sQ0z4PHoyY+irmj8KbJJl11ccM=;
        b=R0/OnWLPsOlOpNG/HdLQZYmPLC+zovl0UUlltRyYb8XoD4nLg9BpWCGOL8Y88Sw/RV
         VjsDJjPxwDspjhKUx5047McGWaabfMeXX2Jl9rPmeSc7Z1u+8/9D3BkG+KWorq2FNFjZ
         UkB+Bas4z+Z+yBysPb9AJu1wWCrdEAGn2YH5h1hTtAkfjaHnso1PLP4B5P4fTUlXHw31
         D59jhnvHkme7Q+4MhY9Nk5Z0Z8XBFaiSXs+PjNi9ONGw8ggyK65BMA0l9MHkmQ2cxNhI
         CnLl+FeSWldMjW70k2i52l/LqVHLYHS1kNkGeTLVKd84MdNesZoLdwFQyd4R8knFap2i
         7N6Q==
X-Gm-Message-State: ACgBeo1l24rmib4RBFOD3WPVNIwc2iLCL7I8U5ebLv3klc1UcTpeZMV2
        tpZHi3f7rrRzoGpk77jIwtghcCHTOJEL
X-Google-Smtp-Source: AA6agR6U8HuxmeEmOg2xKiG5EaLZptlqRvTU/96KVbdgF9UNJQZOAhDc3wv92IWVBNw06nO0sGNPAA==
X-Received: by 2002:a63:9dca:0:b0:429:c235:8b3b with SMTP id i193-20020a639dca000000b00429c2358b3bmr20478788pgd.567.1661934032448;
        Wed, 31 Aug 2022 01:20:32 -0700 (PDT)
Received: from thinkpad ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001753654d9c5sm656123plg.95.2022.08.31.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:20:31 -0700 (PDT)
Date:   Wed, 31 Aug 2022 13:50:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
        robh@kernel.org, vidyas@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Use link_up() callback in place of
 LINK_UP notifier
Message-ID: <20220831082025.GC5076@thinkpad>
References: <20220811094237.77632-1-manivannan.sadhasivam@linaro.org>
 <20220811094237.77632-3-manivannan.sadhasivam@linaro.org>
 <c200a544-31fe-b660-82bb-4bbed5acf135@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c200a544-31fe-b660-82bb-4bbed5acf135@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:47:10PM +0530, Kishon Vijay Abraham I wrote:
> Hi Mani,
> 
> On 11/08/22 15:12, Manivannan Sadhasivam wrote:
> > As a part of the transition towards callback mechanism for signalling the
> > events from EPC to EPF, let's use the link_up() callback in the place of
> > the LINK_UP notifier. This also removes the notifier support completely
> > from the PCI endpoint framework.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
> >  drivers/pci/endpoint/pci-epc-core.c           |  8 +++--
> >  include/linux/pci-epc.h                       |  8 -----
> >  include/linux/pci-epf.h                       |  8 ++---
> >  4 files changed, 18 insertions(+), 39 deletions(-)
> > 
> 
> .
> .
> <snip>
> .
> .
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 805f3d64f93b..a51ba9f158c3 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -690,10 +690,15 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> >   */
> >  void pci_epc_linkup(struct pci_epc *epc)
> >  {
> > +	struct pci_epf *epf;
> > +
> >  	if (!epc || IS_ERR(epc))
> >  		return;
> >  
> > -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > +		if (epf->event_ops->link_up)
> > +			epf->event_ops->link_up(epf);
> > +	}
> 
> how do you ensure there is no race while invoking the call back
> functions during add/remove of epf?
> 

Good catch! These should be guarded by epf->lock.

Thanks,
Mani

> Thanks,
> Kishon

-- 
மணிவண்ணன் சதாசிவம்
