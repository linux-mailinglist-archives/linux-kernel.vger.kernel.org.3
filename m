Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C6537A07
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiE3LlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiE3LlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:01 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 04:40:57 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184EF419A3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:40:57 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 981BBA0046;
        Mon, 30 May 2022 13:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 981BBA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1653910855; bh=A94usJLEIZvHxs0NLWIgXXMYLwbbDmxswIagNBme1fA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aqO3x3TZZmEChRN+9pBFGi42ZbmxIRT6l6Fv3SLOfOaU5XUHs41fyYweMmKlfB+DD
         3CJVPNlYi7SWJa9Y+sr46OsbSYUvH35X6fLHGKqDwAV5QJ67Jusl4Q5iubQlwTJWSt
         zAHbudEDy7ZCqBnOxh8lzjWkK2QAsOcavsjm84dE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 30 May 2022 13:40:47 +0200 (CEST)
Message-ID: <7ca20354-1a91-8f18-2de8-8571987fa519@perex.cz>
Date:   Mon, 30 May 2022 13:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <871qwf0x8t.wl-tiwai@suse.de>
 <20220530090846.GS38351@ediswmail.ad.cirrus.com>
 <87czfvxtsc.wl-tiwai@suse.de>
 <20220530093639.GT38351@ediswmail.ad.cirrus.com>
 <87a6azxr7h.wl-tiwai@suse.de>
 <20220530103415.GU38351@ediswmail.ad.cirrus.com>
 <871qwbxpsb.wl-tiwai@suse.de>
 <20220530105329.GV38351@ediswmail.ad.cirrus.com>
 <87wne3wa5w.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87wne3wa5w.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 05. 22 13:07, Takashi Iwai wrote:

> And yet moreover, we'll need to consider some way for protecting
> against DoS-like behavior by frequent kctl changes.

I agree, but only the driver knows details about the kctl operation time and 
resource constraints. So the driver should implement a rate or i/o limit for 
those controls. We may offer helper functions in the ALSA core for this job 
(if required).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
