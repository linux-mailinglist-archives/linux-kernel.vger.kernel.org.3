Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A233858399E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiG1HjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiG1Hi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF46051F;
        Thu, 28 Jul 2022 00:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 302FA61B4B;
        Thu, 28 Jul 2022 07:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D28C433C1;
        Thu, 28 Jul 2022 07:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658993936;
        bh=c3QBeh/2Ki6TN6fZ7YeaGDR9gZa1aakZ4qRtT1zv3CY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r3X5/tGMLFUQFdJRmuO4CUXXvM8df1TtQUTpzeEGx0Wnkc4brNH9kSQpyUUI5WL0n
         xdFUdvH/A3A8yNK0v4h111880bKXhqBgCBwo78DON+y7pNlrTf9d375qAhs+g7aTBT
         6fBlhNOmYAeBDMI5Nrh/jM82cDyGgtk2vFHIpWvgYhxUnnKw5mcMhyjIubKqkkidyI
         nJ1s/f64CCmBvze55JjQ5oieeLWxKd5tT6eWX+PLsYdyWnGvZtA3HknXnGNfjT0gE0
         YQovTvUwbWi7DztVLOI36odWYV7I+r+z2hDaBEhDzv9pF+b9v6pxoK0NVclefxeLj8
         pQp+X0HdlZgWQ==
Message-ID: <0ade7d41-0924-c089-f2da-6eb0e4d7efd8@kernel.org>
Date:   Thu, 28 Jul 2022 09:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org>
 <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
 <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
 <628a7302-1409-81f7-f72b-6b1645df9225@linaro.org>
 <CAODwPW-4i+idH8Nz6=EmNUXYWgWkoOHs3wOZ7BbrH5GwGDZ1Ww@mail.gmail.com>
 <1f3189ef-7d3f-27b3-a691-b9649090b650@linaro.org>
 <CAODwPW-GDkfyFaNSnEngpSfz8LSXRetu+xwp3QrFHP1rH1O06w@mail.gmail.com>
 <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
 <CAODwPW_tcAAqKE66B+RbvMn-=favT07i3EK3TnAspVsWTAeJ4Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAODwPW_tcAAqKE66B+RbvMn-=favT07i3EK3TnAspVsWTAeJ4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 02:22, Julius Werner wrote:
>>> By "use case" I mean our particular platform and firmware requirements
>>> -- or rather, the realities of building devices with widely
>>> multi-sourced LPDDR parts. One cannot efficiently build firmware that
>>> can pass an exact vendor-and-part-specific compatible string to Linux
>>> for this binding for every single LPDDR part used on such a platform.
>>
>> Why cannot? You want to pass them as numerical values which directly map
>> to vendor ID and some part, don't they?
> 
> Yes, but the current compatible string format also requires the exact
> part number, of which there are many thousands and it's impossible to
> build a list in advance. Even for vendors, hardcoding 255 strings in a
> tight firmware space would be an unnecessary burden. 

There are 25 for LPDDR2/3 and and 12 for LPDD4 (although many reserved
so it might grow to ~32). You will not have 255 of them, although I
actually don't insist on that - we can code manufacturer ID as well.

> There's also an
> update problem -- firmware may be built and signed and burned into ROM
> long before the assembly of the final mainboard. Board manufacturers
> want to be able to just drop-in replace a newly-sourced LPDDR part in
> their existing production line without having to worry if the existing
> (and possibly no longer changeable) firmware contains a string table
> entry for this part.
> 
> If you just want the compatible string to be unique, encoding the
> numbers like Doug suggested (e.g. jedec,lpddr3-ff-0100) would work for
> us.
> 
>> If we talk about standard, then DT purpose is not for autodetectable
>> pieces. These values are autodetectable, so such properties should not
>> be encoded in DT.
> 
> But the DT is the only interface that we have to pass information from
> firmware to kernel and userspace. Where else should these properties
> be encoded? They are auto-detectable, but not for the kernel itself
> (only for memory-training firmware running in SRAM). Maybe the usual
> rules of thumb don't apply here, because unlike all other peripheral
> controllers the memory controller is special in that the kernel cannot
> simply reinitialize it and get the same information from the original
> source again.

True, I thought these registers are aliased or also exposed as memory
controllers, but at least for one MC I don't see it so kernel cannot
read them.

Best regards,
Krzysztof
