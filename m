Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249654D003E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiCGNku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiCGNkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B81685BE5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646660394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtoXzlWdMjEaTdkHRpRbjU16+CzIWpJ5Gk6mnrIwGKc=;
        b=YL3HMcElSneMp/r9xt782uwEf6IPZUCxf8TnqHY1xWWFpEMDy1yiQqL5Sq5nCsfU3gy/SF
        99h6K5K8WgFTGA50z1K3TJ+mGa/CPvW+Xl600+5rjMIPsx9tt7Bm+kkIYK+MzrjMc5v1Pl
        6mSS/1B+we3FTbexyYFEgQAXTTzEWeg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-YAw7ITtnM4yyxtl2qiJIfQ-1; Mon, 07 Mar 2022 08:39:53 -0500
X-MC-Unique: YAw7ITtnM4yyxtl2qiJIfQ-1
Received: by mail-oi1-f198.google.com with SMTP id o2-20020a0568080bc200b002d64d89d460so9555385oik.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CtoXzlWdMjEaTdkHRpRbjU16+CzIWpJ5Gk6mnrIwGKc=;
        b=vapW52aqUNACIU9TjWONZdYsHFfV/It4/ZxEpG/0+WgSwSU+P4nGTNuzUfuvOkhbyf
         eHYINbSV9H7D9eavBxenSgnhZx+DLSpTOeFQY8GfpNgdWoIBiwp3BUTVpz4gKBCj60Lp
         ZPybPm9rbv8OS6te9W/zw23SbMXtErv6YwCa9W422ZEXyOu6Eh6zfpUL8Nx+l4iWBqcm
         v5/h3Q77IwjTeHcOHxVPWQ441plfat4bmCSNcSi4LZVEFsP4eJ4/KvbYLwnNt1jkQoei
         2aKsfxSglBCtfFrpdnx0YK8r6553vvr2L3UB0LIkuvhjq39wOURorTYRl3XUMR59fzCO
         dsVA==
X-Gm-Message-State: AOAM532q/wnWVpAd5sjlmDj4tEmOvXcrnLTCyRvBg/JEw5FzXqxNRf4X
        uVou7E+m8wRc/ZduRSYf2T0dmtMHtkLrRPAxtsow7r2DIbqTF+L4MCuJgdle2eJ5jlxEOSpAmZi
        EKpy0+Kpv2bYtVATFMJl7HQ8hvGewsF7lCa3P50PhUq3FZNrFbFEPlMkzE7by4itsIok2DgE=
X-Received: by 2002:a05:6830:2646:b0:5b0:29e9:b623 with SMTP id f6-20020a056830264600b005b029e9b623mr5525179otu.266.1646660392550;
        Mon, 07 Mar 2022 05:39:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGLrIi2ki38vAlN8pwDU2wa+0EYJY5++5iZgmYWGYscX8JZBaezJHnxs4oMV1319QYnLYyHA==
X-Received: by 2002:a05:6830:2646:b0:5b0:29e9:b623 with SMTP id f6-20020a056830264600b005b029e9b623mr5525166otu.266.1646660392286;
        Mon, 07 Mar 2022 05:39:52 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m26-20020a05680806da00b002d797266870sm6326213oih.9.2022.03.07.05.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:39:51 -0800 (PST)
Subject: Re: [PATCH] netfilter: conditionally use ct and ctinfo
To:     Florian Westphal <fw@strlen.de>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
        kuba@kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220305180853.696640-1-trix@redhat.com>
 <20220307124652.GB21350@breakpoint.cc>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b795685f-6cdb-5493-8280-75749ddb0f6f@redhat.com>
Date:   Mon, 7 Mar 2022 05:39:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220307124652.GB21350@breakpoint.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/22 4:46 AM, Florian Westphal wrote:
> trix@redhat.com <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The setting ct and ctinfo are controlled by
>> CONF_NF_CONNTRACK.  So their use should also
>> be controlled.
> Any reason for this change?

Define and use are connected. Doing something to one without doing 
something to the other doesn't make sense.

Could removing the CONF_NF_CONNTRACK be done for the define side ?

Tom

> We try to avoid ifdef where possible, unless it avoids a compiler
> warning/build/linker issue.
>
> This doesn't change generated code for me (NF_CONNTRACK=n) either.
>

