Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69E508441
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350917AbiDTI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377066AbiDTI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:58:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A6275DA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:55:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f38so1671305ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg9pk+UetrJINR/IXCMEPG27A8smwJ173reatbpWnAs=;
        b=RKGpXYNpP24XtTR4/S4cQ942FUxjDpwKFB8z7WktTDA/o5j7xt0+rqLXREu9FZkzh5
         h8joGkLLcty+NEeVXYtVCA8B6KNC0JQn03vjJ7t8l4RZMr5pGjlcuS3+SHXgepofXzDH
         /43GRsEvWkC27rdtNg3C0KLSE+LLDHNgiTlueM9ZBiJPL0hg0HAV/wivTDHaifgGqGYz
         pvixG4ZI+a3ItSUFrI4R4tY5WyGEtT0yU1DqGy5e3O7KfYeJFdmnPm5z6XVnn+BcaaSx
         RguT/WuPwGMx8tPOX8c+VXnfPpR0ivwrv7xOh/MTiPQv8UN/U09H5d1NPr5XJFIOoDya
         pesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg9pk+UetrJINR/IXCMEPG27A8smwJ173reatbpWnAs=;
        b=p7U8rN3GYpId0yjAngEqYNQP7bbWGR3eTUeK8IKyYu91HqugMdVNwfM0K+4HsepHSb
         Ihsc9U9Htx5l6hm0yYNh9/u+jiv8VXkpvq1g8vbsBaTSbne2kjM4/PPVYVTday3L9EEF
         DtHtVkcLZzxDjTdJhq4J/hyubqmINAbbGtj6P2ttTKbT5KhkgdEOyfD0BD8DR8nc5Ojv
         7hxni9Y89bj79q8a1ksAsxrpxxKMJU7M2BczCXu6UPbV4a+vUFOVnNQVQkTD5ShA21Gl
         rVbjLvuOFJx+tstVWt2X84UiGdtyjzJNHbrH0GbMpdE16QnCkEoi/g16oAx81+qee4wb
         JQHw==
X-Gm-Message-State: AOAM530hAHM3IRzp6wSkfgXa7Ze5bvfT5u5cJr4PfQ2CWIyniPvguT4M
        pVsaQZRY+LFl1oXjr9BMMjiP8wPAERrlOXs3IZDQT8urpp7gGLXN
X-Google-Smtp-Source: ABdhPJxj0m+Aw0X4pkRg4HKI8GUsfzdFulsnkJdqL8oCaQwbEwUCxyM4Tdg93dIlfVARmMSQI9Xv9KtdgoL5ZOXbGss=
X-Received: by 2002:a25:c094:0:b0:641:10e0:cfd8 with SMTP id
 c142-20020a25c094000000b0064110e0cfd8mr17714675ybf.88.1650444943184; Wed, 20
 Apr 2022 01:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
 <Yl8GInPZyl2PqK7D@shell.armlinux.org.uk>
In-Reply-To: <Yl8GInPZyl2PqK7D@shell.armlinux.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Apr 2022 14:25:32 +0530
Message-ID: <CA+G9fYvRdg6t6OnoJy62Vte5XnSymyL6B6kARC_1Jao52h6ZYg@mail.gmail.com>
Subject: Re: [next] arm: boot failed - PC is at cpu_ca15_set_pte_ext
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        max.krummenacher@toradex.com, Shawn Guo <shawnguo@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 00:28, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Apr 19, 2022 at 04:28:52PM +0530, Naresh Kamboju wrote:
> > Linux next 20220419 boot failed on arm architecture qemu_arm and BeagleBoard
> > x15 device.
>
> Was the immediately previous linux-next behaving correctly?

This crash started happening from the next-20220413 tag.

- Naresh
