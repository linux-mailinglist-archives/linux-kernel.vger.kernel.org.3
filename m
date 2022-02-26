Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598A44C572F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBZRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiBZRy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:54:56 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F0A418C;
        Sat, 26 Feb 2022 09:54:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21QHs4T8043234;
        Sat, 26 Feb 2022 11:54:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645898044;
        bh=UKCTPlYKasxptxjrQksvRLGUZwS0Va2B1Law47HK7OE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bzixc0s1f6RzzuZuZ6i9AlkyosF4POyZb9NzhAOZ3L27lUROaCzfUhfoaowabzPJX
         iV6XxqcYLZi01j4GkJwOwmik51TaAq/E/6T0lFbMWLK4LCGOjF4FTK5FmsUwK7F5QZ
         Ornzni2M/wENOi7Hx0LpGGTW7Vo+tLPgdbEfzeE0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21QHs3Fn071536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Feb 2022 11:54:04 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 26
 Feb 2022 11:54:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 26 Feb 2022 11:54:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21QHs3l4031275;
        Sat, 26 Feb 2022 11:54:03 -0600
Date:   Sat, 26 Feb 2022 11:54:03 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] arm64: Initial support for Texas Instruments AM62
 Platform
Message-ID: <20220226175403.ewufgirmnbmjxz3j@bryanbrattlof.com>
References: <20220225120239.1303821-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220225120239.1303821-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh

On February 25, 2022, thus sayeth Vignesh Raghavendra:
> This adds AM62 SoC support.
> 
> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
> architecture platform, providing ultra-low-power modes, dual display,
> multi-sensor edge compute, security and other BOM-saving integration.
> The AM62 SoC targets broad market to enable applications such as
> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
> Automation, Appliances and more.
> 
> More details can be found in the Technical Reference Manual:
> https://www.ti.com/lit/pdf/spruiv7
> 
> v3:
> * Update DM firmware reserved region to at top of 512MB DDR region

the patches look good to me :)

Reviewed-by: Bryan Brattlof <bb@ti.com>

have a great weekend
~Bryan
