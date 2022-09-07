Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B635B0A68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIGQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiIGQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:42:14 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030F75494;
        Wed,  7 Sep 2022 09:41:47 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D9AF5C2956;
        Wed,  7 Sep 2022 16:41:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 75A305C1F31;
        Wed,  7 Sep 2022 16:41:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662568903; a=rsa-sha256;
        cv=none;
        b=oOmI+mRHBWHBsdyMUw3/ZrDkz3Nk04DF2PuXfl8emYb4plHEWDRuJjepAFId5dtaqfe60k
        vl6f9n22T4C+wIdFYFOVoWlr3xkpDErSa1DrHt3nzDw9FLf8NpvqsleVl4S+/vUzQlYKbJ
        faBx3uy2NV+53IQ+xasQln4mWlQ4jYDxe/0jd7fa3j6TCCFZmuuEWy2M79jYsok3niZue1
        PGONYgP7CN6dC040dJj+agi9lG0Y6+8ns3T/fxtKqhcUWHYtBp0uRCZzkMH+/iFEGS0aGS
        gUXaUtqEuAtV408aeS6jUzgLSa7GvTycWNiDaxTxzsOcsIESKTHNzBXueTJDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662568903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2wCa/Jt/3D2I+rbeGjg1PPoBnNjJ68RfVRRwxhzeg9s=;
        b=SqoNYL95AcZJrikt4aFRLGw4mWLAXToI3JoJF25O2Ynd/nI0+v8GW3tdeUXEE1J+3Q3cgf
        /Z3xJoNmhPk+FhqbqEepeVeRWsL96+B6hbq+45kE9RuTqXTbm4IhY/aGCPNM+4fJwzjbDf
        ssreFhHF7sCoAmykkGcRR0fW6FV6PwL4SJF6C4AJucq+8D5OTuk3zQymX1W4EfnRuHZfHR
        yu9AuYTD2praR/4rmTOCPGP9mHwM1Hy1KFxiXfp3SWHPJlJw7OuAWjlYAoON1aqyh8fx01
        apEggOAGkUHDN9UqG0ykrO4IcqLATy68PcsNV2HjwIL04bktjUZ3dVdChQwxag==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-xnd69;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Fumbling: 7fe0e4a34c79e059_1662568903912_767146359
X-MC-Loop-Signature: 1662568903912:3198609064
X-MC-Ingress-Time: 1662568903912
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.39.217 (trex/6.7.1);
        Wed, 07 Sep 2022 16:41:43 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4MN7Lr5fPNzFW;
        Wed,  7 Sep 2022 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662568903;
        bh=2wCa/Jt/3D2I+rbeGjg1PPoBnNjJ68RfVRRwxhzeg9s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CxmwPOEIHGF6GhHFwaqiAV0i/CGO0vUy9SrwWioqRLNWsu7UDqUkf/t05zvlw4WId
         uzHh2WlTA6BLxr5RPUGj6m8BaW58oYsLTnhqe33Ik4Yx2AOvcSIMSY2lMGRTO3yR2e
         rp5uQcTQhhZc+VXsyx09X2vM2DTxLJd5aC9X5AiU/LaDs4qKtZMCcnERhFVo/20upA
         D2l5NQEfGVvd/SXUiDTyO5Bzkg+3/QGT/vEDYkAj5vwR3KlCiy+zQBJtASYndOEzkK
         OFNygZOz+42lYsGEg/VIifEr+LWZ0z3xm31lU5NgSa9Lc3/JIVLZ33bLwpaS9DATj6
         qYpGmT8WRwpKw==
Date:   Wed, 7 Sep 2022 09:22:45 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     dan.j.williams@intel.com, x86@kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220907162245.5ddexpmibjbanrho@offworld>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <YxjBSxtoav7PQVei@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YxjBSxtoav7PQVei@nazgul.tnic>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022, Borislav Petkov wrote:

>On Mon, Aug 29, 2022 at 02:29:18PM -0700, Davidlohr Bueso wrote:
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 1abd5438f126..18463cb704fb 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -330,6 +330,20 @@ void arch_invalidate_pmem(void *addr, size_t size)
>>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
>>  #endif
>>
>> +#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
>> +bool arch_has_flush_memregion(void)
>> +{
>> +	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
>
>This looks really weird. Why does this need to care about HV at all?

So the context here is:

e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")

>
>Does that nfit stuff even run in guests?

No, nor does cxl. This was mostly in general a precautionary check such
that the api is unavailable in VMs.

>
>> +EXPORT_SYMBOL(arch_has_flush_memregion);
>
>...
>
>> +EXPORT_SYMBOL(arch_flush_memregion);
>
>Why aren't those exports _GPL?

Fine by me.

Thanks,
Davidlohr
