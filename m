Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF45257A3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiGSPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiGSPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 050542B601
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658245861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bytx0BWlQSL3lnY+bN1k2KN/IEh6mXjIzTlnoLU+R44=;
        b=VsxtqhLh9DuwjDV+pW4xcrtf3+qf5fzcAArojjp6rrjVHbQLMEL6H5kPaPcgtUscfe96Wy
        lxrO448/RKjzxFvDYO+IUTS3khYEZN9/cgSw2K/RcrHuySkYG5An0gvha6f72MEHxb18CF
        0tKpCRSSi8ovOiW9NEMeOFOwoYh58ug=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-P3vdoqYONUOSIPFbaJCB0A-1; Tue, 19 Jul 2022 11:50:59 -0400
X-MC-Unique: P3vdoqYONUOSIPFbaJCB0A-1
Received: by mail-wr1-f72.google.com with SMTP id i13-20020adfaacd000000b0021d96b4da5eso2708123wrc.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bytx0BWlQSL3lnY+bN1k2KN/IEh6mXjIzTlnoLU+R44=;
        b=eSsWy+RReFRzn0pc//aV+HGdgzt0nntoVKtsiFJVNa6/rB1X+IZ5FOTXBfxBiNgdsT
         6pSDEpkTxY6HkjYtmFLGnT8JNBpZnWZoDojVmQjXguFtJgpoEYaebAwgLziRb9omJ1E7
         o6/pTu3cSG+1cUxyc3kQP2Gr1T098WaaAdWFE//5n378qmwG8PmpBl+9baMI+iJUEPiU
         ajVe+JvOs6vfNisIT0yIls3BDDSEeo32me72/ebDVPQgGMGkFnpJlSqBaXCRlsJGEoZs
         lWCUdPnmFLBVGLPrvWWSy2aC8PXohHJ6cm+buy4+c3LWza0fgFUf9sAyuxDLyBarzPcr
         ejRg==
X-Gm-Message-State: AJIora/fkvBaT+FSqRivc1NtIObbRnockUoN18T1DGfl6k1tmkxrj8Yr
        URJiQ0i4Ryi9Kbn7EKN/YI7rWz6LahaY1sfWI0vKlBOCKEx6J1RbPfSo/Xn+RAkLykK6IfytPBw
        p+prw7fJAhB2IvY165yJQtPhj
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr26418130wri.626.1658245858375;
        Tue, 19 Jul 2022 08:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sMzKHTkKdvFnFWDj04IvUBb2vwu3An8lHFZRWwftgjMUJ3NyEdhiR7vhJwlkJKNTox9kKrug==
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr26418114wri.626.1658245858130;
        Tue, 19 Jul 2022 08:50:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:7807:c947:bc5a:1aea? (p200300cbc70906007807c947bc5a1aea.dip0.t-ipconnect.de. [2003:cb:c709:600:7807:c947:bc5a:1aea])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bca52000000b003a320e6f011sm4223270wml.1.2022.07.19.08.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:50:57 -0700 (PDT)
Message-ID: <ecada69b-03e4-4214-ed8e-f25ac74c19e1@redhat.com>
Date:   Tue, 19 Jul 2022 17:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com>
 <YtbPqrNtlr72+qx9@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
In-Reply-To: <YtbPqrNtlr72+qx9@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>> 2) I really dislike having to scatter section online checks all over the
>> place in page ext code. Once there is a difference between active vs.
>> stale page ext data things get a bit messy and error prone. This is
>> already ugly enough in our generic memmap handling code IMHO.
> 
> They should represent a free page in any case so even they are stall
> they shouldn't be really dangerous, right?
Good question. The use-after-free tells me that there could at least be
something accessing page_ext data after offlining right now. As long as
it's only unsynchronized read access, we should be fine.

> 
>> 3) Having on-demand allocations, such as KASAN or page ext from the
>> memory online notifier is at least currently cleaner, because we don't
>> have to handle each and every subsystem that hooks into that during the
>> core memory hotadd/remove phase, which primarily only setups the
>> vmemmap, direct map and memory block devices.
> 
> Cannot this hook into __add_pages which is the real implementation of
> the arch independent way to allocate vmemmap. Or at the sparsemem level
> because we do not (and very likely won't) support memory hotplug on
> any other memory model.

As __add_pages() is also called from mm/memremap.c where we don't want
that metadata, we'd have to special-case (would need a new parameter I
guess).

> 
>> Personally, I think what we have in this patch is quite nice and clean.
>> But I won't object if it can be similarly done in a clean way from
>> hot(un)plug code.
> 
> Well, if the scheme can be done without synchronize_rcu for each section
> which can backfire and if the scheme doesn't add too much complexity to
> achieve that then sure I won't object. I just do not get why page_ext
> should have a different allocation lifetime expectancy than a real page.
> Quite confusing if you ask me.

In contrast to memmap, people actually test for zero pointers here.

If you ask me the memmap access is ugly enough and I don't really enjoy
other metadata following that pattern of "stale and suddenly removed".
Here seems to be an easy way to do it in a clean way.

But yes, if the synchronize_rcu turns out problematic, we'd either have
to optimize or move the allcoation/free phase.

-- 
Thanks,

David / dhildenb

