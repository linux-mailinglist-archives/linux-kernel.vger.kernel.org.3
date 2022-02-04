Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD34A9CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376386AbiBDQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376368AbiBDQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:11:55 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F7C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 08:11:55 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id n17so7926132iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 08:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lNiayXzwU2gmln7e79/ZnK/mf03Y/0z/TVVb/6MvY7E=;
        b=M1rge/xoo1LlbHLv98Hz+NKgyItbVwP+VmmtMV/RjS1pbI2rV2u1WYKrS+1nArnMsX
         fEeKcUsKe+YgtFJuG/31dxNyt+HTpbBp+Olh7k4QuRN7jiOC5V2wnu55v8E+dDPTsNvI
         0O6Iv/BBRoT1JtnjPziUiDk9uJw9D73tKugOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNiayXzwU2gmln7e79/ZnK/mf03Y/0z/TVVb/6MvY7E=;
        b=WkBdmpAWxOmBe55ZP1CfXwErT80nlMkbj7P0Zbs6NcNhBraKCjWEc0kZVN4K9AXwm4
         KXdP3Ittx0/TeAEkmtiolCbCZWRfZUXU8mjFQPsh0DIyx6W/KpT2kM3bk9mvZubmu3nF
         hluJ9j3gseZBqwFe2WxUaP9yfQ/zYzQjXs8z0Qi1+J0H4Lwq0OtaALOKXDuEMy82Rccx
         ZqPGoeC7M4u179tn+oYlDj/Yxg43/aB9ALU2i74oOLtcbskPPiTSw10lgYRxi6FmNmuv
         kjBAYouehxaue7hq+f7GNbIa3r+5nLkXE+FQeZTtekwmstZkrxD/LMeTFNnlQdLpOgjc
         Ua3Q==
X-Gm-Message-State: AOAM531v5Q02svdOoN1IywUB+RGC+3jmMUboFjASpvFK0LnuyYIZZP/x
        PGWc4h/weewlsCIgYmTtTlQpsg==
X-Google-Smtp-Source: ABdhPJzbi7gCN6YRFk6kMGYATtbYjbp9R7LIb8qSfdMwkMWxfQdddh2CymQz1s8cJpHEvtA+EHgIDw==
X-Received: by 2002:a05:6638:2642:: with SMTP id n2mr1669191jat.47.1643991114800;
        Fri, 04 Feb 2022 08:11:54 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l7sm1164762ilv.75.2022.02.04.08.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 08:11:54 -0800 (PST)
Subject: Re: [PATCH] selftests/exec: Avoid future NULL argv execve warning
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220201000807.2453486-1-keescook@chromium.org>
 <Yfqfo0rbq/B/l6IP@localhost.localdomain>
 <7af32164-dbdf-26f1-1aaa-b720365f9743@linuxfoundation.org>
 <Yfrw8GREVRgN76tF@localhost.localdomain>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <942a078a-2b27-d028-0617-714b6f597942@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 09:11:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yfrw8GREVRgN76tF@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 2:00 PM, Alexey Dobriyan wrote:
> On Wed, Feb 02, 2022 at 10:38:57AM -0700, Shuah Khan wrote:
>> On 2/2/22 8:13 AM, Alexey Dobriyan wrote:
>>> On Mon, Jan 31, 2022 at 04:08:07PM -0800, Kees Cook wrote:
>>>> Build actual argv for launching recursion test to avoid future warning
>>>> about using an empty argv in execve().
>>>
>>>> --- a/tools/testing/selftests/exec/recursion-depth.c
>>>> +++ b/tools/testing/selftests/exec/recursion-depth.c
>>>> @@ -24,8 +24,14 @@
>>>>    #include <sys/mount.h>
>>>>    #include <unistd.h>
>>>> +#define FILENAME "/tmp/1"
>>>> +#define HASHBANG "#!" FILENAME "\n"
>>>> +
>>>>    int main(void)
>>>>    {
>>>> +	char * const argv[] = { FILENAME, NULL };
>>>> +	int rv;
>>>
>>> Can we move out of -Wdeclaration-after-statement mentality in tests at least?
>>
>> selftest like the rest of the kernel follows the same coding guidelines.
>> It will follow the moving "-Wdeclaration-after-statement mentality" when
>> the rest of the kernel does.
>>
>> Looks like this topic was discussed in the following:
>> https://patchwork.kernel.org/project/linux-kbuild/patch/c6fda26e8d134264b04fadc3386d6c32@gmail.com/
> 
> The only real argument is "gcc miscompiles /proc" to which adding -Wdeclaration-after-statement
> looks like a too big hammer.
> 

Either way - selftest will stay in sync with the kernel coding standards
for good reasons. Doing its own thing confuses developers and makes it
hard for maintainers.

thanks,
-- Shuah
