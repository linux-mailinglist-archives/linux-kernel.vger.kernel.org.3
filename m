Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B04FEB18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiDLXcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiDLXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E436490FE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:17:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CLKoth058896;
        Tue, 12 Apr 2022 16:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649798450;
        bh=eI1T/bFGS1LickmovZ0igeFAK0lvOxui0sWfaIzxQeY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uO+WB20qXWzIHqPsbw2xPhAIXv1aam7N7nd5s0AcdedCLgqEK+52tIjzb5MSRP4r5
         /w2Vee7SgMLitia9QJpUlPFmqkHHzbfIUa7NOUBDYbU98YXa1p4sp6VwkF+0xq3EN8
         07pTtieb3kZfpKRdjdtit+/v1rDeP2YaI7z4zY9o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CLKoXU093452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 16:20:50 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 16:20:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 16:20:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CLKn6Y077073;
        Tue, 12 Apr 2022 16:20:49 -0500
Date:   Tue, 12 Apr 2022 16:20:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <tony@atomide.com>
CC:     Devarsh Thakkar <devarsht@ti.com>, <linux-kernel@vger.kernel.org>,
        <jyri.sarha@iki.fi>, <tomba@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>, <nikhil.nd@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/tidss: Soft Reset DISPC on startup
Message-ID: <20220412212049.gjnel7aubol56azk@earache>
References: <20220314113739.18000-1-devarsht@ti.com>
 <86a07099-1074-e8d1-6d0e-1ce68414b627@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86a07099-1074-e8d1-6d0e-1ce68414b627@ideasonboard.com>
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

On 17:24-20220412, Tomi Valkeinen wrote:
> Hi,
> 
> On 14/03/2022 13:37, Devarsh Thakkar wrote:
> > Soft reset the display subsystem controller on startup and wait for
> > the reset to complete. This helps the scenario where display was
> > already in use by some other core before the linux was booted.
> 
> The reason the omapdrm doesn't do a reset is that the PM features on some of
> the DSS registers were set and controlled outside dss driver, so the dss
> driver could not do a reset just like that. That design was carried to the
> tidss driver, although I'm not sure if the reason is valid on AM6 and J7
> platforms.
> 
> If that reasoning is not valid, this patch is ok and:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 

Tony - sysc control for older omap devices still control this directly?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
