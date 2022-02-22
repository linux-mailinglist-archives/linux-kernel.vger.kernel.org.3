Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A284C0269
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiBVTv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiBVTv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C250C12D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645559459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hs65sHGE+MAg8ru2wq4oQPdOBMOVsHF1Qt4G5niT3/0=;
        b=LvqwFclonVEV6neKkaMZNx9I7ZlGqyxy9nKutosQkVLp5H/AuZmlvF7iO6WXWGqFresVOk
        dGENZu004NBIT/dPlcUJ4bUKaTR8c3r/2ConjE4CLvd87v4VD/+hoM8CqEVZLeaVL97cft
        HCnI49xBB58oYbo/Tug9bDNv885Z6KQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-Lsyp4OtYPmKBJbB4HfBF-g-1; Tue, 22 Feb 2022 14:50:58 -0500
X-MC-Unique: Lsyp4OtYPmKBJbB4HfBF-g-1
Received: by mail-wm1-f69.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1068320wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Hs65sHGE+MAg8ru2wq4oQPdOBMOVsHF1Qt4G5niT3/0=;
        b=eOmJ/RbTVY8IEwleh28xwu7lo3u3SccIZVB675QMSMWfzJmscdFVAoqsB0NYBE5N8U
         oq+JSE7SveLnlYihZMGNKfISmc94Xt6O+p88PNaGuNFQzDUkLg8xLIlxMPZu/f3zDEAU
         2AO6LVuxS7lztnQVrhTxlKQa3Y1hQ9cEtEXc6irhvmVMAWTE/nAlbq7k0ZpSFA3aICIY
         ZtYjh08gDtk7trkfn8/T7xI7qY2bYK838/LeLeZLa9fN4/Day/vKyxf1JPGOzfqTSqmL
         JHzY2t16TjE3vMtVwmpxDiIFLC+P+cjzn+dMYDdHn3OfQP4WzMwm9Nvny7PvWIEhI5MZ
         RlXw==
X-Gm-Message-State: AOAM530w/O1F4DUUx+8VEeizJFlAgRd17jD+GezpsYxL0pNpAnGsGjGW
        uEkqLWQObetZOMBNf6q9urHyzi1u5wD7WOZ3UW0I2I3QD2NrbMCxnmOYuzngzWBRGzdYLLzEBux
        D+2hMFLy8DZ2KzW3WzJr0QUSP
X-Received: by 2002:adf:e10a:0:b0:1e3:3188:79c7 with SMTP id t10-20020adfe10a000000b001e3318879c7mr20737612wrz.329.1645559457112;
        Tue, 22 Feb 2022 11:50:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7tphXEaOO1Fx4rA4sA8xDWi0f5QH4NP76Lls9shdn0Jr3YsOCHeYZIE82dpFv7tWJ4EMI6A==
X-Received: by 2002:adf:e10a:0:b0:1e3:3188:79c7 with SMTP id t10-20020adfe10a000000b001e3318879c7mr20737594wrz.329.1645559456824;
        Tue, 22 Feb 2022 11:50:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:7d00:477e:35d5:928f:9b7f? (p200300cbc7067d00477e35d5928f9b7f.dip0.t-ipconnect.de. [2003:cb:c706:7d00:477e:35d5:928f:9b7f])
        by smtp.gmail.com with ESMTPSA id 3sm54196254wrz.86.2022.02.22.11.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 11:50:56 -0800 (PST)
Message-ID: <39e919dd-f73c-6698-dd4c-e42c5cbe1494@redhat.com>
Date:   Tue, 22 Feb 2022 20:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] drivers/base/memory: clarify adding and removing of
 memory blocks
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
References: <20220221154531.11382-1-david@redhat.com>
 <YhR5coy7OGyjwQtx@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YhR5coy7OGyjwQtx@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.22 06:49, Oscar Salvador wrote:
> On Mon, Feb 21, 2022 at 04:45:31PM +0100, David Hildenbrand wrote:
>> Let's make it clearer at which places we actually add and remove memory
>> blocks -- streamlining the terminology -- and highlight which memory
>> block start out online and which start out as offline.
>>
>> * rename add_memory_block -> add_boot_memory_block
>> * rename init_memory_block -> add_memory_block
>> * rename unregister_memory -> remove_memory_block
>> * rename register_memory -> __add_memory_block
>> * add add_hotplug_memory_block
>> * mark add_boot_memory_block with __init (suggested by Oscar)
>>
>> __add_memory_block() is  a pure helper for add_memory_block(), remove
>> the somewhat obvious comment.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Thanks for doing this, it makes the code much more clear.
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
>> ---
>>
>> Based on v5.17-rc5 and:
>> 	[PATCH v2 0/2] drivers/base/memory: determine and store zone for
>> 	single-zone memory blocks [1]
> 
> Maybe just my thing, but I also had to pull in [1] in order to apply
> this error-free. 
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20220128144540.153902-1-david@redhat.com/

Ah, yes, I forgot to mention that -- also already in -mm and -next.

Thanks!

-- 
Thanks,

David / dhildenb

