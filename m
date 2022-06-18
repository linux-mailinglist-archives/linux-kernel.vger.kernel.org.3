Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616CF55014F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383664AbiFRA2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiFRA2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:28:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A71409E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:28:47 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I0SbGv051632;
        Fri, 17 Jun 2022 19:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655512117;
        bh=yP5oK4/zen8K0Ml9nwSkK3LsM5k3z1Iu/DaHxTdSORs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uxIFMMrHegeLc9f5S3LIfqVWqayDpFcr1XjcqtR+zzKNvYDL9FflCNCo+HkjoABcT
         lK+LauLF4G/ecqUwnXOixGRbEqYehfHU+yiW4ErtKWJ5p5HxkXRvzx+CBg17IcPyyN
         NKuBVLaiiUTdbJeoA5vMGS0ng3ZfFkQfeVce26Cc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I0SbBE128857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 19:28:37 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 19:28:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 19:28:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I0SaGJ021164;
        Fri, 17 Jun 2022 19:28:36 -0500
Date:   Fri, 17 Jun 2022 19:28:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: pm33xx: Fix refcount leak in am33xx_pm_rtc_setup
Message-ID: <20220618002809.hk2q4dnsriqhagkm@kahuna>
References: <20220516074100.30599-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220516074100.30599-1-linmq006@gmail.com>
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

On 11:41-20220516, Miaoqian Lin wrote:
> of_find_node_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")

Trouble here is that the patch wont apply directly on this commit ->
So, when we pass this over to stable, it will fail for certain stable
kernels, you want to explicitly list the stables on which this should
apply to.

Documentation/process/stable-kernel-rules.rst and be explicit in the
rules here.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
