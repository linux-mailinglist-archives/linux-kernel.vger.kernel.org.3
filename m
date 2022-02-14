Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270B34B4E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350436AbiBNLVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:21:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbiBNLVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:21:05 -0500
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 02:55:38 PST
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4D6E295
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:55:38 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220214104910epoutp04256b59b887ffa3ade0dc2862edcdf037~ToWZw44ar2364023640epoutp04Y
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:49:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220214104910epoutp04256b59b887ffa3ade0dc2862edcdf037~ToWZw44ar2364023640epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644835750;
        bh=9RiOzpva3inwCgdkWJzVDfS0tXO2XUGRdaXnVDb18mE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FONxwvIzEGHz0/i1vDrTPYgbnqabrTZ9g2WJmPWQNy40xqppJv35QsQhCr07qXXm8
         phjKqdkfJ+Gx9lHyLH27w4jX8Ra/+j1C2VghueDYWxoFSRE/NBF5IOExWfd6hmagHL
         0Q60r/ZAK52xxG53m6bDNkTUov8xwtGHQt9k0nxk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220214104909epcas2p4063ea1a98f8a2ff223d41852f5a04f9d~ToWZJgxsW2712527125epcas2p4n;
        Mon, 14 Feb 2022 10:49:09 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jy1Dg00skz4x9Pq; Mon, 14 Feb
        2022 10:49:07 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.A7.10014.FC13A026; Mon, 14 Feb 2022 19:41:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220214104906epcas2p41a589b93685bfc47e0944856ae7caa8f~ToWWMmyQT2712527125epcas2p4h;
        Mon, 14 Feb 2022 10:49:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220214104906epsmtrp217a84b6003f3cbd5857895bac2bf353e~ToWWX7jkl2670226702epsmtrp2e;
        Mon, 14 Feb 2022 10:49:06 +0000 (GMT)
X-AuditID: b6c32a47-473ff7000000271e-d1-620a31cfb8e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.55.29871.2A33A026; Mon, 14 Feb 2022 19:49:06 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220214104906epsmtip180ec5e9b185717aa8f6009d96f09ff7f~ToWWB65Yn1475214752epsmtip1q;
        Mon, 14 Feb 2022 10:49:06 +0000 (GMT)
Date:   Mon, 14 Feb 2022 19:46:50 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v1 2/2] usb: dwc3: Prevent cleanup cancelled requests at
 the same time.
Message-ID: <20220214104650.GA127502@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Ygox+/x5zNjO5u46@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmue55Q64kgw9zrCyOtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7Iy7G7tZChqEKg7Of8HcwPiSr4uRk0NCwERi+tMrjCC2kMAORoltE+O7GLmA7E+MEg/2LWWG
        cL4xSny/fZ4VpuPWrKtMEIm9jBK7V3ewQzhPGCU+LNsPVMXBwSKgKvH6RClIA5uAlsS9HyeY
        QWwRAWOJ/rOzwOqZQdbd2P4NLCEsECsxfeJEJhCbV0BHYs76bcwQtqDEyZlPWEBsTgFNiUX7
        N4PNFxVQkXh1sB5kjoRAI4fE/wvHGSGuc5GY9Xg7M4QtLPHq+BZ2CFtK4vO7vWwQdrHErk+t
        TBDNDYwSjQ9OQDUYS8x61g42iFkgQ2L397lgyyQElCWO3GKBCPNJdBz+yw4R5pXoaBOC6FSW
        mH55AjSAJCUOvj4HNdFDYvqTLmZI8AJD8cTziAmM8rOQfDYLyTIIW0diwe5PbLOANjALSEss
        /8cBYWpKrN+lv4CRdRWjWGpBcW56arFRgTE8rpPzczcxgtOnlvsOxhlvP+gdYmTiYDzEKMHB
        rCTCG3eWM0mINyWxsiq1KD++qDQntfgQoykwmiYyS4km5wMTeF5JvKGJpYGJmZmhuZGpgbmS
        OK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBqYZFwSj5kSHzb5pXyimHHw16FjS5T98Vuaeu18z
        PDxycOmrM59i30vUuBgt7/PqjD2zgqlnDb9870r5z1rJpyuPZSdqHpm4R9p63YYvep+aHGbn
        rXS5tU+ar2nesYB9swJXczfkfNrRUGNzd83GB/9TDW5s7FnTXnH/h9LXu7ODd3DlVAR5ugae
        cjx6RCfWxdRW5FyO0x15iUdHGCZtSjnm/M57n9V//iUTuINk03v7Sr/F64m61Ar9aOOod9ls
        9FTxupbd07zDS225fZmu1k94sLxTokq7zadr4qJzUo9DtE2a9bVninUESDJpr2znzcnQXvGD
        53aPhmyypuahm+K/V811ut8b+Vb591pRFyWW4oxEQy3mouJEABWWQ8goBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO4iY64kg6VrhCyOtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        axSXTUpqTmZZapG+XQJXxv+pL9gKDvBX7G7sZGtgPMTTxcjJISFgInFr1lWmLkYuDiGB3YwS
        j3+vY4VISEosnXuDHcIWlrjfcoQVougRo8TipsVACQ4OFgFVidcnSkFq2AS0JO79OMEMYosI
        GEv0n53FDlLPLLCDUWLtsq+MIAlhgViJ6RMnMoHYvAI6EnPWb2OGGPqNUeJCzyNWiISgxMmZ
        T1hAbGagqTf+vWQCWcYsIC2x/B8HSJhTQFNi0f7NrCBhUQEViVcH6ycwCs5C0jwLSfMshOYF
        jMyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI0BLcwfj9lUf9A4xMnEwHmKU4GBW
        EuGNO8uZJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPT
        JcW5Hzk3vL0u9iV9YqTSGt81mQVaEza1hvrs3VpsKcX01CHzeuW3BTv0Vxzj049J3TNllsJl
        h9b1rZH/d76sWWUU7r9yUYf6/b3hIuwLcp8rZb/kvcAz1Ss2f8UFoQ0+7Pz+q6K3vTg23egM
        M3+36MdXHhHvk7QmX3r/qlT/hmBREsOeGqP6d5fVv/Qf0dmZ8HXdJKHTfHFznvjcdbMtYObd
        uIDnrNXG8uCupjSTeU3i8/6tex9mocZ0xMx4ilHOedsek/64PG4Dz8aW8KSuLfo+d81/Mxz4
        POHegjIW6z0rJkaG+azbfWyH26MNPkv5tT6U/I352OOxi119Y2WUfVyGhIrHAQ1bUZNHh64p
        sRRnJBpqMRcVJwIAVxqGw+8CAAA=
X-CMS-MailID: 20220214104906epcas2p41a589b93685bfc47e0944856ae7caa8f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_df482_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5
References: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5@epcas2p1.samsung.com>
        <1644831438-125403-3-git-send-email-dh10.jung@samsung.com>
        <Ygox+/x5zNjO5u46@kroah.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_df482_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 14, 2022 at 11:42:03AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 06:37:18PM +0900, Daehwan Jung wrote:
> > We added cleanup cancelled requests when ep cmd timeout on ep dequeue
> > because there's no complete interrupt then. But, we find out new case
> > that complete interrupt comes up later. list_for_each_entry_safe is
> > used when cleanup cancelled requests and it has vulnerabilty on multi-core
> > environment. dwc3_gadget_giveback unlocks dwc->lock temporarily and other
> > core(ISR) can get lock and try to cleanup them again. It could cause
> > list_del corruption and we use DWC3_EP_END_TRANSFER_PENDING to prevent it.
> > 
> > 1. MTP server cancels -> ep dequeue -> ep cmd timeout(END_TRANSFER)
> >    -> cleanup cancelled requests -> dwc3_gadget_giveback -> list_del -> release lock temporarily
> > 2. Complete with END_TRANSFER -> ISR(dwc3_gadget_endpoint_command_complete) gets lock
> >    -> cleanup cancelled requests -> dwc3_gadget_giveback -> list_del
> > 3. MTP server process gets lock again -> tries to access POISON list(list_del corruption)
> > 
> > [  205.014697] [2:      MtpServer: 5032] dwc3 10b00000.dwc3: request cancelled with wrong reason:5
> > [  205.014719] [2:      MtpServer: 5032] list_del corruption, ffffff88b6963968->next is LIST_POISON1 (dead000000000100)
> > 
> > Change-Id: I9df055c6c04855edd09e330300914454a6657a23
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > 
> > Change-Id: If87c88c3bb4c17ea1a5bde2bfec1382769f7ecab
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> 
> Why did you sign off on this twice?
> 
> And did you run it through checkpatch.pl?  It would have reminded you
> that Change-Id: should not be on patches :(
> 
> Same for patch 1/1.
> 
> Please fix.
> 
> thanks,
> 
> greg k-h
> 

Dear greg,

I'm so sorry. It's my fault when getting patches from our system.
I'm going to fix and re-send it.

Best Regards,
Jung Daehwan

------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_df482_
Content-Type: text/plain; charset="utf-8"


------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_df482_--
