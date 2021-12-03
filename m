Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54FA467B96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382106AbhLCQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382141AbhLCQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:41:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD4C061D5E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:38:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so3405907pfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=1Os1YXl4la47axxJ9jJm6JnaqNSY09GwFIn2TEKSK34=;
        b=NV71F2dXvhAuV9ngT//koygUCamIjyG074O/+3MMVdIx+Yrhh/OnKnrG+HjuqzGIz+
         aeYkCReWJtBYO6vuOUAsjmD0fcNg8qtxl2sMMZeWUuIE/S9WJaj/2HM20Xy4WjfZeK/l
         74fXHGLaHvuzhM8OW+vtoVP7MKYRZVcTs7djM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=1Os1YXl4la47axxJ9jJm6JnaqNSY09GwFIn2TEKSK34=;
        b=zGl4925eHiWipE3We9FSRCYNDMufEnRby4AvS80eaQzC0Nhf+QLE70KUExKP9g3dVQ
         QNMVzH5HklIrsVPJc+hh483xcm2LQXaFkBq+QCztnXZ9+qnBMeHE+ZoxljFqd2cqU1WD
         5bK3utExKxOdj2r5WWqL4HiPY32vSCOAKNH89wRVke4BBoxglyA7mbPLZ7qqM5eopnvP
         5mqbLmh+alKUg5oaNm/wFLvYkl4PQMMvldZY2rP4wTTkae9KKSOZEtDoai8fyK1I/NEb
         6v2Jy+ga0SQe/fdl1z3M7RzKiRYqiEzS3ZDNwijBH/nj1B023ygkfMbnQg/b7WGVhMBo
         PKXA==
X-Gm-Message-State: AOAM530F8JEhmcxIAE4tpflr2xgiAHvHNl6pkKhOUnsNhyiNyZbZOpP/
        wfegYCmfXoOAE+b5hPj+Ys5U/A==
X-Google-Smtp-Source: ABdhPJwQAjEynTS1Zy+kiMxhN1859sy4nV6Hn4qhyUmIOr2nCUvQ1+gveQ8Sp1GCosQcJ/NzZwgNlQ==
X-Received: by 2002:a62:5215:0:b0:49f:a996:b724 with SMTP id g21-20020a625215000000b0049fa996b724mr20111647pfb.3.1638549481618;
        Fri, 03 Dec 2021 08:38:01 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id np1sm6453482pjb.22.2021.12.03.08.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:38:01 -0800 (PST)
Date:   Fri, 03 Dec 2021 08:37:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_find=3A_Do_not_read_beyon?= =?US-ASCII?Q?d_variable_boundaries_on_small_sizes?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YaoN6wnNezMvyyd5@smile.fi.intel.com>
References: <20211203100846.3977195-1-keescook@chromium.org> <YaoN6wnNezMvyyd5@smile.fi.intel.com>
Message-ID: <E1A4953A-8801-48FA-A744-63DA548C5924@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 3, 2021 4:30:35 AM PST, Andy Shevchenko <andriy=2Eshevchenko@l=
inux=2Eintel=2Ecom> wrote:
>On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
>> It's common practice to cast small variable arguments to the find_*_bit=
()
>
>It's a bad practice and should be fixed accordingly, no?

There's an argument to be made that the first arg should be void * but tha=
t's a pretty invasive change at this point (and orthogonal to this fix)=2E

I'd be happy to send a treewide change for that too, if folks wanted?

>
>> helpers to unsigned long and then use a size argument smaller than
>> sizeof(unsigned long):
>>=20
>> 	unsigned int bits;
>> 	=2E=2E=2E
>> 	out =3D find_first_bit((unsigned long *)&bits, 32);
>>=20
>> This leads to the find helper dereferencing a full unsigned long,
>> regardless of the size of the actual variable=2E The unwanted bits
>> get masked away, but strictly speaking, a read beyond the end of
>> the target variable happens=2E Builds under -Warray-bounds complain
>> about this situation, for example:
>>=20
>> In file included from =2E/include/linux/bitmap=2Eh:9,
>>                  from drivers/iommu/intel/iommu=2Ec:17:
>> drivers/iommu/intel/iommu=2Ec: In function 'domain_context_mapping_one'=
:
>> =2E/include/linux/find=2Eh:119:37: error: array subscript 'long unsigne=
d int[0]' is partly outside array bounds of 'int[1]' [-Werror=3Darray-bound=
s]
>>   119 |                 unsigned long val =3D *addr & GENMASK(size - 1,=
 0);
>>       |                                     ^~~~~
>> drivers/iommu/intel/iommu=2Ec:2115:18: note: while referencing 'max_pde=
'
>>  2115 |         int pds, max_pde;
>>       |                  ^~~~~~~
>>=20
>> Instead, just carefully read the correct variable size, all of which
>> happens at compile time since small_const_nbits(size) has already
>> determined that arguments are constant expressions=2E
>
>What is the performance impact?

There should be none=2E It's entirely using constant expressions, so all o=
f it gets reduce at compile time to a single path without conditionals=2E T=
he spot checks I did on the machine code showed no differences either (sinc=
e I think optimization was doing the masking vis smaller width dereference)=
=2E


>

--=20
Kees Cook
