Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4855B2854
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIHVSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIHVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:18:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E8211213B;
        Thu,  8 Sep 2022 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662671899; x=1694207899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlN0VzIb1OGOfyFVjQlBuaoGRl8OlCVp2Bn+npbcAfE=;
  b=WgsehR0is2ycmrMGj0dKeXRj83mhG55tFr9DzO8eKpOkPPWBRkpY7w0y
   RCeE16K+dRb2bCvZlrkxP2qHXGDa3aRlFUF5QZak3j0DZUQloW41Vqe45
   trv5aDmKM9oTuNA6btQks9mkdVnBZFmboBplCqgNBosgRPlIumh6JppAe
   +sbMG4nnB6Km1k6aGNkRK+BqCG+OZb6SIeLkhxJ9IXoxnQJNXYwp9OCgS
   NmdAnMF5Xlv+PtFx8nrZ2r0bb7ncNBePbbxq4Rpyc0ryqsAeTOWwJuCMQ
   UNa+kkNcdd2YbGt9Vr0JuOFFGfv04ZuvqaMo5JbC5Sx7oe/b7xe6iiRmE
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179761230"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 14:18:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 14:18:19 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 14:18:18 -0700
Date:   Thu, 8 Sep 2022 23:22:39 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20220908212239.hyvtvnwyazuqs66a@soft-dev3-1.localhost>
References: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
 <CACRpkdYNvL9xf61BPJ1QDotXkJBG18+o=ZsFwoLw_LL-qGZ-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CACRpkdYNvL9xf61BPJ1QDotXkJBG18+o=ZsFwoLw_LL-qGZ-Qw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/08/2022 10:46, Linus Walleij wrote:
> 
> On Wed, Sep 7, 2022 at 9:59 AM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> 
> > When an external device generated a level based interrupt then the
> > interrupt controller could miss the interrupt. The reason is that the
> > interrupt controller can detect only link changes.
> 
> I see there are some further comments, I expect to just merge v3 into
> fixes as this needs to go into the -rc:s right?

That is correct, it should go into fixes.

> 
> Yours,
> Linus Walleij

-- 
/Horatiu
