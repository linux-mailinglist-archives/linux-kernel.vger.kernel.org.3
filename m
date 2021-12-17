Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C547938D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhLQSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:08:30 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46757 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhLQSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:08:29 -0500
Received: by mail-oi1-f175.google.com with SMTP id s139so4742210oie.13;
        Fri, 17 Dec 2021 10:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGCz2Mkb3xw6Ly/YEIrj+GpLhNUOPqPMSl/tYzJrkMg=;
        b=xqhdyCEdu1agfGXMWMjrOSuAilsvzkwfL7HIFASVlFVj9eZ7g6MMD0zfR9k1TL1NEf
         qfvTCQTx1Pwqk+xAbJArAviD1pe0bwQP6zVJAA9TdjdIIsaXqEQQpRV666vBGoOpT2FP
         8eQiIgGo7OgEzJ1kjJEzzEewWvbNzUiXkZHFNK2Cc8jKf2q3WApwQ5aGxmRVdf3Y5P4c
         S7YNrgqBtBG4RN7Q8yDbVd2rsdTio3T+xJxJmpRWXzAHknhocVqITHCOKT35HmKYCEWy
         5IYvaIewxtFb/oBuktk46vfArm0jVIU2twY7hisuZl+B1IKTVdy3AQZNF6JQkBJzFuNQ
         56Bg==
X-Gm-Message-State: AOAM531uuGt8i7tZ6jaeC3d1suMnR0pfaYlC1DjFzxEiDTlsCVC0A2zP
        q02sC7Fv4bXOcGWyw5cHV2DSiUXsdEDBenxVe88=
X-Google-Smtp-Source: ABdhPJzvcWJ4CbIp8GquSE1y4BVzbRL9LcXmxUSupzHHII7RqING+mGyTVf8dR4sJBAHZKUZGO8yGrju06v7Lm+hZgg=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr2981766oiw.154.1639764508924;
 Fri, 17 Dec 2021 10:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20211213204632.56735-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211213204632.56735-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 19:08:18 +0100
Message-ID: <CAJZ5v0jq=XdH+xeHs5=wMGsu28i+r3nzZbhCNMJkfdOi65N0Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     nvdimm@lists.linux.dev,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 9:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Strictly speaking the comparison between guid_t and raw buffer
> is not correct. Import GUID to variable of guid_t type and then
> compare.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Dan, are you going to take care of this or should I?

> ---
>  drivers/acpi/nfit/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 7dd80acf92c7..e5d7f2bda13f 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -678,10 +678,12 @@ static const char *spa_type_name(u16 type)
>
>  int nfit_spa_type(struct acpi_nfit_system_address *spa)
>  {
> +       guid_t guid;
>         int i;
>
> +       import_guid(&guid, spa->range_guid);
>         for (i = 0; i < NFIT_UUID_MAX; i++)
> -               if (guid_equal(to_nfit_uuid(i), (guid_t *)&spa->range_guid))
> +               if (guid_equal(to_nfit_uuid(i), &guid))
>                         return i;
>         return -1;
>  }
> --
> 2.33.0
>
