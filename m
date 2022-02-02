Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B724A74F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbiBBPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiBBPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:53:53 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E1C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:53:53 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d188so25966406iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WXOsmtDny0WluDniF2bqbqtLayhd1SNumBfgvAoXVDc=;
        b=ENABLJMA05R4soziave+d7UPm5zfjbrRymzXBoJsaW0z6qAKD2n9BRtw7tMe8IWvtT
         Dtw076aY5ms2kHZAAIDpNevhFb8kbWcCRn5sIFiTdWfl+S4e2MesYrqCgrU0NJHNQkOc
         frhUCeyRRNVCb6l36CVwAiB4lbVwnXLyCG9nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXOsmtDny0WluDniF2bqbqtLayhd1SNumBfgvAoXVDc=;
        b=qqychudCEJPQdtvHXLvVzl42EjZPKSCP+dYx1eY3jwQXniBOenLZW5q7/VV5mqJ4fB
         jPRATZulNNW8r20SUAXRVERpwlV97zIKibN8/IQofnC46/2LMgHQyHXpaMgL4ATLu+YQ
         VYcZEJq97frPiqZxI4thfD2aq0/xq89l8tF6z1xfgwV8le8QKrAnYPI80jHbtfq+/rwJ
         UKLV5Xukrqgm5fgW/HeAqK4e4RzUHkyjMM9kE8uEQvTym/bkm+s8TKcxVAwZjNYO5YOI
         xYbz7HoXpGNTwLF/q/TaX15al0fg/KrzaRT2HzYqZhbn2W0sxm86ZbVW4owxaKkk4ouU
         aOUQ==
X-Gm-Message-State: AOAM532Sz3ESEuUNeuNd4+nfaqxd/tj0C+S+z7SRQIoK4X8dNvaX9iWW
        o+pZAEwQRt6FW5egrfGIZVWf5w==
X-Google-Smtp-Source: ABdhPJw6EtuJMPNRgqXBZ1urjdtS9DTte0fKkn/dXlVvcSumMDMNt2EoK1WwnohoNyDsHDMB2u/rhg==
X-Received: by 2002:a02:9f07:: with SMTP id z7mr12280320jal.87.1643817232526;
        Wed, 02 Feb 2022 07:53:52 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o4sm17381145iou.42.2022.02.02.07.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:53:52 -0800 (PST)
Subject: Re: [PATCH] selftests: fixup build warnings in pidfd / clone3 tests
To:     Christian Brauner <brauner@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20220127221115.3731388-1-axelrasmussen@google.com>
 <20220128085759.qgn7o3w57d6oknzv@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <54a0cd63-6ec9-21fa-722a-da933b0ff1bf@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 08:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220128085759.qgn7o3w57d6oknzv@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 1:57 AM, Christian Brauner wrote:
> On Thu, Jan 27, 2022 at 02:11:15PM -0800, Axel Rasmussen wrote:
>> These are some trivial fixups, which were needed to build the tests with
>> clang and -Werror. The following issues are fixed:
>>
>> - Remove various unused variables.
>> - In child_poll_leader_exit_test, clang isn't smart enough to realize
>>    syscall(SYS_exit, 0) won't return, so it complains we never return
>>    from a non-void function. Add an extra exit(0) to appease it.
>> - In test_pidfd_poll_leader_exit, ret may be branched on despite being
>>    uninitialized, if we have !use_waitpid. Initialize it to zero to get
>>    the right behavior in that case.
>>
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
> 
> Thanks!
> (Fwiw, all those tests should also be ported to use the TEST_*() harness
> infra. Currently it's an annoying mix.)
> Acked-by: Christian Brauner <brauner@kernel.org>
> 

Yes. Porting would be great. I will take this for now for 5.17-rc4

thanks,
-- Shuah
