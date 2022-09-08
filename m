Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE35B2086
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiIHO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiIHO0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:26:24 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC58E6203
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:26:21 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220908142618epoutp0184313f57b39bfeefeb047aa7b81ba4a8~S6MyfjoH41062610626epoutp01g
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:26:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220908142618epoutp0184313f57b39bfeefeb047aa7b81ba4a8~S6MyfjoH41062610626epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662647178;
        bh=Io22rULyfccH9NtVY5N2y7sibfxe21ks9Am3qm9P/3w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aswkH4fgLCj96/9dPUNRSpOWlSDtvEZM3IMppIPKJ7XFoxZkgolXE+HRFN+BKUW8Z
         hSVuAIkDvmSu/zkrB7jkF+4uTlkGglTr74U/xubDr9CIRbvSB8PwdgecPOV4oY5leb
         mJ25iiYNtiOhTeYRW8fbc7AKm5NXTzu/qaXQO9ME=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220908142617epcas5p44ed01028cf776d59db23ab5bedbce6d3~S6Mx1GnCQ1580015800epcas5p4x;
        Thu,  8 Sep 2022 14:26:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MNhJ66J3Pz4x9Pw; Thu,  8 Sep
        2022 14:26:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.C0.59633.68BF9136; Thu,  8 Sep 2022 23:26:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220908115432epcas5p419e6aff5e3bc53932a867c31d8d8789a~S4ISqTc673027930279epcas5p4s;
        Thu,  8 Sep 2022 11:54:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220908115432epsmtrp11df4ac1a86d6ec11d4a4a48ec792e840~S4ISo5TxP1477414774epsmtrp1d;
        Thu,  8 Sep 2022 11:54:32 +0000 (GMT)
X-AuditID: b6c32a49-dfdff7000000e8f1-77-6319fb86ca1b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.D3.14392.8F7D9136; Thu,  8 Sep 2022 20:54:32 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220908115429epsmtip24ee6e0bb066ec5405c5ed7221e145a67~S4IPUKUX30257402574epsmtip2z;
        Thu,  8 Sep 2022 11:54:29 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>,
        "'Smitha T Murthy'" <smitha.t@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <andi@etezian.org>,
        <david.plowman@raspberrypi.com>, <dillon.minfei@gmail.com>,
        <stanimir.varbanov@linaro.org>, <jernej.skrabec@gmail.com>,
        <andrzej.hajda@intel.com>, <hverkuil-cisco@xs4all.nl>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <aswani.reddy@samsung.com>,
        <benjamin.gaignard@collabora.com>, <m.szyprowski@samsung.com>,
        <ezequiel@vanguardiasur.com.ar>, <pankaj.dubey@samsung.com>,
        <krzk+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <mchehab@kernel.org>,
        <linux-fsd@tesla.com>, <alim.akhtar@samsung.com>,
        <aakarsh.jain@samsung.com>
In-Reply-To: <1662563606.630951.3457340.nullmailer@robh.at.kernel.org>
Subject: RE: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Thu, 8 Sep 2022 17:24:18 +0530
Message-ID: <000001d8c379$c232d500$46987f00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwYET59QqMDNmfP0SYfUTdtmHMHgGIcczBAeDI2w8CHT/w+6z5+ybQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zTVxTHd9tfH7hVfzyclyKK1ZkBAq3yuHWCS3DNz80tZBqXsDHoym8F
        KW3XFlEWI8PBQlN1JGxIV8rTsqHIhNIWqCDYjsgIk8zZhVEeA3nNLTxEEJe5QsvGf59zzvec
        c8+5OUyqTwWDzUyXqkiFVCjh0DdhpjvBIWEFz/xF3AlHOHpoKaWhEb2JjqqXJylouHoBQ11N
        zQxkvP8NFdV236ahclsfDZk7f8fQzSlXtL/UiaHJ8hsATWuH6Khx7AENjc68h35u1dGR5vtm
        Gqq3ORnoqqOfggyNf1NQVfNjBsq/ZWOg51YLAzmtJoA+L7BRXvcnruuvA8LirAGEo2aeSrRo
        nQyi2jpNIRrrCunE4AMrnWiqOU/k21cw4pKxDhD/5JUxCLXNQScWGncQPYsLjITNiRmH0khh
        KqkIIqUiWWq6VBzLeet4cnxyVDSXF8bjoxhOkFSYScZyjhxLCBOkS1y74ASdFkqyXK4EoVLJ
        iYg7pJBlqcigNJlSFcsh5akSeaQ8XCnMVGZJxeFSUnWQx+Xuj3IJUzLSjJ1jNHnry2eKWs2M
        XPCZrxp4MSEeCdW/LmFqsInpg7cBOK8po7mNeQAHLlbQ3cYTAEdurtDXU4bUGk/gFoC/tedR
        3MYkgK1llYxVFR2PgMM9Gtoq++HH4aWfWtbqUnE9Dd5tmV8TeeECOJo7tybyxU/Cb6dqqauM
        4XvghbaiNQ0L58OhgSUPe8O7pePYKlPxndD8p47qflIQfPrQ4GkmgHmPiuhuzTZof6rxaAa8
        4OwMqQZMFx+Bc7mn3G5fONNtZLiZDacvF3hYBMeqpj2pEthgLcbcfBjevq/DVstQ8WDY0Brh
        dgfCr3puUNxdN8OLz8Ypbj8LWvTrvBfqBpdpbt4O71y7Cr4EHO2GwbQbBtNuGED7f7cKgNUB
        f1KuzBSTyig5T0pm//fhIllmI1g7lZCjFuAcmQ3vAhQm6AKQSeX4sbbWQ5EPK1V4NodUyJIV
        WRJS2QWiXNsuorK3imSuW5OqknmRfG5kdHR0JP9ANI+zjVUcCkQ+uFioIjNIUk4q1vMoTC92
        LiUwWzWlXhgJ3bO8y7r7Te+AM3jfQYOw5PwCq+HKJ5+aeX7x+sf7qg0luV/0SN45faXkETfH
        /nUVf4mWFPyCbcdsc1PAaP3gluJ3szsu/6U9Szfv6x4uZw2WW2J4eT0Ge+9UgLh2jp3Trkvc
        vtJSfI3yml+i5LBpZ1O8aXfvuTkWs7OlkroI9r9EmmS7rBMdfwjetod6x/vfO1f5wcdNenzp
        lyllSrn5w5PGtP5CjThlbEtA3/OSuAtJb2iOFaY7TvX1xrBK7v2ocLQlCjrsA+/HTQhe7M9J
        1rSzjaTwO61BNzaYzzQsntj8ZKnohyTe+CvSo2UfhRqxqpG5vVGB/BOvHuBgyjQhL4SqUAr/
        BYMGuZ+zBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZdlhJXvfHdclkg75PmhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4v+e
        HewWd/dsY7RoaTvC5CDpsWbeGkaPHXeXMHpcX/KJ2WPnrLvsHov3vGTy2LSqk83jzrU9bB6b
        l9R7tB79xeLRt2UVo8e/prnsHl1HrrN5fN4k53Hq62f2AL4oLpuU1JzMstQifbsErowtBx+z
        FuwSq5i4azt7A2OjcBcjJ4eEgInEva4eNhBbSGA3o0RXkyJEXEbif9sxdghbWGLlv+fsEDVP
        GSW+TAwAsdkE9CXun+phBbFFBIIl1qz7D1TDxcEssI1VYu7DlSwgjpDAZ0aJSRe2s4BUcQq4
        STxs+AjWISwQInHi+gKwzSwCKhLNuyeCbeAVsJS4d+s7lC0ocXLmE6BeDqCpehJtGxlBwswC
        8hLb385hhjhOQeLn02VQR7hJNL2ZyAZRIy5x9GcP8wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRM
        LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQITipamjsYt6/6oHeIkYmD8RCjBAezkgiv6FqJ
        ZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYTALcdr5f
        2dPhLD770CpGmyJl/1el/4NnCT1ccHSNwvnX5ww7MrI9+GLz1TXZ7dzEVHn/7TEqUrv7JLE7
        RnXF3ZAtZXnRq2f88K+QKMnQ4d1lqX558YKd70LM+jccnTphyZopsieeblCzOfLCJ+T9jvyv
        b/J/v0mLmW42x3pp4MxfHBw73XfxVGY9/ciqqOMbW+wtnd8XqFOZULNx4dF12SyvLFznX9to
        d3zCp8MKZx7+XuFcMOWQmeXTVXlPur8axT58pCvNLnbxuqpG+PP3hUIt83U2x87+zDiLSV3m
        5oR7/AdUp3Tc3jutZEJZ1qHtlQLmhzV/+V45YX3a8f91UVYZbsvotyvZFhxSPNVVqsRSnJFo
        qMVcVJwIADeovwiZAwAA
X-CMS-MailID: 20220908115432epcas5p419e6aff5e3bc53932a867c31d8d8789a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7@epcas5p1.samsung.com>
        <20220907064715.55778-2-smitha.t@samsung.com>
        <1662563606.630951.3457340.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 07 September 2022 20:43
> To: Smitha T Murthy <smitha.t@samsung.com>
> Cc: linux-kernel@vger.kernel.org; aakarsh.jain@samsung.com;
> andi@etezian.org; david.plowman@raspberrypi.com;
> dillon.minfei@gmail.com; stanimir.varbanov@linaro.org;
> jernej.skrabec@gmail.com; andrzej.hajda@intel.com; hverkuil-
> cisco@xs4all.nl; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; robh+dt@kernel.org;
> aswani.reddy@samsung.com; benjamin.gaignard@collabora.com;
> m.szyprowski@samsung.com; ezequiel@vanguardiasur.com.ar;
> pankaj.dubey@samsung.com; krzk+dt@kernel.org;
> devicetree@vger.kernel.org; linux-media@vger.kernel.org;
> mchehab@kernel.org; linux-fsd@tesla.com; alim.akhtar@samsung.com
> Subject: Re: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
> 
> On Wed, 07 Sep 2022 12:17:01 +0530, Smitha T Murthy wrote:
> > Adds DT schema for s5p-mfc in yaml format
> >
> > Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > ---
> >  .../devicetree/bindings/media/s5p-mfc.txt     |  77 +------------
> >  .../bindings/media/samsung,s5p-mfc.yaml       | 109
> ++++++++++++++++++
> >  2 files changed, 110 insertions(+), 76 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.example.dts:21.11-12 syntax error FATAL ERROR: Unable to parse input
> tree
> make[1]: *** [scripts/Makefile.lib:384:
> Documentation/devicetree/bindings/media/samsung,s5p-mfc.example.dtb]
> Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1420: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://protect2.fireeye.com/v1/url?k=88c9803a-e9429571-88c80b75-
> 74fe485fb305-6955573d9da6ae9f&q=1&e=4823af8c-cd6a-4171-9c03-
> cf0e37ae544b&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F
> 
> This check can fail if there are any dependencies. The base for a patch
series
> is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
error(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

we didn't got any errors while running dt_binding_check with path to the
yaml file but we are seeing errors while running  dt_binding_check without
path.
we will fix it in next series.

Thanks for the review.


Thanks,
Aakarsh 




