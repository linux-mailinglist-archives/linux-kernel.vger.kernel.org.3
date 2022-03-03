Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBA4CBA2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiCCJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiCCJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:27:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C35177777
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:26:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u10so5166152wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 01:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XD9Qk7wqWwcBBnal1woY2MwuyfH3dPMdc0t0VTETirY=;
        b=jj835WVBPjikzv763/1NtVdeljcgnFRm5FOwaGSZc6GCkiLqdopn4eNxVgc0lM88CU
         6wYGrTNCaGl7gJc+aeSw4kw1Wt1lfjEC6zfZWwuT1qnqx3iuDHgQOVCwGXnozOiTemUP
         U1XyxFLEiGZbhqne/cs6zBCu4YpWUw9YNFKMtGY5a0Bqq+ctm5Sqn9311q1sw3vzvRmZ
         VFOgmiayzChAbr1GZojk3MdIBFv5ZAKhplEI2KoFgkWCJk8qAS2FMF+Exyp5ks+7nDC3
         FHu0wJsNgF9H5ddJrHozE/Sm5zs0B7klNLEpCuXp2RRkfiRqNQisi4mBWZodsJ0kvVAQ
         F6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XD9Qk7wqWwcBBnal1woY2MwuyfH3dPMdc0t0VTETirY=;
        b=DEOOGbX+g20xMsuZok+o968fg7cHzdptNIW1kNJ/CL7DXDtFMMJHMECbrX0bu/o7JT
         L2hI8Ei/MvIyfOkG0CjTHEW1xu44EDw8GcRpDZdvOl+6gpiYkI0iiXjv2t5OdPb5gehG
         6hL8WIi4nBLxQlqvMmr3Z70FQFeQVWLG5R++xI1WiYs8WGCh/QDEkg5g3cZ0Tbem8Fi3
         x/ZyQYVL/OZ6qLvtoh+12XpyrFUX7TobeDfcJAbSweNj+MxxowQ6Q5FMpwgt/DW3VXns
         usERkzzAb0dQ/n0VwufjThk6OWufe7oMFBiCzcOfZZlI39obQs3O0EwxsPXIZlQl1ZvQ
         zDXQ==
X-Gm-Message-State: AOAM532Sy5/wnqfp0FjshIvYnwH3RwugAxUSZsn0dT4iUEqVcG/CPrd5
        hJnor5/kET3vOETR3MbeN7XftweRbEn4UQ==
X-Google-Smtp-Source: ABdhPJx2HXvmM5stsWnyAmNP0pTWtWtHiqNK9H8dv04kF9EeQSaBSSpSVjPr2ARfe8ppmjkrCK04dA==
X-Received: by 2002:adf:c3cc:0:b0:1ed:b641:6ee2 with SMTP id d12-20020adfc3cc000000b001edb6416ee2mr25715767wrg.529.1646299579701;
        Thu, 03 Mar 2022 01:26:19 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b0038167e239a2sm1739485wmq.19.2022.03.03.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:26:19 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:26:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/1] sign-file: Use OpenSSL provided define to compile
 out deprecated APIs
Message-ID: <YiCJuPTfea5nf1G+@google.com>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <YVyE3Ax1PRtiBwf+@gmail.com>
 <CAL9PXLws4DjvPB=1KNpom3W52pXNauXQ4V==MprDx73YQ1-sgg@mail.gmail.com>
 <YVyKc51r2tfMmQuO@gmail.com>
 <YVyVNkijABL7CxnM@google.com>
 <202203021251.1DB0383C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202203021251.1DB0383C@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2022, Kees Cook wrote:

> On Tue, Oct 05, 2021 at 07:11:02PM +0100, Lee Jones wrote:
> > On Tue, 05 Oct 2021, Eric Biggers wrote:
> > 
> > > On Tue, Oct 05, 2021 at 10:14:58AM -0700, Adam Langley wrote:
> > > > On Tue, Oct 5, 2021 at 10:01 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > > I ran into these same -Wdeprecated-declarations compiler warnings on another
> > > > > project that uses the ENGINE API to access OpenSSL's support for PKCS#11 tokens.
> > > > > The conclusion was that in OpenSSL 3.0, the new API for PKCS#11 support isn't
> > > > > actually ready yet, so we had to keep using the ENGINE API and just add
> > > > > -Wno-deprecated-declarations to the compiler flags.
> > > > >
> > > > > Your patch just removes support for PKCS#11 in that case, which seems
> > > > > undesirable.  (Unless no one is actually using it?)
> > > > 
> > > > The patch removes support when OPENSSL_NO_ENGINE is defined, but
> > > > that's not defined by default in OpenSSL 3.0. (Unless something
> > > > changed recently.)
> > > > 
> > > > When OPENSSL_NO_ENGINE is defined, ENGINE support is not compiled into
> > > > OpenSSL and the headers don't include the functions:
> > > > https://github.com/openssl/openssl/blob/master/include/openssl/engine.h
> > > > .
> > > 
> > > Okay so this patch is actually a build fix for when OpenSSL doesn't include
> > > ENGINE support?
> > 
> > Correct.
> > 
> > > Currently this patch claims that it's removing the use of a
> > > "deprecated" API, which is something entirely different.
> > 
> > I see your point.
> > 
> > Happy to rejig the commit message if that would help.
> 
> *thread necromancy*
> 
> Hi,
> 
> These warnings are quite noisy on Fedora rawhide and other distros that
> have moved to OpenSSL 3.0. It's not clear to me from this thread if this
> patch is actually the correct fix?

I believe it is the correct fix.

However the commit message seemed to cause Eric some confusion.

Would you like me to resubmit?

It would be nice to get some input from the maintainers at one point.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
