Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF7653513E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbiEZPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:12:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039432C119;
        Thu, 26 May 2022 08:11:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 14so1674819qkl.6;
        Thu, 26 May 2022 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4DEIvAgh2a6TwRuw5XAz6YgWGy2e708PXn5BX7Fd9w=;
        b=LhiIlQuIrnGR3RG4lh+/b1nL9V39Fk39Doqe6ro8hBRHCEaNDLmiW1rCq8gpI5AqMg
         mxLX7cPBK1i/arosPsXXRC8y6OOTVLA9aBs2QqGRk81gOxvW2/gDRiE5zaszrP7mPoQA
         UtacZFNeSfCyyvnN4WCSpiUMLUeZnNBjVb9HCDfd2bxl1oslASQjVXF4qzeV/efCbUa8
         Vm+RmzW854Ue4vF8VpKoPfT2q2T7v+fXWGpZAC/rzu3HMGUgrd85NMk2PoenV43jkMM/
         bwpr+sq+8FY6rVjh/GebvZPdzHbzFkPd/D01MZtBqH6okuZBz+9eddPWgNZwnTxey8x1
         5P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4DEIvAgh2a6TwRuw5XAz6YgWGy2e708PXn5BX7Fd9w=;
        b=EAkJ8gfQU9J1da+o4H7tTAinEtOBSjrSQ6DFmPMqiVJbuIVkcTlTf+410uVj/omO3t
         glRctovi9riKAVr01H1N7Dyz1ok65NGT51ipAXssN1p8UkOQD/iVcghiTOVRMNcX1thA
         HaqvFTSgiTfUumcBvhXtrNTdbzbKk1eN1nFExhQFnPe8PSpSUUqB+QyJ87vWvHFryujA
         Q4ynBWTXtbEQV0lcCn1/J7TjPn0oi0JGysXfE6FeXY7agkKrd6qe9V/Aep65Xbkk7J0C
         rQgta18jAYeUhHyk1Wk2xs3+4Fqe/laCEljw6O2eYC9fIjl01Ed7RRu6qh64pGJd+74k
         indw==
X-Gm-Message-State: AOAM530Bhgut8m1j325QFhO2/lw1X6praM0L8i5NHil27u0iN7SIyT6M
        hFfO35XQM/Bz+vTWH25ouQ==
X-Google-Smtp-Source: ABdhPJxc5GwxW9O1iUet6Mo/SsPbyz3c/BBttn1F5Ds5HafJSKW90OyqNdPMigNwo5WbJcxCfnOmBw==
X-Received: by 2002:a05:620a:120f:b0:6a3:696b:2be2 with SMTP id u15-20020a05620a120f00b006a3696b2be2mr16942517qkj.780.1653577918034;
        Thu, 26 May 2022 08:11:58 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bt15-20020ac8690f000000b002f9399ccefasm1133171qtb.34.2022.05.26.08.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:11:56 -0700 (PDT)
Date:   Thu, 26 May 2022 11:11:55 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 00/28] Printbufs (now with more printbufs!)
Message-ID: <20220526151155.66mp7llgagtpzdx6@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <Yo+SRBSu5OdRl0/J@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+SRBSu5OdRl0/J@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:44:20PM +0200, Petr Mladek wrote:
> On Thu 2022-05-19 13:23:53, Kent Overstreet wrote:
> > So there's a lot of new stuff since the first posting:
> 
> >  - Printbufs have been broken up into multiple patches that each add distinct
> >    functionality - this is intended to make it easier to review and to see
> >    what's used for what
> 
> It is great that it is split. Also it is great to see all the ideas.
> But I would really prefer to somehow split it to make it easier
> for review and rebasing.
> 
> I see the following "independent" parts:
> 
>   1. Add simple API that allows to replace @len, @buf, @end in vsprintf.c
>      by @printbuf. I agree that the code looks better and more safe.
> 
>   2. Clean up of printf_spec. It would be great. But I do not like
>      some parts. For example, si_units, human_readable_units
>      are not property of the buffer. They are specific for a
>      particular substring.

Not in conventional usage - these are properties that are set globally when
building up a string: consider an -h flag to a userspace utility.

> 
>   3. New %p(%p) format. It really needs deep thinking. It is a
>      ticket for potential big troubles. It is one patch that
>      might be introduced and discussed anytime once we have
>      the simple buffer API.

It's split out into a separate patch - discuss away!

>   3. Replace seq_buf. Steven Rostedt has to agree with it. Honestly,
>      I do not see any improvement. The patches mostly do 1:1 replacement
>      of one API with another.

It was necessary to avoid code duplication, which Christoph didn't like, and
seq_buf wasn't quite right for what I was trying to do and Steven didn't want to
change it. (read_pos is tracing specific and doesn't have anything to do with
printing, some of the semantics had to be tweaked to support snprintf, and the
name was wrong... :)

>   4. Heap allocated buffer. I am not sure if it is really needed.
>      The patchset adds 3 users. IMHO, small static buffer would be
>      perfectly fine for 2 of them. I personally do not like the error
>      handling and the need to call exit.
> 
>   5. All the fancy stuff (pr_tab(), pr_string_option()). The patchset
>     does not add any user for them.

Heap allocated buffers and tabstops: these are things that I've been using in
bcachefs, and have quickly become necessities - I included them because I think
others will soon find them valuable (e.g. /proc has a lot of files that would be
more readable if formatted with tabstops).

pr_string_option(): this isn't anything really new, we've got a lot of pretty
printers and string helpers of this nature that need to be better organized and
given a common calling convention, I included this as code I've got that's been
useful and I think does it cleanly. I have more future plans for pretty printer
cleanup.
