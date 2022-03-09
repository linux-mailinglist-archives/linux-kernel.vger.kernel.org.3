Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B14D38E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiCISff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiCISfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:35:32 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC57125518
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:34:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d17so3051976pfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12MTmTpu13hq53lEoH6MFWeYg7xR2/fBkzr+0Z6u0Ck=;
        b=MRRIsrlb2tD1c03r1HRBl9H3yV2f6E76atCl9PpgIr+Y1r8mp8mEEz3g6AjnN0F/AB
         Riqw5V8wHiW0NirwZWoSeYLXhojIBGQceu/lx7Dy2Hxr+1RJUihoh0a8Tm6gHHTdj7OJ
         UAlf0bjJIMErj04+OidGI99baw9exx5hBg3kKm2hhQOJ9bBEA9p8gZowZeZOZqTMyZHW
         NExOBYafwY7M/GnHpOE1vm6V3TracFbCMj24rDko7OyJfM0JBrukvNRzwFPziGnwht8/
         +jBrE2BRn+YBlHlf8l9xRD5om2A6tgGqCzzl+7tWAOAmzW+trkose8cdfzWG0BDp2g4W
         YiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12MTmTpu13hq53lEoH6MFWeYg7xR2/fBkzr+0Z6u0Ck=;
        b=oLFhz9p15rn4SJJjvrpeZFl4Hq/d45S/5JL9gEqDlV4Ux04ZvCJoGFWM50IrE/VwQ3
         bO+nqDgbml1Yds6Nbzp2IV3ETtfzSJKESHp4TGrYtIzqv2k3+SAngM07nuHupg1sAL+q
         MVUxv3vHYri9IfO59DDa0HtaYFwuf6Q9QOlDjeaPfSDxKDIcWkwPVx0so+ulx4ybZOk5
         9DljowCvQJUzLE3nMQcI83mF7aWi8iB5mFeG8B1zx3/DhSUaIyAC9D2SjoYnWgT8IPS8
         hoDaJZuNme0/eIh9O4NJyjc+z7hXN4WeKgvAiDXWbAtNKQqrbD3T6GxjIG1B9zRhDi8Z
         2ISA==
X-Gm-Message-State: AOAM531fFtrFUrtolf9PnTntwky2t7/ZOd+7J+t5k3hYMV2Q3fb6jDE3
        oRnqIuahX6cY2dyMoZ+bPuPnYDbGBPw7KW3z8nr3NA==
X-Google-Smtp-Source: ABdhPJyY9Pzhn8MeMgK0ZEOtq9SIHuzHEgfHwVIwVHOYoOPZHQJfQ5DNisp4IqmBvfdFAK/GaG0qA7iLFovv2I5S3Cs=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr897536pgb.74.1646850872623; Wed, 09 Mar
 2022 10:34:32 -0800 (PST)
MIME-Version: 1.0
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164610294030.2682974.642590821548098371.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220309181843.000003fe@Huawei.com>
In-Reply-To: <20220309181843.000003fe@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 10:34:21 -0800
Message-ID: <CAPcyv4g+++6oc8RQf2vRChR+Utk08r7AhQ9Ma_JOyojz1adTqw@mail.gmail.com>
Subject: Re: [PATCH 02/11] cxl/core: Refactor a cxl_lock_class() out of cxl_nested_lock()
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:19 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 28 Feb 2022 18:49:00 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for upleveling device_lock() lockdep annotation support into
> > the core, provide a helper to retrieve the lock class. This lock_class
> > will be used with device_set_lock_class() to idenify the CXL nested
>
> idenify?

Indeed.

>
> > locking rules.
> >
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Otherwise looks fine to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!
