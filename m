Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2415313AF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiEWNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiEWNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:53:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DE5677E;
        Mon, 23 May 2022 06:53:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 97A941F43599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653314005;
        bh=Dz3ZKPQtwBKUhDVWmG5Z5g8SZn+wliMq5r4L/qYaKxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EVl4yiH5zAw6jU/LesJhdcZjrLZJDkNHinjOf4ToLslJ4PlFJ5m4IaXvTcvkLPhw+
         JJu5XDjsHAMr713gN3K14F58MK1nRcuE3lIbNjmjJCkDp1hbq9LLXXWZ5SY8L/wq8f
         E47LCYpkGvzcElhFqW+1zjprXYTK7yF6x5t4D8BQyw74V45JlkAwNiUsmeLKvXjogU
         JhUArK8+Sw6wgx20cXnvE/PRJID08VdpatPiFR/L56YtsowbVZT3FFn3h+JPAu/n3W
         3IvxfTISvT7jpWMDT9rURYT0llP1DNBdCFI+lfjD1F7rXxkvrycHOWzAkJ714LL7Vc
         HPgSCFXWCA/fw==
Message-ID: <8334772a-6427-352d-4172-ca262267427d@collabora.com>
Date:   Mon, 23 May 2022 15:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] regulator: Add driver for MT6331 PMIC regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
 <YoepiTUfdhkYByo7@sirena.org.uk>
 <6cc68be9-e509-eae4-801d-997fdc01dcf2@collabora.com>
 <YouFcSapkVC7ZfuP@sirena.org.uk>
 <a6606891-d55f-dbce-7c5a-86390694e1c4@collabora.com>
 <YouPdNrBS2xwWwlI@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YouPdNrBS2xwWwlI@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 15:43, Mark Brown ha scritto:
> On Mon, May 23, 2022 at 03:22:39PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 23/05/22 15:00, Mark Brown ha scritto:
> 
>>> Right, my point here is that it looks awfully like the documentation
>>> (this came from documentation I guess?) is including some extra bits
>>> that get ignored in the voltage selection field here.  That seems like a
>>> weird choice somewhere along the line.
> 
>> I wish I had a datasheet for these parts...
> 
>> All of this comes from analyzing a running device on the downstream 3.4 kernel
>> and on understanding the (not really readable) downstream kernel code...
>> ..but yes, I agree on the fact that this seems to be a weird choice.
> 
>> Ah, besides, I hooked up an oscilloscope to the VCAM_IO and I can see that the
>> vreg really does react as expected upon setting the upper bits.. but since it
>> still works without, we can safely ignore them, which makes us able to simplify
>> the driver (as no custom code for that will be required) and, at the same time,
>> avoid seeing a table of values repeated 4 times in a row.
> 
> That seems safer in general if we don't know what those bits are doing -
> it could be some kind of mode control or something.
> 
>> ...so, the regulator will indeed shut itself off and clear either/both the QI_EN
>> and/or its relative bit in the enable register... I've also just found hints of
>> the latter (enable register being set to 0) downstream, so I'm sure that this is
>> indeed right.
> 
> That's still not quite the same thing as a status bit, if the regulator
> disables itself then it won't try to turn itself back on.  Note that the
> core will fall back on using the enable state if there's no status op so
> there's no need for this logic, you can just omit the status op and the
> behaviour will be the same.

Ok then, I'll simply remove that!

Thanks,
Angelo
