Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1250A91F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358121AbiDUT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiDUT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:28:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18D192B7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:25:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so5905877pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeRjKSXDeJIH0+CQwoCMl5922pNFNUxTvF5aowm8rco=;
        b=n99NELoggPuhcsqKws/Ci4cGpg5aTBJYtQnAe9JU8tBA1qr9ygYOAR+1bDIsNVLV5p
         PzgfBQxai1TPXPdvVFGh9O1CcYKegnrlAPTNYxwYYt07W/JnhKPeV2EssXa5URw7o0Ag
         SbxCXwUC9VpajRWpPiZp096BFjq0Fjh6o1gRqvsaf0QS+Sdy/HmIRHNhWGUZRtzVg3E0
         0z9GCsn/tiJHXCCHr7NILgGmwG4cakwPAGUyQGFLATwnHLGp7l43bBirgfe1702YLJfw
         VHRKT35JWViWbCpUyZM0Orq2vsD7GoyOqWqol0/N/ekRJwk1FNnIIjq8s4maGk+0/XGT
         dCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeRjKSXDeJIH0+CQwoCMl5922pNFNUxTvF5aowm8rco=;
        b=oS9wWx7FCiCUsNYZmitZGpG3HF5qZplezc862NksZlK0HmEPuw1Zj4zo16J2v5oAlx
         v5qPkKCYHVjHWIIu04n/7N2m5BYWSvvVz8VCBr7rZoccsr/Om+BRG201vFAt7fFVPWl3
         bXYR7ODE9KnlMT+e/BR1rSjcf6gyH2pkEnd2UmSgndr7AK5AbPSwhyjmoZC2iqQCFYe+
         guLkP80LiyMv7zUaix33y2FMzrDv97eBlPYF8VI5nbxYU2bmyYXtUUb4uQZrR4jB1xHD
         rMjEZdZRDQjQb+Gk3rZE1jFoxBXAMU8L15ttgGKoU1SIjHH5CeAnXoPxTkXSmNqzk7l2
         6zkQ==
X-Gm-Message-State: AOAM5324dEHQblyoZx9r2Eu5X5zLwSDGMi85gD6oHE5X+3+Lp5OgABKG
        OGR2Me3Qr4/a2BycoAxB4fWylPlbP0CN2dch5P2G9Q==
X-Google-Smtp-Source: ABdhPJyqf0QRE4ybiwrpA4CL2rjYdR9Dfz1kuf/M+oV726c8/KeCCX7M1xEsBCAx988EvXNGhdhdyy5S+lFBAanpVRU=
X-Received: by 2002:a17:90b:4c84:b0:1d2:cadc:4e4d with SMTP id
 my4-20020a17090b4c8400b001d2cadc4e4dmr12075384pjb.8.1650569111988; Thu, 21
 Apr 2022 12:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220420020435.90326-1-jane.chu@oracle.com> <20220420020435.90326-2-jane.chu@oracle.com>
In-Reply-To: <20220420020435.90326-2-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Apr 2022 12:25:00 -0700
Message-ID: <CAPcyv4jMNvgWrh5WMY1gFN3-vKLU4eccXW3CDRrn1+=FY7D5jw@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] acpi/nfit: rely on mce->misc to determine poison granularity
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:05 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> nfit_handle_mec() hardcode poison granularity at L1_CACHE_BYTES.
> Instead, let the driver rely on mce->misc register to determine
> the poison granularity.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...I'll add the Fixes: line when applying this.
