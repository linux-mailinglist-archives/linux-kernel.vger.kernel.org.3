Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4524A9D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376820AbiBDRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbiBDRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:12:23 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2BC061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:12:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l13so5668509plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDCNu+Cym44ygOMfR4YUKPeShLKbl0XpTSJGk0VSOuU=;
        b=iOXdV9Lm6nB8ckX5qlo+GUCHjCpNPk1wA/ZsIag7ZI01ms8dWnfgjhpb2BrbnkzBs1
         jQCaD7GKd4nugQpQa9S/g6ijWUOby86C26vxn4hoVe4+HXRBzjTM/Za5gQAtbFn70Ras
         hPsI+dzwFhP6CdKK+lIYaa42T3dHhJGqkSaPd/CJKq3ThTXPm+JF8/eg0zqEag4tZxaE
         +SvzAQ6l3wa6gEeasexHetmIPCKSyp5w9c/1BqDdE9U3sTgtj7OH2BUqcqr4AwLHOuUP
         CfyEdBimOoC0lbs3vyNHq36QdfvUmIb6ux+4xbmvI3xQXemCe3O3ENfoGLNiXz076zL2
         kINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDCNu+Cym44ygOMfR4YUKPeShLKbl0XpTSJGk0VSOuU=;
        b=lKsThR7nyRBMi1OSU6dgE8UUEyh0H8/qL2ng/K/uFGVlD2IRRR0o1dMIGlPlsYqPpi
         KeOgtapzeVKv3V7ESi5R3QIULO1t9JH+EdHL36ZANklf/o3QD85KgiHQVEUEYzpO3RLm
         Mc1Fb/lde0yEDbty0vJH7MNSLmM5mWwnqwJUdYcH5eTJab7fZrYG4UWYk2rwKdBf17Dx
         C7yLFAl757cc/eAj/+J+1caAt1rSxoGF4klWG1xKnNZtg3v+k7PQ0gc8sCUshG8ajR/y
         MMqVOdFUSyV2GqC0iT6dnSkhBVueiubehpcx3oX7PebURezJnn9O6O0DBcAbngYlMSLp
         MhLw==
X-Gm-Message-State: AOAM533RTjyfIKdqilbnhYu3mlAIVofGLX1FNoGuA14OsapBRBLZi2bh
        zFLZvrIqPj9+axcSnthE43/3B7K/MaPjgnB0tcsNQw==
X-Google-Smtp-Source: ABdhPJxKYJutSw/st/2X247wV8SRGXRKrMEx4YEUK4OAA00OPb8lRSqWd7HEf/nqhkjoV/yp9VFqkT8ctQ3iT+Gw+nI=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr4157823pls.147.1643994742614;
 Fri, 04 Feb 2022 09:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
In-Reply-To: <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 09:12:11 -0800
Message-ID: <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:35 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> >  enum pks_pkey_consumers {
> > -       PKS_KEY_DEFAULT         = 0, /* Must be 0 for default PTE
> > values */
> > -       PKS_KEY_TEST            = 1,
> > -       PKS_KEY_NR_CONSUMERS    = 2,
> > +       PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default
> > PTE values */
> > +       PKS_KEY_TEST                    = 1,
> > +       PKS_KEY_PGMAP_PROTECTION        = 2,
> > +       PKS_KEY_NR_CONSUMERS            = 3,
> >  };
>
> The c spec says that any enum member that doesn't have an "=" will be
> one more than the previous member. As a consequence you can leave the
> "=" off PKS_KEY_NR_CONSUMERS and it will get auto adjusted when you add
> more like this.
>
> I know we've gone around and around on this, but why also specify the
> value for each key? They should auto increment and the first one is
> guaranteed to be zero.
>
> Otherwise this doesn't use any of the features of "enum", it's just a
> verbose series of const int's.

Going further, this can also build in support for dynamically (at
build time) freeing keys based on config, something like:

enum {
#if IS_ENABLED(CONFIG_PKS_TEST)
PKS_KEY_TEST,
#endif
#if IS_ENABLED(CONFIG_DEVMAP_PROTECTION)
PKS_KEY_PGMAP_PROTECTION,
#endif
PKS_KEY_NR_CONSUMERS,
}
