Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF14B9AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiBQIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:15:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiBQIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:15:33 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E7284206
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:15:18 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220217081512epoutp014e2181a5120934770b43b140f6467948~UhL1dJfBN1256812568epoutp01Z
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220217081512epoutp014e2181a5120934770b43b140f6467948~UhL1dJfBN1256812568epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645085712;
        bh=PxKHSvSDD9SRnI9pCL+FrHkguRUyZLd5NCaPMnah4+k=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=YQYpdFhVQqNaIkRikX2wGeZcg2HvF1ac1PG9QMlwTzDqKanIA2Q/wTlgt+mhvwRZE
         fz0A84elY8O/8ryWQ9IaTwKVzg9pzY2/HS56radtXMXm6U1DedeSh5mM0Qi0M6J9az
         FffIkJFFWOw0ryn02dJddGZaEkvUa9DVVAbSNh7g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220217081512epcas2p32985d24849fe53ecdd697cd8db726b91~UhL06eHYm2518425184epcas2p3V;
        Thu, 17 Feb 2022 08:15:12 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jzngf1bJzz4x9Pw; Thu, 17 Feb
        2022 08:15:10 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.4C.25540.EB10E026; Thu, 17 Feb 2022 17:05:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220217081509epcas2p2a9dd27625b58114fa924cca85e4ccb9e~UhLyaMQ2x1998919989epcas2p2C;
        Thu, 17 Feb 2022 08:15:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220217081509epsmtrp1f5be47c91c1e112461276ce17933dd22~UhLyZMFBK0095700957epsmtrp1F;
        Thu, 17 Feb 2022 08:15:09 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-46-620e01be80bc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.84.29871.D040E026; Thu, 17 Feb 2022 17:15:09 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217081509epsmtip1522d8503416a31cd685378797292d3b7~UhLyM0ISL2286322863epsmtip1P;
        Thu, 17 Feb 2022 08:15:09 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <cang@codeaurora.org>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <6b298597-f3b3-e4a1-c59a-f704ad4c06e5@acm.org>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Date:   Thu, 17 Feb 2022 17:15:09 +0900
Message-ID: <015701d823d6$7a9e5540$6fdaffc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI4IgZMS69T+T+3eQm0GbWo6Fi0ygFitYZoAW3RkEABzyLjwgIcJuVSq6GJ2YA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmme4+Rr4kg/ajRhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVlc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XL7i7XG5r5fJY/Gel0weExYdYPT4vr6DzePj01ssHn1bVjF6
        fN4k59F+oJspgDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGm1tzGQvWsVZs293A3MA4j6WLkZNDQsBEYsHF/exdjFwcQgI7GCVOdb9i
        hnA+MUocbnsLlfnGKLF21yJ2mJabp1sZIRJ7GSU27/3ICuG8ZJTob7jBBFLFJqAtMe3hbrCE
        iMB8Zokv5xexgiQ4BawlFrQ2MYLYwgKxEje2X2frYuTgYBFQlVj13QAkzCtgKTHx+m42CFtQ
        4uTMJ2DHMgvIS2x/O4cZ4goFiZ9Pl7GCtIoI+Ems2WMJUSIiMbuzDewFCYEHHBIHbm+AetRF
        4saOnWwQtrDEq+NboL6RknjZ38YOMkdCoFhi0z55iN4GRoklnzZD9RpLzHrWzghSwyygKbF+
        lz5EubLEkVtQl/FJdBz+CzWFV6KjTQiiUVni16TJjBC2pMTMm3egSjwkOhdlTWBUnIXkxVlI
        XpyF5JdZCGsXMLKsYhRLLSjOTU8tNiowhkd1cn7uJkZw0tZy38E44+0HvUOMTByMhxglOJiV
        RHg/HORNEuJNSaysSi3Kjy8qzUktPsRoCgzzicxSosn5wLyRVxJvaGJpYGJmZmhuZGpgriTO
        65WyIVFIID2xJDU7NbUgtQimj4mDU6qBKWzRHGG73xNc29cwbpt0Zr7CGcYPLJP+rLcVae3O
        dEz4kH7bcm1AvNt/hau579fuuN52KH6LkgW7psI8tvzA5rrioLlpZ2+VyseuU/8Uvi6rXOhG
        fYHmhR+J6os/9z6P3vMmYN/2Z6ymdi5LJZKndBixl59h3/9bVPar2Yu8tbOmT9kbWjZDk1si
        oslz1lP/29+lHMPK5UX3Mi9Rm/x41sp2ja1tiyfIxP84tN62leMQ9ye/Z9xeUQr1X5srXhle
        +SAmtXIKe8aL/kr57i2JImWZr7ZPzDh3ZOq9BTs/8JetPvb/kfqRT9nH+O/8bvZfelKe+b9a
        SXuJ5P9YAzdtIZ2wE1FPlRqrJi9a8vFduxJLcUaioRZzUXEiAGfSrutjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnC4vC1+SwedV8hYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVlc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XL7i7XG5r5fJY/Gel0weExYdYPT4vr6DzePj01ssHn1bVjF6
        fN4k59F+oJspgDOKyyYlNSezLLVI3y6BK+PNrbmMBetYK7btbmBuYJzH0sXIySEhYCJx83Qr
        YxcjF4eQwG5GiSWX/jFBJCQlTux8zghhC0vcbznCClH0nFFixvGFYN1sAtoS0x7uBkuICGxk
        lljb9gBq1GImiRN3joGN4hSwlljQ2gQ2SlggWmL7hJ9AcQ4OFgFViVXfDUDCvAKWEhOv72aD
        sAUlTs58AraAGWhB78NWRghbXmL72znMEBcpSPx8uowVZIyIgJ/Emj2WECUiErM725gnMArN
        QjJpFpJJs5BMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOBo1dLcwbh9
        1Qe9Q4xMHIyHGCU4mJVEeD8c5E0S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklq
        dmpqQWoRTJaJg1OqgUljh8EzQ2Phw+c2JPyROrIo8Vheb/SRX/9Orrv4SJCXR/3NtIiLVqYp
        m23Xr9n11PzMpK+MBhYrnZr/zS85FaJf+FLY+9Pi+U93aWROfGV5+6Ear8P3GU2Hfybcer/p
        5NRa/RqOlsLt24u27NxwpPDyjW/5j8JeMbpIzZ3ueEtc3Wjidm3GcNNX4vsz/l3OZDHlNcjf
        1r8+44DeloqmuQHFalbhn1S6p37Q2bF/m75wQxHrwd2cAemL6m9K9l4rcTo0Ie2H/rz+G3If
        Xxp+vHNJvOfuzrme/7fn2m9hFJyeXntIuGWalnMCT49+wm2d3+6Z0zQ0dfXrud9r9ZTob77+
        6HfLFreJspwfZ/k7m55XYinOSDTUYi4qTgQA7kotv0UDAAA=
X-CMS-MailID: 20220217081509epcas2p2a9dd27625b58114fa924cca85e4ccb9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
        <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
        <62a5170b-48c0-a372-5392-08f5112d7a06@acm.org>
        <007e01d82231$be8be250$3ba3a6f0$@samsung.com>
        <6b298597-f3b3-e4a1-c59a-f704ad4c06e5@acm.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2/14/22 22:03, Kiwoong Kim wrote:
> > The benefit that I think is not blocking dev cmd during submitting a
> scsi cmd.
> 
> Hi Kiwoong,
> 
> Both ufshcd_exec_dev_cmd() and previous versions of
> ufshcd_queuecommand() obtain a reader lock on the clock scaling lock so
> concurrent submission of both command types is allowed. I'm not aware of
> any version of the UFS driver that serializes device commands against SCSI
> commands.
> 
> Additionally, please take a look at commit 8d077ede48c1 ("scsi: ufs:
> Optimize the command queueing code"). That patch removes the clock scaling
> lock from ufshcd_queuecommand().
> 
> Thanks,
> 
> Bart.

Okay, I got it.

