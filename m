Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A95B02E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIGLaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIGLaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:30:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01A72843;
        Wed,  7 Sep 2022 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662550197; x=1694086197;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TrnktqRIs+K86T7z1mbr+yegNoYFDmK9/RGPfMKeYaU=;
  b=Ybwtqw8/9gpk3DwiA2bJfAED9wHEjA0VQhtfGuoRU3mNRwcPwTAJTiA1
   EqrVZbHZvQQpCEoRaVs8iuJPxxjdNARmxVFTJ1ix6dhAoIJTvm4eZl/1Z
   NO5PACLWxYSghiQ4XQhrN/g6ZUFHW8GMvCyFjAHTCDSvUyphk37+yqywl
   D6mFII7Gh8Zqu7XEgc9W4Hia89x3O88m5vgkgriFGz/QENC9LbSsubmy7
   845a2OZWLvfU/sfkHL7wNVV+MpWUIMk5TYB0UOeTm++SfY9kHRtb6BNQJ
   Xj5/g/vZJPwthIYyytpiZ2RWSQ6VFaGHK0g7xZr5zyRAmFupzwWMt/YME
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279859340"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="279859340"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:29:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676146243"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:29:50 -0700
Date:   Wed, 7 Sep 2022 14:29:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu.Moga@microchip.com
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, admin@hifiphile.com,
        Kavyasree.Kotagiri@microchip.com, Tudor.Ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of
 the existence of GCLK
In-Reply-To: <f3e87d18-41aa-f1e2-e0fb-8944c9fb4910@microchip.com>
Message-ID: <caf05bb5-26df-68ca-59a1-e84983294de@linux.intel.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com> <20220906135511.144725-13-sergiu.moga@microchip.com> <3f98d634-789-a0bd-84e-cfc2a1de70af@linux.intel.com> <f3e87d18-41aa-f1e2-e0fb-8944c9fb4910@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-565948247-1662550196=:1717"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-565948247-1662550196=:1717
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Sep 2022, Sergiu.Moga@microchip.com wrote:

> On 07.09.2022 12:36, Ilpo Järvinen wrote:
> > On Tue, 6 Sep 2022, Sergiu Moga wrote:
> > 
> >> Previously, the atmel serial driver did not take into account the
> >> possibility of using the more customizable generic clock as its
> >> baudrate generator. Unless there is a Fractional Part available to
> >> increase accuracy, there is a high chance that we may be able to
> >> generate a baudrate closer to the desired one by using the GCLK as the
> >> clock source. Now, depending on the error rate between
> >> the desired baudrate and the actual baudrate, the serial driver will
> >> fallback on the generic clock. The generic clock must be provided
> >> in the DT node of the serial that may need a more flexible clock source.
> >>
> >> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >> ---

> > Is percent accurate enough or would you perhaps want something slightly
> > more accurate?
> > 
> 
> 
> It is accurate enough for the all the baudrates I have tested. It 
> usually taps into the GCLK whenever high baudrates such as 921600 are 
> used. For 115200 for example, the error rate was slightly better in the 
> case of the peripheral clock and it acted accordingly, choosing the 
> latter as its baudrate source clock. I do not think that a higher 
> accuracy than this would be needed though. Say that using percent 
> accuracy yields that the error rates are equal, but the gclk would have 
> been better in this case by, say, a few 10 ^ -4, but the code logic does 
> not see it so it proceeds using the peripheral clock. In that case, the 
> error rate of the peripheral clock would still be low enough relative to 
> the desired baudrate for the communication to function properly.
> 
> The higher the baudrate, the lower the error rate must be in order for 
> things to go smoothly. For example, for a baudrate of 57600 I noticed 
> that even an error rate as big as 6% is still enough for the 
> communication to work properly, while in the case of 921600 anything 
> bigger than 2% and things do not go smoothly anymore. So I guess that it 
> would be safe to say that, unless you go for baudrates as high as tens 
> of millions, things should work well with just percent accuracy. A 
> higher accuracy always definetely helps, but I believe it is not needed 
> in this case.
> 
> 
> > Given you've abs() at the caller side, the error rate could be
> > underestimated, is underestimating OK?
> > 
> 
> 
> Yes, this should be fine. While (both empirically and after looking 
> stuff up) I noticed that in the case of negative error rates, their 
> absolute value needs to be smaller than the one of positive error rates, 
> it must be so by a very small margin that is negligible when estimating 
> through percent accuracy.

OK. Thanks for checking.


-- 
 i.

--8323329-565948247-1662550196=:1717--
