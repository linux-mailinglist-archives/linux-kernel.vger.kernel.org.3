Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DB548571B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiAERMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbiAERMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:12:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B55C061245;
        Wed,  5 Jan 2022 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+nGTDSzdqfLc59semsZfycw3vy5N0uRxQd7QNz1AX40=; b=idqvKdZ9BNPkysHsgHIKYpBaNV
        jwgnB0HX31G0i2SBq/jMNx9BFbjzY8vegori0mTUC7obfAyNPvhHA3Ku3iIFnRpIkp7TkKYeUfqwG
        6fuVsjtWq/bXd2iUh1clnXk7OJbmxwy4ew0vmNwOAW1KaS5YF3zCTx7Vn4ZhlYWNv60g8IoKeg5W7
        rOp1KjKNQlqqCBihDQ5ojYLK81aPNmx6LomidmZpoARGtWluCBrRz0QsnmbAqBdIXeG8r32RNE2xw
        7CVPMGjOUNl9k4rImvYhisooJbPKM2vwj1fHero6kUfjPwKB1zNC0H8P7t2xkFYjluZkzypZZdLZ7
        kHysBy6g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n59qA-00EkDH-W9; Wed, 05 Jan 2022 17:12:46 +0000
Message-ID: <45492ddd-42f1-674f-af27-5e0a0aace8c9@infradead.org>
Date:   Wed, 5 Jan 2022 09:12:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: mdadm regression tests fail
Content-Language: en-US
To:     Bruce Dubbs <bruce.dubbs@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Cc:     "Douglas R. Reno" <renodr2002@gmail.com>,
        Pierre Labastie <pierre.labastie@neuf.fr>
References: <c4c17b11-16f4-ef70-5897-02f923907963@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c4c17b11-16f4-ef70-5897-02f923907963@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
[adding linux-raid mailing list]


On 1/4/22 10:55, Bruce Dubbs wrote:
> I am trying to document the mdadm-4.2 installation procedures for our book,
> https://www.linuxfromscratch.org/blfs/view/svn/postlfs/mdadm.html
> 
> For testing, I am doing a simple:
> 
>   make
>   sudo ./test --keep-going --logdir=test-logs --save-logs
> 
> But I get failures for about half the tests.
> 
> Digging in a bit I just ran:
> 
>  sudo ./test --tests=00raid0 --logdir=test-logs
> 
> This is the first test that fails.  With some hacking, it appears that the first portion of this test that fails is:
> 
>   mdadm -CR $md0 -e0.90 -l0 -n4 $dev0 $dev1 $dev2 $dev3
> 
> This resolves to
> 
>   mdadm -CR /dev/md0 -e0.90 -l0 -n4 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
> 
> There is not a lot of error output in the test, so I manually ran:
> 
>   dd if=/dev/zero of=/tmp/mdtest0 count=20000 bs=1K
>   losetup /dev/loop0 /tmp/mdtest0
> 
> For /dev/loop[0123]
> 
> Then I ran
> 
>   mdadm -CR /dev/md0 -e0.90 -l0 -n4 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
>   mdadm: 0.90 metadata does not support layouts for RAID0
> 
> My question is whether the regression tests in the tarball are valid for mdadm-4.2?
> 
>   -- Bruce Dubbs
>      linuxfromscratch.org
> 
> Note: The kernel is version 5.15.12.

-- 
~Randy
