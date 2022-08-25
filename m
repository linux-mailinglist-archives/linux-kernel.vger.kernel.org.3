Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCC5A0879
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiHYFg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHYFg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:36:56 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D677A524;
        Wed, 24 Aug 2022 22:36:53 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220825053653usoutp02456489045177c1e84a817281f0fda212~Of8jWzC000215502155usoutp02f;
        Thu, 25 Aug 2022 05:36:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220825053653usoutp02456489045177c1e84a817281f0fda212~Of8jWzC000215502155usoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661405813;
        bh=2eEQwCM5f0cgb/40KjChgtCm6qb/qVIJsTpipY171hM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pgW4E3XPqezo+m6VuWlJCV1BOncKEvAfLabbsAPsDOODGDa/fE2uMbk8f+sW5ITZb
         xvINC5bsmmRMc7dw0WX8r7cvKtojuO5LYFrJSgqiuLcvJnSvnM3ZLfHeVFWduZ8tXt
         WjlhkyBuXdgwsxHnqUHAONMYaBKqUMhBCuxQ0Z7M=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220825053652uscas1p141c0327cc8763a94de663f4e233eb829~Of8jKVDWi1009810098uscas1p17;
        Thu, 25 Aug 2022 05:36:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 63.93.35398.47A07036; Thu,
        25 Aug 2022 01:36:52 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220825053652uscas1p132794181297b3b0dd26fc5bd69d0e797~Of8i0D-Dr1010510105uscas1p1x;
        Thu, 25 Aug 2022 05:36:52 +0000 (GMT)
X-AuditID: cbfec370-82fff70000028a46-33-63070a74cc4c
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 51.4E.08434.47A07036; Thu,
        25 Aug 2022 01:36:52 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 24 Aug 2022 22:36:51 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        24 Aug 2022 22:36:51 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Topic: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Thread-Index: AQHYtklu6j3UH4AVtU69YQX5WSmWH627o7cAgAPuaYA=
Date:   Thu, 25 Aug 2022 05:36:51 +0000
Message-ID: <20220825053651.GB141173@bgt-140510-bm01>
In-Reply-To: <6303be366cd5b_1b3229487@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <403FA7A074EE5242A1E23B1DEBD4B765@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djX87olXOzJBj+vmVjcfXyBzWL61AuM
        FqtvrmG02P/0OYvFqoXX2CzOzzrFYnF51xw2i1sTjjFZbH4wmcmB06PlyFtWj8V7XjJ5bFrV
        yeYxdXa9x+dNcgGsUVw2Kak5mWWpRfp2CVwZZ1Z/ZCvYw1Ixv+UoawPjGeYuRg4OCQETiY5j
        el2MXBxCAisZJXa+OcEK4bQySfTvfsvUxcgJVvT68G4WiMRaRokPt34zQTifGCXWz+6Ayixj
        lDi7ZTsrSAubgIHE7+MbmUFsEQFtiYlzDoLZzALbmCWmbwkC2S0s4C4x+SInRImHxKH5N1kg
        bCuJTS272EBsFgFViV8H94FdwStgKnHt2F92EJsTqL5vz1owm1FATOL7qTVMEOPFJW49mQ91
        taDEotl7mCFsMYl/ux6yQdiKEve/v2SHqNeRWLD7ExvIOcwCdhK9h/MhwtoSyxa+ZoZYKyhx
        cuYTFohWSYmDK26AvSsh8IJD4v7lj1DzXSRuP70KtVda4u/dZUwQRe3A0JqwjxXCmcAoceft
        T6grrCX+dV5jn8CoMgvJ4bOQHDUL4ahZSI6aheSoBYysqxjFS4uLc9NTi43zUsv1ihNzi0vz
        0vWS83M3MQIT1ul/hwt2MN669VHvECMTB+MhRgkOZiURXqtjLMlCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeZdlbkgUEkhPLEnNTk0tSC2CyTJxcEo1MGncimOJ3RduonDSQjzPq88xe6Xup9uX
        g+fw3yprby3t1JjjPe1JbdSftpy8Cb1ps4vnmhZfrejt2HE4KyLXKeynaN2Uw1fE5AOVk+++
        TW1w93mRduT/2a6te+tUJzYrLol6fXqiuOMsDr1I27T1Gmbcq1l84z1m8+/aKqHxuSZEa+qD
        L3J33iZVf8nv/PDhziyJkiQZdWWllmPHIxe+suK7+Sb/13/pt6cjWS0V38fWVPq67GvY8J6b
        d0qFFOfG9w9/J0pesOXfumKl6suNdw8xP9ZpXznd+7FL1s06R543zAV+GsssW6YZypwUf/kk
        9m6isESsZXxX10n5m7MnWGRvl9udVX3lmvXhppYwJZbijERDLeai4kQAWn+a7scDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWS2cA0UbeEiz3Z4NEcaYu7jy+wWUyfeoHR
        YvXNNYwW+58+Z7FYtfAam8X5WadYLC7vmsNmcWvCMSaLzQ8mMzlwerQcecvqsXjPSyaPTas6
        2Tymzq73+LxJLoA1issmJTUnsyy1SN8ugSvjzOqPbAV7WCrmtxxlbWA8w9zFyMkhIWAi8frw
        bpYuRi4OIYHVjBLXv71lh3A+MUo8+DCLFaRKSGAZo8TrL5kgNpuAgcTv4xvBukUEtCUmzjkI
        ZjMLbGOWmL4lqIuRg0NYwF1i8kVOiBIPiUPzb7JA2FYSm1p2sYHYLAKqEr8O7mMCsXkFTCWu
        HfsLtfcCo8T0/UfBEpxAzX171rKD2IwCYhLfT61hgtglLnHryXwmiA8EJJbsOQ/1jajEy8f/
        WCFsRYn731+yQ9TrSCzY/YkN5DZmATuJ3sP5EGFtiWULXzND3CAocXLmExaIVkmJgytusExg
        lJiFZNssJJNmIUyahWTSLCSTFjCyrmIULy0uzk2vKDbKSy3XK07MLS7NS9dLzs/dxAiM9NP/
        DkfvYLx966PeIUYmDsZDjBIczEoivFbHWJKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ876Mmhgv
        JJCeWJKanZpakFoEk2Xi4JRqYKq5fSZcWYhzh8f28PM3LFfetPXc8C1+i0z/ZvZyhtOhf/6t
        D33KUiv+qT57xTrPzmllJ44nNR/fLmKds9b6xcauaXxXjy/cFD1z+frY72o7mHfN69qRdylQ
        wXznv2jZxDWrlj/WuGF8/dKqK1OPn49K/1vzT/9Fm0qO0km9nR0Xl6aLLVp45dWs8gPNW2bv
        /v0y/+wC9X/S70OndJp/3fE5OEaL5fXlnM4zwZ2XWK50v+lN1X2rJ9Gqz3Z2x42JDs7nuQK5
        1yu/8LkRUH0gl/VvWsyLe9rrJTe5eE7vXu0qJ5WxI/9ji7l2D5f03n0fF4tf5vS7ajBjVwmL
        Rvy+IvmZ899s/sX4disfY/UMgZJZSizFGYmGWsxFxYkApcFJm2MDAAA=
X-CMS-MailID: 20220825053652uscas1p132794181297b3b0dd26fc5bd69d0e797
CMS-TYPE: 301P
X-CMS-RootMailID: 20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
        <20220822170510.125082-1-a.manzanares@samsung.com>
        <6303be366cd5b_1b3229487@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:34:46AM -0700, Dan Williams wrote:
> Adam Manzanares wrote:
> > When reviewing the CFMWS parsing code that deals with the HDM decoders,
> > I noticed a couple of magic numbers. This commit replaces these magic n=
umbers
> > with constants defined by the CXL 2.0 specification.
>=20
> I have a small quibble with CXL_DECODER_MAX_GRANULARITY_ORDER. How about
> CXL_DECODER_MAX_ENCODED_IG? Because the value is not the 'power of 2
> order' it's the 'power of 2 order - 8'.

Sounds reasonable to me. I will also make this change in v2.=
