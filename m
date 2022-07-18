Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89E577A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiGRFpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:45:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4F13D55
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5288FB80EC1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E931C341C0;
        Mon, 18 Jul 2022 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658123115;
        bh=yPiN/vSFCUYAKGMcAOjDfDKLGRowj5r7xJ2VAVb8YNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyGLJo7FwtMSN7/ucLim77qNwaOpXXoif0ZXzrnUQsiveoEgctB0z9X+SknjU8+at
         j2UMdw1kUJUYzyAf7HLnXcVJys6C8LXPczHi4spLfNS97w6IeUz6oEQlG10AQvmPaA
         4LHOLn6bUJFqroOmEhARUeQp6fgT2noHhkaNP5wkgApDNHN76RMHEeabVwZ9BMlksb
         sXvv2pEU+te9ZVVtdtcXqpOe4RuraBI10jijC4ziOrOpLwd15+1XeWmp3A6wHWAs3u
         zeFwoJTfXDEibb02/X4cE+MA0w8NUB2XMLJqC0DzqRhVYgUZKi7VKn+wu9VphbVc67
         F6Bw6naodqYXA==
Date:   Mon, 18 Jul 2022 11:15:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume
 issues
Message-ID: <YtTzZ4iA0xt68euH@matsya>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-22, 09:10, Bard Liao wrote:
> we've been stuck with problems in the dual-amplifier configurations where
> one of the two devices seems to become UNATTACHED and never regains sync,
> see https://github.com/thesofproject/linux/issues/3638.
> 
> This is a rather infrequent issue that may happen once or twice per month,
> but still it remains a concern.
> 
> One possibility is that the device does lose sync but somehow our hardware
> detection fails to see it resync.
> 
> This series just adds a basic read directly from the PING frames to help
> confirm if yes/no the device regain sync.
> 
> The change is mainly on soundwire. @Mark, Could you ack the ASoC patch
> if it looks good to you?

Mark,

The series lgtm, feel free to merge thru ASoC tree with:

Acked-By: Vinod Koul <vkoul@kernel.org>

> 
> Pierre-Louis Bossart (4):
>   soundwire: add read_ping_status helper definition in manager ops
>   soundwire: intel/cadence: expose PING status in manager ops
>   soundwire: add sdw_show_ping_status() helper
>   ASoC: codecs: show PING status on resume failures
> 
>  drivers/soundwire/bus.c            | 32 ++++++++++++++++++++++++++++++
>  drivers/soundwire/cadence_master.c |  8 ++++++++
>  drivers/soundwire/cadence_master.h |  2 ++
>  drivers/soundwire/intel.c          |  1 +
>  include/linux/soundwire/sdw.h      |  5 +++++
>  sound/soc/codecs/max98373-sdw.c    |  2 ++
>  sound/soc/codecs/rt1308-sdw.c      |  2 ++
>  sound/soc/codecs/rt1316-sdw.c      |  2 ++
>  sound/soc/codecs/rt5682-sdw.c      |  2 ++
>  sound/soc/codecs/rt700-sdw.c       |  2 ++
>  sound/soc/codecs/rt711-sdca-sdw.c  |  2 ++
>  sound/soc/codecs/rt715-sdca-sdw.c  |  2 ++
>  sound/soc/codecs/rt715-sdw.c       |  2 ++
>  13 files changed, 64 insertions(+)
> 
> -- 
> 2.25.1

-- 
~Vinod
