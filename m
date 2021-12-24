Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6779E47EBE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351443AbhLXGDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:03:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:19030 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351437AbhLXGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:03:09 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211224060306epoutp014a750153ee11f3a4dd24d0c69da559a8~Dm5y9Pqpy0067400674epoutp01c
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 06:03:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211224060306epoutp014a750153ee11f3a4dd24d0c69da559a8~Dm5y9Pqpy0067400674epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640325786;
        bh=bIAh22o6DNZsL/prcCVL2FUobc7w4qm8PPg4gjo5W6o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=srXp2a4VpSWCOeO1gPnqGFSvUtvkWSEomrfO7YbrhmcDKFH0rXP4aOumvpAC3ptTc
         c03BvJMw7SP5S41GAjDFTUr+8NcZNG7quMJ64OgXhGT4yq7p28eJRudF5Z4yn2Xf8V
         XowlM5AJSfQnSuHieHUb02VbUiayezK3MkfmhY9k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211224060306epcas1p3f497b57bd4bb5eba625de0ace491b697~Dm5ye77361456814568epcas1p3w;
        Fri, 24 Dec 2021 06:03:06 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JKxLc58Ckz4x9Pr; Fri, 24 Dec
        2021 06:03:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.64.64085.89265C16; Fri, 24 Dec 2021 15:03:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211224060304epcas1p17f51efcae3aedaf0724be607f81d530b~Dm5wfjaG51119011190epcas1p1f;
        Fri, 24 Dec 2021 06:03:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211224060304epsmtrp1659a59f303f490b1979946f77a1c27f9~Dm5wenqnv2005320053epsmtrp1l;
        Fri, 24 Dec 2021 06:03:04 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-95-61c56298d106
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.E2.29871.79265C16; Fri, 24 Dec 2021 15:03:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.109]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211224060303epsmtip1ad45b53d3388405969486b6f6d822c55~Dm5wM2W3w2231222312epsmtip1p;
        Fri, 24 Dec 2021 06:03:03 +0000 (GMT)
From:   Manjong Lee <mj0123.lee@samsung.com>
To:     mj0123.lee@samsung.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        nanich.lee@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, junho89.kim@samsung.com,
        jisoo2146.oh@samsung.com
Subject: [Question]Question about the possibility of a problem in
 blk_mq_complete_remote.
Date:   Sat, 25 Dec 2021 00:10:09 +0900
Message-Id: <20211224151009.17195-1-mj0123.lee@samsung.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQHdG0tFEgwnn1CxW3+1ns+h50sRq
        8fVhscXeW9oWl3fNYbOYvnkOs8W1+2fYLc6d/MRqMe+xg8WpHZOZLdbv/cnmwO1x+WypR9+W
        VYwenzfJBTBHZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+ATo
        umXmAB2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEy
        NDAwMgUqTMjO2HzzPmtBM3tFx74JTA2Mq1i7GDk5JARMJPY1dDB3MXJxCAnsYJRY++UKG4Tz
        iVHi/OMGFgjnG6PE169rmboYOcBaDk1Sg4jvZZToWXeHCcL5zCgxv2MuI8hcNgEtieXPLrCD
        2CICGRKXHk0A28EssJNR4vqPiUwgCWGBaIlLX3+CNbAIqEqsXn4OLM4rYC3R2vCMHeJAeYlT
        yw5CxQUlTs58wgJiMwPFm7fOBhsqIXCLXaLj7jaoj1wk9v7vgbKFJV4d3wI1SEriZX8bO0RD
        O6PEvwVrWCCcHkaJGT+6oaqMJT59/swI8iizgKbE+l36EGFFiZ2/IV5jFuCTePcVZAEoLHgl
        OtqEIEpUJHY3f4Pb9ebVAUYI20OiecJiNhBbSCBWYuvOiSwTGOVnIflnFpJ/ZiEsXsDIvIpR
        LLWgODc9tdiwwBAer8n5uZsYwUlSy3QH48S3H/QOMTJxMB5ilOBgVhLh9Vx1JFGINyWxsiq1
        KD++qDQntfgQoykwhCcyS4km5wPTdF5JvKGJpYGJmZGJhbGlsZmSOO8L/+mJQgLpiSWp2amp
        BalFMH1MHJxSDUyaR3fwNl39deHAO0n/i9vnhNQwCiyZpzb1xZpQv0UM7PunGr+Qdnqw+ezZ
        m7NcmtZnx2cf8+b8csEoQsDDsSMvkP99kPSi3uUyNx7c/hygdqz341+GgEvf91Rei3C7YSxR
        axh2I3B9/tZJMsJLT/4/u3S/bu3ltg1zjhVpHr557KpvjXD/+j8uK7svs6pwaTa0hP1hqOq9
        33Yo4vaFi/w2Ug0Re/V+nT/8sezBB+aiwOZq5bSWqRMkaxsLDS4W/nx50CRXYbel3dkFcR84
        JJYfmOrM7nZC6t8Kme0Xm+Q8HwnWLjG5e3XuZ7aKiuuvgjSXv3ha8eeT3a4CbamJuckCHDy7
        qm5eU/e9yPMvNOO+EktxRqKhFnNRcSIAhGcdwxsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSnO70pKOJBu86zCxW3+1ns+h50sRq
        8fVhscXeW9oWl3fNYbOYvnkOs8W1+2fYLc6d/MRqMe+xg8WpHZOZLdbv/cnmwO1x+WypR9+W
        VYwenzfJBTBHcdmkpOZklqUW6dslcGVsvnmftaCZvaJj3wSmBsZVrF2MHBwSAiYShyapdTFy
        cQgJ7GaU+Pd/FksXIydQXEpi3toGNogaYYnDh4shaj4ySrz7u5cVpIZNQEti+bML7CC2iECO
        xMf2VewgRcwCBxkl9m5rYQdpFhaIlLi8SxGkhkVAVWL18nNMIDavgLVEa8Mzdohd8hKnlh2E
        igtKnJz5BOwGZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10v
        OT93EyM4XLU0dzBuX/VB7xAjEwfjIUYJDmYlEV7PVUcShXhTEiurUovy44tKc1KLDzFKc7Ao
        ifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamC6coDPUpSH/8EbtuPMLUbqy2amveZZ2n/J4cmf
        U5wBr0ynB8XdPtny775C53PrrzvaHt7du6xJ1lhxWtM/Kf5tC78uttq7/2iFx9RthotPCz7y
        OfBmJz+zmbXD8y0r+qyi7s1m6rgdUzn97gmLW5FWJc/fOPTfOJ5m92gnU2y25LelF03PfJU4
        uvU69yXB8vzqpydDOHLCra2yps/xf+Rel9gozDNjhu078eOOpcHOk1/dWt5pYRhb8Td80tOj
        /uVe6x1kZJtk5vfVXt57/0iE9L53Ly46TuU6LrGnKlBs8eEZz3e0TX9TdcO0eOmzgzw21/5P
        3b/uVrzoje4vQt3zKiXyV5QsFspbmP092c4pV4mlOCPRUIu5qDgRAMCj4nDGAgAA
X-CMS-MailID: 20211224060304epcas1p17f51efcae3aedaf0724be607f81d530b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211224060304epcas1p17f51efcae3aedaf0724be607f81d530b
References: <CGME20211224060304epcas1p17f51efcae3aedaf0724be607f81d530b@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear block layer developers.

While studying the block layer code, there is something I don't understand 
about the code.
It's hard to understand by myself. So I'd like to ask for your help.

I think the error can occur when the target cpu is changed to 
online -> offline during the ipi operation due to the request complete 
process below.

However, since the return value is not checked in the code,
it seems that a problem may occur.

So I wonder is this code the real problem or is there any other defense code?


Function path.

blk_mq_complete_request_remote
    blk_mq_complete_need_ipi  << Check if the cpu of rq is online
    blk_mq_complete_send_ipi  << Assume that the target cpu becomes offline here.
        smp_call_function_single_async 
            << send ipi to cpu and return -ENXIO if cpu is offline
               but it doesn't check the return value.
