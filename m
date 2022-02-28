Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797EE4C62E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiB1G3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiB1G3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:29:14 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0CC3137D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:28:36 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u16so10165691pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31uK4YkjhMs1DL2/Q3AqCnAeNqmdIPw4uNEjAhf3pkY=;
        b=svJ5MzX9+fImZ7edF97vML1wA8ZtV4GP6Iop57FmHJcjYta3uMx/JVYFU0lTDu9uSx
         v8qkgqBanSyFd9GRkJ4oK5iboJzhvPp4i90PvRAZDoFey5PgZitvtTD76tb01Y3e17rn
         VxY+hZABxoRBWpg6g5qNG9O6sgTkZFS00YJc8CrBULVkFmweB3Yec0Di1RZInnAEj4dX
         SyG+oH+8RNe+1wty94HZo6KeeHhFmQwzigK4mPEhs/q7BCEnAIqB3Cgi2KzTOB13C6A9
         7juRpSbIbP43aCViji7nbWYAhql6AwLRy85rvCAQhBXrKHpgIxRFsfPLIi+Gx52iaGBv
         K2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31uK4YkjhMs1DL2/Q3AqCnAeNqmdIPw4uNEjAhf3pkY=;
        b=P4H3/06rgsD6Ddz1S9dZkEhRWBNMdSn36P8VCTc9aiygYl0eyUzT8APDYbTtEu5Gy+
         leOhbgQ+269dDdkreGf4GSoQSRxVPxiLoa//JK0PELIAajsiG8TSmQwOvm7qbiYZXd8/
         /f5JTsZ6ueBi+zZIQSzveV2WNwNyvthdrmp+DM1n9fJJkQL1LA80ZqVLB1YZZ8dzLrNT
         w1v7aMYKSIcCphabb34w5i9AcWJ78GwJiu2wIwbs9NVtBztJo/gpWY6tixI74/vKjXzJ
         rf8YXRVsCH2cHRw7IlebdyGJ+nzTIdUa+FyqUF5QmVknOm8D2Bsl5lRdH7Lhne1eBNQW
         jFsA==
X-Gm-Message-State: AOAM532/No4laQcpVkSCkbBw7FLs4rMUQG7H7qP1/uDVCuDSwTw1SCCO
        B5vesRpsvnP6/JbAfkQ/vOeN4tRiS6FI
X-Google-Smtp-Source: ABdhPJxEPd3e/wiHRER/eh61H5beCmkUu9zEWpr+PRMoDfEsFyvo/2/FbJz3Bn0dmZINYWdAq7OOFw==
X-Received: by 2002:a63:ea53:0:b0:341:a28e:16b9 with SMTP id l19-20020a63ea53000000b00341a28e16b9mr15937024pgk.259.1646029716089;
        Sun, 27 Feb 2022 22:28:36 -0800 (PST)
Received: from thinkpad ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y16-20020a056a00181000b004de90b16516sm12636089pfa.72.2022.02.27.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:28:35 -0800 (PST)
Date:   Mon, 28 Feb 2022 11:58:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lorenzo.pieralisi@arm.com, Vidya Sagar <vidyas@nvidia.com>,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2] PCI: endpoint: Use blocking notifier instead of atomic
Message-ID: <20220228062830.GA37219@thinkpad>
References: <20220228055240.24774-1-manivannan.sadhasivam@linaro.org>
 <e151083b-c15a-7baa-3423-84bd1881105a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e151083b-c15a-7baa-3423-84bd1881105a@ti.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 11:46:52AM +0530, Kishon Vijay Abraham I wrote:
> Hi Manivannan,
> 
> On 28/02/22 11:22 am, Manivannan Sadhasivam wrote:
> > The use of atomic notifier causes sleeping in atomic context bug when
> > the EPC core functions are used in the notifier chain. This is due to the
> > use of epc->lock (mutex) in core functions protecting the concurrent use of
> > EPC.
> 
> The notification from the controller to the function driver is used for
> propagating interrupts to function driver and should be in interrupt context.
> How it should be handled maybe left to the function driver. I don't prefer
> moving everything to blocking notifier.
> 

I agree that we need to handle it quick enough but I don't see any other valid
options to get rid of the issue. EPF driver may use a non-atomic notifier but
that seems to be an overkill workaround for something that could be fixed in the
EPC core.

And propagating interrupts is not going to work or needed all the time. Do you
forsee any issue with blocking notifier?

> I'm wondering how other users for CORE_INIT didn't see this issue.

This can be triggered with EPF test or NTB if CONFIG_DEBUG_ATOMIC_SLEEP is
enabled.

Thanks,
Mani

> 
> Thanks,
> Kishon
> 
> > 
> > So switch to blocking notifier for getting rid of the bug as it runs in
> > non-atomic context and allows sleeping in notifier chain.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v2:
> > 
> > * Removed the changes related to non-upstreamed patches
> > 
> >  drivers/pci/endpoint/pci-epc-core.c | 6 +++---
> >  include/linux/pci-epc.h             | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 3bc9273d0a08..c4347f472618 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -693,7 +693,7 @@ void pci_epc_linkup(struct pci_epc *epc)
> >  	if (!epc || IS_ERR(epc))
> >  		return;
> >  
> > -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> > +	blocking_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_linkup);
> >  
> > @@ -710,7 +710,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
> >  	if (!epc || IS_ERR(epc))
> >  		return;
> >  
> > -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> > +	blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
> >  
> > @@ -774,7 +774,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
> >  
> >  	mutex_init(&epc->lock);
> >  	INIT_LIST_HEAD(&epc->pci_epf);
> > -	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
> > +	BLOCKING_INIT_NOTIFIER_HEAD(&epc->notifier);
> >  
> >  	device_initialize(&epc->dev);
> >  	epc->dev.class = pci_epc_class;
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index a48778e1a4ee..04a2e74aed63 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -149,7 +149,7 @@ struct pci_epc {
> >  	/* mutex to protect against concurrent access of EP controller */
> >  	struct mutex			lock;
> >  	unsigned long			function_num_map;
> > -	struct atomic_notifier_head	notifier;
> > +	struct blocking_notifier_head	notifier;
> >  };
> >  
> >  /**
> > @@ -195,7 +195,7 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
> >  static inline int
> >  pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
> >  {
> > -	return atomic_notifier_chain_register(&epc->notifier, nb);
> > +	return blocking_notifier_chain_register(&epc->notifier, nb);
> >  }
> >  
> >  struct pci_epc *
> > 
