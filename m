Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C49517EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiECHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiECHXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:23:16 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AE39808
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:19:15 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id v3so6092121uau.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NDjuQ75ayo0y02VvOvQTGtjArT2BL7D/bx+PGGT5og=;
        b=BAEtmxzOwz8J5Up8A7N9UjC8/PEWOjYhRZxZhABtmKjxQIM7YjG963YwAqUMWwEYJi
         4Ip6kb5BTStei89FlRkKpH4+xzSBuO2i3AvS6iR+t5srxfldrknGIZ4NQJNBvm5DIk/P
         2kP/RoSqIS86DXQbBG90pNJ61ay9msF0mTf0Mi1vEuiyB5cFf4AeGx66kz3gaRXKRLob
         dZbgvurwSJo569DlzQmsJoQgCUojS0IWFtjm2XIjNIi6b2H+eOCURe1UjVGtXvaxECQr
         mKYA56F+lfX4Msi8OjHvb9wD8BVRq+TWPwbgLWKGESOCWIHi8AFI47HGl2oO81jHNqSK
         9PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NDjuQ75ayo0y02VvOvQTGtjArT2BL7D/bx+PGGT5og=;
        b=wB/SXGDiR/2SuArcdLoLfkfsde0HNsIkRmY9e5LmsRx8UmjBzaYBLZCmq4YMcdbsUC
         fhFKBwo2e43/Jq71/D2ynbZZD4DhS5bTeOkCKGdztZzBpd7SWFqJDJ0hTc2DiIzWa2sw
         huSq8OtUaLp2+3hKlFZ8Cp8iyx7weajMESbawimE6+2CxPPvXg9YOSwZuswwKAuVf0Cg
         acMYdK9d5qBIm03IhBprr/EnLoN6bwgeaPa3IOMFME4BB79cicNB4aKEAWL8/7InCM6F
         fW4sc9/8qdVsRQZjt7YWSd8LCGyIoI0OfNnksCr/qvRMoiSnUPrM7akMgn2J+C3LGSJI
         jvuw==
X-Gm-Message-State: AOAM531sUKFYANU8mIRoQhOXLxAwBki7jEoevF5hx7gFNUhnYZNrM2WO
        Ee1ruDQstJ1tmZFS1zmsh1u43/0HYvkxuRe1A3EGUw==
X-Google-Smtp-Source: ABdhPJwav71/tsV6N6y5R9/irAJ+th9eFU4wcvvMvfs7CEykh6R5/wDjP1I4Fg+aKRpI/oPJ3c3k6C4QpqHPDZ1sBEo=
X-Received: by 2002:ab0:e14:0:b0:360:e13:e5d7 with SMTP id g20-20020ab00e14000000b003600e13e5d7mr4320904uak.95.1651562352788;
 Tue, 03 May 2022 00:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <c18e273b-f30c-da5c-581b-0cc4672f4481@intel.com>
In-Reply-To: <c18e273b-f30c-da5c-581b-0cc4672f4481@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 3 May 2022 00:19:01 -0700
Message-ID: <CAAPL-u8TtNoonOBDU1HZ-XPA31zsDvDAnO2xDigApypX-+jTYA@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Mon, May 2, 2022 at 8:20 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > The current memory tiering interface needs to be improved to address
> > several important use cases:
>
> FWIW, I totally agree.  We knew when that code went in that the default
> ordering was feeble.  There were patches to export the demotion order
> and allow it to be modified from userspace, but they were jettisoned at
> some point.
>
> > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> > node.
>
> Yeah, this would be a welcome improvement if we can get there.
>
> > * /sys/devices/system/node/memory_tiers
> >
> >   Format: node list (one tier per line, in the tier order)
> >
> >   When read, list memory nodes by tiers.
>
> Nit: this would seems to violate the one-value-per-file sysfs guideline.
>  It can be fixed by making tiers actual objects, which would have some
> other nice benefits too.
>

Good point.  One tier per file should work as well.  It can be even
better to have a separate tier sub-tree.
