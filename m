Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326FF4DDB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiCROFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiCROFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:05:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF03B2B78C6;
        Fri, 18 Mar 2022 07:04:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9196A1F46079
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647612250;
        bh=YOVEdyrfGs6YY8KU6+URoAWfguVsIhXu0otlSBy1Fos=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kizndKYJmfyPLeA2ieV3Q4kGKXJU2rh4JGfZq6SjPorWANlBeVNlaeLBiWUn93v1P
         H/MDKh29H0lBtD4YBJjCB0lInZmsLH72ZIwUjSaiXLW2QNmjkXxG6nW4Tppa6YmgYe
         y7LgQegeL9LkyM+zSTyCsPn/r/vrIkc8nnIdIkoDpT6ky5GtRJK8q83DQLtORJkDst
         BglkyRU9LgthB+9tV7x1+XqqnEJcmjzVFfqIx8lEARq+VgRXvqbDYzTOfr7lGo7f0O
         rbwUkydtWo3Ke80nNPnrohlJ1ylLQbzU29DhWmgWYmP1NHTAHIHUy9nEX70gPMqbl0
         exAXJ7m5Ol42g==
Message-ID: <aae7c675-6be4-03f1-a8fb-121faae320c2@collabora.com>
Date:   Fri, 18 Mar 2022 15:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3, 00/10] Enable two H264 encoder core on MT8195
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220317082230.23622-1-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220317082230.23622-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/22 09:22, Irui Wang ha scritto:
> MT8195 has two H264 encoder cores, they have their own power-domains,
> clocks, interrupts, register base. The two H264 encoder cores can work
> together to achieve higher performance, it's a core mode called
> frame-racing, one core has 4K@30fps performance, two cores can achieve
> 4K@60fps.
> The two encoder core encoding process looks like this:
> 
>      VENC Core0: frm#0....frm#2....frm#4....
>      VENC Core1: ..frm#1....frm#3....frm#5....
> 
> This series of patches are used to enable the two H264 encoder cores,
> encoding process will be changed:
> As-Is: Synchronous
> V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder IRQ -->
> encoding done with result --> job_finish
> V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder IRQ -->
> encoding done with result --> job_finish
> ...
> 
> To-Be: Asynchronous
> V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
> ..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
> (venc core0 may encode done here, done the encoding result to client)
> V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.
> 
> There is no "wait encoder IRQ" synchronous call during frame-racing mode
> encoding process, it can full use the two encoder cores to achieve higher
> performance.
> 

Hello Irui,
like v1 and v2, also this version of the series will crash the kernel when
trying to encode.

Before pushing the next series, you shall ensure that it is not crashing
the entire kernel, hence, please test your code with gstreamer.


Please use the following pipeline to test:

gst-launch-1.0 videotestsrc num-buffers=100 ! v4l2h264enc ! queue ! h264parse ! 
qtmux ! filesink location=test.mov


Regards,
Angelo
