Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C915A7769
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHaHWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:22:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320F95699
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:22:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHbGq5FVgz4xG6;
        Wed, 31 Aug 2022 17:22:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661930552;
        bh=WKkkQRG6bf9R7KZ/zDCU6xhALT0ZrJhryQ3qstr4wgk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OXOVQQmoDSeeEcD48crP47K3BNbJY4Uviw8tglh6zCYmC+OOdxku5P55VfDPf8KFV
         pQxW1oevMEULJVLrLGqrJkLD4u8+Bh4I36NANKY1J0kve8uyeJztIqCyZY7J+gCUFJ
         HpTA3KYAKcucUhKq3zMRUW/k9eWwL9p24AZDN/z4alx67ITDE4zCPY4NZKe8KE82H3
         uaK3YwWDSv7mUHiPtMF6tBBXsRXykTPW8XZnyu3O5bpmGX0g2WiMEIkFn+lW5g9I6V
         5kIxQPXE4kOD1bJiSm4jg3C0c8sZNUfk0wSW1M9j8ZDXsbchhGE3T04xLkeopR4L4C
         Y/tNqlozJU5cQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mingo@redhat.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mbenes@suse.cz,
        chenzhongjin@huawei.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 02/16] powerpc: override __ALIGN() and __ALIGN_STR()
 macros
In-Reply-To: <CMJW5375AS4G.3VZ0XK6D3OZ9O@bobo>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-3-sv@linux.ibm.com>
 <CMJW5375AS4G.3VZ0XK6D3OZ9O@bobo>
Date:   Wed, 31 Aug 2022 17:22:25 +1000
Message-ID: <878rn4vpvy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Nicholas Piggin" <npiggin@gmail.com> writes:
> On Mon Aug 29, 2022 at 3:52 PM AEST, Sathvika Vasireddy wrote:
>> Powerpc instructions must be word-aligned. Currently,
>> there is an alignment of 16 bytes (by default), and it is
>> much more than what is required for powerpc (4 bytes).
>>
>> The default expansion of __ALIGN() macro is:
>> #define __ALIGN       .align 4,0x90
>>
>> Since Powerpc Linux does not require a 16 byte alignment,
>> override __ALIGN() and __ALIGN_STR() macros to use required
>> 4 byte alignment.
>
> Alignment can be desirable beyond the minimum requirement, for
> example 16 byte alignment for functions could be helpful for
> instruction fetch. So it should be explained why possible
> benefits of the larger alignment are not worth it.

Using ".align 2" matches what our existing _GLOBAL macro does. So this
change basically just propagates that existing alignment into this new
macro, which is used for similar purposes.

So if we want to increase the alignment we should do that explicitly,
and update _GLOBAL at the same time.

The change log should probably just say ~= "use the same alignment as
the existing _GLOBAL macro".

What's more important, but not mentioned in the change log, is that we
don't want to pad with 0x90, because repeated 0x90s are not a nop or
trap on powerpc.

cheers
