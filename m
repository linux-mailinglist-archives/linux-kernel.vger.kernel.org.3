Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204F3495984
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378524AbiAUFjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:39:51 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:63247 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348742AbiAUFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:39:49 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220121053948epoutp036ac579715a751d6c091008b523f0b3a5~MMpcpmlow1933819338epoutp03I
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:39:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220121053948epoutp036ac579715a751d6c091008b523f0b3a5~MMpcpmlow1933819338epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642743588;
        bh=XKeuICJKfFTAdoh3v+3Qbno4KZ8zHGwFwXcnqw+frjY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=S6VsddJov8/xpkkV6R2x9GwJhpTjFNBxSZlm/MywkhguISMNg2d5LrbM0NpZaW6Gq
         ACnXYC9cQ5EhBFEKrxsnLo0yd77il+4PkqvYAY2fzRegzjU/uBBa7eJERibzU96f7j
         WXitIPCEaZiHBTPmHg/QEimcHDu8JpEVBSrKFA/c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220121053948epcas2p1696de1dc7c00fb142c30c498877a3d7b~MMpcA0wce0931209312epcas2p1l;
        Fri, 21 Jan 2022 05:39:48 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jg7Vp0RClz4x9QT; Fri, 21 Jan
        2022 05:39:46 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.9B.10014.A564AE16; Fri, 21 Jan 2022 14:36:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121053945epcas2p386871d63f104de31d8fd0c123615b876~MMpZmjxQl0637506375epcas2p35;
        Fri, 21 Jan 2022 05:39:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121053945epsmtrp10820fd05f3b1bcb598a7a645d0e1afcb~MMpZjUDXN2230722307epsmtrp1W;
        Fri, 21 Jan 2022 05:39:45 +0000 (GMT)
X-AuditID: b6c32a47-489ff7000000271e-16-61ea465a00f0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.0B.08738.0274AE16; Fri, 21 Jan 2022 14:39:44 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220121053945epsmtip19972b73c2a30f16fa624a27318692e05~MMpZTWAFi2315723157epsmtip1V;
        Fri, 21 Jan 2022 05:39:45 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2] scsi: ufs: see link lost as fatal
Date:   Fri, 21 Jan 2022 14:37:55 +0900
Message-Id: <1642743475-54275-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTVDfK7VWiwcvDzBYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnfH30izmgkaOijnzPzE1MB5k62Lk5JAQMJHYvnYjSxcjF4eQwA5GiRW/fkM5nxgl
        bu55DeV8ZpTY+O8vC0zLqfmP2SESuxglPq2bwAzh/GCUOD7jPNhgNgFNiac3pzKB2CIC15kk
        5m3PALGZBdQldk04ARTn4BAWMJU4MqMcJMwioCqx/sJzRpAwr4CrRMNHSYhdchI3z3WCjZcQ
        aOSQaDq1FuoIF4mNiz+wQ9jCEq+Ob4GypSRe9rexQzQ0M0rs3N0I1T2FUWLJfpgOY4lZz9rB
        tjEDHbp+lz6IKSGgLHHkFgvEmXwSHYf/skOEeSU62oQgGpUlfk2azAhhS0rMvHkHqsRD4vZB
        e5CwkECsxJWbi9gnMMrOQhi/gJFxFaNYakFxbnpqsVGBMTyOkvNzNzGC06OW+w7GGW8/6B1i
        ZOJgPMQowcGsJMIrVf8sUYg3JbGyKrUoP76oNCe1+BCjKTC4JjJLiSbnAxN0Xkm8oYmlgYmZ
        maG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYOTqkGpiDNw9s+t3ddnLTLsS370gvmFXtW
        nWSUbDj/I/ltwKHZ8RdsNP9NiikWsVFk7jUxnq7+f0pS94EvS0W63pk2J9oGb9AOTd16K2x2
        muKeT6srFn4XZ/VyYzjao/umssK79EnQIWfLL3eeXvlWvyIgQmmCz8p7Bvdiw1w5FxteiWtn
        6OzxNBdR4ci6rC9ve8RC+4Xq8TbWA+rG7O2r/jA2HCy/YWd8NVxINuC3byy35/QpX9eElN/+
        X6HI9Kv0pvcz/Y7JmfODJ97l3nrH133XNnWnKff7Ii4rvov8YqDPWPtNPosjam/zLpFX7vPr
        9faENz2pF1+xWIQn6Kji8q2h6m5byrb46fnlnZywadd6JZbijERDLeai4kQAkiDoERgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK6C+6tEgwvtihYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiOKySUnNySxLLdK3S+DK+HtpFnNBI0fFnPmfmBoYD7J1MXJySAiYSJya/5i9i5GL
        Q0hgB6PE38v3mSESkhIndj5nhLCFJe63HGGFKPrGKDHn/zJWkASbgKbE05tTmUASIgIvmSRe
        zFkDNpZZQF1i14QTQAkODmEBU4kjM8pBwiwCqhLrL4AM5eDgFXCVaPgoCTFfTuLmuU7mCYw8
        CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIesltYOxj2rPugdYmTiYDzEKMHB
        rCTCK1X/LFGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkG
        JtP7iza3btt5TnBj7NX2dpabtiJ5NnwmyWU2tbNb+hPWsBybe6V2C2dUkvacXVt7fXO/bezM
        vWWbevP3hqOb5GMDzZ6bx205H1p05kvErrx3fhzrQ9cKiOcIm0qcdJ1xt69a4PC/EzKGk5vv
        ss9u/tb96t+K+du5PHfLC3nXV9k8k0tNlep+IKPprB4RvmWB7YK8g8aMTPkFpvsWsgrIeucv
        fHerUzBWf39J00vxOP0FajnBb/0Cuz12aj8oSZpvw3zjB8Muj9n1Zkqb1QOuKxVY+DHPnBjn
        HLL/+VuV1Ylb+mOm/uKfeTr1lVD4Ho8TVmcffLl7fPqUdybsXGe5ZjvH7T6rvMvk4a+3sbMm
        K7EUZyQaajEXFScCAERyQnvIAgAA
X-CMS-MailID: 20220121053945epcas2p386871d63f104de31d8fd0c123615b876
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121053945epcas2p386871d63f104de31d8fd0c123615b876
References: <CGME20220121053945epcas2p386871d63f104de31d8fd0c123615b876@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: modify comment

This event is raised when link is lost as specified
in UFSHCI spec and that means communication is
not possible. Thus initializing UFS interface needs to be done.

This patch is to make UFS driver see Link Lost as fatal by using
INT_FATAL_ERRORS. This lead to host reset whenever a link lost
interrupt occurs.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshci.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6a295c8..a7ff0e5 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -142,7 +142,8 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
 				SYSTEM_BUS_FATAL_ERROR |\
-				CRYPTO_ENGINE_FATAL_ERROR)
+				CRYPTO_ENGINE_FATAL_ERROR |\
+				UIC_LINK_LOST)
 
 /* HCS - Host Controller Status 30h */
 #define DEVICE_PRESENT				0x1
-- 
2.7.4

