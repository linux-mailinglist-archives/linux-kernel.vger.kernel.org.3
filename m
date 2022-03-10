Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344984D4026
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiCJEJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbiCJEJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:09:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902610EC66
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:08:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u17so1878299pfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 20:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqToSLq1SUyk2Y3JI0yt1XyMXYlHdKXdzvRi+KrsnXE=;
        b=MfVbkFMmHV850mNu3abpIQMQS4U5DzbjClrYRF+wzyHLHM4qJrkkOLAmTH7O3kKINZ
         HcD2Wn4iCOe70caRGULzt6YKSeqXNUV5hhDqtETitjEU+1YfYvln7mEjyndk/ATwTdrj
         zWDxgJBHTXqOhMM3qLDTuh0eQ4c7jH2dfvvFntr0QHX33eFfOIdfAoM5+W3niKyNlQzL
         dygskK9cwuIfSS1u7Ak8XM5yR2KjVpOC+JD34YscdDpMCHWCGtSmCvnb9AenDXCkdnuK
         2fw5+kNMAjgeXlNbmvacnGR8cBrre+1lfrUSMcWYBNVR0+WBWib/Zkkk5plT343ToP1M
         t1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqToSLq1SUyk2Y3JI0yt1XyMXYlHdKXdzvRi+KrsnXE=;
        b=MDBQUjhovCY9SuIawgK6kBSS/QimX/qn7rwaX5BbgGZfGF+bXqaNtGL81QlapFYEK3
         v/ofoPz+DrWPBymvyQyt6BRBg+kKJDRGe5f+xM6ECtAulpmXljymiw2utQ+lisD5odTZ
         oW5kTcBDXZ/nMF8mmST3Ed8c0ISSG0XNvHH0pm5DLTAwKxCJwPfkwWsPOU53w3+Yi0Sk
         sRQ3ni3LN3JdPPYNPWzN1DVhQuBWSu+YLcV0JJtGq3eW94WzIZItATRtI5JP7Yi7HtH7
         nuBP4HYnEuXgZb9hA5ZJ6ypP0JUpJJ+4WayTaVms1vnuIX/30RMZd2oOSF4xB2QkG3cB
         3xGw==
X-Gm-Message-State: AOAM530HYdlFk1z1baS2ePLi81CnDpd3lH8NvHPqOV2cG0PKUFvg+rZ+
        zf/NvTrA1e0OzVWU0hDDYwHmpvANuawcgwFx0vfX8Q==
X-Google-Smtp-Source: ABdhPJzyZl/HZFJ4W5wvzu82e8lJumsJS2ovk+12eegcKrw+mvv/OWROOu8cpWzIbkqbbjDZGgHjQHE7U+QNtIkWVrQ=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr2878100pfu.3.1646885334033; Wed, 09 Mar
 2022 20:08:54 -0800 (PST)
MIME-Version: 1.0
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164610295699.2682974.3646198829625502263.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220309183323.00000048@Huawei.com>
In-Reply-To: <20220309183323.00000048@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 20:08:43 -0800
Message-ID: <CAPcyv4iv1Rvh6XuJb44JTLciUj_Ai__RWikP4YYYgC=SUCARnQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] cxl/core: Introduce cxl_set_lock_class()
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

On Wed, Mar 9, 2022 at 10:33 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 28 Feb 2022 18:49:17 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Update CONFIG_PROVE_CXL_LOCKING to use the common device-core helpers
> > for device_lock validation.
> >
> > When CONFIG_PROVE_LOCKING is enabled and device_set_lock_class() is
> > passed a non-zero lock class the core acquires the 'struct device'
> > @lockdep_mutex everywhere it acquires the device_lock. Where
> > lockdep_mutex does not skip lockdep validation like device_lock.
> >
> > cxl_set_lock_class() wraps device_set_lock_class() as to not collide
> > with other subsystems that may also support this lockdep validation
> > scheme. See the 'choice' for the various CONFIG_PROVE_$SUBSYS_LOCKING
> > options in lib/Kconfig.debug.
> >
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> One query inline - otherwise looks good to me.
>
> > ---
>
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index b1a4ba622739..f0a821de94cf 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -476,6 +476,7 @@ int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *cxlr)
> >       if (rc)
> >               goto err;
> >
> > +     cxl_set_lock_class(dev);
>
> I didn't see a cxl_lock_class for regions. Or is this meant to use
> the ANON_LOCK?

Oh, yes, first I need to rebase this set before the region series
which is going through a major revision. Second, I expect that the
region lock_class may end up needing to nest inside the decoder lock
class in order to facilitate decoders disconnecting themselves from
regions if a memdev goes through ->remove() while an associated region
is active.

This series was motivated by wanting to validate the locking of the
region creation sysfs-ABI versus device removal events.
