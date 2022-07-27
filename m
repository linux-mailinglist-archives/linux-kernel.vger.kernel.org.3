Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B778C581F63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiG0FK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0FK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:10:56 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2553A5F4F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:10:53 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220727051048epoutp03ba71e86c036e3662317defa8be19ce17~Fl4gKSPIX1327213272epoutp03P
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:10:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220727051048epoutp03ba71e86c036e3662317defa8be19ce17~Fl4gKSPIX1327213272epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658898648;
        bh=x6UA0Rfjozs+/4IZkjtcqdXVV51gdxjf/5gwJCK1G0A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uLDaa6TRgmGnxKp4UdjZ00nDowlX0TL6ExbBbxIfVz2fAlDqjlAV/kW7XD8wnCmT1
         99iObIk/hNe3luQU/FukbG86KG0b+rhh9jKEq/m9hb3ZtekKo5IDV7QsjDzPTB44Wj
         o1NeEegMNypohHOzSatBoNhqX8LmB9edpXEFk2/c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220727051047epcas2p13a92d053a966030f7d3f5f0e612ad190~Fl4fttOME1554115541epcas2p1E;
        Wed, 27 Jul 2022 05:10:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lt2133bysz4x9Px; Wed, 27 Jul
        2022 05:10:47 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.EB.09662.7D8C0E26; Wed, 27 Jul 2022 14:10:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220727051046epcas2p15481688ac3b7917bed8d06ebfb0a4184~Fl4e4YV_S2010320103epcas2p1O;
        Wed, 27 Jul 2022 05:10:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727051046epsmtrp245c710aeb0d1c1f1f69174e765059093~Fl4e3kZrX2748127481epsmtrp2t;
        Wed, 27 Jul 2022 05:10:46 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-5b-62e0c8d71f1a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.25.08905.6D8C0E26; Wed, 27 Jul 2022 14:10:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220727051046epsmtip27aab19aaf95e38ddc3e8ec30c548b4e9~Fl4euqD6b3152631526epsmtip2e;
        Wed, 27 Jul 2022 05:10:46 +0000 (GMT)
From:   Gyunghoon Kwon <goodjob.kwon@samsung.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gyunghoon Kwon <goodjob.kwon@samsung.com>
Subject: [PATCH] scsi: ufs: introduce dev_cmd_notify callback
Date:   Wed, 27 Jul 2022 14:09:55 +0900
Message-Id: <20220727050954.118743-1-goodjob.kwon@samsung.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQvf6iQdJBk9/ilk8mLeNzeLlz6ts
        FtM+/GS26NnpbLHoxjYmi8u75rBZdF/fwWax/Pg/JgcOj8tXvD0mLDrA6PHx6S0Wj74tqxg9
        Pm+S82g/0M0UwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj1xS+ggOCFX23e9gbGM/wdTFyckgImEicWtDGAmILCexglNh6zr2LkQvI
        /sQocXjFbGYI5xujxJrpjUwwHdPfXIfq2Mso8fY6K0TRR0aJZRNPgSXYBPQlpp5/CdTNwSEi
        YCRxbZUnSA2zwFpGidblC8FqhAVsJX6cPgtmswioSqxu2cwOYvMK2Enc2dbMCLFMXuL6zTZm
        iLigxMmZT8DqmYHizVshrpMQuMUu8bgXYrGEgIvEy1P3oJqFJV4d38IOYUtJfH63lw3CLpY4
        +X8DI0RzC6NE5/VzUEXGErOetTOCXM0soCmxfpc+iCkhoCxx5BbUXj6JjsN/2SHCvBIdbUIQ
        jWoSZ2ZOY4awZSTuT2mAusZD4tm0l0yQsIqVuHZuHuMERvlZSL6ZheSbWQh7FzAyr2IUSy0o
        zk1PLTYqMIFHaXJ+7iZGcHrU8tjBOPvtB71DjEwcjIcYJTiYlUR4E6LvJwnxpiRWVqUW5ccX
        leakFh9iNAWG70RmKdHkfGCCziuJNzSxNDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpakFoE
        08fEwSnVwLSI+5uekrPpR/OLGoe9Vn4taXfhry229VrTa8mr+azd+eU3o4pT3D7z5pn2GIas
        za5Z0Vsqtkbouug1yZ8Jn1s3PFwvyb0m1/rSbGvvuP+XGNNbv/JdUklx0K/OiY473d5j4XS6
        5v5q7+cnz18/0R7Ycu3m6RXzpJ7cnTpTa9kGz+V3itgMYoOn/rpm3R26eqP1LJcTBa7lnHnv
        /dtvX1ym7DVp+bUTxlGbJG4VbJmyRvWulv1O+WSm6Pd3Hf3ls2WVc8uYd4tVd271CFtyIeGg
        x4ZLk0KmhZxYmfHug3ycr+weXsU+jTJWq/SMLwqvI/Jk3Te73PsqW8rWYHlL9XOMveH6u2eX
        1pxdoah7S4mlOCPRUIu5qDgRAMjfVQAYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvO61Ew+SDLZMMbV4MG8bm8XLn1fZ
        LKZ9+Mls0bPT2WLRjW1MFpd3zWGz6L6+g81i+fF/TA4cHpeveHtMWHSA0ePj01ssHn1bVjF6
        fN4k59F+oJspgC2KyyYlNSezLLVI3y6BK+PXFL6CA4IVfbd72BsYz/B1MXJySAiYSEx/c52l
        i5GLQ0hgN6PE2WcTgBwOoISMxL0jUhA1whL3W46wQtS8Z5S4dfoSI0iCTUBfYur5l8wgtgjQ
        oBm33oEVMQtsZpRoubmdDSQhLGAr8eP0WRYQm0VAVWJ1y2Z2EJtXwE7izrZmRogN8hLXb7Yx
        Q8QFJU7OfAJWzwwUb946m3kCI98sJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIEB62W5g7G7as+6B1iZOJgPMQowcGsJMKbEH0/SYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamuqXXn540jqpltt6RILe5Nfn9/ajPHBXJ3yR9
        eQV3T1hv9HZvFHPKT1Xhb4UWexfXCG+RnDThwQTvBlXWKL2vUmuSfS7Pd+kPstxvbGmxvb5L
        qffPQeWPG569PvhkwuR9G0LE8yY7yvMop4VutZkxi037sN/GIDnT4P1c6zhvXPLh2m98OTbe
        79reNtGflzcY101yfHNwbq7D8rLQk966kp9sA3v29CWv4zv3zOxrdGTlVqGoBP1LvizXxH9I
        TTvncJEz++HCfbOu9XlfzZBj870x4+fkJT8PJRofFVVLZHT/xhK+kF2Jw3PJrW6zuB3/U08k
        tU+q38x7lHnN1YV3yr/azEy9LMZhvOhOb/9CJZbijERDLeai4kQAR5c1T8kCAAA=
X-CMS-MailID: 20220727051046epcas2p15481688ac3b7917bed8d06ebfb0a4184
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727051046epcas2p15481688ac3b7917bed8d06ebfb0a4184
References: <CGME20220727051046epcas2p15481688ac3b7917bed8d06ebfb0a4184@epcas2p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UFS host controller may need to synchronize dev command among
UFS host controllers.

Signed-off-by: Gyunghoon Kwon <goodjob.kwon@samsung.com>
---
 drivers/ufs/core/ufshcd.c |  2 ++
 include/ufs/ufshcd.h      | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c7b337480e3e..fb642c5e73a3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3021,8 +3021,10 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
+	ufshcd_vops_dev_cmd_notify(hba, PRE_CHANGE);
 	ufshcd_send_command(hba, tag);
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
+	ufshcd_vops_dev_cmd_notify(hba, POST_CHANGE);
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a92271421718..376babf71432 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -293,6 +293,7 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @dev_cmd_notify: called to notify device management request is issued
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -331,6 +332,8 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	void	(*dev_cmd_notify)(struct ufs_hba *hba,
+				  enum ufs_notify_change_status);
 };
 
 /* clock gating state  */
@@ -1217,6 +1220,13 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline void ufshcd_vops_dev_cmd_notify(struct ufs_hba *hba,
+					enum ufs_notify_change_status status)
+{
+	if (hba->vops && hba->vops->dev_cmd_notify)
+		hba->vops->dev_cmd_notify(hba, status);
+}
+
 extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
-- 
2.37.1

