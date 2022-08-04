Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF365897DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiHDGrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiHDGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:47:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC13AB22
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:47:16 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10e615a36b0so21773986fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ca7aQlVikvTUFlDCLSka/jDf7Ip5XoALj+ESY5PyW7k=;
        b=JDFrv3rzbdtOirKTznQHLZhYF9ipFJmFxhsVyFMFbNnBdmaRKzNAja9YgteJpJIZL7
         K5llGj4dJrWS8/f0EKS29lYKVZRUO+6VOaQcRHmOfoo5Hvc4RFQsHv1M0IPstAJK9v8Z
         ClGHHj5qUBV1IjnY/G4dgqkqE3rL36CEBCinaRMJ47HNLSNi3j+tLxbEKC1k+Ivipun7
         3YtiIbZzZrCcVdOSWCmRhQcPz5Zpt1E5iRl9GFGF5cwMCvtC/cN1AfWUOHqKVe9tKFb2
         9srcqx58Za3Dc2ANI8uZl2hV8tNjJrZ5GiH3+6uOmelSOpt0/FRmVsdE0H8ClsCPKLDK
         glbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ca7aQlVikvTUFlDCLSka/jDf7Ip5XoALj+ESY5PyW7k=;
        b=HpPGGUSCwpmuvu2JZzCcF4BdTwxKfCUm0zBmBoOfn8893rlYSTMeaM68dSnkt1MloL
         1sJ81h0RUf7u71UHZN99VpH+f5UcACr/QlO65JaVwaEWVUrH8Kk5AIkXhJynMXeI5dUd
         v8RsPwgHm+ViUYFVPjVUzdlxgrgvrfyqQrf5zYVRvpZq4FDLyXFGT8DpxyKo5JqmaGNJ
         uQ5CncrdSAOtCusOpaLVi/b+GSHR+SgQJI0rWaxE29M6A/IDgRfS2A5sJxsxVYOBhhQL
         n7/Z6o1QKtf+m8YwKG1ylBF9CPXNN89v6RQB+osNCYgwVMLn4XLVLyzn73cAoZkrv6tV
         GLnA==
X-Gm-Message-State: ACgBeo2i297mbVTKaX7mKHEle9fOPsrQnLzgP8RGnJqHvXR7guPCaUDY
        ixa2HndY/EVCvtUOcatER3E7qJl21h31Tii9metuQjEuvpo=
X-Google-Smtp-Source: AA6agR4tQvKb2Uubhm/nwOmxb1j903tmfGNMDszQ1bBlvxy+Vjxl9Bed3RVvBaM/59T6XmsVMDUruUuc5EiT15lt2Uo=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr149567oaq.166.1659595635853; Wed, 03
 Aug 2022 23:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com> <CAPj87rMSNtqZUbH_5rmGAXpWONKhoZHJsjbw11PwYwXJi0b9jA@mail.gmail.com>
In-Reply-To: <CAPj87rMSNtqZUbH_5rmGAXpWONKhoZHJsjbw11PwYwXJi0b9jA@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 4 Aug 2022 09:46:49 +0300
Message-ID: <CAFCwf12NGpFin3fVrGs=Ca5zqAqztoY5wbyV1WD5vTpZML3LCA@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 2:32 AM Daniel Stone <daniel@fooishbar.org> wrote:
>
> Hi Oded,
>
> On Wed, 3 Aug 2022 at 21:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > The reason it happened now is because I saw two drivers, which are
> > doing h/w acceleration for AI, trying to be accepted to the misc
> > subsystem.
>
> Why misc?
You will need to ask them ;)
Seriously, I guess they thought they were not gpu drivers and didn't
find anything else to go to.
And at least for one of them, I remember Greg and Arnd pointing them to misc.

>
> > Regarding the open source userspace rules in drm - yes, I think your
> > rules are too limiting for the relatively young AI scene, and I saw at
> > the 2021 kernel summit that other people from the kernel community
> > think that as well.
> > But that's not the main reason, or even a reason at all for doing
> > this. After all, at least for habana, we open-sourced our compiler and
> > a runtime library. And Greg also asked those two drivers if they have
> > matching open-sourced user-space code.
> >
> > And a final reason is that I thought this can also help in somewhat
> > reducing the workload on Greg. I saw in the last kernel summit there
> > was a concern about bringing more people to be kernel maintainers so I
> > thought this is a step in the right direction.
>
> Can you please explain what the reason is here?
>
> Everything you have described - uniform device enumeration, common job
> description, memory management helpers, unique job submission format,
> etc - applies exactly to DRM. If open userspace is not a requirement,
> and bypassing Greg's manual merging is a requirement, then I don't see
> what the difference is between DRM and this new bespoke subsystem. It
> would be great to have these differences enumerated in email as well
> as in kerneldoc.
I don't think preparing such a list at this point is relevant, because
I don't have a full-featured subsystem ready, which I can take and
list all its features and compare it with drm.
I have a beginning of a subsystem, with very minimal common code, and
I planned for it to grow with time and with the relevant participants.

And regarding the serspace issue, I believe it will be less stringent
than in drm.
For example, afaik in drm you must upstream your LLVM fork to the
mainline LLVM tree. This is something that is really a heavy-lifting
task for most, if not all, companies.
So this is a requirement I think we can forgo.

Thanks,
Oded

>
> Cheers,
> Daniel
