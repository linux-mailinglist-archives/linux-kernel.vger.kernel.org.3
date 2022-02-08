Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57954AE5AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiBHXx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiBHXx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:53:27 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8EC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:53:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x65so1163773pfx.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yllLJXxvJNbb7TJ6F8GXcTe3gXNYnW6vmBXP6xHdmQ=;
        b=1TP2oV0hvpTVvUc38sU25Nq8P8dLloqnVrR1dLnL0k00RIz6cxvWF4JovZ1JHdh+Iq
         QjJ5AHaidFx9YmqNTrZ5h5qyJPKM/tziAB9DhO4YFzjPd5bpNTRb+YsjUwlfA7jtVsFK
         U7OdrJqAvGZ07hdSarMyxYyjKgkfa4xWh2cbsWw1St7pAb9nNM89cLwW6fNieqLKy8A0
         lEy6S237O1zyS6B6nOobWB1RoW/2FsR/vn8FET1ptCNsh08iwgcstMONTlv3sghEwQq4
         uOxijQbfhnxc35FRPR6EYrfjLYHOlXzLa9Vs6xBYs94IsyLrdPrgdUt8qrZhQDjGtN/K
         zJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yllLJXxvJNbb7TJ6F8GXcTe3gXNYnW6vmBXP6xHdmQ=;
        b=xEiepmTR6X4uNPweOm1l93auT/Q+esfh7KxCvypDPao3ePcaGrSgciJLjYpB7zywqO
         EtgG05VmyLx23mhO/dH+C4J62FKEPLH+o9+hj4V2LLduUTMYYkkmnyGJzHozNTeSlPAC
         5qUeh5DfgA8xLLDzsThAX8/h8cL5GbdiNBtx4Lmc4JINyiurzGM7ZSlRHK1Hy1ysZLj7
         HyJK/edlyJgl+qiH6gFV8AmSIsSZvDvckyDhtsxyqo9Tat8Io0gT8mo5sNykdE3fFpee
         C4nLiVA7M63IPwdKCQacO0Zv89gJztx6uPhfSjBRMqbaXUW3jcPJ20TIm9R5SVx9LjdQ
         OyzA==
X-Gm-Message-State: AOAM530FKxWck/dLcE+98GikmkOWHQ26stOiq1jhZqHIyZOOfWwonO2o
        qGyef+Gbw+W7xptqF21HoREjVeyeZNAm7a+kDhDOZg==
X-Google-Smtp-Source: ABdhPJxeYY0PWIjCV0oL3qSXzPE/CqXZVnxQ/6hAd62TUxvblfYAlcQYEDEiHEyZHUJKW9dSv16xGL4Nt/VbJK9Vxe0=
X-Received: by 2002:a63:8849:: with SMTP id l70mr2640980pgd.437.1644364405842;
 Tue, 08 Feb 2022 15:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-7-hch@lst.de>
 <CAPcyv4iYfnJN+5=0Gzw8gKpNCG3PJS1MEZxxoPwuojhU6XHNRA@mail.gmail.com>
In-Reply-To: <CAPcyv4iYfnJN+5=0Gzw8gKpNCG3PJS1MEZxxoPwuojhU6XHNRA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 15:53:14 -0800
Message-ID: <CAPcyv4jfNa2BBuE7E0+8LO5VT9APS1eF3c4Rw99oKY6y+1re9w@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm: don't include <linux/memremap.h> in <linux/mm.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 3:49 PM Dan Williams <dan.j.williams@intel.com> wrot=
e:
>
> On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Move the check for the actual pgmap types that need the free at refcoun=
t
> > one behavior into the out of line helper, and thus avoid the need to
> > pull memremap.h into mm.h.
>
> Looks good to me assuming the compile bots agree.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Yeah, same as Logan:

mm/memcontrol.c: In function =E2=80=98get_mctgt_type=E2=80=99:
mm/memcontrol.c:5724:29: error: implicit declaration of function
=E2=80=98is_device_private_page=E2=80=99; did you mean
=E2=80=98is_device_private_entry=E2=80=99? [-Werror=3Dimplicit-function-dec=
laration]
 5724 |                         if (is_device_private_page(page))
      |                             ^~~~~~~~~~~~~~~~~~~~~~
      |                             is_device_private_entry

...needs:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1e97a54ae53..0ac7515c85f9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -62,6 +62,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/memremap.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
