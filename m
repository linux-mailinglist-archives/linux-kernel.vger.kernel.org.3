Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C933C50CB3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiDWOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiDWOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:36:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBC111CAC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:33:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kltzc14TSz4xLb;
        Sun, 24 Apr 2022 00:33:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1650724381;
        bh=WoVkgo+1c7VtsmcEJ4bIoptWeHFiV0K5oskKMxsYsV0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lrXnP+fpdJguWUAQWN2X0b9+V8jQE/+m2rqG1BLz3rDML3ZSMi7xW+qv0wJWDSXCq
         Xhj6CLepoh2fU8F3p1VITdGldCUyOGWiBEBeNheRZW0W9QjOxwcWq4mV9h/yV1SVZz
         c+/YHpTiXpRZJaJVp4FdGBpALyrEopPLt/J7w84o5QJo70nWyfSErzCldxBL4DU/cg
         Ysg3aCv7AQe5GSGXpXeS1D3CfNjPzG6b6y6k7x385n0URcFGtZBxB4hqsyEVAm8QBB
         nexrFGD9EmNJ0R4hQoYb2z1zQeghYrrFviCWnTbYgZose6Tbequ2yQWHEPpnPRKNHc
         i4zq7Oddw7rgA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Remove useless null check before call
 of_node_put()
In-Reply-To: <c4613523-de98-b824-175a-89fd66931bd6@linux.ibm.com>
References: <1650509529-27525-1-git-send-email-baihaowen@meizu.com>
 <c4613523-de98-b824-175a-89fd66931bd6@linux.ibm.com>
Date:   Sun, 24 Apr 2022 00:32:57 +1000
Message-ID: <87levv98fa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 4/20/22 19:52, Haowen Bai wrote:
>> No need to add null check before call of_node_put(), since the
>> implementation of of_node_put() has done it.
>> 
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>  arch/powerpc/kernel/pci_dn.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>> index 61571ae23953..ba3bbc9bec2d 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -357,8 +357,8 @@ void pci_remove_device_node_info(struct device_node *dn)
>> 
>>  	/* Drop the parent pci_dn's ref to our backing dt node */
>>  	parent = of_get_parent(dn);
>> -	if (parent)
>> -		of_node_put(parent);
>> +
>> +	of_node_put(parent);
>
> This whole block of code looks useless, or suspect. Examining the rest of the
> code for this function this is the only place that parent is referenced. The
> of_get_parent() call returns the parent with its refcount incremented, and then
> we turn around and call of_node_put() which drops that reference we just took.
> The comment doesn't do what it says it does. If we really need to drop a
> previous reference to the parent device node this code block would need to call
> of_node_put() twice on parent to accomplish that.

Yeah good analysis.

It used to use pdn->parent, which didn't grab  an extra reference, see
commit 14db3d52d3a2 ("powerpc/eeh: Reduce use of pci_dn::node").

The old code was:

        if (pdn->parent)
                of_node_put(pdn->parent->node);

> A closer examination is required to determine if what the comment says we need
> to do is required. If it is then the code as it exists today is leaking that
> reference AFAICS.

Yeah. This function is only called from pnv_php.c, ie. powernv PCI
hotplug, which I think gets less testing than pseries hotplug. So
possibly we are leaking references and haven't noticed, or maybe the
comment is out of date.

cheers
