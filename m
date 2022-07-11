Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1330A562A26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGAEHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:07:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCFC65
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:07:03 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 153A53F1E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656648420;
        bh=rCOTYadeHWs5UZ2Ov/Ru+opUXytTadUpqntpKx+cU+k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pveoyLXJZNnA9xdX1OeCsz/CYquD8YRdrRiZaqFNmF/dFNXcXCr5cTRcZk+Eda81h
         EWbKtRZjThfgHfE3TX74KbxuyRbOHOP6sYCsGjiS213bR6cCLwMrTU1yB/6cwWokcY
         YRTQKNtQtqEgubcbZepisjjQ+ljmGQhMOSQUTKSj6WHao+OOS4d1C9xD3whduTKSRU
         MHf+svbKvAfDxiIOCuHEDiDQKqHNxQuZq3phTDGfVWzZB94HWVB2NG1ORb1LKJoxpD
         iDdCViKY8E6WwuhgCvR6B3h64iy4wLClskbl1QuZRxeQl9U1X6PQNLfpLly0JAws9j
         P80ClndJSaw3Q==
Received: by mail-ot1-f69.google.com with SMTP id g1-20020a9d6181000000b00616d223ac8cso613712otk.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCOTYadeHWs5UZ2Ov/Ru+opUXytTadUpqntpKx+cU+k=;
        b=orlg2NAYBKu+L3RWcuxU/NjXSu91QUDkiJIQZ6SgNfkg/rc3VvSGvuSJn2CUetxYLu
         CCT/d/Wu598B6pfRXCsCDLeZi5qKJd6Z3dir8ZieAPRxFKg9KL5b6xdHI1OCP4hGRxVv
         mxR396fhD7uCYk6Np9ct+76Q9qOgx2qDHfRh6zCnZ/PCjpt8PEECtrmmJWZVsgXikF7y
         8mVu9+xGWckGHeeRs+EUNjdQv/NSonD3p0hnCWEA+ruV0lXnDLwuGyHrnxQgWLcVKTn5
         Ki0VAhHz4vE6HGzEL18zqHqfxKuOX6ZvUaH18FX+2DRpEsHnkwZzwAKAz7+tAusIAMEN
         xzLg==
X-Gm-Message-State: AJIora8+I7E92arWJJlT5kIg6cywBUJWLdeJAVaYA/Z5WWf7fm77MK3i
        vNuIxNnHnhfJUXCZcWunGhbjjRRBw7cc4ZS4Eiefu0Ptme7/ZUcuiVpk5ejimmngsPBYLzySmgq
        XwMLPDYvzsXoHgkh4IHtbATSa6xaaH+oik6BnYp9storwS/q/RyjnS6SzoA==
X-Received: by 2002:a05:6830:2a11:b0:616:be83:4bae with SMTP id y17-20020a0568302a1100b00616be834baemr5414258otu.224.1656648417885;
        Thu, 30 Jun 2022 21:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNvLNONNvXm8OT2scFuw3VIoFc7JtThSOM8AKY+O0x+QJ+4kpDKBoFmq8sV9wTGnnlCiNEJIECzCSGYTUON+k=
X-Received: by 2002:a05:6830:2a11:b0:616:be83:4bae with SMTP id
 y17-20020a0568302a1100b00616be834baemr5414254otu.224.1656648417569; Thu, 30
 Jun 2022 21:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220422222433.GA1464120@bhelgaas> <20220422222618.GA1523585@bhelgaas>
In-Reply-To: <20220422222618.GA1523585@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 1 Jul 2022 12:06:46 +0800
Message-ID: <CAAd53p4-pSL=JvfL_k-G4JSmi90eS6C50JuO+YuOFY9WLPRnjg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, baolu.lu@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        david.e.box@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 6:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, linux-pm; sorry forgot this last time]
>
> On Fri, Apr 22, 2022 at 05:24:36PM -0500, Bjorn Helgaas wrote:
> > On Fri, Apr 08, 2022 at 11:31:58PM +0800, Kai-Heng Feng wrote:
> > > On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> > > some errors reported by AER:
> > > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> > >
> > > So disable AER service to avoid the noises from turning power rails
> > > on/off when the device is in low power states (D3hot and D3cold), as
> > > PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> > > that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> > > (D3hot), L2 (D3cold with aux power) and L3 (D3cold).
> >
> > Help me walk through what's happening here, because I'm never very
> > confident about how error reporting works.  I *think* the Unsupported
> > Request error means some request was in progress and was not
> > completed.  I don't think a link going down should by itself cause
> > an Unsupported Request error because there's no *request*.
> >
> > I have a theory about what happened here.  Decoding the TLP Header
> > (from PCIe r6.0, sec 2.2.1.1, 2.2.8.10) gives:
> >
> >   34000000 (0011 0100 ...):
> >     Fmt               001        4 DW header, no data
> >     Type           1 0100        Msg, Local - Terminate at Receiver
> >
> >   08000052 (0800 ... 0101 0010)
> >     Requester ID     0800        00:08.0
> >     Message Code     0101 0010   PTM Request

Is there any TLP decoder software available? That will be really
helpful for debugging.

> >
> > From your lspci in bugzilla, 08:00 has PTM enabled.  So my theory is
> > that:
> >
> >   - 08:00.0 sent a PTM Request Message (a Posted Request)
> >   - 00:1d.0 received the PTM Request Message
> >   - The link transitioned to DL_Down
> >   - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
> >     Unsupported Request
> >   - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
> >     own PTM Enable was clear, it would also be treated as an
> >     Unsupported Request
> >
> > So I suspect we should disable PTM on 08:00.0 before putting it in a
> > low-power state.  If you manually disable PTM on 08:00.0, do these
> > errors stop happening?

Yes, disabling PTM on upstream port can solve the issue.
Thanks for find the root cause!

> >
> > David did something like this [1], but just for Root Ports.  That
> > looks wrong to me because sec 6.21.3 says we should not have PTM
> > enabled in an Upstream Port (i.e., in a downstream device like
> > 08:00.0) unless it is already enabled in the Downstream Port (i.e., in
> > the Root Port 00:1d.0).

So I think it should be like this?
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a82..8ba8a0e12946e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2717,7 +2717,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
         * port to enter a lower-power PM state and the SoC to reach a
         * lower-power idle state as a whole.
         */
-       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+           pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
                pci_disable_ptm(dev);

        pci_enable_wake(dev, target_state, wakeup);
@@ -2775,7 +2776,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
         * port to enter a lower-power PM state and the SoC to reach a
         * lower-power idle state as a whole.
         */
-       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+           pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
                pci_disable_ptm(dev);

        __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));


> >
> > Nit: can you remove the timestamps from the log?  They add clutter but
> > no useful information.

Sure.

> >
> > [1] https://git.kernel.org/linus/a697f072f5da
> >
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v4:
> > >  - Explicitly states the spec version.
> > >  - Wording change.
> > >
> > > v3:
> > >  - Remove reference to ACS.
> > >  - Wording change.
> > >
> > > v2:
> > >  - Wording change.
> > >
> > >  drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
> > >  1 file changed, 25 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 9fa1f97e5b270..e4e9d4a3098d7 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
> > >     return 0;
> > >  }
> > >
> > > +static int aer_suspend(struct pcie_device *dev)
> > > +{
> > > +   struct aer_rpc *rpc = get_service_data(dev);
> > > +
> > > +   aer_disable_rootport(rpc);
> > > +   return 0;
> > > +}
> > > +
> > > +static int aer_resume(struct pcie_device *dev)
> > > +{
> > > +   struct aer_rpc *rpc = get_service_data(dev);
> > > +
> > > +   aer_enable_rootport(rpc);
> > > +   return 0;
> > > +}
> > > +
> > >  /**
> > >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> > >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > > @@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> > >  }
> > >
> > >  static struct pcie_port_service_driver aerdriver = {
> > > -   .name           = "aer",
> > > -   .port_type      = PCIE_ANY_PORT,
> > > -   .service        = PCIE_PORT_SERVICE_AER,
> > > -
> > > -   .probe          = aer_probe,
> > > -   .remove         = aer_remove,
> > > +   .name                   = "aer",
> > > +   .port_type              = PCIE_ANY_PORT,
> > > +   .service                = PCIE_PORT_SERVICE_AER,
> > > +   .probe                  = aer_probe,
> > > +   .suspend                = aer_suspend,
> > > +   .resume                 = aer_resume,
> > > +   .runtime_suspend        = aer_suspend,
> > > +   .runtime_resume         = aer_resume,
> > > +   .remove                 = aer_remove,
> > >  };
> > >
> > >  /**
> > > --
> > > 2.34.1
> > >
