Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652BE5308E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiEWFhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiEWFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:37:12 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8621265
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:37:08 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220523053704epoutp03630fdb8f3f0bcee6951e34634facc2f8~xpT4v_-fC2233422334epoutp03o
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:37:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220523053704epoutp03630fdb8f3f0bcee6951e34634facc2f8~xpT4v_-fC2233422334epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653284224;
        bh=nvsl+YDNSD25J27UmI22kYRLW5G9VeRNNKiYPPDwC0g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jGsQEFULGIUnMTNtxkMq0VN5+axr6WkuYqq0p8RF6V5dSCkiq0rcWkOGauCzlKYSY
         7u3SDZ8AWS3/uhVzNkfuVe1F6GNapBI1gFZou0fbO9J62pggb+/t+1wuqKky//hK5z
         8aquVq3BtwkEfgFe7o5gDudQGIeF6/fWS38ddOl8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220523053703epcas2p419ff7582a3c43c4f092d0bafdec1b0ee~xpT4CoaVE2886028860epcas2p44;
        Mon, 23 May 2022 05:37:03 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L65gK45sHz4x9Pw; Mon, 23 May
        2022 05:37:01 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.1E.10028.A7D1B826; Mon, 23 May 2022 14:36:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220523053658epcas2p2400c4c92126baa05d5fb4b5d6ed7e274~xpTyy1Twt0582905829epcas2p2G;
        Mon, 23 May 2022 05:36:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220523053658epsmtrp18475f5df623d61d6f147d76da960c0e3~xpTyx7oVh1003610036epsmtrp1N;
        Mon, 23 May 2022 05:36:58 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-d1-628b1d7a06a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.D3.08924.A7D1B826; Mon, 23 May 2022 14:36:58 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220523053658epsmtip28545488884d487133517520ffa5783c9~xpTyl9IDR0665706657epsmtip2Y;
        Mon, 23 May 2022 05:36:58 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [RESEND PATCH v1] scsi: ufs: Change the shutting_down flag setting
 position
Date:   Mon, 23 May 2022 02:18:47 +0900
Message-Id: <20220522171847.66373-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhW6VbHeSwbTLhhYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEZVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+PD6vNM
        BZ3cFc+uXWNrYFzI2cXIySEhYCLxuWELcxcjF4eQwA5GiX2PGtlBEkICnxgl/vwMgkh8ZpTo
        6pvMAtPRNGk1C0RiF6PE9y+fGCGcH4wSF05PYgapYhPQkFhz7BATSEJEYAWTRM+mT0wgCWYB
        NYnPd5eBjRIWCJO4d+MZWxcjBweLgKrE+U+sIGFeAUuJU82NjBDb5CUWNfxmgogLSpyc+YQF
        Yoy8RPPW2WB3SwhM5ZB49f4oO0SDi8T0SdfZIGxhiVfHt0DFpSRe9rdB2cUSP96sZoJobmCU
        WNp+jBkiYSwx61k7I8hBzAKaEut36YOYEgLKEkduQe3lk+g4/JcdIswr0dEmBNGoJHFm7m2o
        sITEwdk5EGEPiRl7zkIDNFaipXUnywRG+VlInpmF5JlZCGsXMDKvYhRLLSjOTU8tNiowhsdp
        cn7uJkZwotVy38E44+0HvUOMTByMhxglOJiVRHi3J3YkCfGmJFZWpRblxxeV5qQWH2I0BYbu
        RGYp0eR8YKrPK4k3NLE0MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAlHGq
        Jq9ArSnveRHnlZu9t5c8Kvhu3noq6BDPy1O1O5zrOmv99iTJ9128vuZcQ89Os8ZXDw6+iZvg
        F8Uz63a6v+Vk35tyhm0H5jnHcoknLuU3viH36dYK8xkPY+6x+jperP6/YLa4wnL9C536hh6L
        NXeKTLW1frGinZP5hkfCjJLJZaYy60sdRS8np/+2CtwqNY9r18UZ+yb9dF1rW1qaoPhjwu6D
        DRM8eKoaXhzgvjUr9qLGZ7VV5+IdljUJf599+eOu6V5/Hpq26pro/Jh8O2ftC92bD3/4iZ/6
        ZPwlrmVj2xp5IVv7yYxyO7bsXCRhoX+s3z/B9MrOdw6/rvjz1xh/tRQzLD6WGf/fYstvfiWW
        4oxEQy3mouJEAKGMJSc9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvG6VbHeSwcFt/BYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEcVlk5Ka
        k1mWWqRvl8CV8WH1eaaCTu6KZ9eusTUwLuTsYuTkkBAwkWiatJqli5GLQ0hgB6PE11t9rBAJ
        CYn/i5uYIGxhifstR1ghir4xSrx6OJEdJMEmoCGx5tghJpCEiMA2Jom7H06ygSSYBdQkPt9d
        xgJiCwuESKzdM5uxi5GDg0VAVeL8J7AFvAKWEqeaGxkhFshLLGr4zQQRF5Q4OfMJC8QYeYnm
        rbOZJzDyzUKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnD4a2ntYNyz
        6oPeIUYmDsZDjBIczEoivNsTO5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKa
        nZpakFoEk2Xi4JRqYFq8YfbmvGO6p1Nn9dzOVKgqPBLhNXWXMUfBpY0vN727wnWyeGKY6Mvq
        629u1E3607wkxn4nu+rrxfaGruWz/mk9SPXLU2mqcgl6OmOP2qePv6Vcn9ybylOxcsHCKfvl
        WDJ2KSR0WGz1qTzbN9Vd+oNgVsm2bvurlnse7br2801QwzWpj1fvRS5ytNDe93wu11HDixWC
        lz8w2Ccpbj9w8VMKX11o4tdJKa0Fbo4/Znz58US4ucUvWtPuyrW711ke/F4/fdq6viOxl5pe
        dHfb72M48DWnur1FUmHS/APcby9+zHvyS9VYbZZJpUrYKwmffRpdFfw2GjEyVtvzC4xnXZMN
        Ezq1dGalnMiEr6eOHXimxFKckWioxVxUnAgAc+mxf+4CAAA=
X-CMS-MailID: 20220523053658epcas2p2400c4c92126baa05d5fb4b5d6ed7e274
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220523053658epcas2p2400c4c92126baa05d5fb4b5d6ed7e274
References: <CGME20220523053658epcas2p2400c4c92126baa05d5fb4b5d6ed7e274@epcas2p2.samsung.com>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When System shutdown, will called ufshcd_wl_shutdown().
Then the shutting_down falg set to 1 at ufshcd_wl_shutdown().
And send to SSU cmd at ufshcd_wl_shutdown()->__ufshcd_wl_suspend()->
ufshcd_set_dev_pwr_mode() function.

If occurred fail during send SSU cmd,
then will called ufshcd_err_handler for recovery.
But already set shutting_down to 1, so ufs driver could not recovery.
Then System wait for SSU cmd to be completed and
eventaully it will tak Hang.
So changed the position where shutting_down is set.

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1fb3a8b9b03e..65d47cd5afbe 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9235,10 +9235,6 @@ static void ufshcd_wl_shutdown(struct device *dev)
 
 	hba = shost_priv(sdev->host);
 
-	down(&hba->host_sem);
-	hba->shutting_down = true;
-	up(&hba->host_sem);
-
 	/* Turn on everything while shutting down */
 	ufshcd_rpm_get_sync(hba);
 	scsi_device_quiesce(sdev);
@@ -9248,6 +9244,10 @@ static void ufshcd_wl_shutdown(struct device *dev)
 		scsi_device_quiesce(sdev);
 	}
 	__ufshcd_wl_suspend(hba, UFS_SHUTDOWN_PM);
+
+	down(&hba->host_sem);
+	hba->shutting_down = true;
+	up(&hba->host_sem);
 }
 
 /**
-- 
2.26.0

