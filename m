Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42B25A0CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiHYJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiHYJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9869A406F;
        Thu, 25 Aug 2022 02:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7856061BB3;
        Thu, 25 Aug 2022 09:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F1DC433D6;
        Thu, 25 Aug 2022 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420591;
        bh=9Crr74BWCn4TLo/96gD6DPgzglBlyGdZFZWB4fnsnkU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QV17U11z/PWFsSW3ON5w1o+02gMVm3kqowdsncsi9KALMdzl44jC3UKC0YLfYb3VK
         KQLTDHmtG6bRWINxFHMsYJOGIKLRXa427PYQ/7f2TUUhDH6RZPxAjV0wkGv1f9XzFQ
         E/rMFXxzGaHpZS+xDwBIPmn8pvwNSVTURN08KghtdlVIEUO4O4Ov97X6e0MgVCfJwl
         fLapOuNRIjEgoO+WhJUQBObUUpDlpWxewZiamJead/3BxIupqlooUe0WYE6GRDJKEr
         uvM+AypBDBrJK6PRVTokmCHieN+vd98x0g7SyWuRi0iKNBbDyQ8EBG7YwL9soPIBLM
         lcjZmadvZmNhA==
Date:   Thu, 25 Aug 2022 11:43:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <bnatikar@amd.com>
cc:     Akihiko Odaki <akihiko.odaki@gmail.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3] AMD_SFH: Add a DMI quirk entry for Chromebooks
In-Reply-To: <3bb043a4-987d-5896-29e1-21bb471da0e3@amd.com>
Message-ID: <nycvar.YFH.7.76.2208251142560.19850@cbobk.fhfr.pm>
References: <20220816102120.6131-1-akihiko.odaki@gmail.com> <3bb043a4-987d-5896-29e1-21bb471da0e3@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022, Basavaraj Natikar wrote:

> On 8/16/2022 3:51 PM, Akihiko Odaki wrote:
> > Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
> > of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
> > functionalities, even including the registers necessary for feature
> > detections.
> >
> > The behavior was observed with Lenovo ThinkPad C13 Yoga.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> > index 4b90c86ee5f8..47774b9ab3de 100644
> > --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> > +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> > @@ -288,11 +288,29 @@ int amd_sfh_irq_init(struct amd_mp2_dev *privdata)
> >  	return 0;
> >  }
> >  
> > +static const struct dmi_system_id dmi_nodevs[] = {
> > +	{
> > +		/*
> > +		 * Google Chromebooks use Chrome OS Embedded Controller Sensor
> > +		 * Hub instead of Sensor Hub Fusion and leaves MP2
> > +		 * uninitialized, which disables all functionalities, even
> > +		 * including the registers necessary for feature detections.
> > +		 */
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> > +		},
> > +	},
> > +	{ }
> > +};
> > +
> >  static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct amd_mp2_dev *privdata;
> >  	int rc;
> >  
> > +	if (dmi_first_match(dmi_nodevs))
> > +		return -ENODEV;
> > +
> >  	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
> >  	if (!privdata)
> >  		return -ENOMEM;
> 
> Could you please prefix amd_sfh patches with 'HID: amd_sfh:'
> With that addressed,
> 
> Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

I have fixed that up and applied. Thanks,

-- 
Jiri Kosina
SUSE Labs

