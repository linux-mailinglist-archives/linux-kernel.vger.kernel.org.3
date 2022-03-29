Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20F24EB584
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiC2WE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiC2WEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:04:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35075175385;
        Tue, 29 Mar 2022 15:02:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 17so25256578ljw.8;
        Tue, 29 Mar 2022 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=GFh+hu29pLGd1yFJqG3TD5ib8w39W4JQGiYky9bmdEA=;
        b=Uul80CmlA5J9+LprVKWbEBNT+SmpX7fuHJuj2ZcNq5lQoGbXiK7l08X9mWZUnyQ9xj
         JGG6phzP2JIgAVM7Ck+/uPDofSFZS9DiEe+vTdfqlpktGqi5ac7BkNwpDuVFGoxB1j/L
         kiTUpYuWVv1NpO5CD/u3+wXPH+VkKXOxXU0EKfbfEIs9OIrNH5DeSfkqq0ywl+G16oUs
         EjjTffPfQWSLwPTUxIsp9apeOAkSzbzkNz+6u6mon973oumaMEcdCiHqApsz0Veblhsd
         qGyeBpLbqSDPrXgY78vgDjWeIZHmYGtPl54GxQn+x5B1VeLWM6M7Ui77iW8/TQ/Q1xEu
         yH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=GFh+hu29pLGd1yFJqG3TD5ib8w39W4JQGiYky9bmdEA=;
        b=QTZ6asthYglorU/F7oLyGZ9cRfytm8GAX3IHw7yrVzMqOxEqabJWlUB/DrqZf+55cB
         QG8oF3V0zdD4RPNqsqLxcL7kOGq5twy52DkMybyz3dS3/aSd3Wy/0ypqXR/LvYistaek
         YyNw84d+tTaGxVe1KlxwITGinYOXkLA8WZJobVD3Vio5vg/vRA92N9W0UTpcvHxerMqP
         ++JumkdHJzTrsdjghuFnxFq/SB+o3m4+5SWzGGDz0WuUFoFmax8D3BAqUPqR9he43bxi
         YK90bp+3DICwZpI/AhA0jSqVd/1RCuSXyjImnQlDGVm/mQAsHBESjJIPNlJeg/LbS3nt
         uhSQ==
X-Gm-Message-State: AOAM531QncgtY/96RR74Nej+3w5U9y7r1yjRLT2lbIJdS6ui1C/I5YCd
        HYF1CNxoE3cjS9lkKDP3nbo=
X-Google-Smtp-Source: ABdhPJwoHVOneGk1MKkV++hihnKGasRhaKJqXGRhP23iN10zifJJPhye88xL0pFF5DtY6cv59xPRXg==
X-Received: by 2002:a2e:b7c1:0:b0:249:7a91:bba1 with SMTP id p1-20020a2eb7c1000000b002497a91bba1mr4503477ljo.276.1648591358215;
        Tue, 29 Mar 2022 15:02:38 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.225])
        by smtp.gmail.com with ESMTPSA id i2-20020a196d02000000b004488dae6d45sm2114104lfc.52.2022.03.29.15.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 15:02:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------787Zf0iirh0AwihTJK1ygKXK"
Message-ID: <419a9bb8-cb68-8add-e7be-275a48b2126d@gmail.com>
Date:   Wed, 30 Mar 2022 01:02:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] general protection fault in dma_fence_array_first
Content-Language: en-US
To:     syzbot <syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com>,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, gustavo@padovan.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000008eedfe05db620952@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <0000000000008eedfe05db620952@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------787Zf0iirh0AwihTJK1ygKXK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/30/22 00:23, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8515d05bf6bc Add linux-next specific files for 20220328
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1694e21b700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=530c68bef4e2b8a8
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c943fe38e86d615cac2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1467313b700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121b7cb9700000
> 
> The issue was bisected to:
> 
> commit 519f490db07e1a539490612f376487f61e48e39c
> Author: Christian König <christian.koenig@amd.com>
> Date:   Fri Mar 11 09:32:26 2022 +0000
> 
>      dma-buf/sync-file: fix warning about fence containers
> 

There is ZERO_PTR dereference caused by passing 0 to krealloc_array(). 
Code should not try to reduce allocated memory area if index is equal to 0

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master




With regards,
Pavel Skripkin
--------------787Zf0iirh0AwihTJK1ygKXK
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9zeW5jX2ZpbGUuYyBiL2RyaXZlcnMvZG1h
LWJ1Zi9zeW5jX2ZpbGUuYwppbmRleCBiOGRlYTRlYzEyM2IuLjYwY2I0MjY2ZTc3ZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9kbWEtYnVmL3N5bmNfZmlsZS5jCisrKyBiL2RyaXZlcnMvZG1h
LWJ1Zi9zeW5jX2ZpbGUuYwpAQCAtMjY0LDcgKzI2NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lu
Y19maWxlICpzeW5jX2ZpbGVfbWVyZ2UoY29uc3QgY2hhciAqbmFtZSwgc3RydWN0IHN5bmNf
ZmlsZSAqYSwKIAlpZiAoaW5kZXggPT0gMCkKIAkJYWRkX2ZlbmNlKGZlbmNlcywgJmluZGV4
LCBkbWFfZmVuY2VfZ2V0X3N0dWIoKSk7CiAKLQlpZiAobnVtX2ZlbmNlcyA+IGluZGV4KSB7
CisJaWYgKGluZGV4ICYmIG51bV9mZW5jZXMgPiBpbmRleCkgewogCQlzdHJ1Y3QgZG1hX2Zl
bmNlICoqdG1wOwogCiAJCS8qIEtlZXAgZ29pbmcgZXZlbiB3aGVuIHJlZHVjaW5nIHRoZSBz
aXplIGZhaWxlZCAqLwo=

--------------787Zf0iirh0AwihTJK1ygKXK--
