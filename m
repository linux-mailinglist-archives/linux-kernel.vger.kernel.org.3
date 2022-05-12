Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7F525472
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357298AbiELSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbiELSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:08:50 -0400
X-Greylist: delayed 101439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 11:08:46 PDT
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C25626866F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:08:45 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 995D9C800A0;
        Thu, 12 May 2022 20:08:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VtnO0W-gAp6B; Thu, 12 May 2022 20:08:43 +0200 (CEST)
Received: from [192.168.176.111] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 10D9FC8009E;
        Thu, 12 May 2022 20:08:42 +0200 (CEST)
Message-ID: <a9a88617-101c-739c-fecd-5925e5f5085c@tuxedocomputers.com>
Date:   Thu, 12 May 2022 20:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ALSA: hda/intel: Add quirk for TongFang devices with pop
 noise
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        linux-kernel@vger.kernel.org, imre.deak@intel.com,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com
References: <20220511133828.13724-1-wse@tuxedocomputers.com>
 <s5h35hggpao.wl-tiwai@suse.de>
 <71fadca3-7750-2fc0-c04a-f05ab4e85112@tuxedocomputers.com>
 <s5hv8ucf9f7.wl-tiwai@suse.de>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <s5hv8ucf9f7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 11.05.22 um 16:09 schrieb Takashi Iwai:
> On Wed, 11 May 2022 15:58:03 +0200,
> Werner Sembach wrote:
>> Am 11.05.22 um 15:41 schrieb Takashi Iwai:
>>> On Wed, 11 May 2022 15:38:28 +0200,
>>> Werner Sembach wrote:
>>>> When audio stops playing and sometimes when it starts playing, there is an
>>>> audible "pop" noise when using headphones on most Tongfang GMxMxxx,
>>>> GKxNxxx, GMxZxxx, GMxTxxx, and GMxAxxx devices.
>>>>
>>>> Disabling power saving for the Realtek codec fixes this noise. Presumably
>>>> it is triggered on some power event in the audio circuit.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: stable@vger.kernel.org
>>> Usually this denylist is a last resort if any other methods never
>>> helped.  Is it the case?
>> I also tried setting codec->power_save_node = 0; in a patch_realtek.c quirk.
>>
>> static void alc274_fixup_pop_noise(struct hda_codec *codec, const struct
>> hda_fixup *fix, int action)
>> {
>>        codec->power_save_node = 0;
>> }
>>
>> That initially seemed to work, but when I tested it again a day later
>> after a fresh install, it didn't anymore. I don't know what is
>> different. On the install before, I did some debugging with boot
>> parameters and other stuff, cant reproduce anymore what exactly.
> power_save_node is already 0 as default for patch_alc269(), so it must
> be irrelevant.
>
>> I took the line from alc274_fixup_bind_dacs which fixes the pop noise
>> when applied to the devices, but does a lot of random other stuff too
>> not meant for the device.
> It's only one thing, there are tons of different fixes :)
> alc274_fixup_bind_dacs() rather specifies the routing so that the
> speaker is connected to the preferred DAC.
>
> Many click noises come from the default pin shut-up behavior.  You
> can disable it or change it in other way.  Also, setting
> auto_mute_via_amp may influence on such behavior (that is included in
> alc274_fixup_bind_dacs()).
>
> Note that many quirks can be enabled even without compiling but via
> the codec patch loading (using hints).
>
>
> thanks,
>
> Takashi

Found a quirk in patch_realtek.c with the same effect as the
power_save=0 and 2 more affected subsystem ids. Patch send as v2.

Kind Regards,

Werner

