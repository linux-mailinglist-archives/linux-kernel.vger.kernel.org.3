Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63667502DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355812AbiDOQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354079AbiDOQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:23:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B39E9E9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:20:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so14666401lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBexj3eQsZ3wqG1HL5nZa5jhi+e1ylFf5sIYb7x7L1I=;
        b=lyJP4p0/jTYul0L7lAjkhp1x44jUqCwvtCr08WvTa6Wqh6aKOdBE87Mfec1WJaP2uE
         4Dq4pu8IkavHpAxUT6GKabeIGzkQqgVuAIlfyToWC7pWqLSXwj2hE888qZJJu1Q3DAjN
         drPpFeFdvPi+4WmjvdD1BhjcgY+QaPsGSWhbIY1E+55M10pBPjDuH3w/p6j4/4X5wbeo
         G2u3zFHxaL/HxCuWzoiatweF31uhkMLF0xo2JrwPEPmdMiyIC6iB8C9jmBwRyoXaRB1H
         yoQR8IpsNm7npG5MUVn0g/jn9UhMb2yhQF6shscDSV0nKbJF/GnJQbk4bUOFo234pkR0
         wcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBexj3eQsZ3wqG1HL5nZa5jhi+e1ylFf5sIYb7x7L1I=;
        b=Osd54YDw67ToQU9UXD2Qnp4+uDN7B7BOtMnu6PGzFCkF3wy9mPkuGbjUGIuNWkKvbh
         ubvxvg4CllW3IkgsVXFsCABZTmVgatRKjdZVPZelKKbJSAmwAEWl/JaSSnhPXzD8ki8R
         q93kk/Hsqvb9D7h8l/SklP+WuBVK2IHZMqkHw7WjK7UAzdkiQ3M6bU+zTJ5T/vkVAJJP
         hSDu2SvTUlcxGY/p3OrLA1g71KB+zC4EjL8R6taomlcdnC1HSYnJo6qZeP58ohcA0MFp
         kl+jr3pe93NcHS7FZrA/y0RJ/7CM088HfAt17l+cS/KcZfcP4afZxvFL5HMMsk+1oqGQ
         zjpg==
X-Gm-Message-State: AOAM531oHZhLxMd+1xqXkp0ykT3kJLtIP8OODNyrvcp7iHnahxQl3/ce
        NLEMR4ku7Nf1Tj7XtaKIDOfAuSJ9Gx6ERlmwMGYzyg==
X-Google-Smtp-Source: ABdhPJyrpFklWSsc8st0wbc04Hdn0wEal7J3pt97tatylqke3ynq/jSAqqktjaRPn62ybtQahD24pOa4QhxwQAYgQw8=
X-Received: by 2002:a05:6512:687:b0:46b:8d08:36da with SMTP id
 t7-20020a056512068700b0046b8d0836damr5435405lfe.402.1650039652290; Fri, 15
 Apr 2022 09:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220414162325.1830014-1-jackyli@google.com> <fe209f25-6119-cc26-2608-8aaccf11ac36@amd.com>
In-Reply-To: <fe209f25-6119-cc26-2608-8aaccf11ac36@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 15 Apr 2022 10:20:40 -0600
Message-ID: <CAMkAt6pyDQaqLCRzJWow6hgtyMrAtarPri9yUWBgMPPuucm77A@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: ccp - Fix the INIT_EX data file open failure
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 7:49 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/14/22 11:23, Jacky Li wrote:
> > There are 2 common cases when INIT_EX data file might not be
> > opened successfully and fail the sev initialization:
> >
> > 1. In user namespaces, normal user tasks (e.g. VMM) can change their
> >     current->fs->root to point to arbitrary directories. While
> >     init_ex_path is provided as a module param related to root file
> >     system. Solution: use the root directory of init_task to avoid
> >     accessing the wrong file.
> >
> > 2. Normal user tasks (e.g. VMM) don't have the privilege to access
> >     the INIT_EX data file. Solution: open the file as root and
> >     restore permissions immediately.
> >
> > Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> > Signed-off-by: Jacky Li <jackyli@google.com>
> > Reviewed-by: Peter Gonda <pgonda@google.com>
>
> Looks good, just a quick question. Should there be any type of access
> checks before switching credentials? Should we check access to /dev/sev or
> such? Or is the capability to load the module enough?

I thought this was fine because regardless of if an admin sets
psp_init_on_probe=true or false, their intention is that people who
have rw access to /dev/sev can use the commands which require the PSP
to be init. In the case of psp_init_on_probe=false only rw users can
cause the file to be created. The case of psp_init_on_probe=true seems
a little less clear to me but if a user can modprobe ccp that seems
like sufficient privilege to create the file. What do you think, Tom?
