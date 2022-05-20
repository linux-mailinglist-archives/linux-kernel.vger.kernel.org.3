Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FC52E7ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347245AbiETImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347309AbiETImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:42:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2D55485;
        Fri, 20 May 2022 01:42:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 60EF21F43F56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653036164;
        bh=VV7uxDN1Imb56z7LKukCJYplYNlWvJ/o/kgUG//vB80=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CKGNnBlz4UxZuDv7oD+pHQm7jL3iCcv8u3ytZdgZt3UxC7Kn+CH4sbiXcbZSkW6zk
         pp2ICEZD6VK0NzUkAbammKLfF42VOFCJusfNoIre8ZI3iQVTxKirFr/vrjwl67dqPg
         GHIBJtyzT9A01nFU+FpgxyZ/4E8BrF/LtizIvVHejrd608DjOsCgioQ1l+XEKNOT+j
         8UnYE5WsOQ6PN+uj2YiLL06m/9WTm7u+ow0CJzC+MTx23OJlMxvVOnwo/rIxhCkaHR
         DD/JBHD04El4FpremJNnmTaH1ZYufM51vARbL03EBZhaV+MWvPwjPUgby88kldwWE7
         ycqmpMXjAqvdA==
Message-ID: <5b5f6656-8694-dc78-ef42-7ce301849aa4@collabora.com>
Date:   Fri, 20 May 2022 10:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/6] clk: mediatek: reset: Return reset data pointer on
 register
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
 <20220519134728.456643-4-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519134728.456643-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 15:47, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Return a struct mtk_clk_rst_data * when registering a reset
> controller in preparation for adding an unregister helper
> that will take it as an argument. Make the necessary changes
> in drivers that do not currently discard the return value
> of register functions.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Hello Yassine,

Thanks for your efforts on helping to make the MediaTek clocks better - I agree
(and I'm not the only one..) that there's a lot of work to do on this side.

Though... I don't think that this is the right direction: you're right about
properly unregistering (in patch 4/6) the reset controllers on rmmod/failure
but I'm not sure that this kind of noise brings any benefit.

Explaining:
You definitely saw that there's a new register _with_dev, which uses devm ops
and that's going to automatically cleanup in case of removal/failure.
This is what we should do.

Hence, my proposal is to drop patch 3/6, 4/6, 5/6 and (slowly, steadily) migrate
all of the MediaTek clocks from CLK_OF_DECLARE() to platform drivers (which also
means that we can eventually change them to tristate!), so that we slowly remove
all users of all functions that are not "_with_dev", and that we finally remove
all of these then-unused functions as well.

Making sure that I don't get misunderstood:
      I'm not implying that this huge migration work is on your shoulders!

P.S.: Chen-Yu, Miles: do you also agree? :-)

Cheers,
Angelo

