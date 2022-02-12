Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021DA4B32FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 05:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiBLEor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 23:44:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBLEop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 23:44:45 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C752428E20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:44:41 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220212044438epoutp04b33a252530475541e55c313e89472d48~S8FjdDfPz1728517285epoutp04X
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220212044438epoutp04b33a252530475541e55c313e89472d48~S8FjdDfPz1728517285epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644641078;
        bh=dmeKw7sjrH1sYaJQ8rlULXmQM6GP+l0eHhvgAaKtwxc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=CXSyOhb7mmBL1OHHOk4LZlEpiI0qfH3maqQo86aPqP6Zn/gjy1l6sfP/eFfNMhJOW
         ioWZUl1RvQOXLPyojO9L+64OciH99iPlVTZBfdHkHsDLLtA+PauNLzwJc3v/6UN+Ro
         bAYw83r35aN7jKUU0qMpmnMRwgsp5guTdgULJKMY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220212044437epcas2p1701d7d5aaf742f35af1fa19caaab2576~S8Fie8Pef1074010740epcas2p1s;
        Sat, 12 Feb 2022 04:44:37 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JwdDz5hKHz4x9Py; Sat, 12 Feb
        2022 04:44:35 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.65.51767.33B37026; Sat, 12 Feb 2022 13:44:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220212044434epcas2p169d006abc79a6cdcc8eb818231b577fc~S8FgHH7NG1074010740epcas2p1r;
        Sat, 12 Feb 2022 04:44:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220212044434epsmtrp246eeb06fbededf509aa03c48436f9a7d~S8FgDacb72824128241epsmtrp2Z;
        Sat, 12 Feb 2022 04:44:34 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-62-62073b33d111
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.82.08738.23B37026; Sat, 12 Feb 2022 13:44:34 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220212044434epsmtip27396de9a97e31c2b074121975d52912a~S8Ff1m9oc1836618366epsmtip2i;
        Sat, 12 Feb 2022 04:44:34 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'Avri Altman'" <Avri.Altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <cang@codeaurora.org>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Date:   Sat, 12 Feb 2022 13:44:34 +0900
Message-ID: <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI4IgZMS69T+T+3eQm0GbWo6Fi0ygFitYZoAa2Aj1kCJc0N+wFVhb0mq5rz/jA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmma6xNXuSwcunahYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLy7vmsFl0X9/BZrH8+D8mi667Nxgt
        lv57y2Jx5/5HFgc+j8t9vUwei/e8ZPKYsOgAo8f39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwB
        HFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAhysp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoT
        sjMWvFjIWjCVteLR5tMsDYz/mbsYOTkkBEwktvXOYgWxhQR2MEoc2c/fxcgFZH9ilNh99jgr
        hPOZUeLKns3sMB1X+88yQiR2MUps65sDVfWSUWLZi7Ngs9gEtCWmPdwNlhARmMksMWHLIbAE
        p4CtxNd3fUwgtrBArMSN7dfZQGwWAVWJmXvegx3FK2ApMXf7EihbUOLkzCcsIDYz0NBlC19D
        Ha4g8fPpMrCZIgJ+Eh//tkPViEjM7mxjBlksIXCGQ+LP9rtQd7tIbN51hgXCFpZ4dXwLVFxK
        4vO7vUBHcADZxRKb9slD9DYwSiz5tBmq3lhi1rN2RpAaZgFNifW79CHKlSWO3IJayyfRcfgv
        O0SYV6KjTQiiUVni16TJjBC2pMTMm3egSjwkOhdlTWBUnIXkx1lIfpyF5JdZCGsXMLKsYhRL
        LSjOTU8tNiowhMd1cn7uJkZwktZy3cE4+e0HvUOMTByMhxglOJiVRHhX3GBNEuJNSaysSi3K
        jy8qzUktPsRoCgz1icxSosn5wDyRVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUg
        tQimj4mDU6qB6WRF3K1Y2zdGM+bMm3qTTdLXMjD/lPEZ/fWf7fnydyue1Fn56/Kdy6UzQ09V
        HDoj89lvgcUpBznnUs+eWT8OLP7h0+3ylSv5j/rZNafZyjLst7g/mXLvRfD12a5VJ+qXlxqn
        avIEKrzexdN01mB+ftrMFYeWVGpttV8T4e3gpnbx7C8T7e7VsSwHvjW8XijpwvZvpXNs8NPX
        wSLNETF6PZEbrG317pnvn3ZonjDX6X5Hxn7Xi8Yn+mapTuvNqm+78CNb1IdDt+FtmRhrZA2n
        CL/1l7Uv5So/5H4/5hIS7c9y7v+ulGvlMr42mor/Z/cXT6l65h5ycs0mwXXFK+4tq/C/yhX2
        tV3tc/E03jVBSizFGYmGWsxFxYkAzGoKflsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK6RNXuSwZ8+KYuTT9awWTyYt43N
        4uXPq2wWBx92slh8XfqM1eLT+mWsFqsXP2CxWHRjG5PF5V1z2Cy6r+9gs1h+/B+TRdfdG4wW
        S/+9ZbG4c/8jiwOfx+W+XiaPxXteMnlMWHSA0eP7+g42j49Pb7F49G1ZxejxeZOcR/uBbqYA
        jigum5TUnMyy1CJ9uwSujF8f9jAXzGCt+HnhPksDYwNLFyMnh4SAicTV/rOMXYxcHEICOxgl
        nl+fyQ6RkJQ4sfM5I4QtLHG/5QgrRNFzRok1RxawgiTYBLQlpj3cDZYQEVjOLHFu1yMWiKrj
        TBIXet+DtXMK2Ep8fdfHBGILC0RLbJ/wE8xmEVCVmLnnPTOIzStgKTF3+xIoW1Di5MwnYPcx
        A214evMpnL1s4WtmiJMUJH4+XQZ2hYiAn8THv+1QNSISszvbmCcwCs1CMmoWklGzkIyahaRl
        ASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4PjU0trBuGfVB71DjEwcjIcYJTiY
        lUR4V9xgTRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB
        qfVFmujPY8eq/j5T0Zx5/9KytMp3nPt+mF/4188jvtJnv1Vm67drpw64/Nd+8fPV4ZSS2+9F
        P528/CNg6rSbXu9uvm08JPvHpo1TsdOXmedLZ8PCTt0FFzl0DlZv1mz16HjVeTVtXVbz8hf2
        xeFpu951CKt+t9jPmcI3YZr2me5D0TfWWGlFm3gtaDn7smHb5YcXc1S+xgZbHPrg8VP+gXKz
        e3jsZI633BN/bAvM7ntZJVz78oHNv3utq03u9QZxK/PXaNvu0dx60DNYwMxHKP2Lzt72+fZT
        W1Kvxn3J7agw1br/+OYZA9O/c/kXdDyY8/lkuYJ47Wr39OYVZTv8bbYJKYnV176a8+zN3PdO
        iUosxRmJhlrMRcWJAJWhqpY+AwAA
X-CMS-MailID: 20220212044434epcas2p169d006abc79a6cdcc8eb818231b577fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
        <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
        <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
        <007101d81eed$4d120a60$e7361f20$@samsung.com>
        <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The error handler really should have exclusive access.  One of the places
> you change does explain that:
>=20
>  		 * Hold the scaling lock just in case dev cmds
>  		 * are sent via bsg and/or sysfs.
>  		 */
> -		down_write(&hba->clk_scaling_lock);
> +		if (ufshcd_is_clkscaling_supported(hba))
> +			down_write(&hba->clk_scaling_lock);=20


Yeah.., I saw the comment but didn't get why.

Is there anyone who knows why it's necessary for all SoCs?
At lease, I know there is no reason to forbid concurrent executions of dev =
cmd and power mode change.

If there's nothing, how about adding a quick to ignore it?

Thanks.
Kiwoong Kim

