Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC24A335A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353819AbiA3CoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:44:17 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:48826 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230484AbiA3CoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:44:06 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACHJsRY+_VhYiYuAA--.39477S2;
        Sun, 30 Jan 2022 10:43:36 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     justinkb@gmail.com
Cc:     frank-w@public-files.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
Date:   Sun, 30 Jan 2022 10:43:35 +0800
Message-Id: <20220130024335.114461-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHJsRY+_VhYiYuAA--.39477S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xtw48uFyfJF4DCry3urg_yoW8GF15pw
        4Ig3s3tw1qgFWkKwn8A3yrKFn3Zw1rJr15Jw1rGa40yr1UWFWkAF4jyFW3uFZ7Gw4kua43
        tFZ0qF4UCas8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfUO_MaUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:26:51PM +0800, Paul Mulders wrote:
> I guess this breaks all MT7622 SoCs since it'll prematurely exit
> init_clks (and subsequently init_scp) completely once devm_clk_get
> fails to get a reference to the mm clock producer (which happens to be
> the first one tried). This is because MT7623 has a GPU (so no mm
> clock) and MT7622 doesn't, and as a result the other clock producer
> pointers never get initialized (and other stuff in init_scp after
> returning from the error never happens).
>
> The patch seems fundamentally flawed, I guess it was either not tested
> at all, or only tested on a MT7623. The initialization functions seem
> designed with the idea that it's ok if some clocks aren't present, so
> stopping the initialization when one of them isn't present seems
> wrong. (For example, there is also a MT7622B variant of the MT7622
> which probably also lacks some clocks MT7622(A) does have).

I don't think the patch for init_clks() is flawed.
At most it is incompleted.
What it did is like fixing a potential error in the tool platform
providing service for the upper application, like what you said,
MT7623 and MT7622.
We should not keep the error in the platform because of the upper
application.
And it seems like it is MT7622 that is flawed.
The better way is to fix both the bug in init_clks() and its caller,
MT7622.

Sincerely thanks,
Jiang

