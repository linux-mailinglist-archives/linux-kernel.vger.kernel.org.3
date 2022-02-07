Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B024ACAB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiBGUsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbiBGUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:40:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D92C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05270B81157
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B2C340EE;
        Mon,  7 Feb 2022 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644266402;
        bh=rf8gPOUN5xstVP7dA1npNbWM8q6AFZtBXiHOYtQg9Cc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZmMoxaILZCQ1Z8+Rw+tECtxqVH+UqOhIRSjRZsplt0uiPd/zUNiEtdFt4AvBx8OAa
         6epZplVOVDsfv9ZR9+RP18fVCUjnqHkJtiG6s220QyxssWrhTw4ahDBoN6v4HkHjwY
         P63xwfuMhcFEYQZQpWATVU/wtKSkiQsuW8ErMmQ4=
Date:   Mon, 7 Feb 2022 12:40:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Outline copy_overflow()
Message-Id: <20220207124002.edd04bf6d2abac8a01e35144@linux-foundation.org>
In-Reply-To: <b9a31b025e729394e7081257870f0a0e73355a04.1644229010.git.christophe.leroy@csgroup.eu>
References: <b9a31b025e729394e7081257870f0a0e73355a04.1644229010.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Feb 2022 11:55:18 +0100 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> While building a small config with CONFIG_CC_OPTIMISE_FOR_SIZE,
> I ended up with more than 50 times the following function in vmlinux:
> 
> 	c00243bc <copy_overflow>:
> 	c00243bc:	94 21 ff f0 	stwu    r1,-16(r1)
> 	c00243c0:	7c 85 23 78 	mr      r5,r4
> 	c00243c4:	7c 64 1b 78 	mr      r4,r3
> 	c00243c8:	3c 60 c0 62 	lis     r3,-16286
> 	c00243cc:	7c 08 02 a6 	mflr    r0
> 	c00243d0:	38 63 5e e5 	addi    r3,r3,24293
> 	c00243d4:	90 01 00 14 	stw     r0,20(r1)
> 	c00243d8:	4b ff 82 45 	bl      c001c61c <__warn_printk>
> 	c00243dc:	0f e0 00 00 	twui    r0,0
> 	c00243e0:	80 01 00 14 	lwz     r0,20(r1)
> 	c00243e4:	38 21 00 10 	addi    r1,r1,16
> 	c00243e8:	7c 08 03 a6 	mtlr    r0
> 	c00243ec:	4e 80 00 20 	blr
> 
> That function being a non conditional warning on an error path,
> it is not worth inlining.
> 
> Outline it.

"uninline" is the conventional term for this.

> This reduces the size of vmlinux by almost 4kbytes.

Did you consider uninlining check_copy_size() instead?


