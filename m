Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B84C42CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiBYKxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiBYKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:52:53 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D717FD20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:52:20 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1E017A003F;
        Fri, 25 Feb 2022 11:52:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1E017A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1645786338; bh=iJ1NLrVE5m5/910GN8+APcCFZEpD5R1STwg2JWo5YLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TTTCRKQ6KbNfa0FDRsV7vkM5ih7pSBJQ3husdPxJSOrHWnuWgpFuXKoxNDf5ffyIj
         Yf7xOgB3bayNEA/lIkZni2ISS2qdKfRwUupvxVu01Q2ZfCp62NBMvwcLHkKM2gZpx8
         KzBLzBfe6vMXmdIkThcfz/ngGU8chh185PuWmAQw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 25 Feb 2022 11:52:05 +0100 (CET)
Message-ID: <83e4b67d-91d3-dca9-4b1f-d209f927d517@perex.cz>
Date:   Fri, 25 Feb 2022 11:52:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V0 1/1] ALSA: pcm: fix blocking while loop in
 snd_pcm_update_hw_ptr0()
Content-Language: en-US
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        ierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, Zubin Mithra <zsm@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Krishna Jha <quic_kkishorj@quicinc.com>
References: <cover.1645784757.git.quic_rbankapu@quicinc.com>
 <4d8b1cb4b0db88c3e28207a81403fbf1e4a87bff.1645784757.git.quic_rbankapu@quicinc.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <4d8b1cb4b0db88c3e28207a81403fbf1e4a87bff.1645784757.git.quic_rbankapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 02. 22 11:39, Raghu Bankapur wrote:
> When period interrupts are disabled, while loop in snd_pcm_update_hw_ptr0()
> results in the machine locking up if runtime->hw_ptr_buffer_jiffies is 0.
> Validate runtime->hw_ptr_buffer_jiffies value before while loop to avoid
> delta check.

I would set hw_ptr_buffer_jiffies to 1 in this case in snd_pcm_post_start().

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
