Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5F5867C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiHAKoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiHAKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:44:36 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95CD88
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1659350669; bh=1EJPgP5q2q4V6iN2Gc8k3q+T6sP+TuI5mAZxt56oEQs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=v9H4tKDdubqQVOdqaUwRK8QP0jXaMIWtxKlvyIiTLreQbdA/IBUpyp9xVApCdYE31
         qnwe8Onyel1WcDO1/+4Z0XsEul2UA6IJTyRB4/XKeAd93kZdLHfvvUrLFMEZHsQ/z8
         l48EYuJEuTFwWCnGyEkFelCf7Y43U5Iq8m6M3BtM=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2590B60103;
        Mon,  1 Aug 2022 18:44:29 +0800 (CST)
Message-ID: <a9777679-ff44-daac-57bb-ea3c52c6907f@xen0n.name>
Date:   Mon, 1 Aug 2022 18:44:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:105.0)
 Gecko/20100101 Thunderbird/105.0a1
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
Content-Language: en-US
To:     Jinyang He <hejinyang@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Lulu Cheng <chenglulu@loongson.cn>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
 <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
 <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
 <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
 <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
 <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
 <7b1f9813-85fc-acfd-8e24-7e01469ded3a@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <7b1f9813-85fc-acfd-8e24-7e01469ded3a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/1 18:08, Jinyang He wrote:
> [snip]
> 
> Actually, I really hope kernel image is in the XKVRANGE, rather
> than being in XKPRANGE. So that we can limit kernel and modules
> be in 4GB range. I think it will make all work normally. :-(

Just my 2c. I'd prefer any scheme in which memfd_secret is possible. The 
current design makes it impossible to carve out memory regions from 
kernel's view, IIUC, which is of course something to improve...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

