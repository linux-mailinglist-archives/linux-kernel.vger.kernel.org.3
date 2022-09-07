Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4252B5AFF89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIGIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIGIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950499B66;
        Wed,  7 Sep 2022 01:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64ADF617FE;
        Wed,  7 Sep 2022 08:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A623C433C1;
        Wed,  7 Sep 2022 08:48:00 +0000 (UTC)
Message-ID: <9270d6c8-fc8d-3a15-5469-aca3faab098b@xs4all.nl>
Date:   Wed, 7 Sep 2022 10:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 00/43] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI
 Rework
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 26/08/2022 20:31, Paul Kocialkowski wrote:
> This part only concerns the rework of the CSI driver to support the MIPI CSI-2
> and ISP workflows.
> 
> Very few patches have not received any review at this point and the whole
> thing looks good to go. Since this multi-part series has been going on for a
> while, it would be great to see it merged soon!

Testing with just patches 1-15 gives me these kerneldoc results:

kerneldoc: WARNINGS
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:79: warning: Function parameter or member 'csi_dev' not described in 'sun6i_csi_is_format_supported'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:79: warning: Excess function parameter 'csi' description in 'sun6i_csi_is_format_supported'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:86: warning: Function parameter or member 'csi_dev' not described in 'sun6i_csi_set_power'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:86: warning: Excess function parameter 'csi' description in 'sun6i_csi_set_power'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:94: warning: Function parameter or member 'csi_dev' not described in 'sun6i_csi_update_config'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:94: warning: Excess function parameter 'csi' description in 'sun6i_csi_update_config'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:102: warning: Function parameter or member 'csi_dev' not described in 'sun6i_csi_update_buf_addr'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:102: warning: Excess function parameter 'csi' description in 'sun6i_csi_update_buf_addr'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:109: warning: Function parameter or member 'csi_dev' not described in 'sun6i_csi_set_stream'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:109: warning: Excess function parameter 'csi' description in 'sun6i_csi_set_stream'

If this is caused by just 1 or 2 patches, then please post a v6.1 version of just
those patches fixing this. Otherwise perhaps a v7 is needed.

Regards,

	Hans

> 
> Changes since v5:
> - Rebased on latest media tree;
> - Switched to using media_pad_remote_pad_first;
> - Switched to using media_pad_remote_pad_unique.
> 
> Changes since v4:
> - Removed the v4l2 controls handler from the driver;
> - Removed the info message about video device registration;
> - Fixed "literature" typos;
> - Moved patches dependent on the ISP driver to its dedicated series;
> - Rebased on the latest media tree;
> - Added collected tags;
> 
> Changes since v3:
> - Updated Kconfig to follow the latest media-wide changes;
> - Rebased on latest changes to the driver (JPEG/sRGB colorspaces);
> - Added helper to get a single enabled link for an entity's pad, to replace
>   source selection at link_validate time and select the remote source at
>   stream on time instead;
> - Kept clock-managed regmap mmio;
> - Added collected review tags;
> - Various cosmetic cleanups;
> 
> Changes since all-in-one v2:
> - Reworked capture video device registration, which stays in the main path.
> - Reworked async subdev handling with a dedicated structure holding the
>   corresponding source to avoid matching in the driver;
> - Added mutex for mbus format serialization;
> - Remove useless else in link_validate;
> - Reworked commit logs to include missing information;
> - Cleaned up Kconfig, added PM dependency;
> - Moved platform-specific clock rate to of match data;
> - Added collected Reviewed-by tags;
> - Updated copyright years;
> 
> Paul Kocialkowski (43):
>   media: sun6i-csi: Define and use driver name and (reworked)
>     description
>   media: sun6i-csi: Refactor main driver data structures
>   media: sun6i-csi: Tidy up platform code
>   media: sun6i-csi: Always set exclusive module clock rate
>   media: sun6i-csi: Define and use variant to get module clock rate
>   media: sun6i-csi: Use runtime pm for clocks and reset
>   media: sun6i-csi: Tidy up Kconfig
>   media: sun6i-csi: Tidy up v4l2 code
>   media: sun6i-csi: Tidy up video code
>   media: sun6i-csi: Pass and store csi device directly in video code
>   media: sun6i-csi: Register the media device after creation
>   media: sun6i-csi: Remove controls handler from the driver
>   media: sun6i-csi: Add media ops with link notify callback
>   media: sun6i-csi: Introduce and use video helper functions
>   media: sun6i-csi: Move csi buffer definition to main header file
>   media: sun6i-csi: Add bridge v4l2 subdev with port management
>   media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
>   media: sun6i-csi: Add capture state using vsync for page flip
>   media: sun6i-csi: Rework register definitions, invert misleading
>     fields
>   media: sun6i-csi: Add dimensions and format helpers to capture
>   media: sun6i-csi: Implement address configuration without indirection
>   media: sun6i-csi: Split stream sequences and irq code in capture
>   media: sun6i-csi: Move power management to runtime pm in capture
>   media: sun6i-csi: Move register configuration to capture
>   media: sun6i-csi: Rework capture format management with helper
>   media: sun6i-csi: Remove custom format helper and rework configure
>   media: sun6i-csi: Add bridge dimensions and format helpers
>   media: sun6i-csi: Get mbus code from bridge instead of storing it
>   media: sun6i-csi: Tidy capture configure code
>   media: sun6i-csi: Introduce bridge format structure, list and helper
>   media: sun6i-csi: Introduce capture format structure, list and helper
>   media: sun6i-csi: Configure registers from format tables
>   media: sun6i-csi: Introduce format match structure, list and helper
>   media: sun6i-csi: Implement capture link validation with logic
>   media: sun6i-csi: Get bridge subdev directly in capture stream ops
>   media: sun6i-csi: Move hardware control to the bridge
>   media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
>   media: sun6i-csi: Cleanup headers and includes, update copyright lines
>   media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
>   media: sun6i-csi: Only configure capture when streaming
>   media: sun6i-csi: Add extra checks to the interrupt routine
>   media: sun6i-csi: Request a shared interrupt
>   MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
> 
>  MAINTAINERS                                   |   17 +-
>  .../media/platform/sunxi/sun6i-csi/Kconfig    |   12 +-
>  .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 1027 ++++------------
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  149 +--
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  844 +++++++++++++
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |   69 ++
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 1089 +++++++++++++++++
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   88 ++
>  .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  362 +++---
>  .../platform/sunxi/sun6i-csi/sun6i_video.c    |  685 -----------
>  .../platform/sunxi/sun6i-csi/sun6i_video.h    |   38 -
>  12 files changed, 2551 insertions(+), 1831 deletions(-)
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
>  delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
>  delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
> 

