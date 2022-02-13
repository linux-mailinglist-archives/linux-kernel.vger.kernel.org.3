Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9DF4B3B28
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiBMLeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 06:34:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiBMLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 06:34:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F2307;
        Sun, 13 Feb 2022 03:33:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so22413920wrc.13;
        Sun, 13 Feb 2022 03:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02vp1JcshzGAmd266InAE4p0SMLcVM41XUbfgVtkk8w=;
        b=OK0IROEtmVHSd6bnjgTZAXeNZrVBxdV791WH8w6dkmD8N9Rc4BOr1zMpPhM0oAZXUu
         F5+8tdpFeHqnUYZviWCBWzlZ2ikr2llcEWe2hHPNQg6igNlyv09Bv68r6NlXQUNEZpz6
         YcMc3pe37dtNU0ALFTxUqgVf86I1ffFURsf3MdcQndVytg90HmTZCJb756kytkkqTQtI
         dcPT6EL5NDuYJd8o9tSAWNY3Li7cEkY/rZW0c0BS0vTv8hfMvTEwzXxpaDF3dnt7JW3f
         UPvTSd+ff+mcbppFm0AnkM2BufIEg5BbEtHreOY8Qynr2HRYSjgO3THIXWe4xdJDVtF8
         adUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02vp1JcshzGAmd266InAE4p0SMLcVM41XUbfgVtkk8w=;
        b=jtWRtDchqyyzm1wZPbThmpUznhDtIVLmJYcKuJs7TikaELeStLaMPAilQWXJw4IeLr
         BV1RTPjQ6KPtcOzq3OLA38tfkwFvI1lAQXmuKs4F3RPAD0Er6vJKpgvUt/XtUMDFUf7T
         b+gliYFjsuXevjrDpKqeEk0bf3MhnllCZy1CwqvvuYo6/UFAeu368wmT3O6ijyqoIFyr
         zy/UO5YjiBr3Xueeuu7RBdQnMISbRByRJvBdyQxPZ0iQJbu4NlJOxecWQ1AmDLI4+BuY
         3hJD+eZbz9gS1pFnfe+OBEP1WAhiF8nZjRESp5yG8Gt5qRADR07YsUU4LWCUMEl2ilyL
         sepg==
X-Gm-Message-State: AOAM5331g8NsflSMPzHJwoEhUt1qHydtsdm4XBOAvKx77+zbeaqOmCp2
        1NR8gf/nVMoauL2tWmllJIk=
X-Google-Smtp-Source: ABdhPJyTwqnXzmlapAqyauG6oyW/56U04p6xjFiix7W8KKn7b5P3uTYi4MmaqWyzQZ3BYqmtZlTA1A==
X-Received: by 2002:a5d:4fc7:: with SMTP id h7mr7611085wrw.673.1644752034944;
        Sun, 13 Feb 2022 03:33:54 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id p27sm9091564wms.39.2022.02.13.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 03:33:54 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Alex Bee <knaerzche@gmail.com>, jc@kynesim.co.uk
Subject: Re: [RFC] media: uapi: Move HEVC stateless controls out of staging
Date:   Sun, 13 Feb 2022 12:33:53 +0100
Message-ID: <8038233.T7Z3S40VBb@kista>
In-Reply-To: <20220201123439.353854-1-benjamin.gaignard@collabora.com>
References: <20220201123439.353854-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

CC: Alex, John

Sorry for late response, but I've been very busy last week.

First of all, thank you for doing this! It's about time that HEVC moves 
forward.

Dne torek, 01. februar 2022 ob 13:34:39 CET je Benjamin Gaignard napisal(a):
> The HEVC stateless 'uAPI' was staging and marked explicitly in the
> V4L2 specification that it will change and is unstable.
> 
> Note that these control IDs were never exported as a public API,
> they were only defined in kernel-local headers (hevc-ctrls.h).
> 
> While moving the controls out of staging they are renamed and
> control IDs get new numbers.
> Drivers (Hantro, Cedrus) and Documentation are updated accordaly.

accordaly -> accordingly

> 
> Additional structures fields has been added for RKVDEC driver usage.

You should do separate patch for that, preceding this one. One patch should 
only do one thing.

I also suggest that you add additional patch for removing bit_size field in 
struct v4l2_ctrl_hevc_slice_params. Similar fields were already removed from 
MPEG2 and H264 structures. Bit size can be deduced from output buffer size and 
it doesn't hurt if bit size in Cedrus is set to bigger value than actual slice 
bit size.

> Hantro dedicated control is moving to hantro-media.h
> Since hevc-ctrls.h content has been dispatched in others file, remove it.
> 
> fluster tests results on IMX8MQ is 77/147 for HEVC codec.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Note that Cedrus still needs additional information in order to decode some 
HEVC videos. Missing info is num_entry_point_offsets and list of all 
entry_point_offset_minus1 (obviously, num_entry_point_offsets in size).

I suggest that this is represented in a new control, which would use dynamic 
array feature, written by Hans. While Cedrus supports max. 256 entries, it can 
be much bigger in theory, but in reality, it's much smaller (like 4-8 
entries).

Last but not least, data_bit_offset should be better defined. Currently it 
points right after last header bit, just like Cedrus needs it. However, there 
is padding after that, at least 1 bit and 8 bits at most, so slice data always 
starts from byte aligned address. It probably make sense to rework that field 
to be byte offset, not bit, just like in VA-API. Note that RPi HEVC driver also 
uses byte aligned address directly. Cedrus would need some kind of workaround 
and only one that works is this one:
https://github.com/bootlin/libva-v4l2-request/blob/master/src/h265.c#L191-L209

Best regards,
Jernej


