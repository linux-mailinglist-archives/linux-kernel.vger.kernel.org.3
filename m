Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD054FE274
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355744AbiDLNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbiDLNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:31:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BACDEE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:29:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j21so19165458qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=utHfHRuEPsFSz+t+xVfjXy9ka6MMfgaIZASNpR7InEI=;
        b=SxlfMPQPhz+k04tLf1e3BiEJDZeTeSTHtmTmHpU/IotpKeudy7b1diCTvh0ntAbJmg
         +AHt6cJnIoJiag2v2tCfGYjXHyS5MMQFahb4J4exdhP+HvXug+HGUrqhFW74n4LXWGCu
         8JOpmoawvLnfHkdQneaEVx5KiqZ+gdSlZGfg/O018VShj4JdRwdflY/sPFMN0+0NHwKR
         8E+A6g3UnmsZoQG1EMLXQaoIlKNPycu4cyR+RVvWJ4Uqu+ZfHBJLF95ckXrfwm1yc6+9
         YPqAZ8NWvwoEW10PTJm2+WVwyfXBiaPh1RI/YAe1aWtg+jYvUMq0n4WvxIM9FV4rpTCn
         LOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utHfHRuEPsFSz+t+xVfjXy9ka6MMfgaIZASNpR7InEI=;
        b=H8gGYctt4j/JUtKRkVLO0AZnGMuYrOxiV9fkVvvCNxkyl05T01JfMOzb6+UlKpTyuC
         AFQeDQ6sNGJJBS5qekCpT3DiQWbySPiu8UkrKs5CfCQ+YAExf5igShbROFL7e/zGNTDp
         O1Pp7+gC9ngcx5PMH3joVnk7a+R5qkyxHoK2khVF5OICmcp5DpBauNxHEl7MfvQZqruo
         ufjI9SEt7vnTVxsuAJmaoWRWl2yw4e809ifWVTkTeO+8sojq/Kfcwy/qqyTI3XW6JC+P
         rNoYf/dQht8QLUGea7yc2f7sUiEHKBAKLmm0hPy1GLV4lewjrMmQ+6uwi8XPX+wXMP3M
         c1Tw==
X-Gm-Message-State: AOAM533EgAmF5R6zczQZ4FgPRjje5TtffbYLNM28FSx/CuDkKHLk8qQu
        Co4JKVP8yWaZ6Iqpeh6OTOJa0g==
X-Google-Smtp-Source: ABdhPJzR1/3qgAB9udxtprYbf3EHazhFycozkIuHDQce9GFcvxEpv9Sv2My0uQTgIIcCUEot20+ozg==
X-Received: by 2002:ac8:7ca2:0:b0:2eb:db4c:1b53 with SMTP id z2-20020ac87ca2000000b002ebdb4c1b53mr3155060qtv.307.1649770171417;
        Tue, 12 Apr 2022 06:29:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a4-20020a37b104000000b0069c2ba88bdasm2820895qkf.85.2022.04.12.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:29:30 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neGaH-000nVL-7x; Tue, 12 Apr 2022 10:29:29 -0300
Date:   Tue, 12 Apr 2022 10:29:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 15/21] KVM: s390: pci: add routines to start/stop
 interpretive execution
Message-ID: <20220412132929.GC64706@ziepe.ca>
References: <20220404174349.58530-1-mjrosato@linux.ibm.com>
 <20220404174349.58530-16-mjrosato@linux.ibm.com>
 <20220408124707.GY64706@ziepe.ca>
 <b143e333-0add-8042-12de-7e9e8b275ec0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b143e333-0add-8042-12de-7e9e8b275ec0@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:14:36AM -0400, Matthew Rosato wrote:
> On 4/8/22 8:47 AM, Jason Gunthorpe wrote:
> > On Mon, Apr 04, 2022 at 01:43:43PM -0400, Matthew Rosato wrote:
> > > +int kvm_s390_pci_register_kvm(struct device *dev, void *data)
> > > +{
> > > +	struct zpci_dev *zdev = NULL;
> > > +	struct kvm *kvm = data;
> > > +
> > > +	/* Only proceed for zPCI devices, quietly ignore others */
> > > +	if (dev_is_pci(dev))
> > > +		zdev = to_zpci_dev(dev);
> > > +	if (!zdev)
> > > +		return 0;
> > 
> > Especially since this only works if we have zpci device
> > 
> > So having the zpci code hook the kvm notifier and then call the arch
> > code from the zpci area seems pretty OK
> > 
> > Also why is a struct kvm * being passed as a void *?
> 
> Only because the function is intended to be called via
> iommu_group_for_each_dev (next patch) which requires int (*fn)(struct device
> *, void *)

I think this further says this should be called from vfio on the
actual struct device that is assigned to the KVM, not try to deduce it
from the gorup..

Jason
