Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B94AF4DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiBIPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiBIPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:13:12 -0500
Received: from forward104o.mail.yandex.net (unknown [IPv6:2a02:6b8:0:1a2d::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF690C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:13:13 -0800 (PST)
Received: from myt6-2f925e734dc9.qloud-c.yandex.net (myt6-2f925e734dc9.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2626:0:640:2f92:5e73])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id C108E65D4A4B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:13:09 +0300 (MSK)
Received: from myt6-9bdf92ffd111.qloud-c.yandex.net (myt6-9bdf92ffd111.qloud-c.yandex.net [2a02:6b8:c12:468a:0:640:9bdf:92ff])
        by myt6-2f925e734dc9.qloud-c.yandex.net (mxback/Yandex) with ESMTP id UiLSGg5SFX-D9cuigSq;
        Wed, 09 Feb 2022 18:13:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1644419589;
        bh=BBn3j1VmbuQuHfwDHMUb+1SF5zRq0gAjZvezkNqz10o=;
        h=From:Subject:Date:Message-ID:To;
        b=CgSSKWno2kpoBnmjdQ5KSAuXtimAD4WrAX3sr1k42vv+irw1h2CRDd6q7jweZhW6b
         m6aC/A2DveNnWaQbWELG3kxtElA9BWCDe7jz0nV1TPM3xjRm9Hth+C2VjUFjLE45nf
         w6gcvZmvCGcQHsSCpWCT/h30GWOmXkb2802xjGCU=
Authentication-Results: myt6-2f925e734dc9.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-9bdf92ffd111.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id jLkkRH39d4-D9I4q6Yh;
        Wed, 09 Feb 2022 18:13:09 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <96405f85-4a09-c1a8-4bb2-82420e8aacdc@yandex.ru>
Date:   Wed, 9 Feb 2022 18:13:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linux kernel <linux-kernel@vger.kernel.org>
From:   stsp <stsp2@yandex.ru>
Subject: Q: is spin_lock() good outside of irq handler?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel developers!

Just a quick question.
Kernel doc says this:
https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
---

IFF you know that the spinlocks are
never used in interrupt handlers, you can use the non-irq versions:

     spin_lock(&lock);
     ...
     spin_unlock(&lock);

(and the equivalent read-write versions too, of course). The spinlock will
guarantee the same kind of exclusive access, and it will be much faster.

---

But in this case the interrupt is possible
inside the locked section, which can make
that section much longer than expected,
and will make other CPU cores to spin longer
while waiting for that lock.

So my question is: is spin_lock() actually
preferred to spin_lock_irq() when it is known
that the inthandler doesn't get the same lock?
Or maybe I should still use spin_lock_irq()
just to make sure my critical section doesn't
get an interrupt, causing other cores to spin
longer?
