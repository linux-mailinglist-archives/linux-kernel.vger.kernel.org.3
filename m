Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0902259182E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiHMBjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMBjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:39:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D63AA4D9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=phg0WUAyk3WUBhOF3sWiVukqvICVg898M0ekOQM16+Q=; b=UzZbtQWBo723lvDkiWukbgH8aS
        5zW401ZUqbQlTBoPda3lbQIbvc0+Afu+vlxB/+n57waUD1bQBDKnY7CWYcBotLdaia7oLoVFwQsxX
        roFjHFMjRFjoKUoPyn1tnDZ8bZmGnK4iNu4c1xjOyoGkP/o3MSzX8lPTe4FB+xI+AIrOC6hnIMmCi
        10YMsV83bQanqEGXOt3eLE0S1e6UMKQ03YlxeWP+44C0809iKMCvNCXUjKPp27fgVAwYJWXrffsxl
        Yk0B9tKp1dAvegZwdKmfl8f0Y0Ko0KeT9KHTb24Hs+4m+MBzRv+wO7Yz1voiHPS+P50m/xmMdGWmh
        GEjktGFQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMg78-002rZP-8Q; Sat, 13 Aug 2022 01:38:58 +0000
Message-ID: <19555696-0bb3-f1f4-2c4d-4d3334f49212@infradead.org>
Date:   Fri, 12 Aug 2022 18:38:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Futex wait is not interrupted by signals if no timeout is
 provided
Content-Language: en-US
To:     Elijah Stone <elronnd-linux@elronnd.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <88516d10-bd53-9725-77f5-2772a6c784@elronnd.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <88516d10-bd53-9725-77f5-2772a6c784@elronnd.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add tglx and mingo]

On 8/12/22 18:14, Elijah Stone wrote:
> I've observed a strange behaviour of futexes that I believe to be a bug.  If a signal is delivered while a futex wait is in progress, the wait will be interrupted, but only if that wait had a timeout.  I expect it to be interrupted regardless of whether a timeout is provided.  The following runnable snippet demonstrates this:
> 
> void handler(int) { printf("SIGINT\n"); }
> int main() {
>     signal(SIGINT,handler);
>     int i=2;
>     printf("1\n");
>     syscall(SYS_futex, &i, FUTEX_WAIT, 2, &(struct timespec){.tv_sec=1000});
>     printf("2\n");
>     syscall(SYS_futex, &i, FUTEX_WAIT, 2, NULL);
>     printf("3\n");
> }
> 
> Pressing ^C once causes the first wait to terminate, and '2' to be printed. But repeatedly pressing it after that does not allow the program to make progress.

-- 
~Randy
