Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5301A4ED967
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiCaMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiCaMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:12:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F61EA289;
        Thu, 31 Mar 2022 05:10:32 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-df22f50e0cso7853899fac.3;
        Thu, 31 Mar 2022 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMLH4roAssjYlqt9tXdE/1yhUcCtf54ytNBqcciXIlM=;
        b=ijUCtOM1m7OVkDb45cGiWdBHuwTxDGwfxBnUwPRC7Q1GuaBWYJJ84njX/3Z25x3GSr
         YfEYYMSpdZI/Z/eDfTbYg3rOnsgZCm1mXxZFCTLRt82RVayttX4XtuYMNgNGX8kfSdH0
         LutWf5upxYJPzKRymQvj9WrsefH68XJtF68wZ8VWkklhRaxoNASjbb2wbLO++plJQToG
         3o1gNdNICkrS07zCMwwCiTKMy6SbfeEmu9zRhQNNO+G+nmNRS3kL7db2aPEQrhuHXANd
         Yk092aFTrKJxizm62StO2coJTxXptU0L9HkdjxFfesC1HC3id8m0pHEYauQfWfFviwmH
         rXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMLH4roAssjYlqt9tXdE/1yhUcCtf54ytNBqcciXIlM=;
        b=lHXfgI1Y7AnOUZOyJhfQkF8Uf8nlbj/67eyFgQs+DovGwXvUgE9zcukmoIa/oS2HCy
         9CL7UWJBBt7h/zMIV17a6Xez/iXbZA1+Iwy7o63AZFnhd0z0ajvw+ySCQsPP3/JZTQWl
         w66Y17PgnKptixagGWxhuP/cT8eFTaoag8LnUF0QivZBcoYYRHs3uMNvEqbQfg+Qu9Fb
         XBBwNw3AWsMp+nG7jJLsbzRB29w1AmiGlDkoW9duSBxbTxTutKoczICsRT1OgDCxXuzk
         WDrJR7HHOLBZ2hcBDiqE05/Chp2pI4AdkU2URUW4tHwfaxPVawSeQwrT8O2bo5qzV1F+
         /4Pg==
X-Gm-Message-State: AOAM5337YHLGvVN/hVF5GvypCNDgadvM3F79FhcTWFq0EBcaaCIEtm9x
        O/U5OQG8s1KFAjicm2adFgsHcZYiiHr8yg==
X-Google-Smtp-Source: ABdhPJwn78KkNRG8XbMBkWr82a2KaLcdLc7slrebULAC9oc6l6CKGpxbuISsQmNj7yszzscXqH2tiw==
X-Received: by 2002:a05:6871:85:b0:d9:ac7a:7a5a with SMTP id u5-20020a056871008500b000d9ac7a7a5amr2499111oaa.9.1648728630062;
        Thu, 31 Mar 2022 05:10:30 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1500:3a00:7d51:e2a5:f339:2aa7])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm2978034oot.14.2022.03.31.05.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:10:29 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:10:23 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        dlatypov@google.com, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Subject: Re: [PATCH v3 1/2] Documentation: dev-tools: Add a section for
 static analysis tools
Message-ID: <YkWaL26K7UjKB0sa@marsc.168.1.7>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
 <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
 <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On 03/31, Dongliang Mu wrote:
> On Thu, Mar 31, 2022 at 12:07 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Complement the Kernel Testing Guide documentation page by adding a
> > section about static analysis tools.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> > Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> > Change log v2 -> v3:
> > - Added Julia's acknowledgment tag
> >
> > Change log v1 -> v2:
> > - Brought generic tool characteristics to the intro paragraph
> > - Made explicit that these tools run at compile time
> > - Added a note of caution about false positives
> > - Updated Coccinelle info to make it sound better and be more skimmable
> >
> >  Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > index 65feb81edb14..b5e02dd3fd94 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
> >  Some of these tools integrate with KUnit or kselftest and will
> >  automatically fail tests if an issue is detected.
> >
> > +Static Analysis Tools
> > +=====================
> > +
> > +In addition to testing a running kernel, one can also analyze kernel source code
> > +directly (**at compile time**) using **static analysis** tools. The tools
> > +commonly used in the kernel allow one to inspect the whole source tree or just
> > +specific files within it. They make it easier to detect and fix problems during
> > +the development process.
> > +
> > +Sparse can help test the kernel by performing type-checking, lock checking,
> > +value range checking, in addition to reporting various errors and warnings while
> > +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> > +page for details on how to use it.
> > +
> > +Smatch extends Sparse and provides additional checks for programming logic
> > +mistakes such as missing breaks in switch statements, unused return values on
> > +error checking, forgetting to set an error code in the return of an error path,
> > +etc. Smatch also has tests against more serious issues such as integer
> > +overflows, null pointer dereferences, and memory leaks. See the project page at
> > +http://smatch.sourceforge.net/.
> > +
> > +Coccinelle is another static analyzer at our disposal. Coccinelle is often used
> > +to aid refactoring and collateral evolution of source code, but it can also help
> > +to avoid certain bugs that occur in common code patterns. The types of tests
> > +available include API tests, tests for correct usage of kernel iterators, checks
> > +for the soundness of free operations, analysis of locking behavior, and further
> > +tests known to help keep consistent kernel usage. See the
> > +Documentation/dev-tools/coccinelle.rst documentation page for details.
> > +
> > +Beware, though, that static analysis tools suffer from **false positives**.
> > +Errors and warns need to be evaluated carefully before attempting to fix them.
> 
> Hi Marcelo,
> 
> Should we include static analysis tools based on LLVM? For example,
> Clang static analysis.

I think that would be a good addition. I haven't checked out Clang tools
though, so it would take me a bit more time to write something about that.

> 
> > --
> > 2.35.1
> >
