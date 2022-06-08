Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4974543837
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiFHP43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244718AbiFHP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:56:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A71424B3;
        Wed,  8 Jun 2022 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654703785; x=1686239785;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PakbZTj6F8oVLf44PnFGTZXI1pnrNbdzeA/hNlTXs/E=;
  b=HMmHjWLuqcePZR3s7YEjcx6/y4Oek9jaNHZOBiMETLPyQiT8hxgOJqWN
   89TMRAyMb+H20008tZnN2IkJ0a0Trf+ltP/lp94Q6P5y3QaYmvHu5G4NI
   g4eh8QWSMILEYg9SmM/SxGI1fFH0H31HEFjojURQ51l1x0aNFoX7zqAbO
   fkZOdtZg30c6Vp34/t1vRnYukVZhN+0JpJp9mkuP7ZIN/XM34gtuuTons
   VB68Hr74svfSf5Yaodn/9w2drpgVkz+u/MObqqqaiOfQqtKm0NWyXnu3J
   QBoN7xlRPtvdg3MmU14RDt/N+hWPFwRpZe3LHKnZOV44v/2fOnDfnlC7b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="256775332"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="256775332"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 08:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="555458483"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2022 08:56:23 -0700
Received: from ssokhan1-mobl.amr.corp.intel.com (ssokhan1-mobl.amr.corp.intel.com [10.251.11.65])
        by linux.intel.com (Postfix) with ESMTP id F050258094D;
        Wed,  8 Jun 2022 08:56:22 -0700 (PDT)
Message-ID: <7d908ecc145f3dbf35161e39587f7bd82f1b64c2.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] platform/x86/intel: Fix uninitialized entry in
 pmt_crashlog_probe
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 08 Jun 2022 08:56:22 -0700
In-Reply-To: <CAHp75VenPBtQJ7SVMaOLqER_5HjUDUT-bdJawb3LK=n9oU+4Yg@mail.gmail.com>
References: <20220608011712.2371-1-xiaohuizhang@ruc.edu.cn>
         <CAHp75VenPBtQJ7SVMaOLqER_5HjUDUT-bdJawb3LK=n9oU+4Yg@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 12:58 +0200, Andy Shevchenko wrote:
> On Wed, Jun 8, 2022 at 9:45 AM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
> > Similar to the handling of pmt_telem_probe in commit 2cdfa0c20d58
> > ("platform/x86/intel: Fix 'rmmod pmt_telemetry' panic"), we thought
> > a patch might be needed here as well.
> > 
> > The probe function, pmt_crashlog_probe(), adds an entry for devices even if
> > they have not been initialized.  This results in the array of initialized
> > devices containing both initialized and uninitialized entries.  This
> > causes a panic in the remove function, pmt_crashlog_remove() which expects
> > the array to only contain initialized entries.
> > 
> > Only use an entry when a device is initialized.

Thanks for the patch. I've already acked the same fix here:

https://lore.kernel.org/all/9df6d96f9672b16ca88f5d2c7dd43c87ae938ad3.camel@linux.intel.com/

> 
> ...
> 
> >         auxiliary_set_drvdata(auxdev, priv);
> > 
> >         for (i = 0; i < intel_vsec_dev->num_resources; i++) {
> > -               struct intel_pmt_entry *entry = &priv->entry[i].entry;
> > +               struct intel_pmt_entry *entry = &priv->entry[priv-
> > >num_entries].entry;
> 
> This requires more explanation, what do the entry and the i mean in
> the below call?

priv->entry is an array of crashlog devices. i is the index to a resource for a
single device. It is correct that i cannot also be used, as it was here, to
refer to the device in the array. This is because we will skip some devices we
detect as unsupported without failing probe. So the array only contains a list
of devices we've added and may be less than the total available. This doesn't
affect probe or device usage, but it did affect remove since the current code
left gaps in the array where devices were skipped.

> Why is using the same entry over all resources fine?
> num_entries as an index is pointing out of bounds, is that what was
> really expected (first free entry?)?

Not shown is num_entries++ which happens only after successful addition of an
entry. It's not the case that the same entry gets reused over all resources.

num_entries cannot be used out of bounds. The array is allocated with
struct_size to the total number of resources.

Thanks,

David
> 
> 
> >                 ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns,
> > intel_vsec_dev, i);
> >                 if (ret < 0)
> 
> 

