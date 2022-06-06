Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99AE53E006
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbiFFDYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245564AbiFFDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:24:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34481C102
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56BFCB80944
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB0C34119;
        Mon,  6 Jun 2022 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654485864;
        bh=27QfA0HUowPRHp50PZrytVJKom6NrSAJVHItu8R3jHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvcFToTHkstRhWpP8zzRAtwT4O09ePpK8HGekpw3LbbkO31qHgbzt6f+XtyUX0wyA
         Upkatwg5nauh8UM2QzesBlVcMsGR/vOtWBVpC8AQ7EE08dURfEzfG2PAQfmyn3Wsev
         fbiAi3oV74RKwRDQyTv0Ao+mF7On+YoFOu+v3y2rwJR3RNstABANHp1SN/96ILPiON
         E8aoRDtBzGZ9BnEuJp+MH983c3K/e7h5ieOGtIgCU0lq7G+SWBxJyWELlENqgeq8qP
         Yiu9caGxHd3WDJsM/emwZ+t53/hVArkLUxciUrdm/uTeV5OPOQTfX2fckcYnno1Mrm
         YoUygv94h4p3Q==
Date:   Mon, 6 Jun 2022 03:24:19 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chrome-platform@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Fix refcount leak in
 cros_ec_codec_platform_probe
Message-ID: <Yp1zY39dZDzquBE7@google.com>
References: <20220603131043.38907-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603131043.38907-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:10:43PM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
