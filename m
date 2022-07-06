Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD7568117
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiGFIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiGFIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:23:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AB6240B8;
        Wed,  6 Jul 2022 01:23:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8EEA0660193A;
        Wed,  6 Jul 2022 09:23:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657095813;
        bh=zMavF5qlus89eOAZ65TVOYCbV1BgOtLseFPdJnK0pqc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XBoOLVBqow1+SY/p9pYfbIE9SrKkWJZkosm8xUMr4t715qcbeAmaYTjUDICvFemnD
         kx/OwMFwl4oSZX+spu2Q2emzF3xoeZqeA1Sa14iGDe5MLuBvC7UD3Df8RGsif7e8VR
         voC7H8mW5SJybbsAbxw3Tp2XgqSRboNj3wfyePdcbYzRqzSfrjDyQVfWgFVFF3DaXz
         U1yaTLwlOZBO3uxAMhNSz3Ntpj5ISldD5/s7gUsTftPTbEQ4HE7GSBBYoa3op2IXpe
         9v73g8MZ5YyNDfB2hGLYXQVCBBcAGe7JyqYauDdF1sLxq+N7RBmOxWHKzOegu3pJQR
         b5fUX5i7N99vw==
Message-ID: <03ba07c0-af10-4a99-7d5f-15d9a0cf853b@collabora.com>
Date:   Wed, 6 Jul 2022 10:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] PM: domains: Ensure genpd_debugfs_dir exists before
 remove
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Pin-yen Lin <treapking@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705171649.969194-1-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220705171649.969194-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/07/22 19:16, Hsin-Yi Wang ha scritto:
> Both genpd_debug_add() and genpd_debug_remove() may be called
> indirectly by other drivers while genpd_debugfs_dir is not yet
> set. For example, drivers can call pm_genpd_init() in probe or
> pm_genpd_init() in probe fail/cleanup path:
> 
> pm_genpd_init()
>   --> genpd_debug_add()
> 
> pm_genpd_remove()
>   --> genpd_remove()
>     --> genpd_debug_remove()
> 
> At this time, genpd_debug_init() may not yet be called.
> 
> genpd_debug_add() checks that if genpd_debugfs_dir is NULL, it
> will return directly. Make sure this is also checked
> in pm_genpd_remove(), otherwise components under debugfs root
> which has the same name as other components under pm_genpd may
> be accidentally removed, since NULL represents debugfs root.
> 
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

