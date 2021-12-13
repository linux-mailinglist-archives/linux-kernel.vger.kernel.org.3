Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3A472B82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhLMLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:34:24 -0500
Received: from www381.your-server.de ([78.46.137.84]:40310 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhLMLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=KFfrL7tchd3VQzoip5NprnryMqESCMxCPR4jMuHmN3Y=; b=PtJ5x9X5GFq5e39UsHWKoQ/s+D
        vMaEmN3GRDCeTlzSU5n8/j4hpu83k3oOfIC4DANGz/IRIPoseaDZ8W0TE8dGCHx3bjxBL4e0Y3tip
        S+gfNn9qzIbV2VCL7+jy44NBJFJQ47NDUOKXPONs3ZWFYeJOUiunaUtHa62X9vtaJiiRB9EoxhyjY
        n/MW8zOxCMYeCh86Xeks9/I/UHTFOG0rvp46N64bKJVTCE5l4GXP9kh+HE3/LwlRDZcY5IcRx7Ym8
        C4OaMH4VNhX1m+lK0M18aTD9aIAvps0gl4IrW4MgFN4X57MMJeG6WSAd9f7dYXmmWZEl2t57Lui6r
        XqxyYe+Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mwjb2-00031o-59; Mon, 13 Dec 2021 12:34:20 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mwjb1-000HZ2-VA; Mon, 13 Dec 2021 12:34:20 +0100
Subject: Re: [PATCH v2 0/2] Add ADXL367 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211207094337.59300-1-cosmin.tanislav@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fbf1bc12-5013-0b09-a6f4-a602f0afbe70@metafoo.de>
Date:   Mon, 13 Dec 2021 12:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211207094337.59300-1-cosmin.tanislav@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26385/Mon Dec 13 10:38:12 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 10:43 AM, Cosmin Tanislav wrote:
> I have one question that is not actually specific to this driver but would
> help me clear up some issues.
>
> I used mutex_lock and mutex_unlock when accessing anything in driver's
> state that could potentially be written by another process in parallel.
>
> I heard mixed opinions about this. Some people said that it is not
> necessary to lock everywhere because loads and stores for data with size
> smaller or equal than register size would be done in one single atomic
> instruction.
>
> On the other hand, I also heard that this is not true unless WRITE_ONCE
> and READ_ONCE is used.
>
> It felt weird using WRITE_ONCE and READ_ONCE in this driver, so I kept
> using mutexes.
>
> Could I get some opinions on this matter?

What you wrote sums it up very well. READ_ONCE/WRITE_ONCE are required 
for correctness when no lock is used. The compiler is allowed to do all 
sorts of optimizations that could break multi-threading, when 
READ_ONCE/WRITE_ONCE is not used. E.g.

if (x)
   foo->bar = 10;
else
   foo->bar = 20;

Could be implemented as

foo->bar = 20;
if (x)
   foo->bar = 10;

In the absence of multi-threading the result will be the same. But if 
another thread reads foo->bar just at the right time it will read the 
incorrect 20.

For simple things like `foo->bar = x;` it is unlikely that the compiler 
will do anything other than the single store. But it could and the code 
is not correct without the WRITE_ONCE.

Using a mutex is OK, since non of this is performance critical.
