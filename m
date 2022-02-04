Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54534A934F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiBDFUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiBDFUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:20:11 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F91BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:20:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y5so3221955pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ONDbtydhwvDrYLEYV5txKtDM/twBw6nwsql7TNaIK4=;
        b=pupvvGTN+4tl8bnMiR93yAJZN/VwZtm8Iz3Sim27vtu7zOgW+YhJAjNZiBEgSFqLHd
         J50gPwMHlzMx7ACHI+7RjH2xQC1zPDWnEslifItGIobpvdut5LSVuSlsqPog9nt7ryoa
         8tAtyu26yuepHy/pD2G3qcYQKWcmyq/ltZVQpWHx9ONs7x1p0uQWrL6ksD3nQGUVcOxO
         p5UaMVHCfmtzv1365WBve3tG7NC1QVYHJ7TzqgaxoCUwkTZiSf0j9lf5hcTOgtXlvgOT
         fN8yeAYdLo6ZZ9EXSwciI8y/T0G757Pfcm1CvTiBu7IgP51SlTnh2NSIB9KdaiNHO+m2
         9F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ONDbtydhwvDrYLEYV5txKtDM/twBw6nwsql7TNaIK4=;
        b=ORIMLxyAiD6xYvHu/TDMhXlF/QLVyVwBLGWs4PxOPDpDFB2uL/GDIWcM+iM0r1dabk
         43kvVlp4sUHiJK+eHH/kUkNU8prwCcQyNdMwg41TVQ/Lb2XrNmMfA4xizCyrkyGwrw33
         IFdK2dJ28WuMMZiV4vWbI0O9xbqCxsDN0cgs7xcIOJ69kj6Q5TvI9iVu0QT5w8d3SEZu
         mRJnaszIm+NNp4LOuYq2j1Bm/aTkh3IZHF2WrM6cdQ7hW35D7sZ0lG3Z5mD94DjPFSAJ
         qq5nVP85UqKse/F/RJ5T5DEJPMiNOGjDfohM3iWUeZHJbJFXigiM1nNRCvsfplV3rlfV
         BfDw==
X-Gm-Message-State: AOAM531RWCquIYB7mC31MLoztfOqZW9aG4aMHtwXcfSCSnNYyPHsObk1
        k8HjFIsbmhecGp1sXISEFsH8b7QBa4URhiPWx9w+Aw==
X-Google-Smtp-Source: ABdhPJx9ljMU12WA2lRrT4cyWqQ4QOXUXt36hi6yHoYhxmwWez1RSsr6A2ZSL3pZw/YqUPhRNQFaQgi8sq7kcevnD/Q=
X-Received: by 2002:a63:4717:: with SMTP id u23mr1170549pga.74.1643952010788;
 Thu, 03 Feb 2022 21:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-43-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-43-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 21:19:58 -0800
Message-ID: <CAPcyv4gDBnUQCe7BSWzccWGfcPZRza3PSBLqReBQgobSf09JGA@mail.gmail.com>
Subject: Re: [PATCH V8 42/44] dax: Stray access protection for dax_direct_access()
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> dax_direct_access() provides a way to obtain the direct map address of
> PMEM memory.  Coordinate PKS protection with dax_direct_access() of
> protected devmap pages.
>
> Introduce 3 new dax_operation calls .map_protected .mk_readwrite and
> .mk_noaccess. These 3 calls do not have to be implemented by the dax
> provider if no protection is implemented.
>
> Threads of execution can use dax_mk_{readwrite,noaccess}() to relax the
> protection of the dax device and allow direct use of the kaddr returned
> from dax_direct_access().  The dax_mk_{readwrite,noaccess}() calls only
> need to be used to guard actual access to the memory.  Other uses of
> dax_direct_access() do not need to use these guards.
>
> For users who require a permanent address to the dax device such as the
> DM write cache.  dax_map_protected() indicates that the dax device has
> additional protections and that user should create it's own permanent
> mapping of the memory.  Update the DM write cache code to create this
> permanent mapping.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
[..]
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9fc5f99a0ae2..261af298f89f 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -30,6 +30,10 @@ struct dax_operations {
>                         sector_t, sector_t);
>         /* zero_page_range: required operation. Zero page range   */
>         int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
> +
> +       bool (*map_protected)(struct dax_device *dax_dev);
> +       void (*mk_readwrite)(struct dax_device *dax_dev);
> +       void (*mk_noaccess)(struct dax_device *dax_dev);

So the dax code just recently jettisoned -the >copy_{to,from}_iter()
ops and it would be shame to grow more ops. Given that the
implementation is pgmap generic I think all that is needed is way to
go from a daxdev to a pgmap and then use the pgmap helpers directly
rather than indirecting through the pmem driver just to get the pgmap.
