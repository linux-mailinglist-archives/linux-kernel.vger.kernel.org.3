Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFEF5255E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiELTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358114AbiELTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:39:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA7268E91;
        Thu, 12 May 2022 12:39:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 9771C1F45802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652384366;
        bh=l7sEGPwFChsQe883K+Tm9Z1Antz2QzvNm5fjecKjZro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiRat4ZX8kCJFkC9cOzTnSv5u0RYAj5LmdftjvZ1b1Pv9LYRgjAST3ZsIo14/Lq4U
         8xjLPDuf16rEYbWZ25pXgAcaLIyyeGdtuKjf8bdi0+QLHfeZ2ohyGerWTSeHNHdDvn
         Ib43klOczH6uRZgywp9LsyfFRvRH5pfDlwqHlIFO9rPjL1/d8B+vK5eaeAYN3qQWRG
         KmTKJRc/r1PjnE4gZJAQXS4FtikcBXIcjODVsKltLiZMdBActDruHRZc1VVFXM/ONE
         +prPluUCKcrIuhvfPHz0j9YwwJRP7A5AFJQEal2Gv8u66T2XYwLMr9+TzLghEU447M
         nNJXeXWcALSOA==
Date:   Thu, 12 May 2022 15:39:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v12, 00/17] media: mtk-vcodec: support for M8192 decoder
Message-ID: <20220512193917.tu6waopwagm3oyaz@notapiano>
References: <20220512021950.29087-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512021950.29087-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:19:33AM +0800, Yunfei Dong wrote:
> This series adds support for mt8192 h264/vp8/vp9 decoder drivers. Firstly, refactor
> power/clock/interrupt interfaces for mt8192 is lat and core architecture.
> 
> Secondly, add new functions to get frame buffer size and resolution according
> to decoder capability from scp side. Then add callback function to get/put
> capture buffer in order to enable lat and core decoder in parallel, need to
> adjust GStreamer at the same time. 
> 
> Then add to support MT21C compressed mode and fix v4l2-compliance fail.
> 
> Next, extract H264 request api driver to let mt8183 and mt8192 use the same
> code, and adds mt8192 frame based h264 driver for stateless decoder.
> 
> Lastly, add vp8 and vp9 stateless decoder drivers.
> 
> Patches 1 refactor power/clock/interrupt interface.
> Patches 2~4 get frame buffer size and resolution according to decoder capability.
> Patches 5 set capture queue bytesused.
> Patches 6 adjust GStreamer.
> Patch 7~11 add to support MT21C compressed mode and fix v4l2-compliance fail.
> patch 12 record capture queue format type.
> Patch 13~14 extract h264 driver and add mt8192 frame based driver for h264 decoder.
> Patch 15~16 add vp8 and vp9 stateless decoder drivers.
> Patch 17 prevent kernel crash when rmmod mtk-vcodec-dec.ko

Hi Yunfei,

With this series, and the new scp.img for mt8192 [1] (still waiting to get
merged), I was able to get the following fluster scores on
mt8192-asurada-spherion:

VP8: 59/61
VP9: 249/303
H.264: 92/135

So for the whole series:

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

[1] https://lore.kernel.org/all/2537b84fbba82a77ee0a517b12bdcdd5e6ac1503.camel@mediatek.com/
