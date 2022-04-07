Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7F4F8750
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346948AbiDGSsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbiDGSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:47:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5DB852
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:45:33 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 125so7878709iov.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Ji4YlYFHVDR0gxdj/6jpb0FghGwzOywEFt8q/52gXM=;
        b=QqSdyP3Dq30pUUzEmwW5hyQ4pc+G9DSDB01FoJsLcJ8OLSMzmuJX66C7O08kVxI5GR
         GP47x+r279qwgojRznD4Ox6yInvx/ZYvGYeDOkdgkAcuFWBBJzjGCpxsvSmAO77Mabnv
         2y/OMqdsdW1fDw1aqPJ9itZ4+RiSioZcqunX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Ji4YlYFHVDR0gxdj/6jpb0FghGwzOywEFt8q/52gXM=;
        b=Xc0pZDurHrCUp/VxTB/uTNEk20H10cWHX1hK5f+zACMB1+0K/CUCE9bddN5cLtJNcY
         3FeYzu3Xuh1c/XE4apyB63Gdn4ZDxU5RT7PtoMPfMhNOT6jDTln+eoC+AErGGRekQZaa
         0E8nySOY1pAsUFQWoRE5OU0xpvl/Kj0WOid5y5P6gZZQ0GrqO1ROBI2EXi3Sgs0+myIc
         TvESNaX6bhy/AyR1LBFmfgSguOS/I4ZNQNK7VYcoa0jbLzrEbLmTL84WeiRLVBcd82Tc
         FRnXE6sKfj4dG2ZRaD0hC8gS/bvBawOOfQgJ5ApRWyGZXS228oy/AGxTmiK4oKGILQEb
         zUPw==
X-Gm-Message-State: AOAM532YVy3B9y0M4wJzOXGE9NwCRDIGW023JGE2vu2teU9vmOJY0y+T
        zDuDbudbxAYRX13Lmh6RXEeU7Q==
X-Google-Smtp-Source: ABdhPJwgU4mSkmGOP4lzd2vZXXDmbmz/CKWESrQlvZqHqyu743d967VGiNZihTjDEIKxeEg/WxKIQw==
X-Received: by 2002:a05:6602:154d:b0:64c:5fab:4076 with SMTP id h13-20020a056602154d00b0064c5fab4076mr6828405iow.169.1649357133271;
        Thu, 07 Apr 2022 11:45:33 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d85d2000000b00649254a855fsm12811819ios.26.2022.04.07.11.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:45:32 -0700 (PDT)
Subject: Re: [PATCH] userfaultfd/selftests: use swap() instead of open coding
 it
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220407123141.4998-1-guozhengkui@vivo.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <059030d7-657a-6403-ae75-3314f790afa3@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 12:45:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220407123141.4998-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 6:31 AM, Guo Zhengkui wrote:
> Address the following coccicheck warning:
> 
> tools/testing/selftests/vm/userfaultfd.c:1536:21-22: WARNING opportunity
> for swap().
> tools/testing/selftests/vm/userfaultfd.c:1540:33-34: WARNING opportunity
> for swap().
> 
> by using swap() for the swapping of variable values and drop
> `tmp_area` that is not needed any more.
> 
> `swap()` macro in userfaultfd.c is introduced in commit 681696862bc18
> ("selftests: vm: remove dependecy from internal kernel macros")
> 
> It has been tested with gcc (Debian 8.3.0-6) 8.3.0.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Looks good.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
