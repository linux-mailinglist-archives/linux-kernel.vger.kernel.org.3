Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBCD483E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiADIv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiADIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:51:58 -0500
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A553C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:51:57 -0800 (PST)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id 4150B91611; Tue,  4 Jan 2022 09:51:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1641286315;
        bh=qBWalmtKSmagHda2t4OLj3e+LegwcyqsE7AA17/oBUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PqXA/8s2D/QczOIgnuISHzpxprHZBgjX5z5bc4rH2deGDk6PLW/zh5W8cQH6m+FQH
         dHmExgYMIDgXdEfIRgw/ZO15vLCegzhEI5HfAF43oOnXPXRxmGntcZkNInCJiaDPqL
         OlQMSD0aIQwAINymhxUYaEqG6UJ9HLFwDkV3mDRg=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from webmail.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by magratgarlick.emantor.de (Postfix) with ESMTPA id B8BCA915FB;
        Tue,  4 Jan 2022 09:51:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1641286310;
        bh=qBWalmtKSmagHda2t4OLj3e+LegwcyqsE7AA17/oBUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrS2vg4Rgw3Ez9BAx2YYKumQcsmZTn6CHmhxthAPEZIsH5zO4ie7E3TBeCdR32e9l
         XHr8aBLvxjvEZgcCzwRKYo7MSTWeSyakUF959sCev3OoNMBHnUiOmgPixY1w/ix90V
         vQbI0+iWtFIS5V0xtwlDuP3REAtaetfS9MN0dOzk=
MIME-Version: 1.0
Date:   Tue, 04 Jan 2022 09:51:50 +0100
From:   rouven@czerwinskis.de
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Simeon Simeonoff <sim.simeonoff@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Colin Ian King <colin.king@intel.com>
Subject: Re: IOMMU Page Fault with Creative Soundblaster Zx after suspend
In-Reply-To: <s5hwnjmo7ae.wl-tiwai@suse.de>
References: <87mtkjqvgj.fsf@czerwinskis.de> <s5hwnjmo7ae.wl-tiwai@suse.de>
Message-ID: <f039f58c6aa161a15ed38737c51cc233@czerwinskis.de>
X-Sender: rouven@czerwinskis.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-12-30 08:56, schrieb Takashi Iwai:
> On Wed, 29 Dec 2021 16:24:13 +0100,
> Rouven Czerwinski wrote:
>> 
>> Hi,
>> 
>> With current 5.15.11, my soundblaster Zx is not correctly coming back
>> from suspend. Dmesg prints:
>> 
>> [Mi Dez 29 16:12:14 2021] [drm] UVD and UVD ENC initialized 
>> successfully.
>> [Mi Dez 29 16:12:14 2021] snd_hda_codec_ca0132 hdaudioC0D1: ca0132 DSP 
>> downloaded and running
>> [Mi Dez 29 16:12:15 2021] [drm] VCE initialized successfully.
>> [Mi Dez 29 16:12:15 2021] usb 1-5: reset full-speed USB device number 
>> 2 using xhci_hcd
>> [Mi Dez 29 16:12:16 2021] ata1.00: Enabling discard_zeroes_data
>> [Mi Dez 29 16:12:16 2021] OOM killer enabled.
>> [Mi Dez 29 16:12:16 2021] Restarting tasks ... done.
>> [Mi Dez 29 16:12:16 2021] PM: suspend exit
>> [Mi Dez 29 16:12:16 2021] snd_hda_intel 0000:06:00.0: AMD-Vi: Event 
>> logged [IO_PAGE_FAULT domain=0x000f address=0xdf880000 flags=0x0000]
>> [Mi Dez 29 16:12:17 2021] igb 0000:08:00.0 enp8s0: igb: enp8s0 NIC 
>> Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
>> 
>> Where the IOMMU Page Fault looks suspicious. Unbinding and rebinding 
>> the
>> driver using sysfs fixes it, thats the current workaround I have
>> been using.
> 
> Is it a regression from the earlier releases?  If yes, please try to
> narrow down the regression range, at least, which version started
> showing the problem.  It'd be great if you can perform git bisection,
> of course.

I thought it was but it isn't, I recently switched the profile from 
"Analog Stereo Duplex"
to "Analog Surround 5.1" within pavucontrol (underlying sound daemon is 
pipewire).
This seems to lead to the IOMMU error on resume, using 2.0 works fine 
over a suspend resume
cycle.
Time to find out what the surround handling does differently from plain 
stereo for the
soundblaster Z cards.

Kind regards,
Rouven
