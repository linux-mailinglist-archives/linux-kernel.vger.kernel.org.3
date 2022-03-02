Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81E4CA03B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiCBJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbiCBJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:03:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460E19C0D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:02:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bd1so992868plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4uOo5MHkeQgzq17T9YFrhDC6UuQ0Je/UgBAobCZK4Y=;
        b=NB7oDpZG1zrTleofPpyTpCvySKZckLxHjXrTodWOnM02cHwTokRsxQhz226NYS51v8
         weGGODXATipQwe9eixdr8HjDeI4Z+E/d1z/gYlGrU4gcOcTdmd1zN5D5Vdl2M9SN7nj8
         je5N326XMvsXKjl9kXGyQ4SDYHmobI8tYA++cuEK7Iovn8qXcU6Gx8Cvc+D2nQaZuS1C
         Oh0X1R9UOjS1m0PoPboOEd0zdg4arkp+74+rfb2E8wtXiwcr+heiI8swox8UyoSn9i26
         FtZlGTbNgxrKSVdvnCQx0C/lFtWfTr/T4AM8Eyvcs4k5qM7+3L5cMBclXPv5Qwg2Kjz6
         utJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4uOo5MHkeQgzq17T9YFrhDC6UuQ0Je/UgBAobCZK4Y=;
        b=MbKEjciZZfM3dDu2ejnafvV7xf+ruTo/2j0UQ8yRH53/1LFv19dTHlv3VE1KnOQAJo
         boRLJJOdIUxATnFUz6zk5CHvZW5Awl2YhKzTJuVckw7dmJrvGH/soSCa/TrQ8a0EwHKS
         dfYl6ozdgUxyLchInkwUE9Od3WhP8Zrz6oRLWQsgp2kfMWSQ+oZjyRUu/5xjGRKZmOTP
         5jSvuPoIbqFIbdxL24g5yNgnksuJXhatsapEw1uvJ1dFyfkCWHrKnata9l0SwEIe9Avq
         62aDp92iDp0kQvOv0GDl0iaEbD7efIzZq5ZccaO/a+74bbYZl84exreEQhbN6cEstPCQ
         pj2A==
X-Gm-Message-State: AOAM532dymxMdLS4nkN7X5Sz8ry94eq1MehwUagidmGQQ77uuR2zrW/a
        Vxbu6t4a6Dzfzo1uDXUroT0=
X-Google-Smtp-Source: ABdhPJwnq5VviDuQV2d+MxqmT3gBbwUOhuOZU5vyoHoOiukTwPepAlMDov6Mb6n6JDegnvyNa5Gr5A==
X-Received: by 2002:a17:90a:1d04:b0:1bc:98ca:5e6f with SMTP id c4-20020a17090a1d0400b001bc98ca5e6fmr26362307pjd.32.1646211773654;
        Wed, 02 Mar 2022 01:02:53 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id q8-20020a056a00088800b004bca31c8e56sm21461840pfj.115.2022.03.02.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:02:53 -0800 (PST)
Date:   Wed, 2 Mar 2022 22:02:46 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, paskripkin@gmail.com
Cc:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: prevent uninitialized data from being
 printed out
Message-ID: <Yh8ytrK7EJjYbrHF@mail.google.com>
References: <Yhmruyr2BUn0+3O3@mail.google.com>
 <593b1840-aba1-3fcb-daef-9cc0011d0805@gmail.com>
 <20220228064415.GB2794@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228064415.GB2794@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:44:15AM +0300, Dan Carpenter wrote:
> On Sat, Feb 26, 2022 at 04:08:48PM +0300, Pavel Skripkin wrote:
> > > Patch dependency:
> > > 
> > > - this patch depends on the following patch to be applied first as
> > > both of them change the same file:
> > > https://lore.kernel.org/lkml/Yhla4a1Clpguoo2h@mail.google.com/
> > > ---
> > 
> > You can send all these patches as a patch series with proper order. It will
> > help maintainers to not break the order while applying.
> > 
> 
> 1) All what Pavel said is true.

Hi Pavel, Hi Dan, 

thanks for taking the time to review my patch (and apologies for taking
this long to reply back to you guys).

This patch ended up being merged yesterday so I will be extra careful
for the next patches I send :)

> 3) Greg is going to see that and he is *never* going to click on that
>    link.  In staging then we do not care about the order of patches.
>    Everything is applied in first come first serve basis.  If Greg finds
>    out that order matters and it is not sent as a patch set then he
>    just deletes all your patches and asks you to resend everything
>    correctly.

Noted.

Best regards,

Paulo Almeida
