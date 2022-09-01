Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57E15A969E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiIAMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiIAMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:20:40 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D668B7E6;
        Thu,  1 Sep 2022 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662034824;
  x=1693570824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5o5T+cNPjW0KviUEr8asDCjXy32h/49HXr3yNLpVmZ4=;
  b=QIccnKipNbrTytGmuIOZUf7ywmR/gUpOvxBEpGtjjoit+A/bWo77uy13
   twcwT0sh8LGlB+v0MfpMdbK/RBZUG1TBZTotwTZvKx2bjRvczapn/EVkQ
   mErrB61kOdMdUyxwa/Z+LSev4chlROG5uYaObCDQsXcItZVK6++To3FoN
   /77QF+or4T4h4wheKPxvvx9BkjYgOBLVr8SURdq02DSrAbmvHSKx4eFHi
   18C7iDFmH4GzWOCNzi13liQeDi+MYcRiV4qkJmiDPNd3ArIZd+FYt99Qv
   ezCW2f7lRQ5an8oIGWdEFbdcXpqMkRE0bcLzTPtjHNi2ynWaui9Z/STHM
   w==;
Date:   Thu, 1 Sep 2022 14:20:13 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "dj76.yang@samsung.com" <dj76.yang@samsung.com>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
Subject: Re: [PATCH 4/4] mfd: Samsung: Add Samsung sysmgr driver
Message-ID: <20220901122013.GU22198@axis.com>
References: <CGME20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
 <20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
 <f0ab0036-54eb-f0e4-3169-740e7fca9c65@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0ab0036-54eb-f0e4-3169-740e7fca9c65@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Thanks for your comments Krzysztof and sorry for being late in replying, I'll
try to fill in the blanks for some of the issues below.


The ARTPEC-8 is derived from a Samsung design, but built to order for Axis, so
long term responsibility will fall to Axis (me and Lars primarily).

The ARTPEC-6 and ARTPEC-7 were built by an other vendor and are quite different
not to mention that they are 32-bit ARMs, compared to ARM 64-bit for the ARTPEC-8.


The driver in this patchset is derived from the drivers/mfd/altera-sysmgr.c and
solves the same problem, in where the SoC system controller IP is a collection
of registers that controls quite a lot of different peripheral functions (from
PCIe and Ethernet to PWM) and is reachable only through SMC calls. I think the
naming of the software was set as samsung-sysmgr since it is not Axis design at
all, but (to my knowledge) only existing in ARTPEC-8 as yet. I can't recall why
the mfd driver route was selected, but it could be that the earlier
implementation was more complex and used both smc and direct mmio writes.

The users of this system manager would initially be the ARTPEC-8 DWC EQoS and
ARTPEC-8 DWC PCIe drivers sent in other patch-sets.


I believe a possible alternative to solve the system manager problem is to open
code the SMC calls directly from the drivers in question, quite a lot of
drivers seem to do this, notably a specific altera driver
(drivers/edac/altera_edac.c) even though it also has a reference to the above
mentioned altera-sysmgr regmap... :-)

Does that seem reasonable?

Thanks for your patience and excuses for the top-posting.

/Jesper

On Wed, Jul 13, 2022 at 09:27:52AM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2022 06:57, Dongjin Yang wrote:
[...]

> Best regards,
> Krzysztof

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
