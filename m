Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6772512D79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbiD1H6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiD1H57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:57:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B15F253
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:54:44 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220428075442epoutp025169229d268b9926a933412f9a9e4d5e~qAD6WfwUV2115421154epoutp02K
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:54:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220428075442epoutp025169229d268b9926a933412f9a9e4d5e~qAD6WfwUV2115421154epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651132482;
        bh=ezbrraO8aVmu2laJsDo6jcJ3FLv2F245TKkCYuIqyHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=otWKbaVxjlX9bFAq8CJP7AuCPO/c3nf7Dwxf8uzjg8fkLTzcODn0QwDaoZcJyde4V
         YxhdO9Ospw9Wz27OSLhM5JSXF0NN0fT29DDl+dV4GZjc68k+8aJLoNpebJV7zzi40u
         IO7k4P6S0yVy747u/9mVRaZ5FaaI7OIPNUj2T7KI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220428075441epcas2p4a1cccd2ad3e178104bc6098cf5ebe21d~qAD5e1PfZ1539415394epcas2p4a;
        Thu, 28 Apr 2022 07:54:41 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kpnvg4HGqz4x9Q3; Thu, 28 Apr
        2022 07:54:39 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.35.10069.B384A626; Thu, 28 Apr 2022 16:54:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220428075434epcas2p1792bc1c96afd57aff3af85c82761b99e~qADzfhaZZ1912219122epcas2p1L;
        Thu, 28 Apr 2022 07:54:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428075434epsmtrp109bfd176b36bf1fff984b3ba672a5bad~qADzev3nA1575615756epsmtrp1R;
        Thu, 28 Apr 2022 07:54:34 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-c1-626a483bf3ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.BF.08924.A384A626; Thu, 28 Apr 2022 16:54:34 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428075434epsmtip12106b10af694ea89b2a9eaf5a55e51f9~qADzSWFpf1899518995epsmtip14;
        Thu, 28 Apr 2022 07:54:34 +0000 (GMT)
Date:   Thu, 28 Apr 2022 16:53:05 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <20220428075305.GH151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <fa113ba0-1221-de93-a18f-e4e942cdb261@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmma61R1aSwfcHYhZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6U0mhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnXFixlLmgp+cFS/2ujUw9nJ0
        MXJySAiYSLQu3M7SxcjFISSwg1Hia89iKOcTo8SFp6sZIZzPQJm9C5hhWn69WcoKkdjFKNF3
        6hg7hPOEUeLfsRdMIFUsAqoSc9cfZgOx2QS0JO79OAHWLSKgKXH973ewbmaBOcwS15bcYAFJ
        CAvYSvzaupMRxOYV0JFoXvmQDcIWlDg58wlYDaeAncTxFf+BBnFwiAqoSLw6WA8yR0JgJYfE
        7MWrmSDOc5H48vMDK4QtLPHq+BZ2CFtK4mV/G5RdLLHrUysTRHMDo0TjgxNQvxlLzHrWDnYE
        s0CGxMqWtWwgyyQElCWO3GKBCPNJdBz+yw4R5pXoaBOC6FSWmH55AtRaSYmDr89BTfSQ+PZ0
        IxskgHYySxy5MZttAqP8LCSvzUKyDcLWkViw+xOQzQFkS0ss/8cBYWpKrN+lv4CRdRWjWGpB
        cW56arFRgSE8tpPzczcxgtOwlusOxslvP+gdYmTiYDzEKMHBrCTC+2V3RpIQb0piZVVqUX58
        UWlOavEhRlNgRE1klhJNzgdmgrySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp2ampBalF
        MH1MHJxSDUzzmNYmzfkn3SOxcLu0bPMb6xmTb/ry6X+/69ViwLnr459P5dP0HRL+2zPNcJd9
        HeKuJ9S7dPOWM8p2vio8p87cbPzewjdjgVvEBBGdrkNvQ3fuLZ8bfaKjeaMdc8Pi5eyqD3u6
        rgXqpopUytz6msfxY0vYh0ftHQ9sllqs+jXpRes2hT95FhLmHn1aDbFvVX7+mXF4w5zS1x4f
        0vdXzSi/4Ptejf213vHP0T8fPJ9gcHVCiOWJmvtZNxVjFxyJOVt4pjLM99Gqfw+Wmk3v4Fqm
        ac3EbV3P0/Lk/++HoTMEp8zb1paRIMgvve1pt3fls3Pak3QXb9BkeeC33FH8+p47nPYLHjxr
        5Nl+bXLo1IRrSizFGYmGWsxFxYkA/pV5/UwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnK6VR1aSwdsv2hZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK2L/a
        oGAne8WpZWcZGxifsXYxcnJICJhI/HqzFMwWEtjBKDHneT1EXFJi6dwb7BC2sMT9liNANVxA
        NY8YJaZv2s8IkmARUJWYu/4wG4jNJqAlce/HCWYQW0RAU+L63+9gDcwCC5glzrXNAysSFrCV
        +LV1J1gzr4CORPPKh2wQU3cyS7Q3NkIlBCVOznzCAmIzA0298e8lUxcjB5AtLbH8HwdImFPA
        TuL4iv/MIGFRARWJVwfrJzAKzkLSPAtJ8yyE5gWMzKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYJjSEtrB+OeVR/0DjEycTAeYpTgYFYS4f2yOyNJiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqYzJlnqBcInOuzmOm5ewuAYuOWNVWhn1tFV
        hy6yLX15avLiguSYM3/+VO35cffjsrjNVRxnfnx6nemtxqUlzsXye9uk+HcJ89YH2zS/rLnp
        mpucnHpulY31ep43Z4KOTZkuJ3nNXoNRtP3Ens9/LvsFfLtk0bNzWq0g+5bcqyX3Nwmd+bTs
        +rLAuu+h67wPdJZpvRFZl3b556zVAf8yHWWcWZj/XFmp56X8TS9CjmV3a5D+Vn6uf+J2p8RM
        nB6VtorcY7OVvb9frKrCqcuh4JJI3/cz7jMM2K+ePK/Voj57hm+ef1/615Oq8lWOvay3j24T
        i22qKLVguxcXuPfEkpJ7Qa/VPHUDc3fLcSauSlRiKc5INNRiLipOBAAAHGPbEAMAAA==
X-CMS-MailID: 20220428075434epcas2p1792bc1c96afd57aff3af85c82761b99e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_31fa8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
        <20220428012941.GF145620@ubuntu>
        <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
        <20220428063634.GF151827@ubuntu>
        <fa113ba0-1221-de93-a18f-e4e942cdb261@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_31fa8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Apr 28, 2022 at 09:31:56AM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2022 08:36, Jung Daehwan wrote:
> >>
> >> Since you called everything here as "exynos" it is specific to one
> >> hardware and not-reusable on anything else. How can then you use some
> >> other compatible? It would be a misuse of Devicetree bindings.
> >>
> > 
> > I got it. Let me add them. Is it still necessary if it is only used by
> > other module on runtime as I said above?
> 
> Except what Greg wrote, if by "other module" you mean out-of-tree, then
> the patchset will not be accepted as it is unusable for Linux users.
> Basically it would be a dead code in Linux kernel.
> 
> Best regards,
> Krzysztof
> 

I wanted to submit patches of just xhci. Let me add a patch together of other
module(dwc3-exynos) that is in-tree on next submission.

Is it still necessary to add compatible or bindings in this case?

Best Regards,
Jung Daehwan

------ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_31fa8_
Content-Type: text/plain; charset="utf-8"


------ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_31fa8_--
