Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE59565234
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiGDKZ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jul 2022 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiGDKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E4EE32
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc22W5T6qz4xYN;
        Mon,  4 Jul 2022 20:23:31 +1000 (AEST)
Date:   Mon, 04 Jul 2022 20:23:29 +1000
From:   Michael Ellerman <michael@ellerman.id.au>
To:     =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
User-Agent: K-9 Mail for Android
In-Reply-To: <20220702094405.tp7eo4df7fjvn2ng@pali>
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali>
Message-ID: <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 July 2022 7:44:05 pm AEST, "Pali Rohár" <pali@kernel.org> wrote:
>On Tuesday 24 May 2022 11:39:39 Pali Rohár wrote:
>> gcc e500 compiler does not support -mcpu=powerpc option. When it is
>> specified then gcc throws compile error:
>> 
>>   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
>>   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
>> 
>> So do not set -mcpu=powerpc option when CONFIG_E500 is set. Correct option
>> -mcpu=8540 for CONFIG_E500 is set few lines below in that Makefile.
>> 
>> Signed-off-by: Pali Rohár <pali@kernel.org>
>> Cc: stable@vger.kernel.org
>
>Michael, do you have any objections about this patch?

I don't particularly like it :)

From the discussion with Segher, it sounds like this is a problem with a specific build of gcc that you're using, not a general problem with gcc built with e500 support.

Keying it off CONFIG_E500 means it will fix your problem, but not anyone else who has a different non-e500 compiler that also doesn't support -mcpu=powerpc (for whatever reason).

So I wonder if a better fix is to use cc-option when setting -mcpu=powerpc.

cheers
