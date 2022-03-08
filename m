Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC14D1891
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiCHNBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347071AbiCHNBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:01:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1F47AE8;
        Tue,  8 Mar 2022 05:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646744405; x=1678280405;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=murWsNFPOe1OlSq+kj5GaepW/BVIXTdSkeIeUhjHRNg=;
  b=ahkuBYs1tXbnkkWSCnjvFnmwyQWDWJtmcq8akufPw2CnjQKV01mFPMZ1
   xtorutZ4PZbhfrKrC36Qlj9OOmE9vkowbRvv0qACN1QHwWkFCkYpCQ8on
   Nqotn1tpp5sBlnSKzaoKuHQFOhu6WOM/soLx7p9inhkmNd0M/hr8bsjtL
   4k4ZRVJzo38dh6DySNDuvGHFyzZZ+XnTevt9sdPunI1bTo9zMiDem1H/K
   FuJZm+c/YLflCQMdzwGrBKMy2z3Gpz23qn7yrLUJN+iAS793J3IyPe4Lb
   84FzIoqfwPkOu/GJp5FGYjS2dJOBhnHJkA2dtr32JsBxDDfyNeSHYdWJq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315391326"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="315391326"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:00:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="537558240"
Received: from lpessina-mobl.ger.corp.intel.com ([10.249.37.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:00:01 -0800
Date:   Tue, 8 Mar 2022 14:59:59 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
In-Reply-To: <20220308122220.GA24694@wunner.de>
Message-ID: <d9aabfe-1179-67c2-98d1-f36e7e698f33@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de> <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com> <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
 <20220307191854.GA27748@wunner.de> <YiZfdlw0A75cojCx@smile.fi.intel.com> <6931d6ad-7520-b585-a8ba-35349e730bb@linux.intel.com> <20220308122220.GA24694@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-177724195-1646744404=:1613"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-177724195-1646744404=:1613
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 8 Mar 2022, Lukas Wunner wrote:

> On Tue, Mar 08, 2022 at 02:16:56PM +0200, Ilpo Järvinen wrote:
> > The SoC also has a pin to select between RS485 and RS232. With a combo 
> > transceiver, TCR-based heuristic just runs into the same problems as the 
> > version-based one did.
> 
> I thought this was about detecting whether hardware-assisted DE assertion
> may be used (versus software-controlled), not about whether to enable
> RS-485 mode.  Right?

HW DE assertion only works when RS485 mode is enabled so I don't see how 
these questions could be easily decoupled like that. That's assuming with 
"software-controlled" you mean RTS(RS232)+em485?


-- 
 i.

--8323329-177724195-1646744404=:1613--
