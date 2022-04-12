Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1C4FE5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350780AbiDLQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiDLQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:20:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A555BED;
        Tue, 12 Apr 2022 09:17:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CB88F1F44415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649780272;
        bh=HG4zMAQTMsRTHk1kQ+DW7QY45qxSF73vy5Es63Yx/Hs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ie3NRjpwbAQ6cKLOUQoYITA6lfCLeBMXZqyKTetVNOwu1eFOnlDIS0Hyl1ms1j+hU
         CWOJDqVXrI5AdKOkIllkSsrz7hrLwsPJnS9Lo7jPIeMg7Haa0JyzweD+PRe0JVHK04
         ZdlRENGtXaYzDJkDtrAOgzDh2HuOBspLV5vsR5KvgvMnDPjBV9GuGDNfdc8Zg1ayuo
         FtTuW85jObOrIekLzn62cGHsY6Dn2+F5biP5AN/aBfvU/5q1WAtgooD7FRil6SaE+d
         +9sTEHPcko2Bzusdvyvz0qWsvXuJOVIe/j909WNAbo4d2EucJ2a9qTbxxjgbf35+8g
         Gdk3RqTWV2VbA==
Message-ID: <084cce2b-5c50-1d14-70f8-a313d61b901d@collabora.com>
Date:   Tue, 12 Apr 2022 18:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] spi: spi-mtk-nor: initialize spi controller after resume
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220412115743.22641-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220412115743.22641-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/22 13:57, Allen-KH Cheng ha scritto:
> After system resumes, the registers of nor controller are
> initialized with default values. The nor controller will
> not function properly.
> 
> To handle both issues above, we add mtk_nor_init() in
> mtk_nor_resume after pm_runtime_force_resume().
> 
> Fixes: 3bfd9103c7af ("spi: spi-mtk-nor: Add power management support")
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

That's just one issue, not two, so... "To handle both issues [etc]" should become
something like:
"Solve this issue by reinitializing the registers right after resuming the
controller"

After fixing the commit description,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

