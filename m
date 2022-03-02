Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A14CAA3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiCBQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiCBQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:32:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7ABCC52F;
        Wed,  2 Mar 2022 08:31:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36EA21F383;
        Wed,  2 Mar 2022 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646238714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys3yoRdu+W55dGxYFlu3KoIzoE0Kz5MUvLUMJ8H1DZg=;
        b=MRjk++jPxoC3SRj+V6OA/DZh8e4I6kpJoLcGSJzYlX5/V85zt6ZpGUauWWWnjPj+6BSHpc
        Mkm2RfiVQtie8XbczTVbogPVgCYlj3noZEoVEMMAzri024QPNE82anDWnImrOwOVPJ/3c3
        cc0PmyvrVgvGym3w9h52I6/RLHSjHzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646238714;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys3yoRdu+W55dGxYFlu3KoIzoE0Kz5MUvLUMJ8H1DZg=;
        b=3pB/TAy48D7xr2gEVjVbRCj7zD9kvd15/ymFBNfSoLi9EEfmZ3SJZZkC0gGJHZF8zPfQmK
        mR3TJ7mYJEqWR5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F354613A83;
        Wed,  2 Mar 2022 16:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VRrROfmbH2L+MwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 16:31:53 +0000
Message-ID: <1cc1eb98-fe46-4563-16d3-ac00b630ecd3@suse.cz>
Date:   Wed, 2 Mar 2022 17:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/5] slab, documentation: add description of debugfs files
 for SLUB caches
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-6-vbabka@suse.cz>
 <Yhr01naZNIa2SxEd@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yhr01naZNIa2SxEd@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/22 04:49, Hyeonggon Yoo wrote:
> I think it's not traces of "currently free objects"
> because index bit of free objects are set in obj_map bitmap?

Hm right, thanks.

> It's weird but it's traces of allocated objects that have been freed at
> least once (or <not available>)
> 
> I think we can fix the code or doc?

For now I'll fix the doc. Not clear to me myself what's the best usecase for
free_traces file. For alloc_traces it's clearly debugging memory leaks.
Freeing traces are most useful when a bug is detected and they are dumped in
dmesg. The debugfs file might be just for a rough idea where freeing usually
happens.

> Please tell me if I'm missing something :)
> 
>> +    Information in the output:
>> +    Number of objects, freeing function, minimal/average/maximal jiffies since free,
>> +    pid range of the freeing processes, cpu mask of freeing cpus, and stack trace.
>> +
>> +    Example:::
>> +
>> +    51 acpi_ut_update_ref_count+0x6a6/0x782 age=236886/237027/237772 pid=1 cpus=1
>> +	kfree+0x2db/0x420
>> +	acpi_ut_update_ref_count+0x6a6/0x782
>> +	acpi_ut_update_object_reference+0x1ad/0x234
>> +	acpi_ut_remove_reference+0x7d/0x84
>> +	acpi_rs_get_prt_method_data+0x97/0xd6
>> +	acpi_get_irq_routing_table+0x82/0xc4
>> +	acpi_pci_irq_find_prt_entry+0x8e/0x2e0
>> +	acpi_pci_irq_lookup+0x3a/0x1e0
>> +	acpi_pci_irq_enable+0x77/0x240
>> +	pcibios_enable_device+0x39/0x40
>> +	do_pci_enable_device.part.0+0x5d/0xe0
>> +	pci_enable_device_flags+0xfc/0x120
>> +	pci_enable_device+0x13/0x20
>> +	virtio_pci_probe+0x9e/0x170
>> +	local_pci_probe+0x48/0x80
>> +	pci_device_probe+0x105/0x1c0
>> +
> 
> Everything else looks nice!
> 
>>  Christoph Lameter, May 30, 2007
>>  Sergey Senozhatsky, October 23, 2015
>> -- 
>> 2.35.1
>> 
>> 
> 

