Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366648FDD8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiAPQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232084AbiAPQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642350417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nAKKNi5XgiAfNAzdu5aMlABcg+AfndDyAJ+czrA3dE=;
        b=Ezx1eoFtGtYGdIsj6hWy/hyi7trbhFjBkrokNq1GlTlRrxD29AUdJdnBJfRb2xWCimLyqP
        31g9BVzqayXWFgHXCyzUSd4X3+LJzoP++YhhyLz5Cre+kSs86AeFM5tn0MYDOrpddl2YMd
        N5yIYJiZsbjwFV2lRsV1qfrRfSGeRzE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-BVDJw2hwMPCCtzpzYhC-XA-1; Sun, 16 Jan 2022 11:26:56 -0500
X-MC-Unique: BVDJw2hwMPCCtzpzYhC-XA-1
Received: by mail-ot1-f70.google.com with SMTP id e73-20020a9d01cf000000b005935b064de2so3738236ote.22
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 08:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+nAKKNi5XgiAfNAzdu5aMlABcg+AfndDyAJ+czrA3dE=;
        b=zaTBKs7Nf/oOjV3VlqhnNEWQ6Uwd40jHP9d4I/iFTHnxPCOOXn/z4ZZMllLE7Upe9V
         UngGmQQaWy/VXagSoI7c4xif2TjLnXgNV3JkZZVbqUWl2ZmnpjOOMPfgsKCJ4cwTcy0L
         kjsaMQs634hAmXjR7HP0okOavUVQjv0a7efOH8d1DkAXJIWiPIPG/SnD285GHAG2O8Kl
         6fK2uKgJBZYg8k1/lTmB4n7EWSWzexXPTAIr76km0K33e35xp/Dfs6OKLqdRa72ySRe1
         zRCaaD8zOqo3meUKGTMOKAxSIC3cU1A3/FyWEuJs/UDlSLX4g6fJAw8l+znWtuKFPrMi
         Hc/Q==
X-Gm-Message-State: AOAM530+fvhr7mw6K4uGewSb6B60OtmC4KH3rqcwiMzPKg5ATSoFGP//
        bTvDWZH3wF6uWdHMaFD1eEp26RcPxKukrnjNgBBYS0fIPAhKGtUtGuk3iBxE1KgXVNlXYIVt3Zs
        caSvNoQkUrILctG6fKh3B8oa1NWZICQhZoggQsvoO4aifHai5mkurTiz+gcWP8/GrOyT7i7A=
X-Received: by 2002:a9d:7f0e:: with SMTP id j14mr1680722otq.305.1642350415651;
        Sun, 16 Jan 2022 08:26:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0frExX8193TcIlUQCAdXQ8x5SRFRqaag+E9CI8NFwDwphAdh5+uw2Ho1hbhxiMP7W3hFeWA==
X-Received: by 2002:a9d:7f0e:: with SMTP id j14mr1680711otq.305.1642350415410;
        Sun, 16 Jan 2022 08:26:55 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bo8sm4862700oib.22.2022.01.16.08.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 08:26:55 -0800 (PST)
Subject: Re: [PATCH] NFS: simplify check for freeing cn_resp
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220116144301.399581-1-trix@redhat.com>
 <9362b77845cecef630cd2cf98e3daf557318941b.camel@hammerspace.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1bfd05a9-5245-9094-b382-f01c8b35f761@redhat.com>
Date:   Sun, 16 Jan 2022 08:26:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9362b77845cecef630cd2cf98e3daf557318941b.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/22 7:47 AM, Trond Myklebust wrote:
> Hi Tom,
>
> On Sun, 2022-01-16 at 06:43 -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> nfs42_files_from_same_server() is called to check if freeing
>> cn_resp is required.  Instead of calling a function, check
>> the pointer.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   fs/nfs/nfs4file.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
>> index e79ae4cbc395e..677631ea4cfb3 100644
>> --- a/fs/nfs/nfs4file.c
>> +++ b/fs/nfs/nfs4file.c
>> @@ -180,7 +180,7 @@ static ssize_t __nfs4_copy_file_range(struct file
>> *file_in, loff_t pos_in,
>>          ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out,
>> count,
>>                                  nss, cnrs, sync);
>>   out:
>> -       if (!nfs42_files_from_same_server(file_in, file_out))
>> +       if (cn_resp)
>>                  kfree(cn_resp);
> The kernel convention in these circumstances is to just skip the NULL
> pointer check, since kfree() does that anyway.

Yes. I'll respin.

Tom

>
>>          if (ret == -EAGAIN)
>>                  goto retry;

