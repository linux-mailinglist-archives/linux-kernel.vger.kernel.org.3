Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8297149DF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiA0Kc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:32:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiA0Kcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:32:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C6C341F44FF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643279572;
        bh=3IabDGDX1X8Lt5ZJt6EaeuvYuynxAJ9WYVmwg7VmWFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A+56cwLIlE83emP51k58CylI86F66rWP4M+qdLmNZZXsyQsc/rk7rAaw9cQ9GfzN2
         NFg1ESq9RvxlhQuPqpZ83YpsLZus80W1ZC+B03U52ypPP8BL6wO3m32ed7gnMgJ2g/
         hYfaG3ddeF05kmu1TeS4zl1baGU/pyAENVuy6BHej1ROueYVRX5rOB06JdZgobg954
         3KMh+vmTcgCJdQBuNDcBUqT/aVC2iPZdL/6ZFD6RBQYPJZsXyGW6fomKu+HiEwa3tL
         uZcaLZLdxBXNXqKu4XmBlgD7wBnMkkbqvI163A8FUnXoM2gQ27qBysJBPxG+n1bS1O
         Flfp/NL33MO7Q==
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: Avoid EPROBE_DEFER loop with
 external bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
References: <20220104095954.10313-1-angelogioacchino.delregno@collabora.com>
 <CAMty3ZAojTyw3H8VprH9aiyTyWjeL8oqPxNNr=J33_5FrcUj9Q@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4b46b8ce-7300-ef42-eb17-efd87ebdf773@collabora.com>
Date:   Thu, 27 Jan 2022 11:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZAojTyw3H8VprH9aiyTyWjeL8oqPxNNr=J33_5FrcUj9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/01/22 08:09, Jagan Teki ha scritto:
> On Tue, Jan 4, 2022 at 3:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> DRM bridge drivers are now attaching their DSI device at probe time,
>> which requires us to register our DSI host in order to let the bridge
>> to probe: this recently started producing an endless -EPROBE_DEFER
>> loop on some machines that are using external bridges, like the
>> parade-ps8640, found on the ACER Chromebook R13.
>>
>> Now that the DSI hosts/devices probe sequence is documented, we can
>> do adjustments to the mtk_dsi driver as to both fix now and make sure
>> to avoid this situation in the future: for this, following what is
>> documented in drm_bridge.c, move the mtk_dsi component_add() to the
>> mtk_dsi_ops.attach callback and delete it in the detach callback;
>> keeping in mind that we are registering a drm_bridge for our DSI,
>> which is only used/attached if the DSI Host is bound, it wouldn't
>> make sense to keep adding our bridge at probe time (as it would
>> be useless to have it if mtk_dsi_ops.attach() fails!), so also move
>> that one to the dsi host attach function (and remove it in detach).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
>> ---
> 
> Eventually I've observed similar issue on other Component based DSI
> controllers, hence
> 
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
> 

Hello dri-devel,
can you please pick this patch?

All MediaTek platforms are broken in v5.17 without this one.

Thanks,
Angelo
