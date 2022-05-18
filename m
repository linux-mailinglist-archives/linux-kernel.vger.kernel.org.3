Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE152B886
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiERLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiERLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:19:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39EE1737E2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C0F1B81F02
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ACFC385A5;
        Wed, 18 May 2022 11:19:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BihFco4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652872740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZZ48KnZhImT4lBQVSMqwvSLcrQ295suUff1DgEP/tQ=;
        b=BihFco4jaqUO8BEP/IyPOuz2gj2pHqAsnvqNHFLsfLrsldPYOdxDOujn23SSe+D+eusreD
        roWFPY5rOu64m2T77uW+1SQVpq01WAVTc/I0Oc2c8Sm1b7KaChmfxbZAnDmcbWCMerPs7N
        EpapQQEIn26zL4Qr6aqYNT9qWBaChuo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1eeb3965 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 18 May 2022 11:18:59 +0000 (UTC)
Date:   Wed, 18 May 2022 13:18:58 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vadim Galitsin <vadim.galitsyn@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
Message-ID: <YoTWIowYVAqSSnQq@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <YnKeag3Ulg0NR58Q@zx2c4.com>
 <YoRFjTIzMYZu8Hq8@zx2c4.com>
 <YoTVIGiXUO2l8Czm@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoTVIGiXUO2l8Czm@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:14:40PM +0200, Jason A. Donenfeld wrote:
> I wrote a tiny reproducer that should be pretty reliable for testing
> this, attached below. I think this proves my working theory. Run this in
> a VirtualBox VM, and then move your mouse around or hit the keyboard, or
> do something that triggers the add_{input,disk}_randomness() path from a
> hardirq handler. On my laptop, for example, the trackpoint goes via
> hardirq, but the touchpad does not. As soon as I move the trackpoint
> around, the below program prints "XSAVE is borked!".

I should also add that the VM should have as many CPUs as the host, to
better the chances that the irq arrives on the same CPU that the guest
VM is running on.
