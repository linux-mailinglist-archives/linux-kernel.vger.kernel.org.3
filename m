Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7665313CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiEWQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiEWQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:17:27 -0400
Received: from mx1.supremebox.com (mx1-c1.supremebox.com [198.23.53.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39A66684
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KjSGju59Ich2PK+YmLbZYQHyPrKADu4YlcAeuTKJzsY=; b=Vuzwf6Kty+1GzL54plgo8ujUPA
        cvuJQiA228sTLSCGqEx9YCy/CphorA+BgZ47Vlf+IVcH8uKd2De5DgTDkY4AnatcvvWtXT8mvsV2N
        5qk3mKF0N6FKxbJqHdnMY2DHe+acRXg/6rzuPVwmPwm+ImqlEEGurE3uxZGnPqvJ6RSA=;
Received: from 75-166-140-231.hlrn.qwest.net ([75.166.140.231] helo=[192.168.0.91])
        by mx1.supremebox.com with esmtpa (Exim 4.92)
        (envelope-from <opensource@jilayne.com>)
        id 1ntAeg-0000R8-Tf; Mon, 23 May 2022 16:11:39 +0000
Message-ID: <97d8beb2-db33-1e50-eadb-6ac8d650f044@jilayne.com>
Date:   Mon, 23 May 2022 10:11:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, Max Mehl <max.mehl@fsfe.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
References: <20220516101901.475557433@linutronix.de>
 <1652706350.kh41opdwg4.2220@fsfe.org> <87zgjhpawr.ffs@tglx>
 <87wnelpam3.ffs@tglx> <1652775347.3cr9dmk5qv.2220@fsfe.org>
 <8735h7ltre.ffs@tglx>
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <8735h7ltre.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 3:43 PM, Thomas Gleixner wrote:
> On Tue, May 17 2022 at 10:25, Max Mehl wrote:
>> ~ Thomas Gleixner [2022-05-16 20:59 +0200]:
>>> There is also an argument to be made whether we really need to have SPDX
>>> identifiers on trivial files:
>>>
>>> #include <someheader.h>
>>> <EOF>
>>>
>>> Such files are not copyrightable by any means. So what's the value of
>>> doubling the line count to add an SPDX identifier? Just to make nice
>>> statistics?
>> We agree that such files are not copyrightable. But where is the
>> threshold? Lines of code? Creativity? Number of used functions? And how
>> to embed this threshold in tooling? So instead of fuzzy exclusion of
>> such files in tools like spdxcheck or REUSE, it makes sense to treat
>> them as every other file with the cost of adding two comment lines.
>>
>> This clear-cut rule eases maintaining and growing the effort you and
>> others did because developers would know exactly what to add to a new
>> file (license + copyright) without requiring looking up the thresholds
>> or a manual review by maintainers who can interpret them.
> Seriously no. I'm outright refusing to add my copyright to a trivial
> file with one or two includes or a silly comment like '/* empty because */.
>
>       There is nothing copyrightable there.
>
> I'm not going to make myself a fool just to make tools happy, which can
> figure out on their own whether there is reasonable content in the vast
> majority of cases.
>
> Also you need some exclude rules in any case. Why?
>
>    - How do you tell a tool that a file is generated, e.g. in the kernel
>      the default configuration files?
>
>      Yes, the file content depends on human input to the generator tool,
>      but I'm looking forward for the explanation how this is
>      copyrightable especially with multiple people updating this file
>      over time where some of the updates are just done by invoking the
>      generator tool itself.
>
>    - How do you tell a tool that a file contains licensing documentation?
>
>      Go and look what license scanners make out of all the various
>      license-rules.rst files.
>
>    - ....
>
>    Do all scanners have to grow heuristics for ignoring the content past
>    the topmost SPDX License identifier in certain files or for figuring
>    out what might be generated content?
>
> You also might need to add information about binary blobs, which
> obviously cannot be part of the binary blobs themself.
>
> The exclude rules I added are lazy and mostly focussed on spdxcheck, but
> I'm happy to make them more useful and let them carry information about
> the nature of the exclude or morph them into a general scanner info
> which also contains binary blob info and other helpful information. But
> that needs a larger discussion about the format and rules for such a
> file.
>
> That said, I'm all for clear cut rules, but rules just for the rules
> sake are almost as bad as no rules at all.
>
> As always you have to apply common sense and look at the bigger picture
> and come up with solutions which are practicable, enforcable and useful
> for the larger eco-system.
>
> Your goal of having SPDX ids and copyright notices in every file of a
> project is honorable, but impractical for various reasons.
>
> See above.
>
> Aside of that you cannot replace a full blown license scanner by REUSE
> even if your project is SPDX and Copyright notice clean at the top level
> of a file. You still need to verify that there is no other information
> in a 'clean' file which might be contradicting or supplemental. You
> cannot add all of this functionality to REUSE or whatever.
>
Max, Thomas,

I think the discussion here is hitting upon the "inconvenience" of the 
lack of black/white rules in the law (as to what is copyrightable) 
versus the convenience of downstream recipients of code who want to be 
sure they have proper rights (which mixes in the guidance/rules of 
Reuse, tooling, etc.).

I think some rules in terms of files that are clearly not copyrightable 
can be implemented in various tooling (hopefully, with the guidance of a 
lawyer steeped in copyright law), and I agree that putting a license (by 
way of an SPDX identifier or any other way for that matter) on such 
files is neither a good use of time nor a good idea (from the 
perspective of being inaccurate as to the need for a license and thus 
sending the wrong impression). That being said, there will not be a way 
to make clear cut rules for everything, without involving a judge. 
Sorry! That's just how the law works (and we actually often don't want 
black/white lines in the law, actually).

I can see a policy of, "when it's not clear (as to copyrightability), 
then add a license", though.

Thanks,
Jilayne

