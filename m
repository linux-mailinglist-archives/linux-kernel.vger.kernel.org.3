Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F452B901
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiERLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiERLeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:34:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC61778B5;
        Wed, 18 May 2022 04:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14B40B81F30;
        Wed, 18 May 2022 11:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CA7C385A5;
        Wed, 18 May 2022 11:34:15 +0000 (UTC)
Message-ID: <31992c67-400e-8e14-38c2-4655995886f5@xs4all.nl>
Date:   Wed, 18 May 2022 13:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6, 6/7] media: mediatek: vcodec: prevent kernel crash
 when scp ipi timeout
Content-Language: en-US
To:     "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220513092526.9670-1-yunfei.dong@mediatek.com>
 <20220513092526.9670-7-yunfei.dong@mediatek.com>
 <ea9a04fb-368d-daca-96ae-9366253a5e91@xs4all.nl>
 <f26d5225fc8c499226c297ed86feb5ee20e8f3d3.camel@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <f26d5225fc8c499226c297ed86feb5ee20e8f3d3.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/22 13:29, yunfei.dong@mediatek.com wrote:
> Dear Hans,
> 
> Thanks for your review.
> On Wed, 2022-05-18 at 11:37 +0200, Hans Verkuil wrote:
>> Hi Yunfei,
>>
>> On 5/13/22 11:25, Yunfei Dong wrote:
>>> When SCP timeout during playing video, kernel crashes with
>>> following
>>> message. It's caused by accessing NULL pointer in
>>> vpu_dec_ipi_handler.
>>> This patch doesn't solve the root cause of NULL pointer, but merely
>>> prevent kernel crashed when encounter the NULL pointer.
>>
>> Is the root cause being addressed as well? Where is the root cause?
>> Is it
>> in this driver or in the scp (i.e. the remoteproc) driver?
>>
>> I need a bit more information to decide whether this series is ready
>> to
>> be merged for 5.20 or not.
>>
>> Regards,
>>
>> 	Hans
>>
> Vpu will be NUll when scp(micro processor) is hang or crash. Need to
> keep kernel works well , so add this patch.

OK, I think this should be stated in the commit log, and also in the code
(see below).

> 
> Best Regards,
> Yunfei Dong

<snip>

>>> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
>>> b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
>>> index 35f4d5583084..1041dd663e76 100644
>>> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
>>> @@ -91,6 +91,11 @@ static void vpu_dec_ipi_handler(void *data,
>>> unsigned int len, void *priv)
>>>  	struct vdec_vpu_inst *vpu = (struct vdec_vpu_inst *)
>>>  					(unsigned long)msg-
>>>> ap_inst_addr;
>>>  
>>> +	if (!vpu) {
>>> +		mtk_v4l2_err("ap_inst_addr is NULL");

E.g., either add a comment here or perhaps change the error message to:

"ap_inst_addr is NULL, did the SCP hang?"

Or something along those lines.

Shouldn't there be a \n at the end of this message as well? Or does
mtk_v4l2_err add that?

Regards,

	Hans

>>> +		return;
>>> +	}
>>> +
>>>  	mtk_vcodec_debug(vpu, "+ id=%X", msg->msg_id);
>>>  
>>>  	vpu->failure = msg->status;
> 
