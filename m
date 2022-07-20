Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F257BD75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiGTSL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGTSLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49A973B955
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658340683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J19kfipQoHZOcixHPVK0+w19cOCQBsO+YkDTCU5/NKk=;
        b=OzxMaWhcbjcGJDmujUyMIVmb2ygd2vA8+Py+Hmj0Scr4sZr3zTRrCemicea5h92qSoegHv
        02KC6RNL4vZofBAZkq4e4Yw/LlIQL9WaPacelW/Hzi6c+8N256xUUclQhPekYG9P4ywd4t
        c+8TA/Pj9GUjVfuKxMl+V0iDrAovQqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-14U4ABYkO6iMuLjGwObEPQ-1; Wed, 20 Jul 2022 14:11:22 -0400
X-MC-Unique: 14U4ABYkO6iMuLjGwObEPQ-1
Received: by mail-wm1-f71.google.com with SMTP id z20-20020a1c4c14000000b003a3020da654so1102211wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=J19kfipQoHZOcixHPVK0+w19cOCQBsO+YkDTCU5/NKk=;
        b=JHU/a065nLdnt/JbhNaJ8TWFwVhxMOPdMTtFUBWPjSnQvgYDGCHGefAwEw5yJxdH7G
         J2RsKtwdlvgcP8XfoOB9I/qPInqEFjQ837PgVDnSwWXBMD3qwnCSQB+IPMNRe/SKnYLJ
         A8lVpLWyRDpTxkn2WGBC/tKUR6isQv2QKWGsp8mx1DIBhe4iNoQ8T0kPhjt8v62Dye+U
         iadzPl7Qoz3zUNqm5HCEwUTqubV92TePnNwHGH7v3zaYGUu47o5SOxYlHlG5RXym4IRP
         XJE7yqGelgj97N7ej9By1AeGi1FXouW9jh0yr71BiiaQaZ7oA2mSSn1rLdVkJFuLF2Uz
         EbqQ==
X-Gm-Message-State: AJIora+LKtCQG6njzkHfHkRG8LiX8BBM7pWbmaLqqWoTSUkVRIFtIZ3w
        SnYHzQvUUHQSYGiqs99qmuyxGMdDkAMYzAvRfrijoxIblz4W+qjsjfmTG7uZ/jO9EdrDx8SYgZt
        Hr81heJ0punNQ9+vEtyA0g2wp
X-Received: by 2002:a5d:6b09:0:b0:21e:2eb6:2d03 with SMTP id v9-20020a5d6b09000000b0021e2eb62d03mr7709842wrw.684.1658340680823;
        Wed, 20 Jul 2022 11:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+RPY7OrL5ClIPGayUaOxuBGC/vAsMkUZh9pSms3wOqtib+ulGOoTI3DS06KcDyzfJNlbHLw==
X-Received: by 2002:a5d:6b09:0:b0:21e:2eb6:2d03 with SMTP id v9-20020a5d6b09000000b0021e2eb62d03mr7709823wrw.684.1658340680567;
        Wed, 20 Jul 2022 11:11:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id l14-20020adff48e000000b0021d7ad6b9fdsm16603709wro.57.2022.07.20.11.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:11:20 -0700 (PDT)
Message-ID: <f33b1f78-6556-bc93-ec3c-2632669b5c35@redhat.com>
Date:   Wed, 20 Jul 2022 20:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <09d84297-65d5-a3df-fdc0-a7168cdb0798@redhat.com>
 <99AFB0A0-B2F8-420A-8164-1705EC14B255@vmware.com>
 <97e82e31-2411-501e-d401-d175eb24642f@redhat.com>
 <18EDDBB1-255A-475F-812A-8CA947493EC8@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <18EDDBB1-255A-475F-812A-8CA947493EC8@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 20:09, Nadav Amit wrote:
> On Jul 20, 2022, at 11:00 AM, David Hildenbrand <david@redhat.com> wrote:
> 
>> My patch review skills have seen better days. I thought you'd be
>> removing the pte_write() check ... :( Tired eyes ...
>>
>>> Having said that, I do notice now that pte_mkdirty() should not be done
>>> only this condition is fulfilled. Instead we should just have
>>> something like:
>>>
>>> if (will_need) {
>>> ptent = pte_mkyoung(ptent);
>>> if (pte_write(ptent))
>>> ptent = pte_mkdirty(ptent);
>>> }
>>
>> As can_change_pte_writable() will fail if it stumbles over a !pte_dirty
>> page in current code ... so I assume you would have that code before the
>> actual pte_mkwrite() logic, correct?
> 
> No, I thought this should go after for 2 reasons:
> 
> 1. You want to allow the PTE to be made writable following the
> can_change_pte_writable().
> 
> 2. You do not want to set a non-writable PTE as dirty, especially since it
> might then be used to determine that the PTE can become writable. Doing so
> would circumvent cases in which set_page_dirty() needs to be called and
> break things down.

The I'm confused how can_change_pte_writable() would ever allow for
that. Best to show me the code :)

-- 
Thanks,

David / dhildenb

