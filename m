Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA22490917
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiAQM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:59:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbiAQM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642424360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WayZrn9OtdTNjvMSCi7bp9k17/9dsOPxH85ueokRnnw=;
        b=NQJ2Y7o4XNFVYR0CDNjJdsSTC2ZuRLLb0YoCck3pZ8pSehWvo19sBiAGlX1o2PntYPKLKW
        2ip2nI6SRXKX1i0U/iM9ZFcnAXIlaEfvizzPG2Mk7VdglQx3n4mMT6OtBFitkN24ZfKtcO
        zygl4buJvwp99jXuq9hDj4L14lvnssM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-irMQ5o6OP_eGBVYwuOodBw-1; Mon, 17 Jan 2022 07:59:19 -0500
X-MC-Unique: irMQ5o6OP_eGBVYwuOodBw-1
Received: by mail-wm1-f72.google.com with SMTP id o3-20020a05600c4fc300b0034aee9534bdso4288912wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WayZrn9OtdTNjvMSCi7bp9k17/9dsOPxH85ueokRnnw=;
        b=LDnPXv4dejxsUAteyDrT4hsKzyB5OVt8zAW+gp0mlj0FuNiPEHEoPsrAKcpIhpTk6G
         aJYeh3LGVDBSEcsIK5bUrdIAob2l8YYwt9jo06UuRiiewuEwPNdJHiqtFo8cz/5gc5ta
         mS9QAcwI7cJ+lAN13Xo42suv1Eu8ct15IXGR3XVldfeqrwq7SovEcWWXY89j4RokOFUq
         AQB0to+V7DRYEL2qpqFwvnKeLf3YG5ujamFsNxsHi5UMgGP+rX1PmpN4PkbtGIVOKw9S
         8fC+SIDnsr4k85HbbBxL2nJvD+kljstmDCxAMkZaxwWQUXeoYWsieiNDXrFKOxZfCcqt
         uiXw==
X-Gm-Message-State: AOAM531sUmovmWty8sFwfIRcHrVKdgS3AR73rJdITmdmLp85LtSviwIQ
        Mam/UMU6SOzUH9Ag5fDxa7X07H+SBah9qiWClgMzOgf2NfV7JdDHuWbKDFPksBi93UG1Ti5/Zld
        ldOhdtkVWYH/1oBw8hztG91AP
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr19500720wmh.146.1642424357966;
        Mon, 17 Jan 2022 04:59:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXcYEPTZMha9EiZGHnelJLl+0iXniwadqq9/vPUiP1EgB83J18s3TPNXXS+tLhcVqsuyyMJg==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr19499071wmh.146.1642424327807;
        Mon, 17 Jan 2022 04:58:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:dd00:68a1:1bd:6733:bde9? (p200300cbc705dd0068a101bd6733bde9.dip0.t-ipconnect.de. [2003:cb:c705:dd00:68a1:1bd:6733:bde9])
        by smtp.gmail.com with ESMTPSA id s22sm18046060wmc.1.2022.01.17.04.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 04:58:47 -0800 (PST)
Message-ID: <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
Date:   Mon, 17 Jan 2022 13:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
To:     "zhangliang (AG)" <zhangliang5@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.22 03:11, zhangliang (AG) wrote:
> Hi, thank you very much for your patient reply, and I completely agree with the viewpoint from you and Linus about COW and reuse_swap_page(). :)
> 

If you have some sparse cycles, it would be great if you could see if

https://github.com/davidhildenbrand/linux/tree/reuse_swap_page

works as expected as well for your setup.

-- 
Thanks,

David / dhildenb

