Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37A56A48F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiGGNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiGGNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:54:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8CC1A3B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30DF2B82222
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B52EC3411E;
        Thu,  7 Jul 2022 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657202044;
        bh=YxMzjokADQrbKoPDO+0wT5Rr7rSlh3WfSRj6cxknfTQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sanBS9M6YlcLU7O/8cdfdB0fjs8mOK7nmYA/qprrlS3oPFF80teijQX5KL1DBd3m6
         yNpAEgmKilip5p6fSWvHpIx3hzNpKeLTdplocbFQtjuEqJQFSKS6xDlUHgYv7s8iAT
         1NLNrPFk4jwfb/8IIuTyzEpaQMPAgKZhbVghtMpZ+t/acsildYrFgMy25ReVcJt1VY
         ClVGcGVb9JXHalfk8/1vAMJ6Q1lq5ePiLmKPkuRFP/AuiMpR66iAwkhk0lfcIUj58y
         ZXmzpNwwt9uculMT8mWc0bmTUw5Q8WhrTFBXEwqkoBL+8vyF9lhKoSpPUIVgRSxjzM
         6xUlMbb4kzK3w==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com
Cc:     daniel.baluta@nxp.com, lkp@intel.com, tiwai@suse.com,
        Alexander.Deucher@amd.com, pierre-louis.bossart@linux.intel.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        julianbraha@gmail.com, lgirdwood@gmail.com,
        AjitKumar.Pandey@amd.com, linux-kernel@vger.kernel.org,
        zhuning@everest-semi.com, perex@perex.cz,
        tanureal@opensource.cirrus.com
In-Reply-To: <20220706205515.2485601-1-Vijendar.Mukunda@amd.com>
References: <20220706205515.2485601-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix ACPI dependency compile errors and warnings
Message-Id: <165720204134.3916612.9568740345035740462.b4-ty@kernel.org>
Date:   Thu, 07 Jul 2022 14:54:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 02:25:14 +0530, Vijendar Mukunda wrote:
> Fixed ACPI dependency complie errors and warnings as listed below.
> 
> All warnings (new ones prefixed by >>):
> 
> sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
>   34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>      | ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:38:1: note: previous definition of
> 'snd_soc_acpi_find_machine'
> with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
> 38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>    | ^~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
> sound/soc/soc-acpi.c:58:36: error: implicit declaration of function
> 'acpi_fetch_acpi_dev';
> did you mean 'device_match_acpi_dev'?
> [-Werror=implicit-function-declaration]
> 58 | struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
>    |                            ^~~~~~~~~~~~~~~~~~~
>    |                            device_match_acpi_dev
> >> sound/soc/soc-acpi.c:58:36: warning: initialization of
>    'struct acpi_device *' from 'int' makes pointer from integer
>    without a cast [-Wint-conversion]
> sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type
> 'struct acpi_device'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix ACPI dependency compile errors and warnings
      commit: ab34403db24233e603338b70deb9a84093c88397

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
