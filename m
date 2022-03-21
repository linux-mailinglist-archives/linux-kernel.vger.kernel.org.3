Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9EE4E2CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbiCUPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiCUPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:51:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC89F386
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:50:30 -0700 (PDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 747413F329
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647877829;
        bh=amAeexB40qeQuUsgEFDBLhcLC0MO2/MpF5kxBkxTRmI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=XFCpwt7tCAZlBPG+AZ0usNVyFZJujaZlgsN7eV/aNU8ZUxl7LZ1WkxywUhhI57HQ8
         TiJEqyDUcWs6elIvE4kOGILr+cUQWbnsac7l25h68IFqmrsoLhVZ2mzddidZDPY4TB
         K3L0s3ecxyqwNRyndX3nLYmcwnd/dWesFJu04wwpkcB44lX7ktW5oJPi0J67OZqY3O
         S3bgM1n66VRoRMxZR5EyvHb3WSD9fEgk0xiVFb50rfoZiH828qnHUZ5pf81jVb2obk
         gs7oMkbiqv/xscO1paYA2lM2ZVUklBgUbPLkFyn5HkeIX9PPA8QnDEgzYV0V/eqP1R
         FrOdrlXXj6OEg==
Received: by mail-io1-f69.google.com with SMTP id i19-20020a5d9353000000b006495ab76af6so7777368ioo.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amAeexB40qeQuUsgEFDBLhcLC0MO2/MpF5kxBkxTRmI=;
        b=P3sXItGmXDwAiplo8/NdykiRPDnQwYUHHmoVb7r7X5jr+QE66UKU3lkLj6Syhctuk5
         4pkbgTVqt/3B92tojm1Oazgbib41YSvPVapxqnYhOxZx7jfJiDv6TIPrYLVHci/930hN
         TR3clZmsohWHT6v4qxQngBKbKKSn2LLqCBcE7NKziAhmpI9p0xfJNE5Bm/nAOR4mtgxd
         6AFx3oXt6gkSyKj2IC5UvRxWTiNXyetHLDKCrYiQdYZewDJSd5v5RsaFSPi4W1cvAYaU
         071To4eV7iCh1lT4t2L06RlUg+oBjHZqN8sGwIshWV4S2r5LNVI8ebmuD03xJ7u6ab/S
         zldw==
X-Gm-Message-State: AOAM5324LVcc+PHC8CfSizYrVPah6/69l3eH1yJDz1ErS+kL+U240GBG
        zH2OshlJT4/g51+ywrYipKKfd7l9kW6HLbeA+EgCYq4mQS8Tnb1Hpr950FSQ8FAOEMvIUQ48XdZ
        xqWRcdcRismTc+bqbFGG/G9OxJJi8OloyGLd62U08cQ==
X-Received: by 2002:a92:ca4a:0:b0:2c8:301e:3624 with SMTP id q10-20020a92ca4a000000b002c8301e3624mr1747923ilo.301.1647877828243;
        Mon, 21 Mar 2022 08:50:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5zI7dbe8PgtCdpDk52EDFpaKY1vg7MjzSrWomIEbD/IHHzCyZhQG2tfBo94Rl9x/jY457wA==
X-Received: by 2002:a92:ca4a:0:b0:2c8:301e:3624 with SMTP id q10-20020a92ca4a000000b002c8301e3624mr1747912ilo.301.1647877828016;
        Mon, 21 Mar 2022 08:50:28 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id q197-20020a6b8ece000000b00648d615e80csm8501663iod.41.2022.03.21.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:50:27 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:50:24 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Message-ID: <YjiewB5Nz5CyFuI0@xps13.dannf>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:17:34AM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> > merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> > IB window setup") fixed XGene-2, but left the rest of the zoo
> > unusable.
> >
> > It is understood that this systems come with "creative" DTs that don't
> > match the expectations of modern kernels. However, there is little to
> > be gained by forcing these changes on users -- the firmware is not
> > upgradable, and the current owner of the IP will deny that these
> > machines have ever existed.
> 
> The gain for fixing this properly is not having drivers do their own
> dma-ranges parsing. We've seen what happens when drivers do their own
> parsing of standard properties (e.g. interrupt-map). Currently, we
> don't have any drivers doing their own parsing:
> 
> $ git grep of_pci_dma_range_parser_init
> drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> of_pci_range_parser *parser,
> drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> drivers/of/address.c:#define of_dma_range_parser_init
> of_pci_dma_range_parser_init
> drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
> drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
> include/linux/of_address.h:extern int
> of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> include/linux/of_address.h:static inline int
> of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> 
> And we can probably further refactor this to be private to drivers/pci/of.c.
> 
> For XGene-2 the issue is simply that the driver depends on the order
> of dma-ranges entries.
> 
> For XGene-1, I'd still like to understand what the issue is. Reverting
> the first fix and fixing 'dma-ranges' should have fixed it. I need a
> dump of how the IB registers are initialized in both cases.

Happy to provide that for the m400 if told how :)

  -dann

> I'm not
> saying changing 'dma-ranges' in the firmware is going to be required
> here. There's a couple of other ways we could fix that without a
> firmware change, but first I need to understand why it broke.

