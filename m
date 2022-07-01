Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A9563945
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGASmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGASmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:42:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABFC3FBDA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 72B76CE34DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 18:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FB9C3411E;
        Fri,  1 Jul 2022 18:42:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jCx3Y+7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656700930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TL4JY8Ftp+z+objy2mMk9BabLXu7JrwLro/njsVh28s=;
        b=jCx3Y+7lKvG6rV/H0c74qzXO9LHPhknsJUEpLx0Ph7rAyYSDSHVTxu+sNwVgwmDnySvx49
        Ya2q04AivbmcjmNH+pc6IBSPWf5mADtlC7b8rJP9ZuZF9Jm4wEm0sAv7e6zhTYTxo7Fr1v
        9CvvWqKFufIrHp5k1UvL4evMJeQ+HAw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74e9fbb9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 1 Jul 2022 18:42:09 +0000 (UTC)
Date:   Fri, 1 Jul 2022 20:42:03 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] x86/setup: Allow passing RNG seeds via e820 setup
 table
Message-ID: <Yr8/+3qha3nCRLOD@zx2c4.com>
References: <20220630133106.35970-1-Jason@zx2c4.com>
 <20220701175808.188604-1-Jason@zx2c4.com>
 <05A1E6F8-432A-4D68-9CF8-C77A3FC68584@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05A1E6F8-432A-4D68-9CF8-C77A3FC68584@zytor.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jul 01, 2022 at 11:25:49AM -0700, H. Peter Anvin wrote:
> Please correct the incredibly confusing title of this patch.
> 
> The setup_data linked list has nothing to do with memory types (e820),
> except that memory types is one kind of data that can be passed on by
> this mechanism. This title makes it sound like you are passing random
> data in as a memory type, which could make some bizarre sense if it
> were, say, some kind of ring buffer preconfigured by the BIOS/VMM/boot
> loader to be continually overwritten with new random data.

Yea that is pretty confusing. Alright, I'll retitle that to something
like:

    x86/setup: Allow passing RNG seeds via setup data

Hopefully that matches more, considering the function that does the work
is called "parse_setup_data".

(I'll wait some more time before posting yet another v+1 with that
change, in case others have more feedback.)

Jason
