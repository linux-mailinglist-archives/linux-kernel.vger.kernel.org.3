Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3152948D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350129AbiEPW7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350095AbiEPW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4D8546670
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652741864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Fde+ld/4sGgSKrAUxZSGkT/mr1xjoM3zJiebHiO81s=;
        b=aLex9aUzmrWkO8lpYU2rv0Uhu0IWLLDXEBBXo94zMpOCDcfyzk7sybbMyhvOPXXFnCRM/g
        A36l4zH93XZW2QopIyeex8D7+euoiV5GB1uTDCSyDY94BNVNE8p659ajlc6UnC4yBhF1Eq
        pG4n5hTtkN3jDmqDKe6dnJ9lODsgNBQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-DIkhQygTOB-xr9i8CRQLKQ-1; Mon, 16 May 2022 18:57:42 -0400
X-MC-Unique: DIkhQygTOB-xr9i8CRQLKQ-1
Received: by mail-il1-f200.google.com with SMTP id s13-20020a056e02216d00b002d10fed8e04so2386365ilv.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+Fde+ld/4sGgSKrAUxZSGkT/mr1xjoM3zJiebHiO81s=;
        b=FUiENWwCKyTx50WbI8a56sv5DgLnFseppsopjtJx+LYkUJoukQpIl6mRrxSE9/oFpy
         XGrf3MIhQ5WJ1F/TFDXbYJwOnJBBlQql0CQNa8ck9jZpG7mPourWbMzQvUubSoW6uWa6
         6mVQQGnsqCMsyhlgtmD8T8j14E/0ttUkafJ/uo/CSmXgdOFBf1Yda7OzXa9mRJf+dVaI
         pvL51iWb91uzAFbSOm2w1xbiBjeOeqaWlsaZBvCOq+em3B2NFNz2GsFo37UC21hnEdUX
         OARjUwtlrXOLEo/01DyTN5i9eN5mcfwYKRRQexLV+3DUz1JBKKtyKUqmdpV30hdlxGNU
         TcSg==
X-Gm-Message-State: AOAM530EpyIKaJC9tl7QBz3HNIPY/vGMYd8X9QM/G3lMISu4BYOpIi1Y
        EX/CWo0Zi96FQfJLhuf0w+Yky88UiBGi6w7uvv2TatjlaHoYG8AOmoIwlPeGHM39Fj8Mm4kvvtj
        oTkxVl2H+8DV6B9VvkspgFJHl
X-Received: by 2002:a92:6706:0:b0:2cd:f8ad:dddf with SMTP id b6-20020a926706000000b002cdf8addddfmr10394857ilc.212.1652741861948;
        Mon, 16 May 2022 15:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLZo+UyzsScR37PCkysR03v7p5DHDyGrg2pMRzkR2EGIg03bvEHUi2kJ6/fv2xRF05zvb3pQ==
X-Received: by 2002:a92:6706:0:b0:2cd:f8ad:dddf with SMTP id b6-20020a926706000000b002cdf8addddfmr10394848ilc.212.1652741861737;
        Mon, 16 May 2022 15:57:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z4-20020a05660229c400b0065a48a57f6dsm166857ioq.40.2022.05.16.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:41 -0700 (PDT)
Date:   Mon, 16 May 2022 16:57:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "windy.bi.enflame" <windy.bi.enflame@gmail.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] drivers/pci: wait downstream hierarchy ready instead of
 slot itself ready, after secondary bus reset
Message-ID: <20220516165740.6256af51.alex.williamson@redhat.com>
In-Reply-To: <20220516202825.GA1047972@bhelgaas>
References: <20220516173047.123317-1-windy.bi.enflame@gmail.com>
        <20220516202825.GA1047972@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 15:28:25 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Lukas, pciehp expert; Alex, reset person]
> 
> Thanks for the testing, analysis, and patch!
> 
> Run "git log --oneline drivers/pci/pci.c" and make your subject line
> similar.
> 
> On Tue, May 17, 2022 at 01:30:47AM +0800, windy.bi.enflame wrote:
> > While I do reset test of a PCIe endpoint device on a server, I find that
> > the EP device always been removed and re-inserted again by hotplug module,
> >  after secondary bus reset.
> > 
> > After checking I find:  
> > 1> "pciehp_reset_slot()" always disable slot's DLLSC interrupt before  
> >    doing reset and restore after reset, to try to filter the hotplug
> >    event happened during reset.  
> > 2> "pci_bridge_secondary_bus_reset()" sleep 1 seconad and "pci_dev_wait()"  
> >    until device ready with "PCIE_RESET_READY_POLL_MS" timeout.  
> > 3> There is a PCIe switch between CPU and the EP devicem the topology as:  
> >    CPU <-> Switch <-> EP.  
> > 4> While trigger sbr reset at the switch's downstream port, it needs 1.5  
> >    seconds for internal enumeration.  
> 
> s/seconad/second/
> s/devicem/device/
> s/sbr/SBR/
> s/"pciehp_reset_slot()"/pciehp_reset_slot()/ also for other functions
> 
> > About why 1.5 seconds ready time is not filtered by "pci_dev_wait()" with
> > "PCIE_RESET_READY_POLL_MS" timeout, I find it is because in
> > "pci_bridge_secondary_bus_reset()", the function is operating slot's
> > config space to trigger sbr and also wait slot itself ready by input same
> > "dev" parameter. Different from other resets like FLR which is triggered
> > by operating the config space of EP device itself, sbr is triggered by
> > up slot but need to wait downstream devices' ready, so I think function
> > "pci_dev_wait()" works for resets like FLR but not for sbr.

Is the unexpected hotplug occurring then because the device is not
ready after the 1s sleep after the sbr and we re-trigger the hotplug
controller which then triggers because the link status is still down?

> > In this proposed patch, I'm changing the waiting function used in sbr to
> > "pci_bridge_secondary_bus_wait()" which will wait all the downstream
> > hierarchy ready with the same timeout setting "PCIE_RESET_READY_POLL_MS".
> > In "pci_bridge_secondary_bus_wait()" the "subordinate" and
> > "subordinate->devices" will be checked firstly, and then downstream
> > devices' present state.
> > 
> > Signed-off-by: windy.bi.enflame <windy.bi.enflame@gmail.com>  
> 
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.17#n407
> regarding pseudonyms.
> 
> > ---
> >  drivers/pci/pci.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9ecce435fb3f..d7ec3859268b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5002,6 +5002,29 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> >  	}
> >  }
> >  
> > +int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> > +{
> > +	struct pci_dev *dev;
> > +	int delay = 1;
> > +
> > +	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> > +		return 0;
> > +
> > +	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> > +		while (!pci_device_is_present(dev)) {
> > +			if (delay > timeout) {
> > +				pci_warn(dev, "secondary bus not ready after %dms\n", delay);
> > +				return -ENOTTY;
> > +			}
> > +
> > +			msleep(delay);
> > +			delay *= 2;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  void pci_reset_secondary_bus(struct pci_dev *dev)
> >  {
> >  	u16 ctrl;
> > @@ -5045,7 +5068,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
> >  {
> >  	pcibios_reset_secondary_bus(dev);
> >  
> > -	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);

I assume pci_dev_wait here was always a no-op because we're testing the
wrong device, maybe this should be marked as:

Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")

> > +	return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);

The theory looks reasonable to me, but I'd hope we cold get a better
commit log and improve the dev_warn message.  It seems to make sense to
use pci_device_is_present() since we shouldn't be dealing with VFs
after a bus reset, but I wonder if we want to enumerate all the missing
devices.  Since the timeout has passed, we shouldn't incur any extra
delays beyond the first device that doesn't re-appear.  Thanks,

Alex

> >  }
> >  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
> >  
> > -- 
> > 2.36.1
> >   
> 

