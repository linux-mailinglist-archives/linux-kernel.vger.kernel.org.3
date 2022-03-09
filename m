Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D124D3AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiCIUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbiCIUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:00:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A92E3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:59:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e3so3153527pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qY0faMoU6BxNREoouDEmmFkWjqNRWbbfGDDwPhgFlaA=;
        b=ivyOe9HAmFp+PudsjkLZ5tKnlEZ4emhasp+yGMoOTg2U2ZJIqZkPIaXk1sql1I9WK/
         nUQOffCU0ssrR/N1lWHZbUwROdhkUx1NUNSBwt2M8X/x7LR6luljUNwitO9CtXykihEV
         7kMFECvdyoBIRJtwymkhM3klne+juuikdSIPpr4gNHAkjhB3bjU74tx0mu7aEZVFWwbD
         84UlWp9k042Z8eHBdTXX0QlWCXBn+wKUPfpEmZeHi+kLP8NdiYFPshaM0E0/HqMx5RqT
         ep+KpE+k3C30Da7hHMeIZR2O29RGOwYnk4gzbgAodkdGpUcAefZkLPIMO8V8FjE+ryc6
         PukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qY0faMoU6BxNREoouDEmmFkWjqNRWbbfGDDwPhgFlaA=;
        b=HXIgVJclRE3K32Oi4vEUzoYWHQsw05VathYnYS0thkwaG4+eDJbOk//Ca3/904yGIp
         9TS110KTPTNCwER9ff0XMHces9vJYOc/UURRdJSYWKa6Sy3TDnSaSoMlPRZ3UmgTa8bc
         BWU4KrEgANrOdKIMUKLuSw9wRfghK6gedNm0R5tE0jlowuSxykZ0a4/ggG13fN70fi9C
         9XOKqZ1R2n7kNj5UpzgZyfnHmP9yghPlJsMr9ZlieN+YKbsaVJtHrntj2dCBYW6Z01k+
         MkOp3/r2WQofcvTAA9rXCREicCWaLhkYh+xOR+n+psO4uLx10P/2DLglrRLbJ8kmBEJG
         rfQg==
X-Gm-Message-State: AOAM530UO8n5TXYQG/YHOcrxYQ/1McxqkgHoYAGhCqlbIjT88ve+rVp2
        xu8rp0SffsBPN+bLvIpnUE8hMVK8qWlxTH986AxnrA==
X-Google-Smtp-Source: ABdhPJyybkU4/zl86lxMdAicFm/HAASMobJ7TCzsCf62cS4iwKaWjXHvqPPPTaNM0MIrxlS5E1MmhGpaOR/XFMKMpRw=
X-Received: by 2002:a17:903:32d1:b0:151:da5c:60ae with SMTP id
 i17-20020a17090332d100b00151da5c60aemr1327115plr.34.1646855964287; Wed, 09
 Mar 2022 11:59:24 -0800 (PST)
MIME-Version: 1.0
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164610295187.2682974.18123746840987009597.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220309182650.00006b28@Huawei.com>
In-Reply-To: <20220309182650.00006b28@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 11:59:13 -0800
Message-ID: <CAPcyv4iw+7WzAWykbsF+4pv9a8p0G8c6Bw5fk-JGfLZQX=susQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] cxl/core: Clamp max lock_class
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:27 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 28 Feb 2022 18:49:11 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > MAX_LOCKDEP_SUBCLASSES limits the depth of the CXL topology that can be
> > validated by lockdep. Given that the cxl_test topology is already at
> > this limit collapse some of the levels and clamp the max depth.
> >
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/cxl.h |   21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 97e6ca7e4940..1357a245037d 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -501,20 +501,33 @@ enum cxl_lock_class {
> >       CXL_ANON_LOCK,
> >       CXL_NVDIMM_LOCK,
> >       CXL_NVDIMM_BRIDGE_LOCK,
>
> I'd be tempted to give explicit value to the one above as well
> so it's immediate clear there is deliberate duplication here.

Sounds good.

I also notice that clamp_lock_class() should return -1 when it wants
to disable validation, not zero.
