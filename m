Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC44DBA94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358321AbiCPWPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358250AbiCPWPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E57D823BF2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647468815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=widanWPxmLsp9RBskMYejQsCIyl8ORL0mCMrniC/lyc=;
        b=PFROJbGKLKgxV6QcPquk6WHtYmHf9s7q0ll7GgqW7ryDp+pxKbfWq4CT7yXikGTLPo8M5t
        oA/+aUyZY161kdWz9QgnoUn9nPNaZqCfyv6tJSA5S7UBWYZnF1WMiU1yno3m8ywLFRVT0A
        hSGh/G0+qEt8/USooinkjAtzMDMeFwY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628--OKw5WlWO2C1A49YWsHxVQ-1; Wed, 16 Mar 2022 18:13:32 -0400
X-MC-Unique: -OKw5WlWO2C1A49YWsHxVQ-1
Received: by mail-io1-f72.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so2100707iox.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=widanWPxmLsp9RBskMYejQsCIyl8ORL0mCMrniC/lyc=;
        b=0XalATakL22knVT9mGHL1MG3AgiuCyEQ67JbcQUPEwz+c5xuoDY1OSViblofZSsaOe
         xfByW/natEBWnBWUfIDKO2xG3qZ5Q7G3OHaKYNSBKKar/GkbJ2xPiajbDRo7xmnQXEA/
         vR3C1LjdYYAo9jTQNS6eFExWhX3av1wYfkoLHSMx23Ua4NZSXy9u8/44HA69FZQ/jql+
         g30loaRYrphNbVJy19fD/AOpWnI4OkQLHxsSEHGR+CKWp8kl8ZInGb4mA9r7RHLy7TCf
         Dimg5wqLg3qTe2m7639IMQQjAzf5QkUDLOnmyRS4xCMr6/46zerFBSXnNiRsOhCLPhfP
         Uf0g==
X-Gm-Message-State: AOAM530M4mLm8xdxk4cgdnouLx2ZShIFdlGf03EW+xRlT4AZx182G47R
        mB+htqAIOxkh1hpWqhasniBzqMq9KOnA2VbmRdfmYrt5U2Kanhka8ZHpF4r7jeNSmjlQtLxmZNr
        UyzwQVdyzgkcimUzdWel8vaPz
X-Received: by 2002:a05:6638:1925:b0:31a:195e:5b94 with SMTP id p37-20020a056638192500b0031a195e5b94mr776660jal.86.1647468811866;
        Wed, 16 Mar 2022 15:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAaGdSZjg1GtXxQ/rFR6RFz8OURcGlq5550erjJAfWWF/Dl8hmfEKnAcNOewpLsv0oAOQYJQ==
X-Received: by 2002:a05:6638:1925:b0:31a:195e:5b94 with SMTP id p37-20020a056638192500b0031a195e5b94mr776652jal.86.1647468811532;
        Wed, 16 Mar 2022 15:13:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b12-20020a6be70c000000b00648f61d9652sm1542249ioh.52.2022.03.16.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:13:31 -0700 (PDT)
Date:   Wed, 16 Mar 2022 16:13:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <20220316161330.33b605da.alex.williamson@redhat.com>
In-Reply-To: <20220316211548.GA677098@bhelgaas>
References: <YjIMY1/r15xj65pZ@smile.fi.intel.com>
        <20220316211548.GA677098@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 16:15:48 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Wed, Mar 16, 2022 at 06:12:19PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 16, 2022 at 06:52:09AM -0500, Bjorn Helgaas wrote:  
> > > On Wed, Mar 16, 2022 at 12:27:57PM +0200, Andy Shevchenko wrote:  
> > > > On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:  
> > > > > On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:  
> > > > > > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:  
> > > > > > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:  
> > > > > > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work
> > > > > > > > if INTx is disabled.  Enable the respective quirk as
> > > > > > > > it's done for other ATI devices on this chipset,
> > > > > > > > 
> > > > > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on
> > > > > > > > PCI devices")  
> 
> > > > > Anyway, I applied this to pci/msi for v5.18 with the following
> > > > > commit log:
> > > > > 
> > > > >     PCI: Disable broken MSI on ATI SB600 USB adapters
> > > > > 
> > > > >     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't
> > > > >     work if INTx is disabled.  Disable MSI on these adapters.  
> > > > 
> > > > But IIUC MSI is _not_ disabled. That's why I have issued this
> > > > version of the patch with different commit message. Did I
> > > > misunderstand something?  
> > > 
> > > Oh, right, of course.  Sorry, I was asleep at the wheel.  
> > 
> > Are you going to fix that?  
> 
> Yes, of course, I'll do something with the commit message after we
> figure out how to handle PCI_COMMAND_INTX_DISABLE.
> 
> > > I guess it's just that for these devices, we don't disable INTx
> > > when enabling MSI.  I can't remember why we disable INTx when
> > > enabling MSI, but it raises the question of whether it's better to
> > > leave INTx enabled or to just disable use of MSI completely.  
> > 
> > It's required by specification to disable INTx if I read 6.1.4.3
> > Enabling Operation correctly.  
> 
> Thanks for the reference; I was looking for something like that.  But
> I don't think this section requires us to set
> PCI_COMMAND_INTX_DISABLE.  For the benefit of folks without the spec,
> PCIe r6.0, sec 6.1.4.3 says:
> 
>   To maintain backward compatibility, the MSI Enable bit in the
>   Message Control Register for MSI and the MSI-X Enable bit in the
>   Message Control Register for MSI-X are each Clear by default (MSI
>   and MSI-X are both disabled). System configuration software Sets one
>   of these bits to enable either MSI or MSI-X, but never both
>   simultaneously. Behavior is undefined if both MSI and MSI-X are
>   enabled simultaneously. Software disabling either mechanism during
>   active operation may result in the Function dropping pending
>   interrupt conditions or failing to recognize new interrupt
>   conditions. While enabled for MSI or MSI-X operation, a Function is
>   prohibited from using INTx interrupts (if implemented) to request
>   service (MSI, MSI-X, and INTx are mutually exclusive).
> 
> The only *software* constraints I see are (1) software must never
> enable both MSI and MSI-X simultaneously, and (2) if software disables
> MSI or MSI-X during active operation, the Function may fail to
> generate an interrupt when it should.
> 
> I read the last sentence as a constraint on the *hardware*: if either
> MSI or MSI-X is enabled, the Function is not allowed to use INTx,
> regardless of the state of PCI_COMMAND_INTX_DISABLE.
> 
> I searched the spec for "Interrupt Disable", looking for situations
> where software might be *required* to set it, but I didn't see
> anything.
> 
> I suspect "Interrupt Disable" was intended to help the OS stop all
> activity from a device during hot-plug or reconfiguration, as hinted
> at in sec 6.4, "Device Synchronization":
> 
>   The ability of the driver and/or system software to block new
>   Requests from the device is supported by the Bus Master Enable,
>   SERR# Enable, and Interrupt Disable bits in the Command register
>   (Section 7.5.1.1.3) of each device Function, and other such control
>   bits.
> 
> So I'm trying to figure out why when enabling MSI we need to set
> PCI_COMMAND_INTX_DISABLE for most devices, but it's safe to skip that
> for these quirked devices.

I don't have an authoritative answer, but in the conventional PCI 2.3
spec the bit definitions for DisINTx and MSI Enable cross reference each
other from which one might infer a symmetry that we disable one to use
the other.  In PCIe INTx becomes a virtual wire interrupt and there the
DisINTx bit definition states that setting this bit requires the device
to issue the de-assert message for that virtual wire, so there might be
some FUD relative to enabling MSI/X while the device has already
asserted INTx.

At best though, I don't know of anything to support that setting
DisINTx should have any effect on MSI/X, that much seems like it is
certainly a hardware bug.  Thanks,

Alex

