Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA8583ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiG1I6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiG1I6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:58:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487A65592;
        Thu, 28 Jul 2022 01:58:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c139so1400243pfc.2;
        Thu, 28 Jul 2022 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sszjawbarXDFBNDL6MVd3XJHGuLyws9W8rL+FnR9Zv8=;
        b=Zr6Ld07bY5PNLNgmErOISs3vUW/7RpAxbMYFsBvSU9iRhNS0uq7QrzsMPq2QtiOP2f
         JV7ac7Csj1tZyCpn49IXELH+dGn6H9se5UYZyq2fuvx0OO7iwU+1jc1lMj9RdrIECeoP
         ohmc1DGM4oz0xTw/fbAalH6fyMYC0/DwAloLjXRlEF/MlFDQM3GHdjxiYChJyec3jkjf
         Mzz+yLKAU/hY2Csy3YNYGkJmgILN+Gw3TR/M05oN2xqiwtSYnm3Slr3ZqHuhjZZHWXOm
         p+AdKvshTy3X0Yc7p5YvDXo9WgLu1iGmh5NyoK/KwLl7zhEBp7vcKAmIg63Pju8fHOQI
         VP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sszjawbarXDFBNDL6MVd3XJHGuLyws9W8rL+FnR9Zv8=;
        b=Lcy3o/lyCrIIo0JR17UZK48enVarf/efa11SE1uuf72L8EMnlLkkAJzt742Xo9KFF2
         viC5MrWMlrZ/Aj7Zs4R0LfBcDs+dkMorFyZYxJ7V3UWQFcHQ8l50fv+jxVmM/UA9lQ1V
         eURKwDqpgqSnuXswgOQXEodLcz/r4BbMesGI5m9u2+qClh4EnAy/PocDJIAO6x/FPPAS
         Pe6QTxNohY7Ef7xUU06cCImaLD22O9MEpqpR/13sQ+jQffQasFNKHkhPI8ZthTuDj8/u
         tX1pCWyepKQz1JVFTzd4T6q5QHak82PiqVL5xIz+99+JhtC6l57B7H+BEp02twZK79q/
         ZWKA==
X-Gm-Message-State: AJIora+OKE3yOjP0473lvpnVVTryQ7D82Vu68AfQG/lRQ+JNQ6csLOgn
        srUUfJL+3TvT48QvW1Q1nUQ=
X-Google-Smtp-Source: AGRyM1vSgUqmM8aMJWH02JIKBFzVFYPls5sFHYRDUKXCx3LSYhSP1OXWBP2/oSidSYM3jQWWNv8MKA==
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr22719798pgc.233.1658998682344;
        Thu, 28 Jul 2022 01:58:02 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id h27-20020a63211b000000b0040d48cf046csm505029pgh.55.2022.07.28.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 01:58:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DE9F6104A8A; Thu, 28 Jul 2022 15:57:58 +0700 (WIB)
Date:   Thu, 28 Jul 2022 15:57:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, corbet@lwn.net, hch@lst.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: linux-next: build warning after merge of the dma-mapping tree
Message-ID: <YuJPllC3SHqOR1ez@debian.me>
References: <838314fe-a85d-19be-71b6-264cad7e83c9@deltatee.com>
 <8a3a24b5-1f2f-d2bd-f2c9-2bda9298e23c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a3a24b5-1f2f-d2bd-f2c9-2bda9298e23c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:23:34AM +0900, Akira Yokosawa wrote:
> > Oh, hmm, I thought I addressed this when I added the extra line at the
> > end of the comment, but it seems the htmldocs is a bit fussier than that
> > with the white space. 
> > 
> > The only way I can seem to suppress that error is by adding another tab
> > character in the list; see below.
> 
> I think all you need is to see the reference at:
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#option-lists
> 
> There are examples for long options.
> 

Hi Akira,

I read the reference, and for the long option case, I see:

> --very-long-option  A VMS-style option.  Note the adjustment for
>                     the required two spaces.
>
> --an-even-longer-option
>            The description can also start on the next line.

I interpreted that for the first case above, two spaces separator between
the first and second sentence of option description is required, right?

-- 
An old man doll... just what I always wanted! - Clara
