Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB45A993F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiIANnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiIANmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:42:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1000586041;
        Thu,  1 Sep 2022 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662039721; x=1693575721;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+lQKwXNZpAuQINVUmfj0tEtA/2ipPtcHfyLg00xvWMk=;
  b=QOi018ZCl2QTywhk5uQQ4n7B5CRnq3i9M/k1naMfs4SAs2SU8isFaez+
   iZz8DBiJCqPV6fJXWvBN6hHDXOCpRgsdPxL8rGAj5R5s6ZdjwFD1lYl+F
   oXztNCM/lP2CtMvFFkKrg/hDxGRG8KvsWjPDAQMFqMJMCzdZmllmsWWvN
   37RWHr3+jqYYn4oGxQLOlxg4QP4FRBGHFvTGnS6pknljsX6tRceCBX9Re
   h0Ruo4kfNXlzG894buUyH3UkLLI2hxuiBs+SdiyNKjVgKuhWtY6prNF04
   qrNQiT54cxJ3buOqH9+UgWtnZm5qyzdVtyZLw+LXXeIr2rx0QRR3HHpQn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296500268"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="296500268"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:41:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673852409"
Received: from rmalliu-mobl.amr.corp.intel.com ([10.249.44.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:41:54 -0700
Date:   Thu, 1 Sep 2022 16:41:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel.Thiagarajan@microchip.com
cc:     andy.shevchenko@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: RE: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the multi-function endpoint of pci1xxxx
 device.
In-Reply-To: <BN8PR11MB3668BAC07D493EE02AEAEB14E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
Message-ID: <63f48d1-f716-5040-c8d1-486087bd1c5e@linux.intel.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com> <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com> <CAHp75VfraADCTmZATWTSsYtC5uk5bc=WDVVm0jtUVO90xdFd9g@mail.gmail.com>
 <BN8PR11MB3668BAC07D493EE02AEAEB14E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022, Kumaravel.Thiagarajan@microchip.com wrote:

> > > +       const unsigned int standard_baud_list[] = {50, 75, 110, 134, 150, 300,
> > > +                                               600, 1200, 1800, 2000, 2400, 3600,
> > > +                                               4800, 7200, 9600, 19200, 38400, 57600,
> > > +                                               115200, 125000, 136400, 150000, 166700,
> > > +                                               187500, 214300, 250000, 300000, 375000,
> > > +                                               500000, 750000,
> > > + 1000000, 1500000};
> > 
> > Why?!
>
> The standard baud rates are handled within serial8250_do_set_termios 
> which is invoked from within mchp_pci1xxxx_set_termios in first place. 
> Hence if it matches with any of the standard baudrates,
> it can return immediately.

Care to explain why the baudrates in your table don't match those in 
tty_baudrate.c? ...It makes no sense to me that you call these "standard 
baud rates".


-- 
 i.

