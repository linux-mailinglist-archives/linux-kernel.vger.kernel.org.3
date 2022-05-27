Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2097535976
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbiE0Gg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiE0Ggz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:36:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3867C166
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:36:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so3369366plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SuokLXZBT769hHza25K/JKzYPz4okNLCTIvug/IPsOQ=;
        b=w/Dtt17bexhMQfEO6bZdS8g76rcXfd1fCxzoZiPupXvbG6D1PCjYICkTcZoXMchs33
         XwQDdljexH8C7HWpuWkcd0aabZDZmfOs37/pSWL2o/Ma2ckuRkSN4tVLxE3BGT8SjmmZ
         /JHpZM9duuHTTZ/hqxVnt4BMWzchBWwfjfx1TZXxxn3s7cEvgS8S/aWR+aakyvAW8LGi
         BUHH0av/nN3KGi26NcaMjBdfZ6bmAo2QAxjbYMkVFw675/L/X8gkdLIELP7ZP9Myzhz7
         vQ/X1Rz9UX2xuO+xfYfn6QqA/MsysGxlfvyPQco5aSoo19c6jl7B2GTMxIfcgqs9i2YR
         xeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SuokLXZBT769hHza25K/JKzYPz4okNLCTIvug/IPsOQ=;
        b=se6oU5/Y/3KXFfwtaZSIHnP5MkqIjVNwlJLIbTjHlZcYizRrcomAbk0nrLq1lETqHA
         RewdVWtua3tDLwtnWk+nOZ09VEVRs+jRpjIJT9UA8UvIMTysz3bSB4fupzNQ700hhiqk
         nHd0hXUlUrrqBp3Qu66G6vLIhyb19bhzta6LMVRtnQ8XuSZnxvwYigdCZTyKb8mdSMfz
         7bxv4PJCH8eBH0EPNMzTGhkuumsOEpZqEWD2K+i5U8ZvXsji1/WFM5i0sMGs8OkjoKod
         OURNkz6Yfy+eGuOqR2z1w5HZHnyHX7ye5AC4+sKi6nsHzvv1sDd/yf0fWorf1jbJIh56
         FHSg==
X-Gm-Message-State: AOAM533KWrLHF/EXCeIwvXsNql8qZGWKwALn59Wq+NXdxq5RqnIY1GCe
        qaPPl4zdChiOzM3nl0Jx0DDjow==
X-Google-Smtp-Source: ABdhPJxOPiXIhe6VKd4CALjITeyKD3bUphXadgcUtVKUa901LvCRw8JDURlFy6QfYahvehfnBi6M3g==
X-Received: by 2002:a17:90a:bb17:b0:1e0:ab18:4491 with SMTP id u23-20020a17090abb1700b001e0ab184491mr6583871pjr.120.1653633413656;
        Thu, 26 May 2022 23:36:53 -0700 (PDT)
Received: from [10.255.70.20] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id m9-20020a63ed49000000b003f9d1c020cbsm2619464pgk.51.2022.05.26.23.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 23:36:52 -0700 (PDT)
Message-ID: <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
Date:   Fri, 27 May 2022 14:32:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Jue Wang <juew@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Paolo Bonzini <pbonzini@redhat.com>,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yo/I3oLkd9OU0ice@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 02:37, Peter Xu wrote:
> On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
>> The hypervisor _must_ emulate poisons identified in guest physical
>> address space (could be transported from the source VM), this is to
>> prevent silent data corruption in the guest. With a paravirtual
>> approach like this patch series, the hypervisor can clear some of the
>> poisoned HVAs knowing for certain that the guest OS has isolated the
>> poisoned page. I wonder how much value it provides to the guest if the
>> guest and workload are _not_ in a pressing need for the extra KB/MB
>> worth of memory.
> 
> I'm curious the same on how unpoisoning could help here.  The reasoning
> behind would be great material to be mentioned in the next cover letter.
> 
> Shouldn't we consider migrating serious workloads off the host already
> where there's a sign of more severe hardware issues, instead?
> 
> Thanks,
> 

I'm maintaining 1000,000+ virtual machines, from my experience:
UE is quite unusual and occurs randomly, and I did not hit UE storm case 
in the past years. The memory also has no obvious performance drop after 
hitting UE.

I hit several CE storm case, the performance memory drops a lot. But I 
can't find obvious relationship between UE and CE.

So from the point of my view, to fix the corrupted page for VM seems 
good enough. And yes, unpoisoning several pages does not help 
significantly, but it is still a chance to make the virtualization better.

-- 
zhenwei pi
