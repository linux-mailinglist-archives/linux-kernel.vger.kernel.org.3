Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE658751B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiHBBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHBBjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:39:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49EFDF61
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:39:05 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802013859epoutp01654ba17ee8175e7449b8cc25f8bdbb3e~HY3RrgIoG2199021990epoutp01N
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:38:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802013859epoutp01654ba17ee8175e7449b8cc25f8bdbb3e~HY3RrgIoG2199021990epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659404339;
        bh=xw9z0IxRZw8PjzpETeDaFEZVELGr2AIVYnF7tMkBhOY=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=kvC26qaQpYg9SjCdn9FPEsDwT8cXjKmJIbUYCs2jDC9f60N9f58Nu8OsSuxKpVgoF
         nWDZVlT7GKUzfErjF9kGL9TG14V8ZQ4R0gM/QZeLCKOsf9HQU1SnAARNOCrfxTRJ+M
         BmeDTQ9IKJ50DfRS00a+2YTRU2vH0FhyCH1v047M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220802013858epcas2p258e3e00b51d448966cf4530f8041d71d~HY3RFq-CX0590205902epcas2p2H;
        Tue,  2 Aug 2022 01:38:58 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lxd1t2XJBz4x9QB; Tue,  2 Aug
        2022 01:38:58 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.C0.09662.23088E26; Tue,  2 Aug 2022 10:38:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220802013857epcas2p4c286702683bc8c08905016f50096ecab~HY3QNI7vf0143901439epcas2p4B;
        Tue,  2 Aug 2022 01:38:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220802013857epsmtrp28c86d0e5da49f576bad02189ae62d3ea~HY3QMEl6Y3158331583epsmtrp2S;
        Tue,  2 Aug 2022 01:38:57 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-7e-62e88032611a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.B9.08802.13088E26; Tue,  2 Aug 2022 10:38:57 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220802013857epsmtip1ea448e7c23ec3b98638d2ab08d96b186~HY3P_5fNC3059430594epsmtip1T;
        Tue,  2 Aug 2022 01:38:57 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <adrian.hunter@intel.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <bhoon95.kim@samsung.com>
In-Reply-To: <1809cefc-0c59-ef6c-c3da-7695722a8b78@acm.org>
Subject: RE: [RESEND PATCH v1] scsi: ufs: enable link lost interrupt
Date:   Tue, 2 Aug 2022 10:38:57 +0900
Message-ID: <00dd01d8a610$a2136fe0$e63a4fa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpOkUG0t00dn0mHLEw74dXOqQj4gFq7LAsAoPYMSms2jZf0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmma5Rw4skg9XnBC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotpH34yW6xe/IDFYtGNbUwWl3fNYbPovr6DzWL58X9MFl13bzBa
        LP33lsWB1+PyFW+PxXteMnlMWHSA0eP7+g42j49Pb7F49G1ZxejxeZOcR/uBbqYAjqhsm4zU
        xJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygk5UUyhJzSoFC
        AYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2Rmzlzcx
        Fyxlrjjyt5mpgXEnUxcjJ4eEgInEiZdnWEBsIYEdjBJNJ0u6GLmA7E+MEg09jxghnM+MEqt6
        brPCdDxe1ssOkdjFKDHjxmp2iPaXjBKbThaA2GwC2hLTHu5mBSkSEXjNJNG66TxYEaeAtcTi
        FcvAbGEBF4mrb7eDTWURUJFo6bzPDGLzClhKTF18mhHCFpQ4OfMJ2H3MAvIS29/OYYa4QkHi
        59NlYL0iAk4Sf+bsYoaoEZGY3dnGDLJYQuAMh8THg3eAlnEAOS4SUzbyQvQKS7w6voUdwpaS
        +PxuLxtESbHEpn3yEK0NjBJLPm1mgagxlpj1rJ0RpIZZQFNi/S59iHJliSO3oC7jk+g4/Bdq
        Ea9ER5sQRKOyxK9JkxkhbEmJmTfvQC31kNj7qJt9AqPiLCQ/zkLy4ywkv8xC2LuAkWUVo1hq
        QXFuemqxUYEJPKqT83M3MYLTspbHDsbZbz/oHWJk4mA8xCjBwawkwnvH5XmSEG9KYmVValF+
        fFFpTmrxIUZTYKhPZJYSTc4HZoa8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWp
        RTB9TBycUg1Mdtz8aTne5oV1PzftNM26P9Ov7GjeXIG9ey8GdbyPNvuZ0OGW+U9E9P/EDSeD
        T00ufKjJFpn8WapF/Pnt2h+3/T7/+iJRoREqv0BfXvLX39/hn7kX/OD7/ZJHeqn28XR7gbmG
        d5zlbmWffnuwO9Clr2v+NY/L6xzF9pz7yCd+dv2H+Co9qQ8uD3nO6r03eeP+7Omxw1cVV7MG
        pqR/OujXlKAVclkz+X3I5/QU7+9fXR89u8vwQzvqclK/yqOkP/UeMusPT34VfTPSoC6i/NqG
        lKny8qz9HTfZtuV9mS7Eqjzv3iQp3yX7QuVrHpnNKnTLXrnT2aNtrXzmstyKSfUPMl+fEFuY
        uIbhZJTHGs5yJZbijERDLeai4kQAnKmpHFQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnK5hw4skg5MPtSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotpH34yW6xe/IDFYtGNbUwWl3fNYbPovr6DzWL58X9MFl13bzBa
        LP33lsWB1+PyFW+PxXteMnlMWHSA0eP7+g42j49Pb7F49G1ZxejxeZOcR/uBbqYAjigum5TU
        nMyy1CJ9uwSujNnLm5gLljJXHPnbzNTAuJOpi5GTQ0LAROLxsl72LkYuDiGBHYwStzd8ZoZI
        SEqc2PmcEcIWlrjfcoQVoug5o0Tj3K8sIAk2AW2JaQ93gyVEBH4zSex7NwusW0jgOKPE66P+
        IDangLXE4hXL2EFsYQEXiatvt7OC2CwCKhItnffB6nkFLCWmLj7NCGELSpyc+QRsATPQgt6H
        rYwQtrzE9rdzoK5TkPj5dBnYHBEBJ4k/c3YxQ9SISMzubGOewCg0C8moWUhGzUIyahaSlgWM
        LKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjUktrB+OeVR/0DjEycTAeYpTgYFYS
        4b3j8jxJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqaT
        T5YnpsyOeX5aqVVomlBHwqRLiy5KubneuR17YZXS1WzDE/brnp5Suy4m4co3X+Ug+wK7B7tM
        pCe5rD5g/IV1+82uR/7CNs0/X8QpXqtU3xbscblv4U/9D2pTnD1+xpjdzT2x0Nsiyy5GbAvH
        vP07bURZJTzuPBD83Wppdsfmb4pPHbew4Dfr3PB//3utS98yC+XNPi7l+iHwkfVMg3Nrwt1s
        VglbyWjFZhp7fDi4U0GwR9W6uiq2q1tje+X/5vOWl1a9v26oMjWGn8HO88/iM5HrjJtnl3/b
        dsnje2O7d/GvLM0tr764dv2Rs5mnanb9eeCjT6uXHfh662trbHj7gfgp8+9l6Zu4sX85tk6J
        pTgj0VCLuag4EQDGeExnNwMAAA==
X-CMS-MailID: 20220802013857epcas2p4c286702683bc8c08905016f50096ecab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155
References: <CGME20220801031300epcas2p25866dfc0158ecdd33ef18c44aa23b155@epcas2p2.samsung.com>
        <1659323380-161341-1-git-send-email-kwmad.kim@samsung.com>
        <1809cefc-0c59-ef6c-c3da-7695722a8b78@acm.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Link lost is treated as fatal error with the following patch, but its
> > event isn't registered as interrupt source, so I enable it.
> > --
> > scsi: ufs: Treat link loss as fatal error
> 
> Is this patch perhaps intended as a fix for patch "scsi: ufs: Treat link
> loss as fatal error"? If so, does it need a Fixes: tag?
> 
> Thanks,
> 
> Bart.

Right and let me add the tag.

Thanks.
Kiwoong Kim

