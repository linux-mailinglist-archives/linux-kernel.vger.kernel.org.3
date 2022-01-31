Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEF34A444F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbiAaL1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378098AbiAaLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:19:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A1C0612F4;
        Mon, 31 Jan 2022 03:11:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3C1B71F4323B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643627515;
        bh=bih+YpN7Bu9FDncTaHYjpoZqdzNV5LPiHw6/cv1cfhQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hKRtf4cDoo1ygR4TE6AVz3KwgVq9I2wipi4rIcHIGgpe4sBTYjAxOsd2Kf7TyyOys
         tcCjMJOIJjFy9IwzerMUjdbmP1MW8aRsU1mwqccSQAZGK6MiYYTIVzUU62IJS2evjN
         v2ybCwImU3qGLqu44MtMpNG+od93c0ze1Jo0k/1WMx5nW1fjzNx4bBNE4dch9yN2in
         oGRNDJQQjPrfD61oTV/yKPQa7DwOXZzaLfqi9zaMpRFiXS7vY6pcD8Ge8UnXnJhO+p
         lLERwen3qfXz8zdm4FsGqmtK2XkAK6LBUbHVT0wKUOcY3i1JRCEjeN/hM8NjeMiXXt
         QKJ6fsA1asRpw==
Message-ID: <0846872b-03da-ee5d-6a9d-e6c9fa754191@collabora.com>
Date:   Mon, 31 Jan 2022 12:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v22 5/7] soc: mediatek: SVS: add debug commands
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
 <20220127033956.24585-6-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220127033956.24585-6-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/01/22 04:39, Roger Lu ha scritto:
> The purpose of SVS is to help find the suitable voltages
> for DVFS. Therefore, if SVS bank voltages are concerned
> to be wrong, we can adjust SVS bank voltages by this patch.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>


Hello Roger,
I was thinking about what this patch is adding... and I have a few considerations.

It's nice to have a debugging mechanism to read the status and dump registers, as
that's very helpful when doing heavy debugging of the IP... but adding the
possibility to write a voltage offset may be very dangerous: think about the case
in which, either for misconfiguration, or for any other reason, the debugfs entry
that allows writing voffset becomes user-writable, or a user writes an impossibly
high voffset.
In case a very low (negative) voffset is entered, the platform would crash (denial
of service); if a very high voffset is entered, hardware damage may occur.

For this reason, there are two proposals:
1. If you want to keep the debugfs voffset write, please constrain the permissible
    voffset to an acceptable range that at least makes it unlikely to damage the HW;
    Moreover, since voffset write is a feature that would be used in very limited
    debugging cases, I think that this should be implemented over a build-time
    configuration barrier... something like CONFIG_MTK_SVS_DEBUG_ALLOW_WRITE, or
    similar;
2. Since it's very unlikely for someone to really play that much with a voltage
    offset during runtime, and since this looks like something very machine specific
    (perhaps addressing board-specific quirks?), I would suggest to add this as a
    device-tree parameter instead, such as "mediatek,svs-voffset", as it is indeed
    possible to specify both positive or negative values in DT.

I would prefer proposal 2, as it looks generally cleaner and way less risky.

Regards,
Angelo
