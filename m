Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F8559DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiFXPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFXPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:52:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F4C4E3B4;
        Fri, 24 Jun 2022 08:52:31 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EECA66017FA;
        Fri, 24 Jun 2022 16:52:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656085949;
        bh=DgfoNJhSsryqfplIgapwVlrJl8IUXtflN7RQAeVipj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRcB9OTSGwTrzCzogGYid2DA7CbLSkQf0DinQj+He0ch53qch29VhNLuAvYoinfW9
         OTtnD33hlk+VKIZG7Wtk2f0sJttrOgCLYU5kqkATYdDs9pnpp/nwX7+AZ+hX2fUAWD
         1ssL0Hn2Fe0kVs7GLy8CNzY1I+ootvjrMHWEcGjgYar4i2HiZx4djX7SHdLkPNlTCo
         3Yk2Iy5CdOJ9B3fS4IldNxuagX2/14WxtdqrDLXv8gwMW/UGkQ1z3G9Il3jItwdWMZ
         3nYMAjFFh7XSHsXI1fVveaCuyrhuhxZi0Kr1e0nUbKOXLN0afb4gandBH8J9pERLXm
         hp/wdkGLGXC8w==
Date:   Fri, 24 Jun 2022 11:52:24 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/5] pinctrl: mediatek: add generic driving setup
 property on mt8192
Message-ID: <20220624155224.lizeca5rnruhihdn@notapiano>
References: <20220624133700.15487-1-guodong.liu@mediatek.com>
 <20220624133700.15487-2-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624133700.15487-2-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

please see comments below.

On Fri, Jun 24, 2022 at 09:36:56PM +0800, Guodong Liu wrote:
> 1. The dt-binding expects that drive-strength arguments be passed
> in mA, but the driver was expecting raw values. And that this
> commit changes the driver so that it is aligned with the binding.
> 2. This commit provides generic driving setup, which support
> 2/4/6/8/10/12/14/16mA driving, original driver just set raw data
> setup setting when use drive-strength property.

This commit message is a bit confusing, I suggest using the following commit
message instead:

The dt-binding expects the drive-strength arguments to be passed in mA, but the
driver was using callbacks that expect raw values instead. Change the callbacks
for the ones that operate on mA values, so that the driver is in accordance to
the dt-binding.

The drive-strength property requiring values in mA is the standard and other
MediaTek SoCs of the same generation already do the same, so this change avoids
mt8192 having a non-standard property.

There are no current upstream users of this driver, so this change doesn't cause
any regression.

> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
