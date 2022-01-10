Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA7489D55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiAJQRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237212AbiAJQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641831422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YjTLY75U3Rr/IBjHhdFVsX4vnS2z8mb10E/ypAsx9o=;
        b=NKvrG1Ff/BReEbNZCSIxAwyvB4pMuBxFjEPcWornGzwdPqjkZbt0RQpICANewlujbWtkKf
        8c5wpr5AHOpznYuZnXhUiaf/J/X7noNp2zHSUxDf6rNVER/zQkJnbUxKNuVjuzWrtCfOJ5
        zqkL8D/k3OQswA5rh8rpc9zD5SRYF+Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-_va0i5i4OT6THJv7bWwAcQ-1; Mon, 10 Jan 2022 11:17:00 -0500
X-MC-Unique: _va0i5i4OT6THJv7bWwAcQ-1
Received: by mail-qt1-f199.google.com with SMTP id 4-20020ac85744000000b002b2f329efc2so11137623qtx.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+YjTLY75U3Rr/IBjHhdFVsX4vnS2z8mb10E/ypAsx9o=;
        b=ADbLsvEMEJtQ+NI8o4aQoM//u93UF2MgW2/fu+6m2c9/9Pxaqe/798y1E6PDrXS+OZ
         XqFI3tbZJNzu2YrMgSgtALrOulLl5PgXcjmStJH4PpuYcQz1BU7t/S6rHGCfYzmPo6yy
         KKsmjjZf02dd3u8Azk/x41N9SaRRzAL+uT860hkjcQ1DVVpQd7vtIE+1Hc1pwaW4fVWM
         1xs2ms/Rar7nPNJTmYH5swZ3v0hJLCnirYqiNicXdts8synUuFMSCJhG9rx+8rCB8M2A
         Spg8Gs4rlqYJ4sxl+RsX6P9avYf1YExkH0b+ScalqnAozpbw/F1ijAa34EIv9O1lame3
         yYmQ==
X-Gm-Message-State: AOAM531TbyotcdzfA/piHPEqWddpRr6zncZ6gRDNdYEfuX11Bj5xNUUD
        C2n4HEcUyXBdZ2+uqebHier9ZzKRW5XO66RkqlMXw5OcbINu62u0zJg8G9Z7w2B6K4Fum/eXv93
        rompmtIxsrBB/yZMy5DB2loD2
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr377042qta.620.1641831420240;
        Mon, 10 Jan 2022 08:17:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAUtzH3EEX9Ff3ydZLCMZTFVjkkVjbUCwm51dfml+s1g3fpFnx//1UUzWe5M/akiYa/jS9DA==
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr377024qta.620.1641831420013;
        Mon, 10 Jan 2022 08:17:00 -0800 (PST)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id v13sm3080842qtk.93.2022.01.10.08.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 08:16:59 -0800 (PST)
Subject: Re: [PATCH] livepatch: Avoid CPU hogging with cond_resched
To:     Song Liu <song@kernel.org>
Cc:     David Vernet <void@manifault.com>, live-patching@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, jpoimboe@redhat.com,
        pmladek@suse.com, jikos@kernel.org, mbenes@suse.cz
References: <20211229215646.830451-1-void@manifault.com>
 <1f1b9b01-cfab-8a84-f35f-c21172e5d64d@redhat.com>
 <CAPhsuW4Ua2hDs5WMtF0s_CQki-ZdYMvkU2s+Nc7Rvs=-D6WL=Q@mail.gmail.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <4df1f9a0-3b26-903b-fe63-af5e75ed98d4@redhat.com>
Date:   Mon, 10 Jan 2022 11:16:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4Ua2hDs5WMtF0s_CQki-ZdYMvkU2s+Nc7Rvs=-D6WL=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 11:46 AM, Song Liu wrote:
> On Fri, Jan 7, 2022 at 6:13 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>>
>> On 12/29/21 4:56 PM, David Vernet wrote:
>>> For example, under certain workloads, enabling a KLP patch with
>>> many objects or functions may cause ksoftirqd to be starved, and thus for
>>> interrupts to be backlogged and delayed.
>>
>> Just curious, approximately how many objects/functions does it take to
>> hit this condition?  While the livepatching kselftests are more about
>> API and kernel correctness, this sounds like an interesting test case
>> for some of the other (out of tree) test suites.
> 
> Not many patched functions. We only do small fixes at the moment. In the recent
> example, we hit the issue with ~10 patched functions. Another version
> with 2 to 3
> patched function seems fine.
> 
> Yes, I think this is an important test case.
> 

Thanks, Song.  If you can share any test setup details, I'll pass those
along to our internal QE group.  And once merged, we'll be adding this
one to the list of backports for our distro.

-- 
Joe

