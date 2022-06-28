Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6C55DAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiF1HOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiF1HOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:14:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55DD2A431
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3B0BCE1EE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6910C3411D;
        Tue, 28 Jun 2022 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656400436;
        bh=+ycfB1Hl0lD9RheqfPWf44MXTkEi9iGYdW2HhYKiQ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cAMmlyJaLmp0Gsp5dl+tiF9f4+HJVhKzhhUrCBzpt8EC9pSbGQo9PAl0oQ2YoG12E
         UcoJ0Fg0T+0n4Ao5iIpigLYj04rOkHx7j3X1mVjDXlH/zvIOkGEh5g5Ay+ibjvECJE
         enywzKf7END8JfLzUG8v7TnFV6GFbjf44SikhMfY=
Date:   Tue, 28 Jun 2022 09:13:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] habanalabs: enable gaudi2 code in driver
Message-ID: <YrqqMYcqN8L+1Yfe@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-13-ogabbay@kernel.org>
 <Yrqfs3xUWwqHcbeR@kroah.com>
 <CAFCwf1086rKquhRC7SebTkPe=wLyd+jpr==eLtf+JsN_XdJ-2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf1086rKquhRC7SebTkPe=wLyd+jpr==eLtf+JsN_XdJ-2w@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:05:42AM +0300, Oded Gabbay wrote:
> On Tue, Jun 28, 2022 at 9:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 27, 2022 at 11:26:20PM +0300, Oded Gabbay wrote:
> > > Enable the Gaudi2 ASIC code in the pci probe callback of the driver so
> > > the driver will handle Gaudi2 ASICs.
> > >
> > > Add the PCI ID to the PCI table and add the ASIC enum value to all
> > > relevant places.
> > >
> > > Fixup the device parameters initialization for Gaudi2.
> > >
> > > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > > ---
> > >  drivers/misc/habanalabs/common/device.c       |  8 +++
> > >  drivers/misc/habanalabs/common/habanalabs.h   | 13 ++--
> > >  .../misc/habanalabs/common/habanalabs_drv.c   | 67 +++++++++++++++----
> > >  drivers/misc/habanalabs/common/sysfs.c        |  6 ++
> > >  4 files changed, 77 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> > > index 38cf2f1659ee..a4656eac495e 100644
> > > --- a/drivers/misc/habanalabs/common/device.c
> > > +++ b/drivers/misc/habanalabs/common/device.c
> > > @@ -645,6 +645,14 @@ static int device_early_init(struct hl_device *hdev)
> > >               gaudi_set_asic_funcs(hdev);
> > >               strscpy(hdev->asic_name, "GAUDI SEC", sizeof(hdev->asic_name));
> > >               break;
> > > +     case ASIC_GAUDI2:
> > > +             gaudi2_set_asic_funcs(hdev);
> > > +             strscpy(hdev->asic_name, "GAUDI2", sizeof(hdev->asic_name));
> > > +             break;
> > > +     case ASIC_GAUDI2_SEC:
> > > +             gaudi2_set_asic_funcs(hdev);
> > > +             strscpy(hdev->asic_name, "GAUDI2 SEC", sizeof(hdev->asic_name));
> > > +             break;
> > >       default:
> > >               dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
> > >                       hdev->asic_type);
> > > diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
> > > index 4537845658f8..587b1c537115 100644
> > > --- a/drivers/misc/habanalabs/common/habanalabs.h
> > > +++ b/drivers/misc/habanalabs/common/habanalabs.h
> > > @@ -3033,7 +3033,6 @@ struct hl_reset_info {
> > >   * @disabled: is device disabled.
> > >   * @late_init_done: is late init stage was done during initialization.
> > >   * @hwmon_initialized: is H/W monitor sensors was initialized.
> > > - * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.
> >
> > You remove this field, but you still keep it in the structure, you just
> > move it later down to the bottom for some reason:
> >
> > >   * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
> > >   *                   otherwise.
> > >   * @dram_default_page_mapping: is DRAM default page mapping enabled.
> > > @@ -3066,6 +3065,10 @@ struct hl_reset_info {
> > >   * @is_compute_ctx_active: Whether there is an active compute context executing.
> > >   * @compute_ctx_in_release: true if the current compute context is being released.
> > >   * @supports_mmu_prefetch: true if prefetch is supported, otherwise false.
> > > + * @reset_upon_device_release: reset the device when the user closes the file descriptor of the
> > > + *                             device.
> > > + * @skip_iatu_for_unsecured_device: skip the device PCI controller initialization when working
> > > + *                                  with device that runs f/w that is not secured.
> > >   */
> > >  struct hl_device {
> > >       struct pci_dev                  *pdev;
> > > @@ -3175,7 +3178,6 @@ struct hl_device {
> > >       u8                              disabled;
> > >       u8                              late_init_done;
> > >       u8                              hwmon_initialized;
> > > -     u8                              heartbeat;
> > >       u8                              reset_on_lockup;
> > >       u8                              dram_default_page_mapping;
> > >       u8                              memory_scrub;
> > > @@ -3199,6 +3201,8 @@ struct hl_device {
> > >       u8                              is_compute_ctx_active;
> > >       u8                              compute_ctx_in_release;
> > >       u8                              supports_mmu_prefetch;
> > > +     u8                              reset_upon_device_release;
> > > +     u8                              skip_iatu_for_unsecured_device;
> > >
> > >       /* Parameters for bring-up */
> > >       u64                             nic_ports_mask;
> > > @@ -3212,11 +3216,9 @@ struct hl_device {
> > >       u8                              dram_scrambler_enable;
> > >       u8                              hard_reset_on_fw_events;
> > >       u8                              bmc_enable;
> > > -     u8                              rl_enable;
> > >       u8                              reset_on_preboot_fail;
> > > -     u8                              reset_upon_device_release;
> > > -     u8                              skip_iatu_for_unsecured_device;
> > >       u8                              reset_if_device_not_idle;
> > > +     u8                              heartbeat;
> > >  };
> >
> > Did you mean to do that?
> >
> > thanks,
> >
> > greg k-h
> 
> Yes, I meant to do that. There are (currently) 13 variables under the
> comment of "bring-up" parameters.
> These parameters are used all over our code and in our internal
> package we expose them as kernel module parameters for us to play with
> to help with bring-ups and testing on palladium.
> But in the upstream driver, I just set them to fixed values and I
> remove the comments as I don't want anyone to play with them. And of
> course I don't expose them as kernel params.
> 
> The alternative is to remove their usage from all over the code but
> this will create for me a serious headache when taking patches and
> upstreaming them, because the code will be very different from our
> internal development tree.
> 
> After I explained all the above, I think I'll just add the comments
> anyway, to make this documentation complete. I hope this will remove
> any future confusion.

Just keep the comments, that makes it easier to understand.

thanks,

greg k-h
