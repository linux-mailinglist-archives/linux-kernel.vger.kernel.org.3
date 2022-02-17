Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDC4BA051
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiBQMqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:46:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiBQMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:46:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3A2A59A7;
        Thu, 17 Feb 2022 04:46:07 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DA3225B;
        Thu, 17 Feb 2022 13:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645101963;
        bh=nhhWEcMkMbDxADxYj1RgUC6I3/acetFo25XZBSPdrPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oZ/GpToytbAjcw3RLuZE5OIQ/+i4mlgrLvXUyzeNY8rf0ExbBpwe8/N3XglPrQcI9
         6p+tM1IHb/E72I3YAptgdVYsXUw0ZYAgpb4MyI8SbGtHcitDyjWGEGkhCycktuT2vG
         fmm/+L2OmNutcFeyI5bUiLWAI8cmb9NS+htergCM=
Message-ID: <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com>
Date:   Thu, 17 Feb 2022 14:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
Content-Language: en-US
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
> On devices with DMM, all allocations are done through either DMM or TILER.
> DMM/TILER being a limited resource means that such allocations will start
> to fail before actual free memory is exhausted. What is even worse is that
> with time DMM/TILER space gets fragmented to the point that even if we have
> enough free DMM/TILER space and free memory, allocation fails because there
> is no big enough free block in DMM/TILER space.
> 
> Such failures can be easily observed with OMAP xorg DDX, for example -
> starting few GUI applications (so buffers for their windows are allocated)
> and then rotating landscape<->portrait while closing and opening new
> windows soon results in allocation failures.
> 
> Fix that by mapping buffers through DMM/TILER only when really needed,
> like, for scanout buffers.

Doesn't this break users that get a buffer from omapdrm and expect it to 
be contiguous?

  Tomi
