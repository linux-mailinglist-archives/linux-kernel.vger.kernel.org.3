Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3259C9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiHVUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiHVUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:12:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF39543CB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:12:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f17so5262729pfk.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=EnKbvX9xMcUF8bvw923k4bLQbt044bTDeeYvXJD7Czs=;
        b=ZRBjLD5DfpCjiGPnLVcp8T95oJyFpcwl/FshmKOsc5f+ipkEpmrxPMkPmtNGASxBXZ
         t3eX8tLsBzZOra5EHFU340BNRI7sV3qioe6iMcHKeW4bNdir3ZUqQgW9oBK5xwc1tPDl
         t+obqjrxd4v8QHRJ6GR08bTFPAwtZz789dhwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=EnKbvX9xMcUF8bvw923k4bLQbt044bTDeeYvXJD7Czs=;
        b=JHi/U2LRzSkv6qaVYikbQdSrKie27gg6UfpHVxdnaMbGJzp8QYqdsDP1m9f5PZthKU
         nkiyQ7r1l2evU8d47VXX48wfZ8yFLdPtQ4OE6Y+YVbV/SpK0W/F1OUxQwLBqx2+hYpPY
         R8jCt36bsDcQhvS3wFXyXkS26GLDa9OOm01zodOegIlfObAcEJSG27RaZOcJ4kSV9Uz6
         9LXLH9wTWz1Wz4XSKEhAgnhPc2qtnkk2ZmQdGc3gk4oU8jdQtCAE0T+YSh606vntSHjz
         p9ORn54M/8tDSGIIST2/phK1Or1WJYrTNNFUOvKotn3DWJoX4qB8J0o39iv8nEyrdKa5
         cK6Q==
X-Gm-Message-State: ACgBeo3vS9qLJZ5hDmCYCZZzBE2QZNsY+9gs5Sukbj1gdIe7o9amHKUg
        6THrA5g3LmlF5Kon0zOeWxUQcw==
X-Google-Smtp-Source: AA6agR5G+bqfudvWxfo80uSnqhz04LgJNbj8hzZj4TJPUbvcxTt36OI0WWl0Nwrzjkz/NDeeRDq2IQ==
X-Received: by 2002:a63:5252:0:b0:42a:9680:bd9c with SMTP id s18-20020a635252000000b0042a9680bd9cmr7772626pgl.469.1661199152102;
        Mon, 22 Aug 2022 13:12:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b0016d6963cb12sm8773868plh.304.2022.08.22.13.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 13:12:31 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:12:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
        airlied@linux.ie, linux-hardening@vger.kernel.org,
        matthew.auld@intel.com, mchehab@kernel.org, nirmoy.das@intel.com,
        Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Subject: Re: [PATCH v7 1/8] overflow: Move and add few utility macros into
 overflow
Message-ID: <202208221301.366A33DACA@keescook>
References: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
 <20220816093525.184940-2-gwan-gyeong.mun@intel.com>
 <Yv10sQADwdZrIV42@alfio.lan>
 <202208171657.63AE7AC@keescook>
 <f3370fb1-5318-c662-294b-2c7fe693efd6@intel.com>
 <52c09fde-f788-4c2b-efdc-d1783dbc0f6c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52c09fde-f788-4c2b-efdc-d1783dbc0f6c@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 04:32:10AM +0900, Gwan-gyeong Mun wrote:
> On 8/22/22 11:05 PM, Andrzej Hajda wrote:
> > On 18.08.2022 02:12, Kees Cook wrote:
> > > On Thu, Aug 18, 2022 at 01:07:29AM +0200, Andi Shyti wrote:
> > > > [...]
> > > > > +#define safe_conversion(ptr, value) ({ \
> > > > > +    typeof(value) __v = (value); \
> > > > > +    typeof(ptr) __ptr = (ptr); \
> > > > > +    overflows_type(__v, *__ptr) ? 0 : ((*__ptr =
> > > > > (typeof(*__ptr))__v), 1); \
> > > > > +})
> > > 
> > > I try to avoid "safe" as an adjective for interface names, since it
> > > doesn't really answer "safe from what?" This looks more like "assign, but
> > > zero when out of bounds". And it can be built from existing macros here:
> > > 
> > >     if (check_add_overflow(0, value, ptr))
> > >         *ptr = 0;
> > > 
> > > I actually want to push back on this a bit, because there can still be
> > > logic bugs built around this kind of primitive. Shouldn't out-of-bounds
> > > assignments be seen as a direct failure? I would think this would be
> > > sufficient:
> > > 
> > > #define check_assign(value, ptr)    check_add_overflow(0, value, ptr)
> > > 
> > > And callers would do:
> > > 
> > >     if (check_assign(value, &var))
> > >         return -EINVAL;
> > > 
> Yes, I also like check_assign() you suggested more than safe_conversion.
> As shown below, it would be more readable to return true when assign
> succeeds and false when it fails. What do you think?

No, this inverts the style of all the other check_*() functions, so it
should remain "non-zero is failure".

> /**
>  * check_assign - perform a type conversion (cast) of an source value into
>  * a new variable, checking that the destination is large enough to hold the
>  * source value.
>  *
>  * @value: Source value
>  * @ptr: Destination pointer address, If the pointer type is not used, a
> warning message is output during build.
>  *
>  * Returns:
>  * If the value would overflow the destination, it returns false. If not
> return true.
>  */
> #define check_assign(value, ptr) __must_check_overflow(({	\
> 	typecheck_pointer(ptr); 		\
> 	!__builtin_add_overflow(0, value, ptr);	\
> }))

Please don't use the __builtin*s, instead stick to the check_* family,
as they correctly wrap the builtins and perform type checking, etc. As
mentioned, check_assign() should just be:

#define check_assign(value, ptr)    check_add_overflow(0, value, ptr)

I don't think any of the other code is needed? What's the use-case for
the other stuff? i.e. Why does anything need overflows_type()?

-Kees

-- 
Kees Cook
