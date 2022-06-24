Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2846559A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiFXNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiFXNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:02:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9F52E42;
        Fri, 24 Jun 2022 06:02:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25OD1arD057664;
        Fri, 24 Jun 2022 08:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656075696;
        bh=wKIIVX9B8JYUP227NnjRLL2+jjNstya4gK76fNwyOAk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lEpWPRGyud0Fo6Rl7uVhgn4HCA4AdMKTH9/pMlSVPSjLyDiDUQ3jvUvT52ByUIFH8
         GjUQhjFCW9zPkbrLQjv91ga2LW8PU7TsexZ7lpU1cQz0PQyVTvXJ13pm+Jd3W3YFVl
         4CdmBtOYQ1gpN17RcmggOIY5lfCiMgt10rS37RY4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25OD1aOv039910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jun 2022 08:01:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 24
 Jun 2022 08:01:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 24 Jun 2022 08:01:36 -0500
Received: from jti (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id 25OD1TAa115638;
        Fri, 24 Jun 2022 08:01:30 -0500
Date:   Fri, 24 Jun 2022 16:01:28 +0300
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH V4 2/2] rtc: Introduce ti-k3-rtc
Message-ID: <YrW1qLhha8VKQ5qV@jti>
References: <20220623170808.20998-1-nm@ti.com>
 <20220623170808.20998-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220623170808.20998-3-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 23, 2022 at 12:08:08PM -0500, Nishanth Menon wrote:
> Introduce support for Texas Instruments Real Time Clock controller on
> newer K3 family of SoCs such as AM62x.
> 
> The hardware module that is being supported is the "digital only"
> version which doesn't have capability of external wakeup sources and
> external power backup. However, for many practical applications, this
> should suffice as RTC is operational across low power sequences.
> 
> The hardware block by itself is split into two distinct domains
> internally to further reduce the power consumption with the actual
> counter block and comparators clocked off a 32k clock source (which
> based on SoC integration can be sourced by an external crystal) and an
> register interface block which is driven by the bus clock. While optimal
> from power perspective, it does create some complicated synchronizations
> and sequences that one must be wary of in the driver handling.
> 
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V3:
> * Updates for fixing typos, removal of un-necessary prints, sharpen
>   usage of ret

Tested on SK-AM62 (AM625).

Tested-by: Georgi Vlaev <g-vlaev@ti.com>

Regards,
Georgi
