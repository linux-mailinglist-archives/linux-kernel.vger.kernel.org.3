Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C60564531
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 07:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGCFGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 01:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiGCFGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:06:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC6CAE77
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 22:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tlFUtPOhJ5W9BydOfa04leYXSuZGr0guP0V0klL0TMk=; b=WlzNeLHYNboE2WwR6ZxWvEljC0
        ZHPCZ7TQS5YqkWeXUf1cY3PWulkczBfsR/WzOVj5ZiZ0UwnnrJKJICTJSwX6NT9Rkk7PLs0DO6Zz3
        d8GSMVxJoqqBsqQa0k4lk1s3N6wzlJ9OOXCudyxzxsMvaCUtcDQxs8QxnlmsCwcqDYEfCQJEuPDzJ
        hQaJVX/cEIrGou+ESankf6Y25Fr3RndIv+mOki4HulbJBBx7dyNVINMTRbz82OrKxgXyE4uEuiNH7
        GlP2MLUwV6jiAhSiVk67n5quxTcsipFT6TqiVy8H+Jq+md8W/d0Q46Tycy7BKeICXaecD5DDQdS+5
        Rhuuwngg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7rok-00Dp61-6B; Sun, 03 Jul 2022 05:06:46 +0000
Message-ID: <87b3e6f7-6272-aeb7-3588-b1527d2c66b6@infradead.org>
Date:   Sat, 2 Jul 2022 22:06:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] vgaarb: Add a module parm to use the first VGA device for
 boot
Content-Language: en-US
To:     Cal Peake <cp@absolutedigital.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
References: <5e3f182f-7b6e-5c7f-d9a9-7cd1417cc38d@absolutedigital.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5e3f182f-7b6e-5c7f-d9a9-7cd1417cc38d@absolutedigital.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/2/22 21:22, Cal Peake wrote:
> Hi,
> 
> I have a dual GPU system with the GPU in the first CPU PCIe slot for the 
> host and the GPU in the second CPU PCIe slot being passed through to a 
> virtual machine.
> 
> Currently, the VGA arbiter enumerates through all VGA devices in the order 
> that they appear in on the bus with the last one ultimately getting the 
> assignment for boot device.
> 
> This is a problem because once the VFIO PCI driver claims the second GPU, 
> all display output is lost -- just empty black screens on both cards.
> 
> Setting VGA_ARB_MAX_GPUS to 1 helps a little: the X server will initialize 
> on the first GPU like it should, but there's no VTs to be found (i.e. 
> Alt-F1/F2/etc), just more black screens.
> 
> Below is an attempt at a fix by creating a kernel param to have the VGA 
> arbiter use the first VGA device it finds for the boot device and then 
> subsequently ignore the rest for this task.

So that's
  vgaarb.use_first=1
right?

Seems worthy of some documentation in
Documentation/admin-guide/kernel-parameters.txt, please.

-- 
~Randy
