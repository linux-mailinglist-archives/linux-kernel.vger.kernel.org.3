Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0857843A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiGRNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiGRNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:47:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8A25C58
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658152056; x=1689688056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E9AP2s70xFyX/Kx7r8Cy/LmGrjmh6rN1yf6uQ7FJICQ=;
  b=IHwavW9DzyvYHg1fMCY9kVS2TIBANUiNrEjI54OvlA7qrxJ50tHX4nyz
   qArHHJ+Vppy4Ay4g8u0wELMcLpNY4dVl+/c+p9ImpMa0bs03lAmV0uk9F
   zV5UQ9Go4JupMY9DLoCykXAno388vqsqKam2O32oFyWfAgfPYD4ZvSe1x
   BEge5x6cwu8S7ESX0aVftK3zLpUl0+F7hdKcNrQ1H0hKs+3hvW/iQMIiU
   Svqu+bY9w9UUirDfdst6aEZF8tqNXy/kwhdgCNW/KStOQgPmRyS/cwOkD
   8xmnK1zRj818tVhPz28MnksFh8Q/8+LMU9Q4GIWLg9/VkWBmekMZLzmIY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266005477"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266005477"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 06:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="624735226"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2022 06:47:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 06:47:35 -0700
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15]) by
 ORSMSX602.amr.corp.intel.com ([10.22.229.15]) with mapi id 15.01.2375.028;
 Mon, 18 Jul 2022 06:47:35 -0700
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
Subject: RE: [PATCH v5 02/14] drm/i915/gsc: add slow_fw flag to the mei
 auxiliary device
Thread-Topic: [PATCH v5 02/14] drm/i915/gsc: add slow_fw flag to the mei
 auxiliary device
Thread-Index: AQHYkS2y4nDoBS6zcUm7lJX3uj+Lia1zfVmAgA+SR+A=
Date:   Mon, 18 Jul 2022 13:47:35 +0000
Message-ID: <c5cae0f43af84182b9539085012088d8@intel.com>
References: <20220706114345.1128018-1-alexander.usyskin@intel.com>
 <20220706114345.1128018-3-alexander.usyskin@intel.com>
 <Ysb5464dRPxPrp0d@intel.com>
In-Reply-To: <Ysb5464dRPxPrp0d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> On Wed, Jul 06, 2022 at 02:43:33PM +0300, Alexander Usyskin wrote:
> > Add slow_fw flag to the mei auxiliary device info to inform the mei
> > driver about slow underlying firmware.
> > Such firmware will require to use larger operation timeouts.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> > ---
> >  include/linux/mei_aux.h | 1 +
>=20
> This patch has a wrong subject since it doesn't touch i915.

This is in a shared file between drm and mei, but I can resend.

>=20
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h index
> > 587f25128848..a29f4064b9c0 100644
> > --- a/include/linux/mei_aux.h
> > +++ b/include/linux/mei_aux.h
> > @@ -11,6 +11,7 @@ struct mei_aux_device {
> >  	struct auxiliary_device aux_dev;
> >  	int irq;
> >  	struct resource bar;
> > +	bool slow_fw;
> >  };
> >
> >  #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
> > --
> > 2.34.1
> >
