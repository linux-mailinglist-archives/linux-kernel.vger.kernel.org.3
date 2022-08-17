Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4765979B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiHQWhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiHQWhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:37:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A2DFF8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:37:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h24so3654824wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SDWaMYet1cn5tTWa6VqUAIapnHAkbX2SDmUgYWXOSHQ=;
        b=cJxcIgHOBjsIi8gQTDFbQJXNLH8MW+M32YQkEB+DYuv45XL3SHfOUhyrJR2eFdg9Ug
         3oNF7fbSC3YoXOWhAX6v0zOkBYybOX4KeVpj+jeynKFCxnE7DdXC4Qd1AUWtyd2I7X7o
         DrjgdqeikaFxhoNNUV5rPAN8wdxMB11w7cVNDKH8XfAOT1swzWWXKux+fY0i/Pacbt86
         YnnUHnfPOa0rt4tsssRtUqwSF9xZV41jzBQkN+XEDIETiQIISR84iqWFhWAoEJsU46bv
         Bg1v3K6luUz7xwmajDS7BKyfMSVNZvpJnlzTyq5txQ5rzZpNoFy+1p7ZXVo9QM6VJ+pZ
         sv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SDWaMYet1cn5tTWa6VqUAIapnHAkbX2SDmUgYWXOSHQ=;
        b=eZzP7auwMSSzo91tQtN/AUB+ohXdv+QKB/MseNa2WxZxwg+pd5DzQdeo7HTSYr8KBW
         BBsMuoMORuipiWsg3LCgOFpp1iLqYuTNuOkS6CMogbcxm3jvIBa9kXE5LK/dWZNTe4i0
         W5y/mVaYGejyFndBotyJPjijhCJYtBOFpaohgIgwgvy4XR3PyXAAcR5xjwm2t5kznj0d
         GrDTxx/tk3E86EYk3ZvNXymtCcCdPa2IHsypg9icA4/yzhWvtwWjllk3z7WUxXHRhuB/
         1nTX2BhdvaYeuiidSedmiavpDr1PbasYRnlY8Um1xRTEK48Pxr+qYxPI3LYYgKZyY3lO
         as9A==
X-Gm-Message-State: ACgBeo0QJfxCwx1X+1e4NEQOP43Oslm+tBrjVjbxfhU02t8EXY4jJVSb
        ANVHa6CYIxQguOqL7k8AtFBxdnphzsl7xhT7kuO7UA==
X-Google-Smtp-Source: AA6agR7VMDNZbYWKatEL6Cfs9SEadTLGRVhpnty9dD9OCHq0q7S2hhqr9nNasHiLuHl7J5tDftalULQOl09bMVeq0hE=
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr83226wry.654.1660775821832; Wed, 17 Aug
 2022 15:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org> <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
 <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net> <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
In-Reply-To: <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 Aug 2022 15:36:49 -0700
Message-ID: <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 17, 2022 at 3:13 PM Chuck Zmudzinski <brchuckz@netscape.net> wrote:
>
> On 8/17/2022 3:52 PM, Chuck Zmudzinski wrote:
> > On 7/26/22 4:43 PM, Ian Rogers wrote:
> > > On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
> > > > > On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
> > > > > >
> > > > > > On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > > > > > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > > > > > > The distro doesn't upgrade from python2 to python3, this causes the
> > > > > > > > building error that the python script is not python2 compliant.
> > > > > > > >
> > > > > > > > To fix the building failure, this patch changes from the python f-string
> > > > > > > > format to traditional string format.
> > > > > > >
> > > > > > > Thanks, applied.
> > > > > > >
> > > > > > > - Arnaldo
> > > > > >
> > > > > > Leo / Arnaldo,
> > > > > >
> > > > > > Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> > > > > > ELRepo Project) experienced when attempting to build on RHEL7.
> > > > > >
> > > > > > So --
> > > > > >
> > > > > > Tested-by: Alan Bartlett <ajb@elrepo.org>
> > > > > >
> > > > > > Hopefully you will get it to Linus in time for -5.19 GA.
> > > >
> > > > > So I'm somewhat concerned about perf supporting unsupported
> > > > > distributions and this holding the code base back. RHEL7 was launched
> > > > > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > > > > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > > > > Maintenance Support 2" phase which is defined to mean [2]:
> > > > >
> > > > > ```
> > > > > During the Maintenance Support Phase for Red Hat Enterprise Linux
> > > > > Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
> > > > > Linux version 7, Red Hat defined Critical and Important impact
> > > > > Security Advisories (RHSAs) and selected (at Red Hat discretion)
> > > > > Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
> > > > > become available. Other errata advisories may be delivered as
> > > > > appropriate.
> > > > >
> > > > > New functionality and new hardware enablement are not planned for
> > > > > availability in the Maintenance Support (RHEL 8 & 9) Phase and
> > > > > Maintenance Support 2 (RHEL 7) Phase.
> > > > > ```
> > > > >
> > > > > >From this definition, why would RHEL7 pick up a new perf tool? I don't
> > > > > think they would and as such we don't need to worry about supporting
> > > > > it. RHEL8 defaults to python 3 and full support ends for it next year.
> > > > > Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
> > > > > this in future. I think the bar for caring should be "will the distro
> > > > > pick up our code", if we don't do this then we're signing up to not
> > > > > allowing tools to update for 10 years! If someone is building a kernel
> > > > > and perf tool on RHEL7 then they should be signing up to also deal
> > > > > with tool chain issues, which in this case can mean installing
> > > > > python3.
> > > >
> > > > In this specific supporting things that people report using, like was
> > > > done in this case, isn't such a big problem.
> > >
> > > So there are linters will fire for this code and say it is not
> > > pythonic. It is only a linter warning vs asking to support an 8 year
> > > old out of support distribution. There are other cases, such as
> > > improving the C code structure, where we've failed to land changes
> > > because of build errors on old distributions. This could indicate perf
> > > code is wrong or the distribution is wrong. I'm saying that if we
> > > believe in the perf code being correct and the distribution is out of
> > > support, then we should keep the perf code as-is and the issue is one
> > > for user of the out-of-support distribution.
> > >
> > > > Someone reported a problem in a system they used, the author of the code
> > > > in question posted a patch allowing perf to be used in such old systems,
> > > > doesn't get in the way of newer systems, small patch, merged, life goes
> > > > on.
> >
> > Considering the proposed patch, can you be sure that replacing the
> > f-string format with the legacy format won't cause a regression for
> > some python3 user somewhere when this hits the real world? Even
> > if it does not cause a regression today, as new versions and features
> > are added to python3, can you be sure none of those new features
> > will depend on the upgrade from the legacy format to the f-string
> > format here to work properly? So many regressions happen because
> > the people who write patches cannot possibly foresee how their
> > patch is going to affect the millions of Linux users out there, but still
> > they are certain it will not cause a regression somewhere. So how
> > can the chances that this patch will cause a regression be minimized?
> >
> > It seems to me for this to be suitable for the Linux kernel, the
> > default should be to use the modern python3 format and only
> > enable python2 compatibility via a sysctl setting and/or kernel boot
> > option for those who are still using python2. There should be no
> > change to the behavior of the kernel for users who have upgraded
> > to python3. But I don't see any such consideration for python3
> > users in this patch.
>
> Sorry, I didn't see this is a script, LOL! So obviously a sysctl or boot option
> does not apply. But can't the script implement this simple logic:
>
> If python version = 3 use f-string format
> if python version = 2 use traditional string format

Doing this in the script would be noisy, having two scripts less than
ideal. I'd suggest we wait two weeks, declare the official death of
RHEL7 without "rpm -i python3" and then revert the python3 to python2
patch. There are plenty of things to worry about and python2 shouldn't
be one of them (it died over 2 years ago).

Thanks,
Ian

> Best regards,
>
> Chuck
