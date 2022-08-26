Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40B5A2891
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbiHZN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbiHZN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:29:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A47183A5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:29:49 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 224F16601B24;
        Fri, 26 Aug 2022 14:29:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661520587;
        bh=+m7sis5b7W8J1KdNle4N0fSBG5qi9iWA0tl/U2ExgXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbcQ27OiXN4L4WS3AG+PvOv7ae/3Eg8kbk7YBuBUC451fN1xBzRc0WTGIhVkh8HRA
         TjnnsPne5t5aFubjmIdbgMCnPSfBYMq8B8N/2i44+DEE6HFX0XI3/J/PLASYLlqRan
         ib9M6x+PUgv0jJrNhDpSem+wsnOeqLeBE2sJ9VpHNavFzGqM2JPtCYIkVj1pcaeDu4
         0Hac8gIJTwbgOy1YeeL0/8fYXgSET8355QagOgJ5ViauNhJ7lMU0DgJeGQ5OiH/g5n
         YPZpygzbV8XhLtZmaV05NRDhq41G9pTlFIIBEeRjmHgfcmjQP2jhjQ4yw/g0B9WM7z
         mt2K9gggrZFrA==
Date:   Fri, 26 Aug 2022 09:29:42 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "xinlei.lee" <xinlei.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        rex-bc.chen@mediatek.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, yongqiang.niu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v3,1/2] soc: mediatek: Add mmsys func to adapt to dpi
 output for MT8186
Message-ID: <20220826132942.k2rnlz5wwi62tity@notapiano>
References: <1661236702-30682-1-git-send-email-xinlei.lee@mediatek.com>
 <20220823201758.ffbgb5t5odoicgir@notapiano>
 <b0f6a3c6-8fef-8983-fb69-6157a9859afd@gmail.com>
 <30f536c754829011e78239a9a400945faa4580e4.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30f536c754829011e78239a9a400945faa4580e4.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 02:12:00PM +0800, xinlei.lee wrote:
> On Thu, 2022-08-25 at 17:04 +0200, Matthias Brugger wrote:
> > 
> > On 23/08/2022 22:17, Nícolas F. R. A. Prado wrote:
> > > On Tue, Aug 23, 2022 at 02:38:22PM +0800, xinlei.lee@mediatek.com
> > > wrote:
> > > > From: Xinlei Lee <xinlei.lee@mediatek.com>
> > > > 
> > > > Add mmsys function to manipulate dpi output format configuration
> > > > for MT8186.
> > > > 
> > > > Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> > > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> > > 
> > > Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > 
> > 
> > Patch looks fine, I'll wait for v4 as there is still some discussion
> > on the DRM 
> > part. Please try to fix the threading problem you had in sending this
> > series.
> > 
> > Thanks,
> > Matthias
> 
> Hi Matthias:
> 
> Thanks for your review.
> 
> Before I send the next version, do you mean the treading problem you
> are talking about is the problem I'm discussing in another patch in
> this series, or something else?

Hi Xinlei,

no, the threading problem Matthias is referring to is the fact that this version
of your series had two cover letters (patch 0) and a patch 2 [1], while patch 1
was sent in a different email thread [2]. The whole series (cover letter,
patches 1 and 2), should have been in the same email thread. Also, I noticed
that your cover letter lists the patches with incorrect prefixes "FROMLIST".

So something weird happened when you sent this version of the series. It was ok
in the previous version. So just make sure this is fixed when you send the next
version of the series (after we finish the discussion on patch 2).

[1] https://lore.kernel.org/linux-mediatek/1661235517-23699-1-git-send-email-xinlei.lee@mediatek.com/
[2] https://lore.kernel.org/linux-mediatek/1661236702-30682-1-git-send-email-xinlei.lee@mediatek.com/

Thanks,
Nícolas
