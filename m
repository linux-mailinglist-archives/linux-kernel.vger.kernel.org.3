Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B69562911
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiGACdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiGACdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1F61D43;
        Thu, 30 Jun 2022 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656642783; x=1688178783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LiAn2X9eQ7NJ+Zx/ueM1wc+DveBL6IQuLDzjH+SXoAc=;
  b=duSEcMBkuVvZx3Y4wchDsMdL286UfieQP0P5fRNsVHLXu5numb2pcp5N
   KEGSr/kRrl07Wtw8FiIdfq3zYgudkCvxGty6LiXSANOrXP3S512b9HMDN
   E1wbkM/rhAVFJ4HEwq1r5IIX5j9R5vCamdQvfXHOF7TUk1IVVc2pbcEm6
   yd7/faN2mZ+4Q/2jbxG2XxWM12K1bAbwkeicUzDGVwXIHAmF1h3nTtP7t
   csVzdp+niJkFkW2bvGw1jVrJvDXe0U4kmtbQoUCiPzhvFyzQ42skTwbka
   HbgTczpXPkVbFgTeGcWuFmR3SZgMNyn4y4DHQbGsZm5t1k2Cg0PTnou+D
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271303997"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="271303997"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:33:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="648153359"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:32:59 -0700
Date:   Fri, 1 Jul 2022 10:31:37 +0800
From:   Philip Li <philip.li@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        senozhatsky@chromium.org, yunkec@google.com, lkp@intel.com,
        kbuild-all@lists.01.org, linux-media@vger.kernel.org
Subject: Re: [kbuild-all] Re: [PATCH v7 2/8] media: uvcvideo: Add support for
 per-device control mapping overrides
Message-ID: <Yr5ciSrjtftJ0+OU@rli9-dbox>
References: <20220617103645.71560-3-ribalda@chromium.org>
 <202206301144.r7yv0yk2-lkp@intel.com>
 <CANiDSCu1+0C7mfmm20ERVdvbzyJmoifnp6tcjEcd7EJfUAijSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCu1+0C7mfmm20ERVdvbzyJmoifnp6tcjEcd7EJfUAijSQ@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:16:23AM +0200, Ricardo Ribalda wrote:
> Hi Dan
> 
> Thanks for your mail
> 
> On Thu, 30 Jun 2022 at 13:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hi Ricardo,
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/uvcvideo-Fix-handling-of-power_line_frequency/20220617-185644
> > base:   git://linuxtv.org/media_tree.git master
> > config: microblaze-randconfig-m031-20220629 (https://download.01.org/0day-ci/archive/20220630/202206301144.r7yv0yk2-lkp@intel.com/config)
> > compiler: microblaze-linux-gcc (GCC) 11.3.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/media/usb/uvc/uvc_ctrl.c:2459 uvc_ctrl_init_ctrl() error: uninitialized symbol 'mapping'.
> >
> > vim +/mapping +2459 drivers/media/usb/uvc/uvc_ctrl.c
> >
> > 866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2401  static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> > 866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2402                            struct uvc_control *ctrl)
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2403  {
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2404     const struct uvc_control_info *info = uvc_ctrls;
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2405     const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2406     const struct uvc_control_mapping *mapping;
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2407     const struct uvc_control_mapping *mend;
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2408
> > 52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2409     /* XU controls initialization requires querying the device for control
> > 52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2410      * information. As some buggy UVC devices will crash when queried
> > 52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2411      * repeatedly in a tight loop, delay XU controls initialization until
> > 52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2412      * first use.
> > 52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2413      */
> > 52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2414     if (UVC_ENTITY_TYPE(ctrl->entity) == UVC_VC_EXTENSION_UNIT)
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2415             return;
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2416
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2417     for (; info < iend; ++info) {
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2418             if (uvc_entity_match_guid(ctrl->entity, info->entity) &&
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2419                 ctrl->index == info->index) {
> > 866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2420                     uvc_ctrl_add_info(chain->dev, ctrl, info);
> > 93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2421                     /*
> > 93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2422                      * Retrieve control flags from the device. Ignore errors
> > 93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2423                      * and work with default flag values from the uvc_ctrl
> > 93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2424                      * array when the device doesn't properly implement
> > 93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2425                      * GET_INFO on standard controls.
> > 93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2426                      */
> > 866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2427                     uvc_ctrl_get_flags(chain->dev, ctrl, &ctrl->info);
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2428                     break;
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2429              }
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2430     }
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2431
> > 071c8bb827c80a drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2432     if (!ctrl->initialized)
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2433             return;
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2434
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2435     /*
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2436      * First check if the device provides a custom mapping for this control,
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2437      * used to override standard mappings for non-conformant devices. Don't
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2438      * process standard mappings if a custom mapping is found. This
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2439      * mechanism doesn't support combining standard and custom mappings for
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2440      * a single control.
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2441      */
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2442     if (chain->dev->info->mappings) {
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2443             bool custom = false;
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2444             unsigned int i;
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2445
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2446             for (i = 0; (mapping = chain->dev->info->mappings[i]); ++i) {
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2447                     if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2448                         ctrl->info.selector == mapping->selector) {
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2449                             __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2450                             custom = true;
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2451                     }
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2452             }
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2453
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2454             if (custom)
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2455                     return;
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2456     }
> >
> > "mapping" uninitialized if chain->dev->info->mappings is NULL.
> >
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2457
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2458     /* Process common mappings next. */
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17 @2459     mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
> >                                                                                                ^^^^^^^
> >
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2460     for (mapping = uvc_ctrl_mappings; mapping < mend; ++mapping) {
> >
> > I'm surprised this made it through testing...  Anyway, the easier way to
> > to iterate through an array of structs is just say:
> 
> There is already a new version under review that fixes this:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/20220617235610.321917-3-ribalda@chromium.org/
> 
> 
> >
> >         for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); i++) {
> >                 mapping = &uvc_ctrl_mappings[i];
> >
> 
> I agree, and that is what I normally used, but that driver iterate this way...
> 
> Thanks again!
> 
> PS: Any idea why the test was triggered 14+ days after the patch was sent?

Thanks, the config is a random one, which is generated on 6/29 "microblaze-randconfig-m031-20220629",
which is probably the case that only this randconfig has chance to trigger the issue
and bisect successfully.

> 
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2461             if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2462                 ctrl->info.selector == mapping->selector)
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2463                     __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2464     }
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2465
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2466     /* Finally process version-specific mappings. */
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2467     if (chain->dev->uvc_version < 0x0150) {
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2468             mapping = uvc_ctrl_mappings_uvc11;
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2469             mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2470     } else {
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2471             mapping = uvc_ctrl_mappings_uvc15;
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2472             mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc15);
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2473     }
> > 87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2474
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2475     for (; mapping < mend; ++mapping) {
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2476             if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> > 071c8bb827c80a drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2477                 ctrl->info.selector == mapping->selector)
> > 866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2478                     __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2479     }
> > ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2480  }
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> >
> 
> 
> -- 
> Ricardo Ribalda
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
