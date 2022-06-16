Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58E54DB52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358984AbiFPHOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiFPHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:14:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF145B3D6;
        Thu, 16 Jun 2022 00:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92166B82281;
        Thu, 16 Jun 2022 07:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A597C34114;
        Thu, 16 Jun 2022 07:14:07 +0000 (UTC)
Message-ID: <39a83a7e-caaf-1dac-1072-72cd2f5d8bf5@xs4all.nl>
Date:   Thu, 16 Jun 2022 09:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] media: cedrus: fix HEVC decoding
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, samuel@sholland.org,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220615204436.137377-1-jernej.skrabec@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220615204436.137377-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/22 22:44, Jernej Skrabec wrote:
> After detailed comparison of register names to vendor library I noticed
> that one register has completely different name. After some testing I
> discovered that it was misnamed and used incorrectly. This patch series
> fixes it. With that, 3 more reference bitstreams are now correctly
> decoded. It is also possible that this fixes instability issue I had
> after decoding such bitstreams. Running Fluster test suite very often
> locked up my board, but after applying this fix, I never experienced it
> again. It might still be completely coincidental, but I doubt this is
> the case.
> 
> Note: Patch 2 clashes with HEVC uAPI destaging. In current form, it can
> be easily backported. However, there are few users of Cedrus HEVC and
> skipping this fix wouldn't be that bad.
> 
> Please let me know which way to go:
> 1) wait for destaging, send rebased v2 and not care about backporting

Let's go with 1. There is not much point in backporting since destaging
the HEVC API will also change it, so userspace will need to adapt. It's
a staging driver anyway (although hopefully not for long).

If you post a v2 on top of the latest series from Benjamin, then that
should almost certainly work fine when Benjamin posts what will hopefully
be the final version of his series. When it is all OK, then I put both in
the same PR.

Regards,

	Hans

> 2) merge before destaging, but v9 of HEVC uAPI destaging would need to
>    be rebased.
> 3) something else?
> 
> Best regards,
> Jernej
> 
> Jernej Skrabec (2):
>   media: cedrus: h265: Fix flag name
>   media: cedrus: h265: Fix logic for not low delay flag
> 
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 29 ++++++++++++++++++-
>  .../staging/media/sunxi/cedrus/cedrus_regs.h  |  3 +-
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
