Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25E5A3BDF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 07:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiH1E7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 00:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1E7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 00:59:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6F5275C7;
        Sat, 27 Aug 2022 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jQsOWK7NX8ntAUmH3ww4h1vB+iWf3MvcUcLZSZ3JeLc=; b=pGwCUd0WB16nWcFvOHgXvmvEGi
        mSZGQbWFo7MZZGbZcofTSSg4NxE36jrjudAuwxJEa/2LJSYz2P2XsglYU5mEEbMsyv7r+YiF7G1jw
        sxzRNIhROzSkKoY66L8yMemd+gQz8nRbPLeDwS7HI++8W0QHUg+qnhOOE4A/IcGBiGGQC1Sme2hdB
        xtjg4vOxQos6rN1C5FonDBR1uvxAH5bNVIYZGoLK9/JuL2rEMP++GcD+hmLVpE4zAeYBRouIUkR7f
        iAxmj543TrmzNLbn3B9xLWDLdUvIrc8LrYxjRLY+DJqbbWa6qXfVcTpTLYSRCsMpEt9Sdps1P9Uj4
        8wsU8mRQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSAOc-00CvtR-SQ; Sun, 28 Aug 2022 04:59:43 +0000
Message-ID: <a79687c7-929e-19d1-97fc-9a2ecf39d38d@infradead.org>
Date:   Sat, 27 Aug 2022 21:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 2/2] docs/conf.py: Respect env variable SPHINX_IMGMATH
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
 <5a582b2b-d51c-a062-36b2-19479cf68fab@gmail.com>
 <2032102a-e2d3-6105-f4e6-bba7decdbb66@infradead.org>
 <e7e3cfb5-fc82-5ce4-b964-e3eec01dcc2c@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e7e3cfb5-fc82-5ce4-b964-e3eec01dcc2c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/22 20:47, Akira Yokosawa wrote:
> Hi Randy,  thank you for looking into this!
> 
> On Sat, 27 Aug 2022 17:38:41 -0700, Randy Dunlap wrote:
>> Hi Akira,
>>
>> On 8/26/22 21:38, Akira Yokosawa wrote:
>>> On some distros with coarse-grained packaging policy, dvipng is
>>> installed along with latex.  In such cases, math rendering will
>>> use imgmath by default.  It is possible to override the choice by
>>> specifying the option string of "-D html_math_renderer='mathjax'"
>>> to sphinx-build (Sphinx >= 1.8).
>>>
>>> To provide developers an easier-to-use knob, add code for an env
>>> variable "SPHINX_IMGMATH" which overrides the automatic choice
>>> of math renderer for html docs.
>>>
>>>     SPHINX_IMGMATH=yes : Load imgmath even if dvipng is not found
>>>     SPHINX_IMGMATH=no  : Don't load imgmath (fall back to mathjax)
>>
>> Please add SPHINX_IMGMATH to Documentation/doc-guide/sphinx.rst
>> (I guess), where other Sphinx environment variables are listed.
> 
> Right.
> As I mentioned in the coverletter, (quoted below):
> 
>> I mentioned in the thread of [3] that imgmath can generate scalable
>> math images in SVG.
>>
>> My plan was to implement that option as well.  But during tests under
>> Fedora/CentOS/openSUSE, I encountered a couple of warnings from dvisvgm.
>> That would be regressions on existing systems which happen to have
>> not-working dvisvgm along with working dvipng.  I'm thinking of adding
>> the SVG option later if I can figure out the minimal requirement for
>> dvisvgm under imgmath.
> 
> , I'm working on follow-up changes related to SPHINX_IMGMATH.
> 
> My plan is to update related docs and help text in Makefile when I manage
> the SVG option. At that time, SPHINX_IMGMATH will have additional options
> like 'svg' and 'png'.
> 
> Hopefully, such follow-up changes can make the v6.1 merge window.
> 
> Does this plan work for you?

Ok, yes, sure, no problem.

Thanks.

-- 
~Randy
