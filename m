Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA26E48D050
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiAMB47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:56:59 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:34760 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230472AbiAMB4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:56:50 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAD3_ye4ht9hf0sdBg--.22540S2;
        Thu, 13 Jan 2022 09:56:08 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
Date:   Thu, 13 Jan 2022 09:56:07 +0800
Message-Id: <20220113015607.1124916-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAD3_ye4ht9hf0sdBg--.22540S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry8GF15uF1UtF17WFWfZrb_yoWfXrg_Ww
        4FyF17Cw4UW3ZrJF1DtrnxZr98KF40qrZFyrn8GanxW3s3CFyrAr93u3WfZ34kCrZa9342
        gr4jvF4Iqr13tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbLiSPUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:20:34PM +0800, Mark Brown wrote:
>> The devm_regmap_init_mmio() may return error pointer under certain
>> circumstances, for example the possible failure of the kzalloc() in
>> regmap_mmio_gen_context(), which is called by devm_regmap_init_mmio().
>
> This doesn't apply against current code, please check and resend.

I checked linux-5.16, and don't think what I said is not against the
latest code.
The devm_regmap_init_mmio() is defined as devm_regmap_init_mmio_clk()
in `include/linux/regmap.h`.
And in the same file, the devm_regmap_init_mmio_clk() is defined as
__devm_regmap_init_mmio_clk().
Then, __devm_regmap_init_mmio_clk() -> regmap_mmio_gen_context() ->
kzalloc().
So I have no idea what's wrong.
Maybe I didn't write the commit message clear.
Please give me more detail.

Sincerely thanks,
Jiang

