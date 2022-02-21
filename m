Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50E4BD62A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbiBUGdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:33:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241366AbiBUGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:33:06 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C867201
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:32:43 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id c14so29611094qvl.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wmHTVh2NfcEW45izXbwh4sjY94it2WsAI7ES7pYD8FU=;
        b=a3g8jiw/4of17us/bKcnaheUrxEsyWgmSsheKhiWNGsJa/GPADHQibwMw3kTEl5jYP
         vCO6jPKhBEjwYh+Otg3D/SvCgD6vEcMI7FbuZh+YTusQB1TTYASCw5bx1YAPIQga7iNM
         Uv6WkkRBatCkaEJ9iooe+TpLljCxIGkRNJlhAqkTEhV9QpzB9LwHd/5IpN69y652f9vY
         6B/cMZRznwHd2NsBG8SdjvOS7GTquxWzWHgZv3ou+x1xMXUVQQvZelaL1Zlt9pu9Oe3b
         J1rhKle0GVyX4KlN9/FAOMf2WxE4jd7luDwvhr16K4B2aa7zTshKeUA2nEeJyIbrvWwr
         81Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wmHTVh2NfcEW45izXbwh4sjY94it2WsAI7ES7pYD8FU=;
        b=IL692GE9iOqgetUZuQiDvm/Fdfo+G9FtJ1j/8L1iDx6TzI/XIhZL/PsVGDdCGnhSG3
         0J+gV6JG3mTs9T+GEKinSaoFvHBAAV7Uytq+UdZKvIIoOIxKld9Xh3lNf5sFamecgq5A
         DJNjxlnP69+dFBywP7CBQpZ6YhTB+4RBzMkNaaxwV2/hfC7qFNlkkE6cbFtf7Q+70D0c
         OANn5T59/NU3srYv7Ug/N5PcbLXjiKqGTh1B1ZJTCxXZxlgOH4JUJy7xxMiE4Pxfj9ZO
         MMrY/wEgDlJvHYvlmoCjFS3FHQhfTCF7i4sxqoMVTRvTIGw3bX+h1tnIMu2hKorp0aNE
         OZ6Q==
X-Gm-Message-State: AOAM531hcwMA+sBSmCwNqb4ZJFL6pn1t7w8ukMZlg1ZFea1BHMBP8tTR
        lG1P4fE7dJWH9OeALkcvI21q2w==
X-Google-Smtp-Source: ABdhPJzuN5WHnPaCleK+xyaSD2sjr9IzNkUaaB49xdktpcIA/iCrSR2CJy44WgmH3PO5Ogn9s8hHAw==
X-Received: by 2002:ac8:5f4c:0:b0:2d5:e2d7:de22 with SMTP id y12-20020ac85f4c000000b002d5e2d7de22mr16794816qta.472.1645425162416;
        Sun, 20 Feb 2022 22:32:42 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p70sm25476041qka.62.2022.02.20.22.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 22:32:41 -0800 (PST)
Date:   Sun, 20 Feb 2022 22:32:28 -0800 (PST)
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
In-Reply-To: <7d35c86-77f6-8bf-84a-5c23ff610f4@google.com>
Message-ID: <a733e937-987e-921-8152-28d48fd89ed7@google.com>
References: <20220218063536.GA4377@xsang-OptiPlex-9020> <7d35c86-77f6-8bf-84a-5c23ff610f4@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2040830854-1645425161=:2653"
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

--0-2040830854-1645425161=:2653
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 18 Feb 2022, Hugh Dickins wrote:
> On Fri, 18 Feb 2022, kernel test robot wrote:
> >=20
> > Greeting,
> >=20
> > FYI, we noticed a -62.6% regression of stress-ng.remap.ops_per_sec due =
to commit:
> >=20
> >=20
> > commit: 237b4454014d3759acc6459eb329c5e3d55113ed ("[PATCH v2 07/13] mm/=
munlock: mlock_pte_range() when mlocking or munlocking")
> > url: https://github.com/0day-ci/linux/commits/Hugh-Dickins/mm-munlock-r=
ework-of-mlock-munlock-page-handling/20220215-104421
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git ee28855a=
54493ce83bc2a3fbe30210be61b57bc7
> > patch link: https://lore.kernel.org/lkml/d39f6e4d-aa4f-731a-68ee-e77cdb=
f1d7bb@google.com
> >=20
> > in testcase: stress-ng
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 C=
PU @ 2.60GHz with 128G memory
> > with following parameters:
> >=20
> > =09nr_threads: 100%
> > =09testtime: 60s
> > =09class: memory
> > =09test: remap
> > =09cpufreq_governor: performance
> > =09ucode: 0xd000280
> >=20
> >=20
> >=20
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >=20
> >=20
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >=20
> >=20
> > To reproduce:
> >=20
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached =
in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml fil=
e for lkp run
> >         sudo bin/lkp run generated-yaml-file
> >=20
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/te=
st/testcase/testtime/ucode:
> >   memory/gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-2020=
0603.cgz/lkp-icl-2sp6/remap/stress-ng/60s/0xd000280
> >=20
> > commit:=20
> >   c479426e09 ("mm/munlock: maintain page->mlock_count while unevictable=
")
> >   237b445401 ("mm/munlock: mlock_pte_range() when mlocking or munlockin=
g")
> >=20
> > c479426e09c8088d 237b4454014d3759acc6459eb32=20
> > ---------------- ---------------------------=20
> >          %stddev     %change         %stddev
> >              \          |                \ =20
> >     109459           -62.5%      41003 =B1  2%  stress-ng.remap.ops
> >       1823           -62.6%     682.54 =B1  2%  stress-ng.remap.ops_per=
_sec
> >  2.242e+08           -62.5%   83989157 =B1  2%  stress-ng.time.minor_pa=
ge_faults
> >      30.00 =B1  2%     -61.2%      11.65 =B1  4%  stress-ng.time.user_t=
ime
>=20
> Thanks a lot for trying it out, I did hope that you would find something.
>=20
> However, IIUC, this by itself is not very interesting:
> the comparison is between c479426e09 (06/13) as base and 237b445401?
> 237b445401 is 07/13, "Fill in missing pieces", where the series gets
> to be correct again, after dropping the old implementation and piecing
> together the rest of the new implementation.  It's not a surprise that
> those tests which need what's added back in 07/13 will get much slower
> at this stage.  And later 10/13 brings in a pagevec to speed it up.

I probably did not understand correctly: I expect you did try the whole
series at first, found a regression, and then bisected to that commit.

>=20
> What would be much more interesting is to treat the series of 13 as one,
> and compare the baseline before any of it against the end of the series:
> is that something that the 0day robot can easily do?

That would still be more interesting to me - though probably not
actionable (see below), so not worth you going to any effort.  But
I hope the bad result on this test did not curtail further testing.

>=20
> But I'll look more closely at the numbers you've provided later today,
> numbers that I've snipped off here: there may still be useful things to
> learn from them; and maybe I'll try following the instructions you've
> supplied, though I probably won't do a good job of following them.

I did look more closely, didn't try lkp itself, but did observe
stress-ng --timeout 60 --times --verify --metrics-brief --remap 128
in the reproduce file, and followed that up (but with 8 not 128).
In my config, the series managed about half the ops as the baseline.

Comparison of unevictable_pgs in /proc/vmstat was instructive.
Baseline 5.17-rc:                    With mm/munlock series applied:
unevictable_pgs_culled 17            53097984
unevictable_pgs_rescued 17           53097984
unevictable_pgs_mlocked 97251331     53097984
unevictable_pgs_munlocked 97251331   53097984

I was very surprised by those low culled/rescued baseline numbers,
but a look at stress-remap-file-pages.c shows that each thread is
repetitively doing mlock of one page, remap_file_pages on that address
(with implicit munlock of old page and mlock of new), munlock of new.
Whereas usually, we don't munlock a range immediately after mlocking it.

The baseline's "if (!isolate_lru_page(page)) putback_lru_page(page);"
technique works very much in its favour on this test: the munlocking
isolates fail because mlock puts the page back on a pagevec, nothing
reaches the unevictable list; whereas the mm/munlock series under test
fastidiously moves each page to unevictable before bringing it back.

This certainly modifies my view of the role of the pagevec, and I
think it indicates that we *may* find a regression in some realistic
workload which demands a smarter approach.  I have experimented with
munlock_page() "cancelling" an mlock found earlier on its pagevec;
but I very much doubt that the experimental code is correct yet, it
worked well but not as well as hoped (there are various lru_add_drain()s
which are limiting it), and it's just not a complication I'd like to get
into: unless pushed to do so by a realistic workload.

stress-ng --remap is not that realistic workload (and does
not pretend to be).  I'm glad that it has highlighted the issue,
thanks to you, but I don't intend to propose any "fix" for this yet.

Hugh
--0-2040830854-1645425161=:2653--
