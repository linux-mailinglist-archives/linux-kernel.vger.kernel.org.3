Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0152CF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiESJK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiESJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:10:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969B4D9C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:10:20 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220519091014epoutp019a602498f58eba8b04cd51e62c586251~wdo3byiqJ0906609066epoutp01H
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220519091014epoutp019a602498f58eba8b04cd51e62c586251~wdo3byiqJ0906609066epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652951414;
        bh=yubcOGk4qBi6F7AK2qNHCDaOxiRtu1ZlVFm1AAMU0xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxB0F0cknfBC3vPdDVAC8PpU76OHGL/xotEs6j9xPSMBQmGxV1FavIcD4Rp1mnKjK
         90nQynLPpn+ffyTMqE5bkWLtkqXwbtxw2KC6Tp0/btBfGpWGsJOSkiOWb6QLfz9UI1
         uuVpQGkue87n9n7xXrVUik7c0CfajlXZ7YlPV9wE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220519091013epcas2p416d53e04b30074a096e59ca0f212ea54~wdo2kAvC31891518915epcas2p4d;
        Thu, 19 May 2022 09:10:13 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4L3kb56xP8z4x9Px; Thu, 19 May
        2022 09:10:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.2F.10028.07906826; Thu, 19 May 2022 18:10:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220519091007epcas2p2ba7cd404e9948ec4160f48cd83a995fa~wdowydnrZ3174631746epcas2p2Z;
        Thu, 19 May 2022 09:10:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220519091007epsmtrp10cf908a2262ecf4b60e494f6890ad86d~wdowxmNml1347613476epsmtrp1H;
        Thu, 19 May 2022 09:10:07 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-0f-62860970cb17
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.5F.11276.F6906826; Thu, 19 May 2022 18:10:07 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220519091007epsmtip27852461bb84b16036f626c1d4545a560~wdowmbKLy2681426814epsmtip2d;
        Thu, 19 May 2022 09:10:07 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: Change the shutting_down flag setting
 position
Date:   Thu, 19 May 2022 05:52:01 +0900
Message-Id: <20220518205201.58264-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <sc.suh@samsung.com;>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmuW4BZ1uSwcYb/BYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEZVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Nft3JB
        F3fFy00HWRoYF3F2MXJySAiYSNzo7GbrYuTiEBLYwSixsW0DK4TziVFi/dalUM43RokVPyey
        wLRM/7cdzBYS2MsocaRJFaLoB6PElPmvmUESbAIaEmuOHWICSYgIrGCS6Nn0iQkkwSygJvH5
        7jKwbmEBf4ltr/YDxTk4WARUJU6fFAUJ8wpYSpzeP5EdYpm8xKKG32CtnAJKEu9PvWWGqBGU
        ODnzCQvESHmJ5q2zmUF2SQis5JA4d/oIG0Szi8S7b1NZIWxhiVfHt0ANlZJ42d8GZRdL/Hiz
        mgmiuYFRYmn7MWaIhLHErGftjCDHMQtoSqzfpQ9iSggoSxy5BbWXT6Lj8F92iDCvREebEESj
        ksSZubehwhISB2fnQJgeEg/XMEFCrVTixYU/jBMYFWYh+WUWkl9mIWxdwMi8ilEstaA4Nz21
        2KjAGB67yfm5mxjByVfLfQfjjLcf9A4xMnEwHmKU4GBWEuFlzG1JEuJNSaysSi3Kjy8qzUkt
        PsRoCgzoicxSosn5wPSfVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mD
        U6qBKSMuZ/Er4wXTMi0laq22bHx8ev6Nk9tOsLmzbdwlMHlj0+enbN84v5m+rrYS2PW+LunU
        kye/+RnDr/IcED/z6MthR5c23cCI8v9N/CIH1h92tblRlnbwZoZ71711yrrWTj3z+bydMw4I
        v5lf+D3u43bj2tT+kjkZ/WlTn0sJvCt4Pu3eyeRkQd2yvT5SIoYzvT9JT5LumF1fuGSXwXrD
        B20L5978UJV8NEVH4LTNrhzlcxa2QlM37dnt1fn4anSKiRp/x3PZT7qKy64Uxx8Wk3im8dQw
        WSLTq43HVcJQaOPPucw9bFUzj/92OFnckM0Z/jzk2Sw/2ZpLPb2tsbI2FjtP5nUwz7c5fKrx
        4zwuJZbijERDLeai4kQAuYR3akcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvG4+Z1uSwc0DmhYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEcVlk5Ka
        k1mWWqRvl8CV8a9buaCLu+LlpoMsDYyLOLsYOTkkBEwkpv/bztLFyMUhJLCbUWLu5ptMEAkJ
        if+Lm6BsYYn7LUdYIYq+MUqcXPmNFSTBJqAhsebYISaQhIjANiaJux9OsoEkmAXUJD7fXcYC
        YgsL+Eoc+fwIKM7BwSKgKnH6pChImFfAUuL0/onsEAvkJRY1/AZbximgJPH+1FtmEFtIQFHi
        29p1TBD1ghInZz5hgRgvL9G8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECI4WLc0djNtXfdA7xMjEwXiIUYKDWUmElzG3JUmINyWxsiq1KD++qDQntfgQ
        ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJsGFu9hTVyuEm9osk9nA3l14MztlJnNm
        fumsdR/WFu5o5dSMsep29Di9wt/1hO15tv3r/vQ2XJ/UeFDkHt8Kzok/5Xvz11crTN2WdKYo
        Z89LzSmL488I7W884lliujEnOFLmuPfh6k7hdcJLS77O0fAw/d658Prk+AlsCyL7fp0TbK+z
        Uf+a6zt3jfj1hQqby1mn7tZL7WS5vD90aZ3fh/fyL+3MI093FmUc3dewVp75yPJpT86dyX8R
        ezzNcn+jXvfbuDs7P63yfsaaPv8x0+5lnyy2xokKdqqe1GjWn9CREv+3oVdR4bLCRZmJios3
        MzkmZcaqCE+IUuPZs/215Pk89TXth9Vf+Xaxz332SomlOCPRUIu5qDgRAJ9CpnMFAwAA
X-CMS-MailID: 20220519091007epcas2p2ba7cd404e9948ec4160f48cd83a995fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220519091007epcas2p2ba7cd404e9948ec4160f48cd83a995fa
References: <sc.suh@samsung.com;>
        <CGME20220519091007epcas2p2ba7cd404e9948ec4160f48cd83a995fa@epcas2p2.samsung.com>
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
eventaully it will take Hang.
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

