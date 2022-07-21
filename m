Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E757CE43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiGUOyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiGUOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:54:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2939B82
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:54:20 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.146.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D08266601AAA;
        Thu, 21 Jul 2022 15:54:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658415259;
        bh=WHsvqu7hShD6Quppt84R/Z5x1/NTIchqeQJ9NSjFbQM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZBJg7o5flzdNNqPrDOEwtFfxH18TzIO47VjIO4Mx7qf5/sFQSd2aXe5QWCyrAtPAg
         3EScNF0f8dEXcZgLv8OddftcR5S/v/9BRjtm6BJw7Bci46Lb+WfrSsf70BUisLuB6R
         aQQmevF9P4SDn6U86rrHKAHYmYNEGpqkW0t8Tuz8cNmlEQSCTf923OPro8pCG5y4MS
         BwV5NC35UAoQrry0uXOKpUlM5IR7ehnxZlqJNKQemLbshogNp7ItdNCEU1FLWhnlQu
         ncpnDTUOjP4jS78ob4YCMo/aJWD/em4jlEi7KnIQSGj5DzQcD/cCZJs6BPc/XFLjO0
         JkOEG003I77Fw==
Message-ID: <0f413cf5-fadc-6fe8-cadc-2c9526d4a2e2@collabora.com>
Date:   Thu, 21 Jul 2022 17:54:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: cs35l41: Set the new legacy DAI naming flag
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220721121454.1378945-1-cristian.ciocaltea@collabora.com>
 <20220721131928.GD92394@ediswmail.ad.cirrus.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20220721131928.GD92394@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 7/21/22 16:19, Charles Keepax wrote:
> On Thu, Jul 21, 2022 at 03:14:54PM +0300, Cristian Ciocaltea wrote:
>> Unlike most CODEC drivers, the CS35L41 driver did not have the
>> non_legacy_dai_naming set, meaning it uses the legacy naming.
>>
>> The recent migration to the new legacy DAI naming style has broken
>> driver functionality because it is now expected to set the new legacy
>> DAI naming flag in order to instruct the core subsystem to use the
>> legacy name format on DAI registration.
>>
>> Let's fix this by setting the legacy_dai_naming flag accordingly.
>>
>> Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
> 
> It is really not intended for any CODECs to be using the legacy
> DAI naming, it was only intended for platform side components.
> Would be good if you had some details on the affected system and
> if that could be updated to use the non legacy DAI naming?

I'm currently testing this on Valve's Steam Deck. Let me also check what 
would be the required changes in order to switch to using a non-legacy 
DAI naming.

> Thanks,
> Charles
