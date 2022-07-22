Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7150157DB9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiGVH5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiGVH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:57:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925163C9;
        Fri, 22 Jul 2022 00:57:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 649E96601ABF;
        Fri, 22 Jul 2022 08:56:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658476620;
        bh=2DGolipgyjptolp4am/pfMdXRfTwRTSgmtA0z4LFs74=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TWjJcmibV8VEFEuMdfgD9HUYattJGFNft4NDLBqSyUYkaeici4lRn0ccNAgCz40cq
         MQZt7GjX8qA8DUEWCTi8yIOL6u9YbtWgdCcaSo/an71v2OEpY//0cGgG2dgkd76qQ3
         u6Zh1RqQxXPI6SdE1agHamet20MjIiy/F03N5QH8AI2jghDmLBv8M1L0nrrSOhXdiP
         Ox5FUb8bFRanFQ4UPFYEQuBXsassSLjVfD4yQHp6JbcxfralOfGQ6rxILansDl2xo3
         ovUHwyqpHQM7s74K/YR+Pv4fHMzMP3J4DkdJcxoQ/D3LrmxfM+REkM+KqQ8GHaIMRx
         OMv/SONENFg+A==
Message-ID: <addbe80a-8fdd-fe5e-f880-c11dc1833fb6@collabora.com>
Date:   Fri, 22 Jul 2022 09:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND] media: mediatek: vcodec: Add to support VP9 inner racing
 mode
Content-Language: en-US
To:     "mingjia.zhang@mediatek.com" <mingjia.zhang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715064938.5812-1-mingjia.zhang@mediatek.com>
 <6d8aeee4-9732-1c62-67e0-6e8f56373aa6@collabora.com>
 <cf62ea99e74ea729a38fe7f806cbc06a0c549ddc.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cf62ea99e74ea729a38fe7f806cbc06a0c549ddc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/07/22 08:43, mingjia.zhang@mediatek.com ha scritto:
> Hi Angelo,
> 
> Thanks for your reply and useful comments.
> 
> In addition to running cts/gts test, I ran the fluster test with
> GStreamer locally. The test result is "Ran 240/303 tests successfully"
> 
> 

Just an advice: if you want to speed up the reviews and merging these
commits, always post the full output of Fluster/GST testing when sending
them.

This will make it easier for the media maintainers to review your code :-)

Anyway, thanks for the Fluster testing!

Cheers,
Angelo

> Thanks,
> mingjia
> 
> 
> On Fri, 2022-07-15 at 10:34 +0200, AngeloGioacchino Del Regno wrote:
>> Il 15/07/22 08:49, Mingjia Zhang ha scritto:
>>> In order to reduce decoder latency, enable VP9 inner racing mode.
>>> Send lat trans buffer information to core when trigger lat to work,
>>> need not to wait until lat decode done.
>>>
>>> Signed-off-by: mingjia zhang <mingjia.zhang@mediatek.com>
>>> ---
>>> CTS/GTS test pass
>>
>> CTS/GTS passing is a good indication but, please, test with GStreamer
>> (and
>> show the output, as well!).
>>
>> Thanks,
>> Angelo
>>
>>> ---
>>>    .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 64 ++++++++++++
>>> -------
>>>    1 file changed, 40 insertions(+), 24 deletions(-)
>>>
> 


