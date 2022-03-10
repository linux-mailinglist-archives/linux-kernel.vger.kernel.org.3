Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAA4D410C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiCJGSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiCJGSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:18:36 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11F3B3C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:17:34 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220310061732epoutp0451c68153983518eac72925abbb9446b9~a8IFcM8He2916329163epoutp04y
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220310061732epoutp0451c68153983518eac72925abbb9446b9~a8IFcM8He2916329163epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646893052;
        bh=QponPmly79j560pf6NtCTq2ma4P/r+A5My0kA9Y/pYc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=HhKPVXaK6QIRqIpRtRu1cCATRCDBwx7ArH85Bpcu9KaHblCEIQUDdz8Rx2L35+KRt
         zPI31/yfz5UlC6z/s8VhZbBi2NxUNdO4wcgIBhWYFUbROmgvGh/Cgyu3+Kl0GJIANs
         HdiP4qXPe5OAzO4veO9usPxcFXx+BlGtO5tiHebA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220310061731epcas2p34cbd032c5dd5d281d9c04a00686fc718~a8IE0DBud0936509365epcas2p3U;
        Thu, 10 Mar 2022 06:17:31 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KDf46278cz4x9QM; Thu, 10 Mar
        2022 06:17:26 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.93.16040.6F799226; Thu, 10 Mar 2022 15:17:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220310061725epcas2p4e3bcdba3a6a6aabb6c6eecfadbf6ac50~a8H-grf_F1090410904epcas2p47;
        Thu, 10 Mar 2022 06:17:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220310061725epsmtrp17fd49ab945c1172ba4ebd738b5b78488~a8H-fPgrV2785227852epsmtrp1k;
        Thu, 10 Mar 2022 06:17:25 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-fd-622997f6c176
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.A2.29871.5F799226; Thu, 10 Mar 2022 15:17:25 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220310061725epsmtip18001a5a3c8eeca77234cce855e2e56ec~a8H-QB2_m2500525005epsmtip15;
        Thu, 10 Mar 2022 06:17:25 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <cang@codeaurora.org>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <b2909fd3-fa5b-9471-fb9c-6f068a1ab871@intel.com>
Subject: RE: [PATCH v2] scsi: ufs: exclude UECxx from SFR dump list
Date:   Thu, 10 Mar 2022 15:17:25 +0900
Message-ID: <009901d83446$82e6d2b0$88b47810$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbUdINlb+WjwqJcHkSSmtt4+at5wKQFrFvAhjHt56rjKIyMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmme636ZpJBkfeclucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBaf1i9jtVi9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYvFnfsfWRz4PC739TJ5LN7zksljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMF
        cERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHa6k
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpM
        yM7oWHaXveAIW8WH83/YGhibWLsYOTkkBEwkmjb9Yu5i5OIQEtjBKPHt0nwo5xOjxIxjt6Gc
        b4wSD76+ZYdpOfXiAxNEYi+jxORzBxkhnJeMEqf27mYBqWIT0JaY9nA3K0hCRKCdWeLKxrNA
        DgcHp4CtxKuDriA1wgLOEp2b+sHqWQRUJfZffgW2gVfAUuLV6juMELagxMmZT8BqmAXkJba/
        ncMMcYWCxM+ny8CeEBFwkvhydCoTRI2IxOzONrCzJQSucEjM2dsN9amLxO1fT6BeEJZ4dXwL
        lC0l8bK/jR3kNgmBYolN++QhehsYJZZ82swCUWMsMetZOyNIDbOApsT6XfoQ5coSR25BncYn
        0XH4L9QUXomONiGIRmWJX5MmM0LYkhIzb96BWuohMXv1deYJjIqzkDw5C8mTs5A8Mwth7wJG
        llWMYqkFxbnpqcVGBUbwyE7Oz93ECE7TWm47GKe8/aB3iJGJg/EQowQHs5IIb1OoRpIQb0pi
        ZVVqUX58UWlOavEhRlNgsE9klhJNzgdmirySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp
        2ampBalFMH1MHJxSDUybw/nvKP1mOWmp7H1l2cxK4YgbT5ZNW1bpKPIm8Mw9+zXbXEVq4tcY
        SixTFpm2W5eVs6tss0fDkSLVN1XbV0mXPejT/Hw4tHhBZgJv9QfRl66N4fFVx64EXV1tmZAz
        X+/Nn1k536frPcs1TFDTnhmh/Dnm7ESRf3feLdTquls9t3HPn82TTRp23r6SkZ+UPMWn5m8M
        Y6+4+rcdpuuMU0qMtvzs1W6fqnBQsU5po11MUfqFqWfv7OneunnhzImcTzn+/29O8ewvitY5
        fyXxR4t9Zmm9cteftv+au694Lfy+0lRbsPKJxs1dP69dWcLN06Jt22q07u36xMC44Dr9Rxdn
        qlv0FSvXWvH1PN3QLKHEUpyRaKjFXFScCADLBDWMXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnO7X6ZpJBmdmqVucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBaf1i9jtVi9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYvFnfsfWRz4PC739TJ5LN7zksljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMF
        cERx2aSk5mSWpRbp2yVwZXQsu8tecISt4sP5P2wNjE2sXYycHBICJhKnXnxg6mLk4hAS2M0o
        MePjOnaIhKTEiZ3PGSFsYYn7LUdYIYqeM0r83zeVCSTBJqAtMe3hbrCEiMB0Zom9dz8yQlSd
        YJSY+2IZkMPBwSlgK/HqoCtIg7CAs0Tnpn4WEJtFQFVi/+VXYNt4BSwlXq2+wwhhC0qcnPkE
        rIYZaEHvw1ZGCFteYvvbOcwQFylI/Hy6DOwFEQEniS9HIQ5iFhCRmN3ZxjyBUWgWklGzkIya
        hWTULCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEenluYOxu2rPugdYmTi
        YDzEKMHBrCTC2xSqkSTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKY
        LBMHp1QD06QZB71e37Ra1DOvsGvfk2j1IO2UI0bLHcLP8qzecjTJ6I6s5bE5jSt8+Ir63l9d
        8k7htMG6mZ/Xaf0S+LTtuf90Q7mLrw90XWmV33+RU+9NyLGq+bZ1X8qeMki9Fl+yvVrvj41B
        rRLfnYPCXPF8LkWfOlVOcN03En6R+XXhLz3ZotCK98YdITvqfK6yT125rGLLBelzxm3dQkf7
        whRqbJ/Us7DXCLx8uWKWZrdfuN+B5K8t4a4r/lsITnxacGSP5q0GDgGbWfcf186rYW7zMtn9
        7eM7g8Jl79ca5345qH300VH7qYs2XQhwTv1otY87QaZa/MJb++mZzxUiZmQ9XfDuw9bJlolM
        38WM3RKjepVYijMSDbWYi4oTAcMjvcg9AwAA
X-CMS-MailID: 20220310061725epcas2p4e3bcdba3a6a6aabb6c6eecfadbf6ac50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68
References: <CGME20220308081304epcas2p4e7279fb51babf93fdf0bf0a3aacf9f68@epcas2p4.samsung.com>
        <1646727118-87159-1-git-send-email-kwmad.kim@samsung.com>
        <b2909fd3-fa5b-9471-fb9c-6f068a1ab871@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > These are ROC type things that means their values are cleared when the
> > SFRs are read.
> > They are usually read in ISR when an UIC error occur.
> > Thus, their values would be zero at many cases. And there might be a
> > little bit risky when they are read to be cleared before the ISR reads
> > them, e.g. the case that a command is timed-out, ufshcd_dump_regs is
> > called in ufshcd_abort and an UIC error occurs at the nearly same
> > time. In this case, ISR will be called but UFS error handler will not
> > be scheduled.
> > This patch is to make UFS driver not read those SFRs in the dump
> > function, i.e. ufshcd_dump_regs.
> 
> This is essentially a fix, so perhaps a fixes tag?
> 
> Wouldn't hurt to wrap the commit description more nicely.


Thank you for your opinion.


Thanks.
Kiwoong Kim

