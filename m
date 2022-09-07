Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C25B0BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIGRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIGRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:43:16 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578BB14DA;
        Wed,  7 Sep 2022 10:43:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B51C8224BB;
        Wed,  7 Sep 2022 17:43:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a211 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8974C2222A;
        Wed,  7 Sep 2022 17:43:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662572592; a=rsa-sha256;
        cv=none;
        b=I+iIZ6ZpY/FLMWmO/0YhUwNX+WRTLi1cwr2jvdm00Qw7F2HCOBDvLaTu0AfPSA6FLY6KC/
        0CYcZJ73VD8enIDhqevmtLIX4uI5W+2Khs9Vnx4NOxoUov21c+Wbk9kYKB2TMwcyZUK1Ul
        B+AJNFpBHqqFTVsJ0cWRsl8cdheyVi8eo12r6v4a35GSPPvvBnIpw9zCXG7bw7AOzcy+at
        l0RfCp9GXmsOrum69o2BsHOr+HZo8PGSxId8uYIuwJDZEVV/A+94vz6DNbcS6d3gmuRRrK
        ifsJn+LnNe/R3iubYnvdeLP7JS7D6BOmkC323vLj4e0ppzBoI/815UAzPM8n1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662572592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=fVAuUmQIdD5h7Yfh/vTIXCwzEOFCdi4pLkzBHSezQjs=;
        b=liAp8W1OAa5wRTmflRs8X08AIZLRuURqVf3g9yJrFHq69wYLMfXc68nksjMM+8t3vAO2MJ
        KoQnAMonBYw+o0NoCYyt1qed2axuTU+79QXdzNcGf2dWovVC/UKPSM16fRwsilttSOsAX5
        kU1EGwj+aajvr8V1qcvHyW4PggrTR+ZA5vjEb8gplwfv6mqyvkWaEJ7/tTGs1sRJ2SSOIl
        EzB3bmclrGWb36ECDirmkCYMzaKf/E/S6tK3VvXPQ5ahpD56Qmh3/Z339uyaapfbMU7RrE
        FuTaNOmHOQMpyu4UwInfd+Y8yebqmmBSeJE50YKq+2i5qvu00JBx+QXLDqkLJg==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-gn4mw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Arithmetic: 5e0a509a18e6db61_1662572592564_2644287583
X-MC-Loop-Signature: 1662572592564:2158350637
X-MC-Ingress-Time: 1662572592563
Received: from pdx1-sub0-mail-a211 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.155 (trex/6.7.1);
        Wed, 07 Sep 2022 17:43:12 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a211 (Postfix) with ESMTPSA id 4MN8jp1zm4z2h;
        Wed,  7 Sep 2022 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662572591;
        bh=fVAuUmQIdD5h7Yfh/vTIXCwzEOFCdi4pLkzBHSezQjs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JtLQnms5e9XP7+PQATTL273KCVj8b9RO14Gcw9LpBQ+ddmnUEWNGlmj9H9UGO49M6
         qhtENtbw/YP/44aC+YzW7GtMhIl/aGJc4s/O4gFHnWnWW+3V7ps7OEMYzk4xhnGNUa
         +VHnIZY3O9FLCiOGPl4NfnCruXN9YRQqSFahLwuZ4BHhIwwydtHQmztws7obtYUM3W
         YuYNnVWtoGv/gmlj1SPQNWxlH+441ppMkiTzk3IEodyh2eINWo+KhGsDdv4GW+uz9i
         HnuPxmOZdxS5yozITGiBUUZidsHPvvuBlej4pm3+nGcB3tBnzr97HPZXABMDWNIy1X
         RqrpMTFNkra/w==
Date:   Wed, 7 Sep 2022 10:24:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220907172414.74mh75svoi6kkom3@offworld>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <YxjBSxtoav7PQVei@nazgul.tnic>
 <20220907162245.5ddexpmibjbanrho@offworld>
 <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
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

On Wed, 07 Sep 2022, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> On Wed, 07 Sep 2022, Borislav Petkov wrote:
>>
>> >On Mon, Aug 29, 2022 at 02:29:18PM -0700, Davidlohr Bueso wrote:
>> >> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> >> index 1abd5438f126..18463cb704fb 100644
>> >> --- a/arch/x86/mm/pat/set_memory.c
>> >> +++ b/arch/x86/mm/pat/set_memory.c
>> >> @@ -330,6 +330,20 @@ void arch_invalidate_pmem(void *addr, size_t size)
>> >>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
>> >>  #endif
>> >>
>> >> +#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
>> >> +bool arch_has_flush_memregion(void)
>> >> +{
>> >> +	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
>> >
>> >This looks really weird. Why does this need to care about HV at all?
>>
>> So the context here is:
>>
>> e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")
>>
>> >
>> >Does that nfit stuff even run in guests?
>>
>> No, nor does cxl. This was mostly in general a precautionary check such
>> that the api is unavailable in VMs.
>
>To be clear nfit stuff and CXL does run in guests, but they do not
>support secure-erase in a guest.

Yes, I meant the feats this api enables.

>However, the QEMU CXL enabling is building the ability to do *guest
>physical* address space management, but in that case the driver can be
>paravirtualized to realize that it is not managing host-physical address
>space and does not need to flush caches. That will need some indicator
>to differentiate virtual CXL memory expanders from assigned devices. Is
>there such a thing as a PCIe-virtio extended capability to differentiate
>physical vs emulated devices?

In any case such check would be specific to each user (cxl in this case),
and outside the scope of _this_ particular api. Here we just really want to
avoid the broken TDX guest bits.

Thanks,
Davidlohr
