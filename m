Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4448059C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhL1B6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:58:40 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:34232 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230367AbhL1B6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:58:39 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowABXXn4eb8ph_T8tBQ--.54598S2;
        Tue, 28 Dec 2021 09:57:50 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] staging: greybus: audio: Check null pointer
Date:   Tue, 28 Dec 2021 09:57:49 +0800
Message-Id: <20211228015749.1635832-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXXn4eb8ph_T8tBQ--.54598S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryDJryktr47uF1DAFy7ZFb_yoW8AF17pa
        yfK34Ik3Z8Xrn5AF18Jw1fJa4fuw4kJrW5GFn8W39rZrW3XF48GrZ3Kr4UWrW7Cr4rAa1q
        vFW0yw1rCr1qvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOMKZDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 11:54:10PM +0800, Alex Elder wrote:
> I think this is a good change, but I would like you to improve
> the description, and fix some different bugs introduced by your
> change.
>
> What you are specifically doing is checking for a null return
> from devm_kcalloc() in gb_generate_enum_strings(), and are
> returning the NULL pointer if that occurs.  That means you
> need to update all the callers of gb_generate_enum_strings()
> to also handle a possible null return value.
>
> The fix does a good thing, and your description is correct
> about what you are fixing.  But it should supply more
> complete context for the change.

Thanks for your advice, I will correct my description in next version.
But I still have some question about the devm_kzalloc().

> You can't simply return here.  If you look a bit above this,
> where the call to allocate a control structure is done, you
> see that a NULL return there jumps to the "error" label, so
> any already allocated and initialized control widgets get
> cleaned up before returning.

Actually, I have already thought of whether it needs to free after the devm_kzalloc().
As we can find in the gbaudio_tplg_create_widget(), the widget_kctls is allocated by devm_kzalloc(), but isn't released when gbaudio_tplg_create_wcontrol() fails and goto error.
And I check of the comment of the devm_kmalloc() in `drivers/base/devres.c`, because devm_kzalloc() returns devm_kmalloc().
And it says that "Memory allocated with this function is automatically freed on driver detach."
So there is no need to free the memory manually.
Is that right?
And I am sorry again because of the lack of the above explanation in my commit message.
I will also add to my new commit.

Thanks,
Jiang

