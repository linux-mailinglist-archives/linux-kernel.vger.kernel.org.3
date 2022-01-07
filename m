Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C993486FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiAGBmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:42:32 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:42430 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229538AbiAGBmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:42:31 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABHTVlwmtdhQ588BQ--.58935S2;
        Fri, 07 Jan 2022 09:42:09 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] tty/serial: Check for null pointer after calling devm_ioremap
Date:   Fri,  7 Jan 2022 09:42:07 +0800
Message-Id: <20220107014207.2761644-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTVlwmtdhQ588BQ--.58935S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4rGF48tw4rXryrtr4UCFg_yoWkZrX_WF
        9YgFs5A3yjganxXa1SywnavF12q39xur1fXrWxCF1IqryfJa15G34kWr9xZw47GayYvrnx
        urWDAa12qr1j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5kucDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 11:01:20PM +0800, Greg KH wrote:
>> As the possible failure of the allocation, the devm_ioremap() may return
>> NULL pointer.
>
> I do not understand this sentence.

Well, since the devm_ioremap() calls devres_alloc() to allocate memory,
it may fail because of the lack of memory and return NULL pointer.

>> And the 'port->membase' will be directly used in mlb_usio_startup().
>
> This does not make sense either.

I notice that in mlb_usio_startup() 'port->membase' is used in
'escr = readb(port->membase + MLB_USIO_REG_ESCR);'
without checking whether it is NULL before, that is to say, it is directly used.
Therefore, it may cause the dereference of the NULL pointer.

>> Therefore, in order to avoid the dereference of the NULL pointer, it
>> should be better to add the sanity check.
>
> What do you mean by "sanity check"?

Since I believe that after all the allocation we need to check whether it
succeed.
So the "sanity check" means the check that lost and we need to make up to
maintain the integrity.

Moreover, I am glad for your reply.
And I will refine my commit message in next version to make it more clear.

Sincerely thanks,
Jiang

