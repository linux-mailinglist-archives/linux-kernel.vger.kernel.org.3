Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4883A5234D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiEKN6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiEKN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:58:10 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF35B3C5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:58:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id B4B55C80099;
        Wed, 11 May 2022 15:58:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fSmKOxGlGNEQ; Wed, 11 May 2022 15:58:04 +0200 (CEST)
Received: from [192.168.178.82] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id E1A7AC80091;
        Wed, 11 May 2022 15:58:03 +0200 (CEST)
Message-ID: <71fadca3-7750-2fc0-c04a-f05ab4e85112@tuxedocomputers.com>
Date:   Wed, 11 May 2022 15:58:03 +0200
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
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <s5h35hggpao.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.05.22 um 15:41 schrieb Takashi Iwai:
> On Wed, 11 May 2022 15:38:28 +0200,
> Werner Sembach wrote:
>> When audio stops playing and sometimes when it starts playing, there is an
>> audible "pop" noise when using headphones on most Tongfang GMxMxxx,
>> GKxNxxx, GMxZxxx, GMxTxxx, and GMxAxxx devices.
>>
>> Disabling power saving for the Realtek codec fixes this noise. Presumably
>> it is triggered on some power event in the audio circuit.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
> Usually this denylist is a last resort if any other methods never
> helped.  Is it the case?

I also tried setting codec->power_save_node = 0; in a patch_realtek.c quirk.

static void alc274_fixup_pop_noise(struct hda_codec *codec, const struct
hda_fixup *fix, int action)
{
       codec->power_save_node = 0;
}

That initially seemed to work, but when I tested it again a day later
after a fresh install, it didn't anymore. I don't know what is
different. On the install before, I did some debugging with boot
parameters and other stuff, cant reproduce anymore what exactly.

I took the line from alc274_fixup_bind_dacs which fixes the pop noise
when applied to the devices, but does a lot of random other stuff too
not meant for the device.

I think I only ever warm rebooted when trying other fixes including that
one, maybe that's the reason for the different behavior a day later ..

Kind Regards,

Werner Sembach

>
>
> thanks,
>
> Takashi
