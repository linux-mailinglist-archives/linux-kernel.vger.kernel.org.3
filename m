Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D045048ABAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349346AbiAKKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:47:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:47:31 -0500
Received: from [IPv6:2a00:c281:14a3:8100:a909:23ff:b834:d3b1] (unknown [IPv6:2a00:c281:14a3:8100:a909:23ff:b834:d3b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6F9A81F443FB;
        Tue, 11 Jan 2022 10:47:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898050;
        bh=PnLophKgQiY91JtWnqsdbLqeipXb7TJHgJaJkht3nhE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AbZsWlMjnCIwYU+63Nvr8EHuMdhLzeVaODnCM5MEhuYqNhFipFGSNOnyv85m2e+k5
         y78ysbrelcx+ZyXACXM91qWSs2kA1TZqOcmERf0ACtsuW5mQwBqOTfY3wB5vLmnqPh
         3BjxKtp7Na8a7/R+g+WkM8SIOK8i4ltMEpMnvCupGpohIFEktquUZNIoQLnLAZT/dY
         bBr+JlD8bIpEfWlAJ2gqkBLbXYUviAaiRQMWbbIxdCPGXH1/09jCImejpV2Nnx/vQu
         usT5N8R6U1d0HQ1RVwibNIHrnKEJDOKFD2HAS3xu1toMS32l2EkymfmBSwKu3dqFQ+
         wVx95VYkFtYVA==
Subject: Re: [PATCH] checkpatch: warn for p0 patch only if prefix is not b
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
References: <20220110200529.18601-1-dafna.hirschfeld@collabora.com>
 <CAKXUXMyepnLO=jLPciG5mWvTxbQGR+1PaeYs1_c+-t3hFAEhNg@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <ff6e3942-24e4-25ec-946c-cc6301ebf260@collabora.com>
Date:   Tue, 11 Jan 2022 12:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMyepnLO=jLPciG5mWvTxbQGR+1PaeYs1_c+-t3hFAEhNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.22 12:18, Lukas Bulwahn wrote:
> Dafna,
> 
> On Mon, Jan 10, 2022 at 9:06 PM Dafna Hirschfeld
> <dafna.hirschfeld@collabora.com> wrote:
>>
>> It might be that file 'b' happens to exit. In that
>> case, if the prefix is also 'b' (which is the
>> common case) we get the falsely warning:
>>
>> patch prefix 'b' exists, appears to be a -p0 patch
>>
>> So warn only if prefix is not 'b'
>>
> 
> The checkpatch script that is maintained here is really only intended
> for its use in the kernel development. You may use checkpatch anywhere
> else, but any changes that increase complexity for those other use
> cases is really difficult to argue for inclusion in the kernel
> repository. The checkpatch script currently is already large and
> complex enough and all rules need to be understood as rough
> heuristics, not as strict rules.
> 
> So, can you point to a kernel repository where there is actually a
> file 'b' included? On a quick scan, I could not find a file 'b' in the
> current trees of the repositories on my machine.
> 
> I am just letting you know about what I have observed; I do not decide
> on the inclusion of this patch, though.

Hi, a 'b' file might make it to the source folder as an untracked file.
This actually happened to me since I was too lazy to give it a meaningful name.
Then I got this warning and it took me some time to figure out what is the problem.

Thanks,
Dafna

> 
> Lukas
> 
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> ---
>>   scripts/checkpatch.pl | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 1784921c645d..72263b142e39 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2821,7 +2821,7 @@ sub process {
>>                          $in_commit_log = 0;
>>
>>                          $p1_prefix = $1;
>> -                       if (!$file && $tree && $p1_prefix ne '' &&
>> +                       if (!$file && $tree && $p1_prefix ne '' && $p1_prefix ne 'b' &&
>>                              -e "$root/$p1_prefix") {
>>                                  WARN("PATCH_PREFIX",
>>                                       "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
> 
>> --
>> 2.17.1
>>
