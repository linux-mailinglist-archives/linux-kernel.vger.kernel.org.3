Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EA47A3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 03:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhLTC0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 21:26:09 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52856 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230024AbhLTC0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:26:08 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxXN2u6b9hZVUCAA--.9443S3;
        Mon, 20 Dec 2021 10:25:51 +0800 (CST)
Subject: Re: [PATCH 2/3] MIPS: signal: Return immediately if call fails
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
 <1639797789-3001-3-git-send-email-yangtiezhu@loongson.cn>
 <a04357b6-c762-ebbe-e983-ee2890b97be9@flygoat.com>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2fefb70a-8dd7-e237-a34b-fa3ab960c750@loongson.cn>
Date:   Mon, 20 Dec 2021 10:25:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <a04357b6-c762-ebbe-e983-ee2890b97be9@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxXN2u6b9hZVUCAA--.9443S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYT7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY
        jI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjfU5vtCUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/2021 10:08 PM, Jiaxun Yang wrote:
>
>
> 在 2021/12/18 3:23, Tiezhu Yang 写道:
>> When debug sigaltstack(), copy_siginfo_to_user() fails first in
>> setup_rt_frame() if the alternate signal stack is too small, so
>> it should return immediately if call fails, no need to call the
>> following functions.
>
> Hi Tiezhu,
>
> Thanks for your patch.
> If we are doing so I see no reason for keeping the err variable.
> Just
>
> if (copy_siginfo_to_user(&frame->rs_info, &ksig->info))
>     return -EFAULT;
>
> seems much more clear.

OK, thank you, I will send v2 later.

Thanks,
Tiezhu

>
> Thanks.
>
> - Jiaxun
>

