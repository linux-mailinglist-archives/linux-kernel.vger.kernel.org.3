Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4F57A3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiGSPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiGSPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:49:29 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 08:49:26 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E85A151
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:49:26 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 46DC5A003F;
        Tue, 19 Jul 2022 17:41:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 46DC5A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1658245316; bh=jssVzMeaCJcQDwD4u3tZ8207RFaqTSc9M9ptu2f+vCI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FMWvYpBirh9cFBmm40mf+DsZ4mt75fcCz8owBBKedUD9xf30twBsJgTb/g01nCGBu
         MSRwrrt/7h0QbRNFU+IJs4nX4OCdRFCw0FDzGFebvjGcyy/Po3KE0+0UbJy4MINS+w
         Mhlv391yX544o35qth9i6KnSyhKK27lOjJrc8Y8c=
Received: from [192.168.88.20] (unknown [95.168.116.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 19 Jul 2022 17:41:49 +0200 (CEST)
Message-ID: <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz>
Date:   Tue, 19 Jul 2022 17:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda: Skip creating captures in SOF context
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, tiwai@suse.com
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220719144753.252231-1-kai.heng.feng@canonical.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220719144753.252231-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 19. 07. 22 v 16:47 Kai-Heng Feng napsal(a):
> On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
> light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
> topology: use new sound control LED layer").
> 
> The micmute LED itself is still working via sysfs, but it doesn't follow
> mute anymore. That's because unlike vendors like Dell and Lenovo, HP
> laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
> laptops, both SOF and HDA create captures with
> SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
> there are two different kcontrols and one of them is not muted.

It does not mean that it's a wrong behavior. When both controls are muted, the
LED should be turned on. It just requires that all inputs are off (and it may
be the default - probably we can set in UCM or so). If you turn the "Capture
Switch" off in amixer / alsamixer, do things work as expected ?

> So skip creating captures for HDA when it's called from SOF, the
> captures are already handled by SOF.

The capture controls are for other inputs like external analog microphone. If
it is required to suppress the MIC LED for some hardware, just skip the
"spec->mic_mute_led = 1" assignment in hda_generic.c . Also, the check
"codec->core.type != HDA_DEV_ASOC" is not sufficient, because you don't know,
if the topology really sets the MIC LED flag.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
