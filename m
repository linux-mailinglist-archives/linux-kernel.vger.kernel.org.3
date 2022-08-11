Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC3590676
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiHKSfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiHKSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:35:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0ADEB7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=DdbX2LXsEvt1nJpgDA8jNe4E5Fy6iy4v9UpXaexOkk8=; b=lY4istv/F3Z8gb9JhvT77ICnuX
        muK6U8A857lWDiHVFsTdAaJAe2hlMVKnCN0eLk9KzKKFoMptGuoKHZKfL25X1uSRJDB/hnYF/yGCm
        DLp3rV1nP6iI9LMFr3GsXJGnVxZ5HEchWTwFy5IomwYwndIEXgXdK8pE538zREeprA690aGRZ5Z/z
        Z4XtL7k7JiR+yxPSwMLhbGCh/Zwy/OE3jG4qpxuBHyhGuGMJ+dHf5ti/X9O9yLDu48cLR/lREPr9P
        YGXG+Ih/TqajGVZb/O5/d0tYWoPMVZnY2DyxGXdx7g2VvSZ7om3kx5QgztzpRHWzPZjHOGQ1WGEie
        0FNymOdQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.152])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMD1N-0003cn-9D; Thu, 11 Aug 2022 18:35:11 +0000
Message-ID: <29708eb3-ff1e-411e-cf84-7aa9af765603@infradead.org>
Date:   Thu, 11 Aug 2022 11:35:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Doc fix for dget_dlock
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Anup Parikh <parikhanupk.foss@gmail.com>
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <Yu1HwVoTYOeaCh4v@autolfshost>
 <98fe1c6d-9528-05b5-c603-fb4ae028a19c@infradead.org>
 <CAH6MFJGuHptQ8peBb8myLR8fgtLtAXwvUePcs7dbzYszF9Yyyw@mail.gmail.com>
 <e055ac0c-312d-78cd-dcc9-7c2e80ea3d3d@infradead.org>
In-Reply-To: <e055ac0c-312d-78cd-dcc9-7c2e80ea3d3d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/22 11:33, Randy Dunlap wrote:
> Hi--
> 
> On 8/11/22 07:48, Anup Parikh wrote:
>> Hello Mr. Randy Dunlap,
>>
>> I checked include/linux/dcache.h (dget() and dget_dlock()), include/linux/lockref.h and linux/lib/lockref.c.
>> My current knowledge is limited but I think:
>> 1) dget_dlock() directly increments the count variable without any atomicity guards.
>> 2) dget() does the same but with atomicity guarantee - even across multiple-cores on a multi-core system (according to https://stackoverflow.com/questions/36964478/understanding-synchronization-with-multiple-processors <https://stackoverflow.com/questions/36964478/understanding-synchronization-with-multiple-processors> and code in linux/lib/lockref.c).
>>
>> Please let me know if I should write the corresponding documentation and send a new patch.
> 
> Yes, please.
> Thanks.

also send the patch to linux-fsdevel@vger.kernel.org
since it touches filesystem code.

> 
>> Thanks and Regards,
>> Anup K Parikh.
>>
>>
>> On Tue, Aug 9, 2022 at 11:58 PM Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>> wrote:
>>
>>     Hi--
>>
>>     On 8/5/22 09:39, Anup K Parikh wrote:
>>     > Removes the warning for dget_dlock in include/linux/dcache.h and
>>     > enables generation of its API documentation
>>     >
>>     > Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com <mailto:parikhanupk.foss@gmail.com>>
>>     > ---
>>     >  include/linux/dcache.h | 2 +-
>>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>>     >
>>     > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>>     > index f5bba5148..ce0b36f72 100644
>>     > --- a/include/linux/dcache.h
>>     > +++ b/include/linux/dcache.h
>>     > @@ -297,7 +297,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
>>     >  /* Allocation counts.. */
>>     > 
>>     >  /**
>>     > - *   dget, dget_dlock -      get a reference to a dentry
>>     > + *   dget_dlock -    get a reference to a dentry
>>     >   *   @dentry: dentry to get a reference to
>>     >   *
>>     >   *   Given a dentry or %NULL pointer increment the reference count
>>
>>     Someone was trying to document both dget() and get_dlock() with the same
>>     kernel-doc comment block.
>>     I suppose that you could duplicate the comments for dget() also.
>>
>>     It would be nice to know the difference(s) in the functions as well.
>>
>>     thanks.
>>     -- 
>>     ~Randy
>>
> 

-- 
~Randy
