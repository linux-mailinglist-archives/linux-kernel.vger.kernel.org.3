Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63B4CAB8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbiCBR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiCBR1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:27:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0D50CA337
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646242010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JShSuOVLOzs3H1G/w8tPv6MflNWdaL6JxcHTBNKQ3o=;
        b=f7v05PQHwTOQE2PRjKCL5kMQiUGwV/3TeavOqC4nsGtr9VCpPZMsUp2a+ieLxyMjvFLN19
        PZrMvriFnB600kWhkwwd3n/VMTtKdBZQ9g7Wl8xdvmodLkHj5kwTPKWZUaCkaMXe2LcZ8+
        Q3izfar2rJVQWoyLBCMyXkSoKzJ2ywI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-_dBH7qtPN36Z2-9F6Oesjw-1; Wed, 02 Mar 2022 12:26:48 -0500
X-MC-Unique: _dBH7qtPN36Z2-9F6Oesjw-1
Received: by mail-il1-f200.google.com with SMTP id m17-20020a923f11000000b002c10e8f4c44so1725484ila.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0JShSuOVLOzs3H1G/w8tPv6MflNWdaL6JxcHTBNKQ3o=;
        b=6hPCq88PY7zvnBBhTz9BGned8j3/xoOPG9iMbZXf8Kmr58J23vxLWiiGXCizfcSQOQ
         SQ1tXZffdcjgI+EOay1OWl6yX50HAXDTssnppSLY8RptByQl5+nMy8tQVXGNFb+zIm28
         p4WRiwxu7ZTzRgEdy3I633yheL3vG7qcaB/thAcvLuBtmDIuIgfimLxeCUl+SO0DTzlB
         ubcnYhXa191jrjbRfVMXVmMpt9jozWNx8uepDnbOJHYEjBycPttXw3qkviBFr2PwdKbK
         TbVO6L9mDBFkCpQOhYzq8l7NkyC4fzEv7BnLtX0M2nMRxK3CTDSPwaXtVVeAea78wLB0
         3viw==
X-Gm-Message-State: AOAM530MUuNTTCbeElF0Br54yyaInbCOfmZmGi7A5uQ29n/YM4COFdnj
        zkY7k5FbA5846+UTTJRRnoNd3sm5c2LJqTRlnVuhclXtxXnjJVEXxFqLwOZlcf5Js++mqKyEfrR
        SD9xQPjEKfSBIivMUCd6wIWct
X-Received: by 2002:a05:6e02:1a06:b0:2c2:20c8:c016 with SMTP id s6-20020a056e021a0600b002c220c8c016mr27470761ild.143.1646242008005;
        Wed, 02 Mar 2022 09:26:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzL8xcxepFTjy/r3mc6Yk5JN69xs++O5rrSs71VHh3GfhTigqI2aHu4Hez7d8OX8UoAnpiSrg==
X-Received: by 2002:a05:6e02:1a06:b0:2c2:20c8:c016 with SMTP id s6-20020a056e021a0600b002c220c8c016mr27470748ild.143.1646242007786;
        Wed, 02 Mar 2022 09:26:47 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0::11d7? ([2601:280:4400:a2e0::11d7])
        by smtp.gmail.com with ESMTPSA id p2-20020a92d682000000b002c291ae0e1bsm9853732iln.23.2022.03.02.09.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 09:26:47 -0800 (PST)
Message-ID: <7f1ba14f-34e8-5f05-53b7-c12913693df8@redhat.com>
Date:   Wed, 2 Mar 2022 12:26:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved robust
 futex
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jsavitz@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
 <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
 <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
 <118fc685-c68d-614f-006a-7d5487302122@redhat.com>
 <Yh9+O/xqNLnV1jmA@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Yh9+O/xqNLnV1jmA@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/22 09:24, Michal Hocko wrote:
> Sorry, this has slipped through cracks.
> 
> On Mon 14-02-22 15:39:31, Nico Pache wrote:
> [...]
>> We've recently been discussing the following if statement in __oom_reap_task_mm:
>> 	if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED))
>>
>> Given the comment above it, and some of the upstream discussion the original
>> RFC, we are struggling to see why this should be a `||` and not an `&&`. If we
>> only want to reap anon memory and reaping shared memory can be dangerous is this
>> statement incorrect?
>>
>> We have a patch queued up to make this change, but wanted to get your opinion on
>> why this was originally designed this way in case we are missing something.
> 
> I do not really see why this would be wrong. Private file backed
> mappings can contain a reapable memory as well. I do not see how this
> would solve the futex issue.
We were basing our discussion around the following comment:
/*
 * Only anonymous pages have a good chance to be dropped
 * without additional steps which we cannot afford as we
 * are OOM already.
 *
 * We do not even care about fs backed pages because all
 * which are reclaimable have already been reclaimed and
 * we do not want to block exit_mmap by keeping mm ref
 * count elevated without a good reason.
 */

So changing to an && would align the functionality with this comment by ignoring
fs backed pages, and additionally it prevents shared mappings from being reaped.
We have tested this change and found we can no longer reproduce the issue. In
our case we allocate the mutex on a MAP_SHARED|MAP_ANONYMOUS mmap so the if-
statement in question would no longer return true after the && change.

If it is the case that private fs backed pages matter perhaps we want something
like this:
	if ((vma_is_anonymous(vma) && !(vma->vm_flags & VM_SHARED))
	||(!vma_is_anonymous(vma) && !(vma->vm_flags & VM_SHARED)))

or more simply:
	if(!(vma->vm_flags & VM_SHARED))

to exclude all VM_SHARED mappings.

-- Nico

