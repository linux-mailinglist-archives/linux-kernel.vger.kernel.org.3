Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4B5A4631
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2JhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2Jg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:36:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836ED5C977
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:36:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D26E06601DB2;
        Mon, 29 Aug 2022 10:36:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661765815;
        bh=G158CjfQdiI7n5kAiwB1ffU/Ky0VT1XFLd5k77luxWA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aUCjw1mHanhtQiZIpUwNswac5D30YX4kqATo6tlBrvrnN/VykansD2j1scYFIifWT
         FgKqoBRMqB6jCUk8HuL3+G/2MIakt05+pY/S2b2Bbl+ShoAq+t6f9OPCg0EGYGiX7O
         sA+QVuiOukSkYgKABLGHKnoTAaO013DUi2VJghsUsOllIQYlsQJmg3nTJkrSB9sDhm
         ddo/mhaJh9JVlJb4TyxHVPJJ3b40ecfxhW6Adlv5tliZsTSHjPNVkyqS4RvcehzmjP
         cjKB9i7IhEVNtYzNlRe/P6K76XCPaVkuc5+gs1yOPccSe9tu1wKCE5X7A/Uy460r98
         qIax8O3etmI0Q==
Message-ID: <37cdcc41-8cfc-443a-a6d7-94b992a0b6f5@collabora.com>
Date:   Mon, 29 Aug 2022 11:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] soc: mediatek: mtk-svs: Use bitfield access macros
 where possible
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-7-angelogioacchino.delregno@collabora.com>
 <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
 <20220825185059.xbh3gigksveg4h4u@notapiano>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220825185059.xbh3gigksveg4h4u@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/08/22 20:50, Nícolas F. R. A. Prado ha scritto:
> On Thu, Aug 25, 2022 at 03:29:33PM +0200, Matthias Brugger wrote:
>>
>>
>> On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
>>> In order to enhance readability and safety during registers setup
>>> and value retrieval, redefine a few register related macros and
>>> convert all open-coded instances of bitfield setting/retrieval
>>> to use the FIELD_PREP() and FIELD_GET() macros.
>>> While at it, some macros were renamed to further enhance readability.
>>>
>>> This commit brings no functional changes.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Does not apply, would you mind to resend together with 1/6? Thanks!
> 
> Hi Matthias,
> 
> Patches 1 and 6 rebased and sent [1].
> 
> Thanks,
> Nícolas
> 
> [1] https://lore.kernel.org/all/20220825184616.2118870-1-nfraprado@collabora.com


Uh, sorry for the previous noise - didn't notice this email.
Many thanks for timely rebasing the patches!

Cheers!
