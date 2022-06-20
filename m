Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5391551600
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiFTKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbiFTKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:35:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9B3140BA;
        Mon, 20 Jun 2022 03:35:07 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KAZ2vR037773;
        Mon, 20 Jun 2022 05:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655721302;
        bh=B/CMxOrjt3USywgvG1ViD+xucM6jErldrfE1XJdq7LY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=n3QmW4mo3zk9yGmAYU0yebQPnnjEbcNH/wKy2BRmua7OP2KlFtBW8vIsBL2XQQLPT
         stLMefhRLkULI7zktQ4LOjF2wBANpRqfCLL4OjnM7SwjAlWPQo/HrE0ZxIUBJ4QGX4
         LIsseadGPxr+BIXScUlCxz2P9N4DmeoNmqFrDWYc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KAZ2pc046067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 05:35:02 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 05:35:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 05:35:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KAZ1rF031751;
        Mon, 20 Jun 2022 05:35:02 -0500
Date:   Mon, 20 Jun 2022 16:05:01 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: am625-sk: Add audio output support
Message-ID: <20220620103501.jw3epiky2iynxphn@uda0497096>
References: <20220620102750.32718-1-j-luthra@ti.com>
 <20220620102750.32718-3-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620102750.32718-3-j-luthra@ti.com>
User-Agent: NeoMutt/20171215
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

On 15:57-20220620, Jai Luthra wrote:
> Add nodes for audio codec and sound card, enable the audio serializer
> (McASP1) under use and update pinmux. Disable all other McASP nodes.
> 
> Audio input is currently not working properly, so the RX port on McASP1
> is disabled for now, until the issue is debugged.
> 
> The serializer is shared between HDMI and codec. By default codec is
> used for output, but it can be toggled to HDMI using a FET switch
> connected to the MCASP1_FET_SEL (J24) header on the board.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 89 ++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

Oops, I sent this patch twice in the series. Please ignore this one.

Thanks,
Jai
