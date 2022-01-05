Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27F485AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbiAEVbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244426AbiAEVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:08 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB3C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:31:08 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kc16so462043qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KaugUz46tW8OmhBqIZ9jwiqPis52Cy1fNqiGsGfoTG8=;
        b=imnzYCQ5MsamiVJKUgz/DAmOxeFUztOWBxZ8rpHXsoPFwt1QIta5OVZ8P7Sbp3RLE4
         lTC0HUWrzyaBAnblC65Xuwu/+MoSx9JEw99xpn4Alxo3N/oIMu8ZeR2S036RBFtQLPLb
         SU3LJrFvYlsO6DR2ojsMyAXtIqpeipPKmK4BnQvd2O9l9mo2zFjGt1EHjqHk1hEROetx
         njzS/MqS1jcndiXHnJ1fzcmaoWEzWXY50wfHUBwgfJsQP9s3HZFKjUpjw1k0cRrTNyxG
         es6r/drZFkPiWMESLgkq0qTfiDLAIl8RxlUO932XRX5PIpIETZY2TLzVPr3nFgtvYEVr
         lGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KaugUz46tW8OmhBqIZ9jwiqPis52Cy1fNqiGsGfoTG8=;
        b=yhL8+T/poEp8mBCQfZ+fj4bP2gHadospDRBMCPwDv915bOGEMwl2D+yKWu6XT6uUqY
         Y/L2tcwx/lBDYRwrguYhvQeTnSiXRqwyme5EDrtQv/XOAbh0F0E++MeCbshQFEdPBJcF
         J7DAcGhBQFtGGF0A2OftPPIDG1+Xb6kHUZqX5fT0rss/oDC53ufZNjlmIc1+SN0spm12
         lzqxZcK3BmWMlvqFwv9T1+G1OyzdP2rejXKeTKkjcAV4aVvYH8Ah/hL8byVWUBm59GzS
         6Xuf3cnglXdyejkmGVLld7vqdYQmtB/sRifJe6BvMrVGv9xeNzaTpjYDNqMDRxJsWFYV
         0L/Q==
X-Gm-Message-State: AOAM53230cvNO3RzKuCheUc9Z78tALLAIPxSYSFbGLbm+RwkjsLlKrrS
        ZgBVjuSVxLQFzRcnsUb1LdIxag==
X-Google-Smtp-Source: ABdhPJy7VyTmEoBTsJdjaQQhxyBAh+c5MvjENhOKOpyyCC8MG09jgKANOY0TEU057qCllHgmuKtK4w==
X-Received: by 2002:ad4:5aa9:: with SMTP id u9mr52496438qvg.50.1641418267445;
        Wed, 05 Jan 2022 13:31:07 -0800 (PST)
Received: from [192.168.0.111] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id 22sm47790qtw.12.2022.01.05.13.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 13:31:07 -0800 (PST)
Message-ID: <28405360-ea08-acdd-d62b-b925c9904dff@google.com>
Date:   Wed, 5 Jan 2022 16:31:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH] rlimits: do not grab tasklist_lock for do_prlimit on
 current
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211213220401.1039578-1-brho@google.com>
 <8735mww2w3.fsf@email.froward.int.ebiederm.org>
 <456a056e-453e-71b0-0f9e-03511b9f56b1@google.com>
 <87zgp1psd3.fsf@email.froward.int.ebiederm.org>
From:   Barret Rhoden <brho@google.com>
In-Reply-To: <87zgp1psd3.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 14:42, Eric W. Biederman wrote:
> In update_rlimit_cpu use lock_task_sighand instead of unconditionally
> grabbing sighand->siglock (because without tasklist_lock sighand might
> be NULL).

this ended up being a minor complication, since update_rlimit_cpu() 
could fail if the task was exiting, but i think i sorted it out.

i'll send out revised patchset shortly with this change, including 
making do_prlimit() static.

thanks,

barret


