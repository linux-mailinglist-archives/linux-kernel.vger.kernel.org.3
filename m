Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD7461FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379358AbhK2TCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:02:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54844
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239649AbhK2TAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:00:00 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 095D54000A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638212202;
        bh=ok4uKKGSTk4p0yYxv2QRxL9x4nnbrUQrc4yllPT/1iI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Cg5pfYPOO8tOReCcoL8Qf9Utwl7iBGKrFfr3OOXSQB+1kLP3LQNlkDPWJTDspNoPI
         rKEPPLf6fsktBXN1svD7LXQv3EeGA/dk+kVJPR2Q6rjGUWPy19SBT/noZVET7/x8C4
         CAkeDpIIn2BrjXIjW4QCs0O4AHwGQTzSGzjqCjrzxbxZpHvv7M6UOdlDDViu5prcQt
         GfeGY1txDSMdNsLDbfYXjMPXiYQisHJMcO0FyAfDP0KWl8JmE5Uo2/WjfxfEYQHrAQ
         e6kBZb8myBS2WCBkXBNv25N6cVatGjw1xIcndS0luJhIOwC7EOWSTtF6XNZ3P0hrcn
         C6/z3YliuFRag==
Received: by mail-pj1-f69.google.com with SMTP id a16-20020a17090aa51000b001a78699acceso10121143pjq.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ok4uKKGSTk4p0yYxv2QRxL9x4nnbrUQrc4yllPT/1iI=;
        b=MQx2vdEkx3o780JPg3cEKSAt4n+LzwjBRUVNnCP1feZ64AVMZJqjkCa/sMrQ7J9xRA
         5ztk+Eo9pmpOCexNbGSbnoxIDouoUSeuEK/M1Eun0Jwi90cgn4oJfkaDwsfiy0SlrXsB
         iOeqHcC6ipKWwySRa0WXuPqRS5ZtI6VKoZ38kT69vf3FJakMb4jychKXpnVi0Kq34log
         cdT8jJJ+E6pyzIar0Meps2dXeCTb+nm1WTLfOiFQoyuiNC9uTZpnL1VyAKdzvarziQ3+
         hOl89qNle1PG9n1Yu3kY40kjvtnUXJt4qXsi2oV8gXbZVL8e5ArGdLwA88jEfuWAs1UC
         j4kw==
X-Gm-Message-State: AOAM5315lNR2XJL3I+SBDAbziUe1WyUaU6yGMYyTvtYW5btguFXwPqp5
        5/FLt8w/jbt3ypySrVnzuNAlb91wuPnhKSHBbtSpIog9qg8NjVo09bo13xwyUqjMXwb5m/8AetB
        jhHfsAnL25L9g3DVATZSi74NugyDzq05CZVJStSHiWA==
X-Received: by 2002:a17:902:7616:b0:143:a8cd:ef0 with SMTP id k22-20020a170902761600b00143a8cd0ef0mr61917177pll.48.1638212200309;
        Mon, 29 Nov 2021 10:56:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/BkSAQbSZFobcpK6b56IvT8KwOyOfFMcjPsmM1aFyNsfSddFxK0GI5ICJJ2P36qgEQdf/Ow==
X-Received: by 2002:a17:902:7616:b0:143:a8cd:ef0 with SMTP id k22-20020a170902761600b00143a8cd0ef0mr61917161pll.48.1638212200099;
        Mon, 29 Nov 2021 10:56:40 -0800 (PST)
Received: from [192.168.1.124] ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id x14sm83630pjl.27.2021.11.29.10.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 10:56:39 -0800 (PST)
Subject: Re: Commit f980d055a0f858d73d9467bb0b570721bbfcdfb8 causes a
 regression
To:     Jeff Layton <jlayton@kernel.org>, len.baker@gmx.com
Cc:     pc@cjr.nz, stfrench@microsoft.com,
        Kamal Mostafa <Kamal.Mostafa@canonical.com>,
        linux-cifs@vger.kernel.org,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <a8b2287b-c459-2169-fbf4-31f3065e0897@canonical.com>
 <0e6e66f7368621128a810bb604eab229dd279187.camel@kernel.org>
From:   Tim Gardner <tim.gardner@canonical.com>
Message-ID: <7592d67c-3311-afd0-6ea9-64bd4d2769b6@canonical.com>
Date:   Mon, 29 Nov 2021 11:56:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0e6e66f7368621128a810bb604eab229dd279187.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/21 9:01 AM, Jeff Layton wrote:
> On Mon, 2021-11-29 at 08:35 -0700, Tim Gardner wrote:
>> Hi Len,
>>
>> I have a report (https://bugs.launchpad.net/bugs/1952094) that commit
>> f980d055a0f858d73d9467bb0b570721bbfcdfb8 ("CIFS: Fix a potencially
>> linear read overflow") causes a regression as a stable backport in a 5.4
>> based kernel. I don't know if this regression exists in tip as well, or
>> if it is unique to the backported environment. I suspect, given the
>> content of the patch, that it is generic. As such, it has been
>> backported to a number of stable releases:
>>
>> linux-4.4.y.txt:0955df2d9bf4857e3e2287e3028903e6cec06c30
>> linux-4.9.y.txt:8878af780747f498551b7d360cae61b415798f18
>> linux-4.14.y.txt:20967547ffc6039f17c63a1c24eb779ee166b245
>> linux-4.19.y.txt:bea655491daf39f1934a71bf576bf3499092d3a4
>> linux-5.4.y.txt:b444064a0e0ef64491b8739a9ae05a952b5f8974
>> linux-5.10.y.txt:6c4857203ffa36918136756a889b12c5864bc4ad
>> linux-5.13.y.txt:9bffe470e9b537075345406512df01ca2188b725
>> linux-5.14.y.txt:c41dd61c86482ab34f6f039b13296308018fd99b
>>
>> Could this be an off-by-one issue if the source string is full length ?
>>
>> rtg
> 
> Maybe? But it doesn't seem to be that long. The error message evidently
> says:
> 
>      "CIFS VFS: CIFS mount error: iocharset utf8 not found"
> 
> The iocharset string ("utf8" here) usually gets set in the mount string
> and then we just pass that string to load_nls().
> 
> The patch you're pointing out though doesn't seem to be involved in any
> of that. It sounds like something else is wrong. I'd validate that that
> patch was applied correctly, and get more details about what this guy is
> doing.
> 
> g/l!
> 

You may be correct. I made the rash assumption the reporter had done a 
normal full upgrade. However, it appears he may have only done targeted 
package updates and neglected the linux-modules-extra package that 
contains the nls_utf8 module. My test kernel installation instructions 
_did_ include linux-modules-extra which is likely why it worked for him.

I've requested more info from the reporter to verify that the missing 
package is the root of his problem.

Thanks for responding.

rtg
-----------
Tim Gardner
Canonical, Inc
