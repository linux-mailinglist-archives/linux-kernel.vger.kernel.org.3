Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDD4BB494
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiBRItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBRItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:49:50 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB12B3546
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:49:34 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id n6so13416552qvk.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nEbY2YjiiLFRKbzNuBnXmCsy26BJHqdcfhTrstsfktw=;
        b=ZY7QI5v0DZWwgTYGMj9AWuTZMRpkGzWZXK6Cq5XtFZ+sa+C/Aa7trPWuhX/yHbTJ8l
         XAVx+X6k1etzbJKtWU58JRN/fMKuOJQVaDCkZGdqZzgS1I9fUelmpXwYuyBMDN8yu1n5
         hA6G2+sgWxi9rLWJZa0PxY601iU+5aZFxA7JKIKHK23NPStgUgoDgAK0u9vHyBAB84LM
         5UPiFlamEwl7NWhOvtDzFEDrCXpj3IVKfh08+9TKe/eM+eB9Avvo/m5Oj0kAMP3e1Ecr
         KCQc3/IJcYGjJ3s5rdKBpw4s9yKkgGFWp3fGNnf4q19mSqYiVXGLxPYeJUn9JpCGyIvm
         wx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nEbY2YjiiLFRKbzNuBnXmCsy26BJHqdcfhTrstsfktw=;
        b=UMu1JbRk7lZLaaEI2a2PjViIxAW1pYxZT4phQr3lcxhqYSmd4ov5fgzydWmNjv2lQc
         Dkzy8/3srOP/VsNnQ+PE4mjiexcEI6SHfbeIfTzJD7WcLPhKJAhqX83/fiikZW66N5hz
         f1oejOYVGNy8r2RDwcshaRDdSjt++1+fbV6M47P2rpECdvvw2uiujB8r0oAkFpyZ1m0a
         bcbQFHm2gC8wXz3+lo0p47f/55fu1Ow150v5PCK3wWCjAzsu9CQAjvS/ZoVss60h1Ihs
         O0akQTd7Y4k3maD5LLvAljQhQYZ/QNT5U3Isw3nJQksqKr1IVXzI8CpLVplgnj8cIcxN
         b5NA==
X-Gm-Message-State: AOAM531GQMSGkOtGCdE9W+lVyO2QdHes4Joave7I5B2c3bFY4QHGwVcQ
        DC0I2NUIEXPy69KxbyfpzjZmYA==
X-Google-Smtp-Source: ABdhPJzHQkRMsAPfx/IlzOrP4JSPs4C2xF5qa4YwnJ5JW7/+m5WFAAh+Xv0J35LmRmumUHJQOLrGDg==
X-Received: by 2002:a05:622a:24d:b0:2cc:3c34:3f15 with SMTP id c13-20020a05622a024d00b002cc3c343f15mr5737996qtx.397.1645174173560;
        Fri, 18 Feb 2022 00:49:33 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w2sm736546qts.29.2022.02.18.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:49:33 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:49:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     kernel test robot <oliver.sang@intel.com>
cc:     Hugh Dickins <hughd@google.com>, 0day robot <lkp@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org
Subject: Re: [mm/munlock]  237b445401:  stress-ng.remap.ops_per_sec -62.6%
 regression
In-Reply-To: <20220218063536.GA4377@xsang-OptiPlex-9020>
Message-ID: <7d35c86-77f6-8bf-84a-5c23ff610f4@google.com>
References: <20220218063536.GA4377@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1056915465-1645174173=:1764"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1056915465-1645174173=:1764
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 18 Feb 2022, kernel test robot wrote:
>=20
>=20
> Greeting,
>=20
> FYI, we noticed a -62.6% regression of stress-ng.remap.ops_per_sec due to=
 commit:
>=20
>=20
> commit: 237b4454014d3759acc6459eb329c5e3d55113ed ("[PATCH v2 07/13] mm/mu=
nlock: mlock_pte_range() when mlocking or munlocking")
> url: https://github.com/0day-ci/linux/commits/Hugh-Dickins/mm-munlock-rew=
ork-of-mlock-munlock-page-handling/20220215-104421
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git ee28855a54=
493ce83bc2a3fbe30210be61b57bc7
> patch link: https://lore.kernel.org/lkml/d39f6e4d-aa4f-731a-68ee-e77cdbf1=
d7bb@google.com
>=20
> in testcase: stress-ng
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU=
 @ 2.60GHz with 128G memory
> with following parameters:
>=20
> =09nr_threads: 100%
> =09testtime: 60s
> =09class: memory
> =09test: remap
> =09cpufreq_governor: performance
> =09ucode: 0xd000280
>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test=
/testcase/testtime/ucode:
>   memory/gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-202006=
03.cgz/lkp-icl-2sp6/remap/stress-ng/60s/0xd000280
>=20
> commit:=20
>   c479426e09 ("mm/munlock: maintain page->mlock_count while unevictable")
>   237b445401 ("mm/munlock: mlock_pte_range() when mlocking or munlocking"=
)
>=20
> c479426e09c8088d 237b4454014d3759acc6459eb32=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>     109459           -62.5%      41003 =B1  2%  stress-ng.remap.ops
>       1823           -62.6%     682.54 =B1  2%  stress-ng.remap.ops_per_s=
ec
>  2.242e+08           -62.5%   83989157 =B1  2%  stress-ng.time.minor_page=
_faults
>      30.00 =B1  2%     -61.2%      11.65 =B1  4%  stress-ng.time.user_tim=
e

Thanks a lot for trying it out, I did hope that you would find something.

However, IIUC, this by itself is not very interesting:
the comparison is between c479426e09 (06/13) as base and 237b445401?
237b445401 is 07/13, "Fill in missing pieces", where the series gets
to be correct again, after dropping the old implementation and piecing
together the rest of the new implementation.  It's not a surprise that
those tests which need what's added back in 07/13 will get much slower
at this stage.  And later 10/13 brings in a pagevec to speed it up.

What would be much more interesting is to treat the series of 13 as one,
and compare the baseline before any of it against the end of the series:
is that something that the 0day robot can easily do?

But I'll look more closely at the numbers you've provided later today,
numbers that I've snipped off here: there may still be useful things to
learn from them; and maybe I'll try following the instructions you've
supplied, though I probably won't do a good job of following them.

Thanks,
Hugh
--0-1056915465-1645174173=:1764--
