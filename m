Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8924BE03B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378874AbiBUPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBUPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:13:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D881AF36;
        Mon, 21 Feb 2022 07:12:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 14D861F43970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645456374;
        bh=D818uSaEHhBQptBy3IOTQWWmyxOFz7UQXvDTQWJYruQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LJ/ZPHNnLPtD3Fk2hA4su8SMfk3HyjKQWYA1w5L7ukJUNF5PNeOOIvC+J7/AkSM7D
         2UwX7z5NJbrJaMqnIx5XWx8Js7j+LRJ6aReCaDs3EGrYlhbj6xQYWa/R2hKR92n3hK
         9YSXaGFsAJ1O1/+eCP1TjSqYoa/NTji/q3ArB9xtAjltf8Atszpo64lCnYTrd8D/W4
         rYKzcarIeSIIh0X0Vqe1PbFz+9Vbglv+YBfdEvE9nrdiwgKYU5xQkwO2OoMO71T4Nh
         eTtsn/Q8s1S6URIjg0RT13e6Gm+giWQjIPBEl47lKJSQ1xc54Ii5IQrQOahDPNcngI
         QZbfTkljn3W8g==
Message-ID: <11c7580e-d7e3-f8ab-3cdc-f310e8dc7308@collabora.com>
Date:   Mon, 21 Feb 2022 16:12:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1] media: v4l2-core: Initialize h264 scaling matrix
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, yunfei.dong@mediatek.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218184208.455488-1-nicolas.dufresne@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220218184208.455488-1-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 19:42, Nicolas Dufresne ha scritto:
> In the final H264 API, it is not required to set scaling matrix if
> they are not present in the bitstream. A flag was added in order to let
> the driver know. The downside is that it leaves the default control
> value to 0, which isn't valid. As per the spec (see formulas 7-8/7-9),
> when the scaling matrix are absent from the bitstream, flat values
> of 16 should be used. This improves this control semantic in a way
> that the control value are always valid. Drivers can then use
> the scaling_matrix control values without having to check its presence.
> Same method was employed for MPEG2_QUANTISATION.
> 
> This fixes issues with MTK VCODEC H264 decoder when using GStreamer.
> GStreamer does not set this control if its not present in the bitstream.
> As MTK VDCODEC was using the initialized to 0 values, the frames ended
> up completely gray.
> 
> Fixes: 54889c51b833d236 ("media: uapi: h264: Rename and clarify PPS_FLAG_SCALING_MATRIX_PRESENT")
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
