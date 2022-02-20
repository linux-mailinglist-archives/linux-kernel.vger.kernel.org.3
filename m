Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E744BCEFD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiBTObT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:31:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBTObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:31:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00940E41;
        Sun, 20 Feb 2022 06:30:56 -0800 (PST)
Received: from [IPV6:2a01:e0a:169:7140:7455:118c:f6d8:298b] (unknown [IPv6:2a01:e0a:169:7140:7455:118c:f6d8:298b])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3BF7825B;
        Sun, 20 Feb 2022 15:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645367451;
        bh=JNOQomlYL0ZA5oGYqK1uafrk9spBe5F5IHhU6wrv6Tc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PMChX8PFM8VrGzU/mOpuL64FGQVIMpIXCQSvurNSq/q07jPwE1QHzGVbzwzDq44yg
         CtsnRs0PwxJwRixQlPZRzpI2/Q4cp5XyptIBizm285urFsLOkgReIlpptOMv5tUp7q
         95nGxmxuIfaRQYI8MsuniKsftKIre+3QGZi6Ju4Q=
Message-ID: <fc3abf5b-64c7-82c6-ec9c-5c3659c55b49@ideasonboard.com>
Date:   Sun, 20 Feb 2022 15:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/11] Add support for BCM2835 camera interface
 (unicam)
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <a7a6f1fe-c2f0-f545-1da3-a7685fdb63d5@i2se.com>
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
In-Reply-To: <a7a6f1fe-c2f0-f545-1da3-a7685fdb63d5@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 16/02/2022 21:57, Stefan Wahren wrote:
> Hi Jean-Michel,
> 
> Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
>> Hello !
>>
>> ...
>>
>> In order to properly configure the media pipeline, it is needed to call
>> the usual ioctls, and configure routing in order to send the embedded
>> data from the sensor to the "unicam-embedded" device node :
>>
>> ```
>> media=0
>> media-ctl -d${media} -l "'imx219 2-0010':0->'unicam-subdev':0 [1]"
>> media-ctl -d${media} -l "'unicam-subdev':1->'unicam-image':0 [1]"
>> media-ctl -d${media} -v -R "'unicam-subdev' [0/0->1/0[1],0/1->2/0[1]]"
>> media-ctl -d${media} -V "'imx219 2-0010':0/0 [fmt:SRGGB10_1X10/3280x2464 field:none]"
>> v4l2-ctl -d0 --set-fmt-video width=3280,height=2464,pixelformat='pRAA',field=none
>> media-ctl -d${media} -v -V "'imx219 2-0010':0/1 [fmt:METADATA_8/16384x1 field:none]"
>> media-ctl -d${media} -p
>> ```
> 
> i tried to test the unicam driver on a Raspberry Pi 4 with the imx219
> camera (based on 5.17-rc4). The unicam & imx219 driver probes and
> /dev/video0 is created.
> 
> If a execute the first media-ctl command, it complains with invalid
> argument 22. Is there a more fool-proof variant to configure this (a
> script or something else)? I never used the unicam driver before.
> 
> Here is the output of
> 
> $ mediactl -d0 -p
> 

Based on your output, I suppose the issue is the naming of the imx219 
media entity ('imx219 2-0010' vs 'imx219 5-0010').
You could add a '-v' in the line to help you I suppose.

A more bullet-proof version of the commands is certainly doable, not 
sure how though as I would not like to rewrite a libcamera-like command ;-).

> Media controller API version 5.17.0
> 
> Media device information
> ------------------------
> driver          unicam
> model           unicam
> serial
> bus info        platform:fe801000.csi
> hw revision     0x0
> driver version  5.17.0
> 
> Device topology
> - entity 1: unicam-subdev (3 pads, 3 links, 2 routes)
>              type V4L2 subdev subtype Unknown flags 0
>              device node name /dev/v4l-subdev0
>      routes:
>          0/0 -> 1/0 [ACTIVE]
>          0/1 -> 2/0 [ACTIVE]
>      pad0: Sink
>          [stream:0 fmt:unknown/0x0]
>          [stream:1 fmt:unknown/0x0]
>          <- "imx219 5-0010":0 [ENABLED,IMMUTABLE]
>      pad1: Source
>          [stream:0 fmt:unknown/0x0]
>          -> "unicam-image":0 [ENABLED,IMMUTABLE]
>      pad2: Source
>          [stream:0 fmt:unknown/0x0]
>          -> "unicam-embedded":0 [ENABLED,IMMUTABLE]
> 
> - entity 5: imx219 5-0010 (1 pad, 1 link, 2 routes)
>              type V4L2 subdev subtype Sensor flags 0
>              device node name /dev/v4l-subdev1
>      routes:
>          0/0 -> 0/0 [ACTIVE, IMMUTABLE, SOURCE]
>          0/0 -> 0/1 [ACTIVE, SOURCE]
>      pad0: Source
>          [stream:0 fmt:SRGGB10_1X10/3280x2464 field:none colorspace:raw
>           crop.bounds:(8,8)/3280x2464
>           crop:(8,8)/3280x2464]
>          [stream:1 fmt:METADATA_8/16384x1 field:none
>           crop.bounds:(8,8)/3280x2464
>           crop:(8,8)/3280x2464]
>          -> "unicam-subdev":0 [ENABLED,IMMUTABLE]
> 
> - entity 9: unicam-image (1 pad, 1 link, 0 route)
>              type Node subtype V4L flags 1
>              device node name /dev/video0
>      pad0: Sink
>          <- "unicam-subdev":1 [ENABLED,IMMUTABLE]
> 
> - entity 15: unicam-embedded (1 pad, 1 link, 0 route)
>               type Node subtype V4L flags 0
>               device node name /dev/video1
>      pad0: Sink
>          <- "unicam-subdev":2 [ENABLED,IMMUTABLE]
> 
