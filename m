Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E957D202
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiGUQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGUQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:52:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472C8BAA5;
        Thu, 21 Jul 2022 09:52:09 -0700 (PDT)
Received: from localhost (dynamic-089-204-139-174.89.204.139.pool.telefonica.de [89.204.139.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F0DE16601AB9;
        Thu, 21 Jul 2022 17:52:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658422328;
        bh=zNaMEOo7SOqVPwog5sld4Rh84NQW2jM34wd4gMktMDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaQlkNNJtOWjoww/FDRduKMLmaEzNNg3t0BH8OHljmHTtf8j2tDXyWSCu4cQNW0IN
         SSdPw0fe1kONYHFRDRzOBgQ9sD0cQna9OSn4vBUIMh6VhwzNZuxI6bGkfNH4z6VWEJ
         x0IeP8WQPl8tJP67cN3/+YnaLBRk0ywisPJj1H+7ndYeXDyY85coYTttdzlO6ZOyZc
         oX4PhPFmDXGvT63/EiQN/OUVtk6jdvTZqu2RRJh3IYO/4bg+MJZ5vaADqS0WgJs6fm
         gCe4lcQTbffsvynj203471bw3vppO5dzDBDYQ98CLTDh/nsn8tC/sPKAGCCFi3EfHL
         HNPwEc3PQDcyg==
Date:   Thu, 21 Jul 2022 18:52:04 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     linux-media@vger.kernel.org, jernej.skrabec@gmail.com,
        kernel@collabora.com, bob.beckett@collabora.com,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        nicolas.dufresne@collabora.com, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/6] RkVDEC HEVC driver
Message-ID: <20220721165204.23sfnwl4pij7eop3@basti-XPS-13-9310>
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
 <20685980-dc81-8fc9-d049-f393071feb20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20685980-dc81-8fc9-d049-f393071feb20@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alex,

Thanks for taking a look!

On 16.07.2022 18:27, Alex Bee wrote:
>Hi Sebastian,
>
>thanks a lot for your work on upstreaming this driver.
>
>See some general comments below.
>
>>Implement the HEVC codec variation for the RkVDEC driver. Currently only
>>the RK3399 is supported, but it is possible to enable the RK3288 as it
>>also supports this codec.
>>
>>Based on top of the media tree @ef7fcbbb9eabbe86d2287484bf366dd1821cc6b8
>>and the HEVC uABI MR by Benjamin Gaignard.
>>(https://patchwork.linuxtv.org/project/linux-media/list/?series=8360)
>>
>>Tested with the GStreamer V4L2 HEVC plugin:
>>(https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079)
>>
>>Current Fluster score:
>>`Ran 131/147 tests successfully               in 278.568 secs`
>>with
>>`python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j1`
>>
>>failed conformance tests:
>>- DBLK_D_VIXS_2 (Success on Hantro G2)
>>- DSLICE_A_HHI_5 (Success on Hantro G2)
>>- EXT_A_ericsson_4 (Success on Hantro G2)
>>- PICSIZE_A_Bossen_1 (Hardware limitation)
>>- PICSIZE_B_Bossen_1 (Hardware limitation)
>>- PICSIZE_C_Bossen_1 (Hardware limitation)
>>- PICSIZE_D_Bossen_1 (Hardware limitation)
>>- PPS_A_qualcomm_7 (Success on Hantro G2)
>>- SAODBLK_A_MainConcept_4 (Success on Hantro G2)
>>- SAODBLK_B_MainConcept_4 (Success on Hantro G2)
>>- SLIST_B_Sony_9 (Success on Hantro G2)
>>- SLIST_D_Sony_9 (Success on Hantro G2)
>>- TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
>>- VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
>>- WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
>>- WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)
>>
>>Not tested with FFMpeg so far.
>>
>>Known issues:
>>- Unable to reliably decode multiple videos concurrently
>>- The SAODBLK_* tests timeout if the timeout time in fluster is lower than 120
>>- Currently the uv_virstride is calculated in a manner that is hardcoded
>>for the two available formats NV12 and NV15. (@config_registers)
>>
>>Notable design decisions:
>>- I opted for a bitfield to represent the PPS memory blob as it is the
>>perfect tool for that job. It describes the memory layout with any
>>additional required documentation, is easy to read and a native language
>>tool for that job
>>- The RPS memory blob is created using a bitmap implementation, which
>>uses a common Kernel API to avoid reinventing the wheel and to keep the
>>code clean.
>>- I deliberatly opted against the macro solution used in H264, which
>>declares Macros in mid function and declares the fields of the memory
>>blob as macros as well. And I would be glad to refactor the H264 code if
>>desired by the maintainer to use common Kernel APIs and native language
>>elements.
>
>I fully disagree here: That way the code is much less 
>read-/understandable - your are putting  bits at some random hardcoded 
>positions with not relation to the codec/hardware and expect everyone 
>to read and understand that huge docblock - the code should be more 
>self-explaining and we should at least try to get rid of those 
>hardcoded positions which, btw, will differ for newer versions of that 
>hardware block.

So, I thought about this a bit:
My thoughts were going generally in two directions:

1. I create a general struct for an RPS layout and let the
  different hardware blocks fill that struct accordingly during
  initialization, this would enable to get rid of those hard coded
  positions but would make the code a bit more complicated and it doesn't
  seem worth it until we actually have a case where it is different (I
  haven't test on RK3288 so far)

2. Implement a function for each hardware block and decide upon hardware
  detection which function to use, this fits more to general kernel coding
  style and to the manner rkvdec is coded. But this won't get rid of the
  hardcoded positions and tbh the code before did have hard coded
  positions as well and you needed to understand this code block as well:
  ```
  #define REF_PIC_LONG_TERM_L0(i)			PS_FIELD(i * 5, 1)
  #define REF_PIC_IDX_L0(i)			PS_FIELD(1 + (i * 5), 4)
  #define REF_PIC_LONG_TERM_L1(i)			PS_FIELD((i < 5 ? 75 : 132) + (i * 5), 1)
  #define REF_PIC_IDX_L1(i)			PS_FIELD((i < 4 ? 76 : 128) + (i * 5), 4)
  ```
  And it least from my perspective this wasn't clean code either as it is
  not obvious without understanding this bit in detail, how the RPS
  structure looks like.
  I'll try to make the code more self explaining for V2. (will need a bit
  preparation for that as I have to rewrite my bit writer implementation
  as it was requested to be usable for other purposes as well)

>
>I'm also not sure what makes you call that a "blob": It's 
>configuration of the hardware which in that case isn't put in 
>registers, but in memory.

That is just the term that I heard the most, so I adopted it, I can use
hardware configuration as well, but the important part for me is that
people understand me.

>
>>- The giant static array of cabac values is moved to a separate c file,
>>I did so because a separate .h file would be incorrect as it doesn't
>>expose anything of any value for any other file than the rkvdec-hevc.c
>>file. Other options were:
>>   - Calculating the values instead of storing the results (doesn't seem
>>   to be worth it)
>
>I'm not sure "not worth it" should be argument for not doing doing 
>anything in general; especially not if it can explain the relation 
>between the standard and this driver.

Thanks for the feedback, you are correct my explanation is a bit lazy
and I will look into calculating the values as an option more seriously.

>
>Looking at  tables of ITU-T Rec. H.265 "9.3.2.2 Initialization process 
>for context variables" and comparing to the first elements of that 
>huge array: It should be doable.

I'll try it out and maybe already in include it in V2.

Thanks again for your feedback.

Greetings,
Sebastian

>
>>   - Supply them via firmware (Adding firmware makes the whole software
>>   way more complicated and the usage of the driver less obvious)
>>
>>Ignored Checkpatch warnings (as it fits to the current style of the file):
>>```
>>WARNING: line length of 162 exceeds 100 columns
>>#115: FILE: drivers/media/v4l2-core/v4l2-common.c:265:
>>+               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
>>
>>ERROR: trailing statements should be on next line
>>#128: FILE: drivers/media/v4l2-core/v4l2-ioctl.c:1305:
>>+       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/CbCr 4:2:0 (Packed)"; break;
>>```
>>
>>v4l2-compliance test:
>>```
>>Total for rkvdec device /dev/video3: 46, Succeeded: 46, Failed: 0, Warnings: 0
>>```
>>
>>kselftest module run for the bitmap changes:
>>```
>>$ sudo insmod /usr/lib/modules/5.19.0-rc3-finalseries/kernel/lib/test_bitmap.ko
>>[   71.751716] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 1750
>>[   71.751787] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
>>[   71.751787] ', Time: 6708
>>[   71.760373] test_bitmap: set_value: 6/6 tests correct
>>```
>>
>>Jonas Karlman (2):
>>   media: v4l2: Add NV15 pixel format
>>   media: v4l2-common: Add helpers to calculate bytesperline and
>>     sizeimage
>>
>>Sebastian Fricke (4):
>>   bitops: bitmap helper to set variable length values
>>   staging: media: rkvdec: Add valid pixel format check
>>   staging: media: rkvdec: Enable S_CTRL IOCTL
>>   staging: media: rkvdec: Add HEVC backend
>>
>>  .../media/v4l/pixfmt-yuv-planar.rst           |   53 +
>>  drivers/media/v4l2-core/v4l2-common.c         |   79 +-
>>  drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>>  drivers/staging/media/rkvdec/Makefile         |    2 +-
>>  drivers/staging/media/rkvdec/TODO             |   22 +-
>>  .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1844 +++++++++++++++++
>>  drivers/staging/media/rkvdec/rkvdec-hevc.c    |  859 ++++++++
>>  drivers/staging/media/rkvdec/rkvdec-regs.h    |    1 +
>>  drivers/staging/media/rkvdec/rkvdec.c         |  182 +-
>>  drivers/staging/media/rkvdec/rkvdec.h         |    3 +
>>  include/linux/bitmap.h                        |   39 +
>>  include/uapi/linux/videodev2.h                |    1 +
>>  lib/test_bitmap.c                             |   47 +
>>  13 files changed, 3066 insertions(+), 67 deletions(-)
>>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
>>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
>>
>Regards,
>
>Alex
>
