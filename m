Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979753BB56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiFBPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiFBPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:04:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0847C12AD9;
        Thu,  2 Jun 2022 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WoitXMmhcMk+1AR9eqwLWDCUvPaR+31os1w7YKjQCsY=; b=qf1smDMX3y1G2ZNd58m0yiSogl
        bwYrKwa4QFCo0UtLdW/sG8QkyZinHgdva6lrpfJ9sdTvJBJDP79IPwh9xj35qFv2xqUPAks61Xc3j
        ztxyiAXolNzSPmgLi/reZu+0X6aEdycPcTW085NNI+fQuVVsXLUuuqziCLAn4J2Df7yzC0RAnZMNt
        Rkt/smIaFrWjifV+6XztuAVaGdSBRv50z5WO78CVl7T+osU7gTaSf4Mpvp1LWj9GkPQtT8v/e4g/i
        Lq4m8a9jGDa3nCtD+JOnusCzDgji/5KG1O1AC/7NCzf9Syv7IceE33Ccx/srS5eKbK3DMuwcTFL6W
        paeELKMw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwmMm-007Drm-Cs; Thu, 02 Jun 2022 15:04:05 +0000
Message-ID: <c9542630-065d-0c80-5ad3-2375d526878b@infradead.org>
Date:   Thu, 2 Jun 2022 08:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] kbuild: show the install image name and path
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>, Keith Busch <kbusch@fb.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <20220602015050.3185028-1-kbusch@fb.com>
 <CAK7LNAQot2kMxmisAE2XP3ukPSGBJkLWWYzrTcjV9exSVQKupQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAQot2kMxmisAE2XP3ukPSGBJkLWWYzrTcjV9exSVQKupQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/22 07:52, Masahiro Yamada wrote:
> On Thu, Jun 2, 2022 at 10:51 AM Keith Busch <kbusch@fb.com> wrote:
>>
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Prior to commit f774f5bb87d13 ("kbuild: factor out the common
>> installation code into"), a 'make install' would print out the install
>> command like:
>>
>>   sh ./arch/x86/boot/install.sh 5.18.0-11935-gbffe08031c89 \
>>         arch/x86/boot/bzImage System.map "/boot"
>>
>> This output was very useful for my workflow, so this patch prints it out
>> again. I'm not sure if there's a better way to do this than what's
>> implemented here, so any feedback is appreciated.
>>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> ---
>>  scripts/install.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/install.sh b/scripts/install.sh
>> index 9bb0fb44f04a..2989d25ef069 100755
>> --- a/scripts/install.sh
>> +++ b/scripts/install.sh
>> @@ -33,6 +33,7 @@ do
>>         # installkernel(8) says the parameters are like follows:
>>         #
>>         #   installkernel version zImage System.map [directory]
>> +       echo "$0 ${KERNELRELEASE} ${KBUILD_IMAGE} ${INSTALL_PATH}"
>>         exec "${file}" "${KERNELRELEASE}" "${KBUILD_IMAGE}" System.map "${INSTALL_PATH}"
>>  done
>>
>> --
>> 2.30.2
>>
> 
> You said "useful for *my* flow",
> so you can do whatever you think is useful in
> ${HOME}/bin/${INSTALLKERNEL}, can't you?
> 
> 

True. E.g., my kernel installer also shows me

a) the modules install path (e.g., /lib/modules/$KERNEL_RELEASE)
b) the number of modules installed

> 
> 
> $ cat ~/bin/installkernel
> #!/bin/sh
> 
> echo '== useful info for my workflow =='
> echo "$@"
> echo '================================='
> 
> exec /sbin/${INSTALLKERNEL} "$@"
> 
> 
> 
> 
> $ chmod +x ~/bin/installkernel
> 
> $ make install
>   INSTALL /boot
> == useful info for my workflow ==
> 5.17.0 arch/x86/boot/bzImage System.map /boot
> =================================
> 
> 
> 
> 
> 
> 

-- 
~Randy
