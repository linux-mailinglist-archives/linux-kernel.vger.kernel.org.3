Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE814B65F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiBOIWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:22:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiBOIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:22:39 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FFAA2ED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:22:28 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220215082224epoutp02cc8120e49b2f0fa45e7c4b4d46a3bd04~T5-i4rJsm0217302173epoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:22:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220215082224epoutp02cc8120e49b2f0fa45e7c4b4d46a3bd04~T5-i4rJsm0217302173epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644913344;
        bh=aR9IgNBanjrSm2zTeMfdygWULOY+uSHTb91+dmX0z54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tZwa81LAIZI+yiCndMI2N6dgYGoHbLr/d6uPF67ZGq9MChBi9ApGDQj0fY6MPvRma
         klp0kcoi6mp7IkHFBSO/Hkk7olu1R6S8ugwv8Kx+Ay8XIpNccOAyQ+Err58LRUpUao
         jTDU4TuZQkDgSNtbsk/6UN/0zvYK7LuS7ogrMsG8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220215082223epcas2p23829b88e8864b6e7e032de0eb1ff7743~T5-id4dS_0977809778epcas2p2R;
        Tue, 15 Feb 2022 08:22:23 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JyYwr6jqZz4x9Pt; Tue, 15 Feb
        2022 08:22:20 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.74.51767.BB26B026; Tue, 15 Feb 2022 17:22:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220215082218epcas2p21276c5dabdd5bcd70d4094878e836233~T5-dqgo0e0433604336epcas2p23;
        Tue, 15 Feb 2022 08:22:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220215082218epsmtrp1ccc63d08558b7191b58c509f6add7b58~T5-dpziyz2046920469epsmtrp1H;
        Tue, 15 Feb 2022 08:22:18 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-6d-620b62bb07e8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.1D.29871.AB26B026; Tue, 15 Feb 2022 17:22:18 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215082218epsmtip1401c59283e283f9487f22cf5cf792578~T5-ddAflS1437814378epsmtip16;
        Tue, 15 Feb 2022 08:22:18 +0000 (GMT)
Date:   Tue, 15 Feb 2022 17:20:04 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Message-ID: <20220215082004.GG144890@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YgtYJ544YsvKTaxS@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhe7uJO4kg46XXBbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dsahu41MBU94Kh6c72JvYJzE1cXIySEhYCJxbvM8li5GLg4hgR2MEhNXv2WFcD4xSqxqf8UE
        4XxjlLh7uoMZpuXOr/2MILaQwF5GidYbxhBFTxglfm7fxAaSYBFQlWh89BasiE1AS+LejxNg
        zSICxhL9Z2exgzQwg+y7sf0bWEJYIFbiwrY2sGZeAR2Jjt6FTBC2oMTJmU9YQGxOAU2Jh7t/
        A8U5OEQFVCReHawHmSMh8JNdYvnro2wQ17lIbHnQzg5hC0u8Or4FypaSeNnfBmUXS+z61MoE
        0dzAKNH44ATUa8YSs561g13NLJAh8X/bdEaQZRICyhJHbrFAhPkkOg7/ZYcI80p0tAlBdCpL
        TL88gRXClpQ4+Poc1EQPid+9i6ChuI1JYk/XavYJjPKzkLw2C8k2CFtHYsHuT2yzgFYwC0hL
        LP/HAWFqSqzfpb+AkXUVo1hqQXFuemqxUYEhPLaT83M3MYJTqJbrDsbJbz/oHWJk4mA8xCjB
        wawkwht3ljNJiDclsbIqtSg/vqg0J7X4EKMpMKImMkuJJucDk3heSbyhiaWBiZmZobmRqYG5
        kjivV8qGRCGB9MSS1OzU1ILUIpg+Jg5OqQYmn8k7E5h9OLWSTrw0uXhYooQzYb/G/RkLOuz2
        HXFUWayct3PNzFzFBDcGlfwpZ2/e03z3VGeawcxj6ivf6Oz/cubd8cMn9ZtcnSOjZVfdTp7G
        y2mRk8iTURN6+Ejzubl8Ja9yXTq+3N/PkX/Z76tgmHKL6d+XWzY1eX1craVsyGT0sGPziQXM
        FfdmbQuJXLrTS+obV2n7v5Mvs9STO+SmV8xYcZ5Fb+IkbQn272XFuV+2CM425a3a/ag3YKds
        V4t7XBDzofDgSx514jcX+2lwyKyN/POm0F5VykRf3ulgoH6MV2Pb8fuH+Y/M41l8NfEVw6bX
        R7MemNuE3VeYH8qhL9G78skkZtlkLtNj6XeVWIozEg21mIuKEwEnLXxHKgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO6uJO4kg2ebVS2OtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        axSXTUpqTmZZapG+XQJXxqPDR1kKlnBVPPk4kb2B8TV7FyMnh4SAicSdX/sZuxi5OIQEdjNK
        9H+ZyQiRkJRYOvcGVJGwxP2WI6wQRY+AijZcZANJsAioSjQ+egvWwCagJXHvxwlmEFtEwFii
        /+wsdpAGZoEdjBJrl30FKxIWiJW4sK0NrJlXQEeio3chE8TUHUwSX7e9YIRICEqcnPmEBcRm
        Bpp6499LoCIOIFtaYvk/DpAwp4CmxMPdv8HCogIqEq8O1k9gFJyFpHkWkuZZCM0LGJlXMUqm
        FhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4CW5g7G7as+6B1iZOJgPMQowcGsJMIbd5Yz
        SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmgcxl782l
        yzVyJvR6tG3ds+Dj6fxp6Xs2LvAWiYx1T2TdebNzl9y6hQFbz4rrsZUvFQxYeuLQjfrLob/e
        pGxmsdpssasq4HQX48I3ayQfWu/XMxdWyRX++WffK42MNaLNGi/fRykXcDaVmO2IOHqJ96HT
        z8Ux/idStU/NXSF272R1eejjxP0F7ae38DhVLHXJi7qjtzn4x/SEBbfmJJ+3Ej2asnGq2ubJ
        MQUiLIe3nVRgWNC8P3lW86cd3nVP46wOG5w9rxX2YarZphlTjWo+3haeUXTI5yY38xEpec5z
        dbunrn4o7jHxjnFAe46d+OIbUcKMU0o8Q1hkvbgsJuzKD/C8eGDNOuVghbuWx7veK7EUZyQa
        ajEXFScCAFGcmF3wAgAA
X-CMS-MailID: 20220215082218epcas2p21276c5dabdd5bcd70d4094878e836233
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e9aa7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
        <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
        <Ygo9LZg8lxitTE8J@kroah.com> <20220215065826.GD144890@ubuntu>
        <YgtYJ544YsvKTaxS@kroah.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e9aa7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Feb 15, 2022 at 08:37:11AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 15, 2022 at 03:58:26PM +0900, Jung Daehwan wrote:
> > On Mon, Feb 14, 2022 at 12:29:49PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 14, 2022 at 08:08:52PM +0900, Daehwan Jung wrote:
> > > > It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> > > > even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> > > > skipping clear stall commmand or giveback from dequeue. We fix to set it
> > > > only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> > > > for next trb to start transfer not update transfer.
> > > 
> > > So is this two different changes?
> > > 
> > > > 
> > > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > > 
> > > What commit id does this fix?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Hi greg,
> > 
> > Below is commit id to fix.
> > 
> > commit c58d8bfc77a2c7f6ff6339b58c9fca7ae6f57e70
> > Author: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Date:   Wed Dec 18 18:14:44 2019 -0800
> 
> <snip>
> 
> Then please properly put that as a "Fixes:" tag in the signed-off-by
> area when you resubmit this.
> 
> thanks,
> 
> greg k-h
> 

I got it. Thanks.

Best Regards,
Jung Daehwan

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e9aa7_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e9aa7_--
