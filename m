Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B850CB2A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiDWOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiDWO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:29:16 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26210C8;
        Sat, 23 Apr 2022 07:26:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23NEQDiJ017135;
        Sat, 23 Apr 2022 09:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650723973;
        bh=3GgoJpyppBXDIA+/GDUz6X8ijNWOukuZyHhXVYccPS8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tGiXsz9Y8fXfvidKwWeLtalI5X2VX9cme567gQh1zbkVUE/KS3cLxgH1hr3L6rFhU
         VsktYRNp0k1zwI1Y5+F/szHOhmdS+oGgbNf2uPZz0ZlZOBVuJ2P/Jw4Vsq4VL1TuZb
         aKymVKh98Y0Oy0i4gkgA/yrq7wIawYZnF2dTw2f8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23NEQDt7015799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 23 Apr 2022 09:26:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 23
 Apr 2022 09:26:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 23 Apr 2022 09:26:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23NEQCqF059088;
        Sat, 23 Apr 2022 09:26:12 -0500
Date:   Sat, 23 Apr 2022 09:26:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Guo Zhengkui <guozhengkui@vivo.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhengkui_guo@outlook.com>
Subject: Re: [PATCH linux-next] clk: keystone: sci-clk: change `struct
 sci_clk **clk` to `struct sci_clk *clk`
Message-ID: <20220423142612.o4qiabqthflh3r3h@marrow>
References: <20220406050321.26177-1-guozhengkui@vivo.com>
 <20220423020608.808E8C385A4@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220423020608.808E8C385A4@smtp.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:06-20220422, Stephen Boyd wrote:
> Quoting Guo Zhengkui (2022-04-05 22:02:32)
> > `struct sci_clk **clk` is unnecessary. Change it to `struct sci_clk *clk`.
> > 
> > Also fix functions relating to it.
> > 
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> > ---
> 
> Waiting for Nishanth to review.

Sorry, this has to be a NAK from me. Broke all the K3 boards. I have'nt
dug to see why exactly.

https://gist.github.com/nmenon/de29ec88efc9f83acc4a8d2c13580290


Compare
vanilla next-20220422:
https://gist.github.com/nmenon/de29ec88efc9f83acc4a8d2c13580290#file-next-20220422-L631

Vs

next-20220422 + this patch:
https://gist.github.com/nmenon/de29ec88efc9f83acc4a8d2c13580290#file-next-20220422-patch-L631


Just posting am64xx-evm log, all other platforms follow the same
pattern.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
