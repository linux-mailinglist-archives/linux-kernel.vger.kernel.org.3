Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E094D0DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiCHCIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiCHCIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:08:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0037A91
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77C33B8163C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC39C340F3;
        Tue,  8 Mar 2022 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646705237;
        bh=FO6In/hNNc4+xoPxbiFoiYv5P+ui3FmIN6FYKohezhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWEhtOmJW/pKK74Snzk7xTRhXgv+PfECzwVqS27gC2uv+FBBOo2AXWAgabYKNVt+d
         BIpJ7iZ3Po4HwcDzJ2hpIyY9slGkOFUek3mSOweWaJP0o/zgPHniPfXS6Xyl3xMy1W
         /Rz66R1l94kASKpyuLrtXi4v3LP3KIXK83RPsRNHnYK8H37abZa9gw0YDgOf+fJ5mT
         6wlZKEO4BNF+nJDa24rlmgPk8Ol+VRhvkNLmeyoJZTOsORSomSuhi/Zxur3dS3afTk
         gHtmjt9unkJHUiRS3XFhwxJiPq9vqDYTFwB5u5Orq1KvIua33EI8lHPbz9O6CKRza3
         0tw+AZSYQ7mmg==
Date:   Tue, 8 Mar 2022 10:07:12 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8192-mt6359: Fix error handling in
 mt8192_mt6359_dev_probe
Message-ID: <Yia6UG1fMZGSYzcs@google.com>
References: <20220308015224.23585-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308015224.23585-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:52:22AM +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> Fixes: 4e28491a7a19 ("ASoC: mediatek: mt8192-mt6359: fix device_node leak")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
