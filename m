Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103754C03E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiBVVcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVVcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:32:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F52A242;
        Tue, 22 Feb 2022 13:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AkEJBGLo6G2IxcYkqrscCgvNviNpvWskNFzIQmbXNqk=; b=Ai5hLR1jmzF7+BIuHNk5p1yGX+
        1eGvh/amhaw+JfH03YgcQXIqqAPn7wLbaL+9AyE1t9hRqdHhKVjssTIJMbaDG+2kjhItEN6U7+FUS
        GMHceajaX8wXnS83lGU6zVuBadXRnjQPhizjGMccFR7zZbOxDbBJWl5rCi5Ire48KjZL7qDIKXiSJ
        AUwmAya0z27ELXT7UvUb9eWnmituDSpZVXtUOWD87FB2d1EMSAT/JYFdHEpB3Ib2WbYYENJOrqq17
        wypV3ucBhGyQisoSOOnrTulAWqQIVrLPU4ZYaVytonGsiv1aLoFFPYo9OMryuRIwjDwl9yiOmXaWq
        uF/Vbsbw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMckz-00C3kh-68; Tue, 22 Feb 2022 21:31:37 +0000
Message-ID: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
Date:   Tue, 22 Feb 2022 13:31:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
 <0285efc4-3983-56fa-6b4e-a0b17bdd841a@infradead.org>
In-Reply-To: <0285efc4-3983-56fa-6b4e-a0b17bdd841a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/21/22 21:39, Randy Dunlap wrote:
> Hi Tomasz,
> 
> On 2/18/22 10:16, Tomasz Warniełło wrote:
>> This series transforms the free-form general comments - mainly the usage
>> instructions and the meta information - into the standard Perl
>> documentation format. Some of the original text is reduced out. And some
>> is simply dropped.
>>
>> The transformation includes language, paragraphing and editorial
>> corrections.
>>
>> The only change in the script execution flow is the replacement of the
>> 'usage' function with the native standard Perl 'pod2usage'.
>>
>> The to-do suggestion to write POD found in the script is ancient, thus
>> I can't address its author with a "Suggested-by" tag.
>>
>> This version follows the advice received on v3, except I'm leaving
>> the old copyrights untouched.
>>
>> The process consists of 14 steps.
>>
>> Patches beginning with no 3 are disfunctional until no 9 has been
>> applied.
>>
>> 1) Add the basic POD sections
>> 2) Relink argument parsing error handling to pod2usage
>>
>> The following subseries is disfunctional before its last part.
>>
>> 3) Translate the DESCRIPTION section
>> 4) Translate the "Output format selection" subsection of OPTIONS
>> 5) Translate the "Output format selection modifier" subsection of OPTIONS
>> 6) Translate the "Output selection" subsection of OPTIONS
>> 7) Translate the "Output selection modifiers" subsection of OPTIONS
>> 8) Translate the "Other parameters" subsection of OPTIONS
>> 9) Replace the usage function
>>     
>> Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -help
>> parameters are handled by POD now.
>>     
>> 10) Drop obsolete comments
>> 11) Refresh the copyright lines
>>
>> Let's see what's wrong this time.
> 
> This patch series looks good to me.
> I'll do some testing with it now.

I did not encounter any problems in testing.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>> Tomasz Warniełło (11):
>>   scripts: kernel-doc: Add the basic POD sections
>>   scripts: kernel-doc: Relink argument parsing error handling to
>>     pod2usage
>>   scripts: kernel-doc: Translate the DESCRIPTION section
>>   scripts: kernel-doc: Translate the "Output format selection"
>>     subsection of OPTIONS
>>   scripts: kernel-doc: Translate the "Output format selection modifier"
>>     subsection of OPTIONS
>>   scripts: kernel-doc: Translate the "Output selection" subsection of
>>     OPTIONS
>>   scripts: kernel-doc: Translate the "Output selection modifiers"
>>     subsection of OPTIONS
>>   scripts: kernel-doc: Translate the "Other parameters" subsection of
>>     OPTIONS
>>   scripts: kernel-doc: Replace the usage function
>>   scripts: kernel-doc: Drop obsolete comments
>>   scripts: kernel-doc: Refresh the copyright lines
>>
>>  scripts/kernel-doc | 347 +++++++++++++++++++++------------------------
>>  1 file changed, 159 insertions(+), 188 deletions(-)
>>
>>
>> base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
> 

-- 
~Randy
