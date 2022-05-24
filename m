Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE665320DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiEXCWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiEXCWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:22:20 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577C62A2F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:22:18 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220524022215epoutp03a14b9741652b225d1b3bb72d465c9d22~x6TElq2zM2185621856epoutp03U
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:22:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220524022215epoutp03a14b9741652b225d1b3bb72d465c9d22~x6TElq2zM2185621856epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653358935;
        bh=ySh4VBTwTZYqs5uHmfByRcOgkoy7vH0TFw3CRIHx+K8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U5imAkWdIDxLJ1BzwfFN6hr6sbvGAu0ZMELAVK9URUfz20i3nw81DDoAJyQ1qAiUg
         eDWSgcdrYaGizRoAeu+9NJcnweNFLn7pZzrK2oaiUYXhqBM04R719D50opaZoTdnux
         dJpba8RM0udU9IhgXyt+tLGC+pcUANEs8iLxR/bc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220524022215epcas1p17a6dc24bf7e9ffa4344ec3616c30bbde~x6TESDgVY1351013510epcas1p1B;
        Tue, 24 May 2022 02:22:15 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L6dJ64fLTz4x9QF; Tue, 24 May
        2022 02:22:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.37.09785.6514C826; Tue, 24 May 2022 11:22:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220524022214epcas1p28d7b7de846e44cedf825eb4f5973932d~x6TDdoOCq2147121471epcas1p2B;
        Tue, 24 May 2022 02:22:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220524022214epsmtrp2956ccbc9e81f31696c8be62e11880dea~x6TDc1w7d0845208452epsmtrp2C;
        Tue, 24 May 2022 02:22:14 +0000 (GMT)
X-AuditID: b6c32a36-4ad09a8000002639-75-628c4156fcb3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.6A.11276.6514C826; Tue, 24 May 2022 11:22:14 +0900 (KST)
Received: from U20PB1-0435.tn.corp.samsungelectronics.net (unknown
        [10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220524022214epsmtip1da14c599fd7db98f448d6b37c4626a7b~x6TDPhvJw2607926079epsmtip1K;
        Tue, 24 May 2022 02:22:14 +0000 (GMT)
From:   Sungjong Seo <sj1557.seo@samsung.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        daehojeong@google.com
Subject: [PATCH] f2fs: allow compression for mmap files in
 compress_mode=user
Date:   Tue, 24 May 2022 10:29:11 +0900
Message-Id: <20220524012911.725783-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmgW6YY0+SwfxVihanp55lspjavpfR
        4sn6WcwWlxa5W1zeNYfNYsu/I6wObB4LNpV6bFrVyeaxe8FnJo++LasYPT5vkgtgjWpgtEks
        Ss7ILEtVSM1Lzk/JzEu3VQoNcdO1UFLIyC8usVWKNjQ00jM0MNczMjLSM7aMtTIyVVLIS8xN
        tVWq0IXqVVIoSi4Aqs2tLAYakJOqBxXXK07NS3HIyi8FOVqvODG3uDQvXS85P1dJoSwxpxRo
        hJJ+wjfGjLeT+9gLWrgq9k/dy97AOIGji5GDQ0LAROLXZuEuRi4OIYEdjBI7f7xkhHA+MUo0
        PPrABOF8Y5RYP+UScxcjJ1jHq//rWSASexklvm9Yxg6SEBJoZ5LY/CESxGYT0JZY3rQMrEFE
        QF3i1KSlLCA2s0ClxPqDb1hBbGEBf4mzzzaAxVkEVCWurJ4IZvMK2EjcuHMXapm8xMxL39kh
        4oISJ2c+gZojL9G8dTYzyBESAsfYJZZ8fscE0eAicefYQTYIW1ji1fEt7BC2lMTnd3uh4s2M
        Es2NRhB2B6PE042ykLCwl3h/yQLEZBbQlFi/Sx+iQlFi5++5jBC2oMTpa93MECfwSbz72sMK
        0ckr0dEmBFGiIvH9w04WmKVXflyFOsxD4sr9U9CQipU4f+oW6wRGhVlIHpuF5LFZCEcsYGRe
        xSiWWlCcm55abFhghBzDmxjBaVTLbAfjpLcf9A4xMnEwHmKU4GBWEuHdntiRJMSbklhZlVqU
        H19UmpNafIgxGRjUE5mlRJPzgYk8ryTe0MTYwMAImPDMLc2NiRC2NDAxMzKxMLY0NlMS5101
        7XSikEB6YklqdmpqQWoRzBYmDk6pBiYmhk+M/C83sLl33Yh7pLheQ23blF/Xeq4Z8Vp7SnH9
        7p3VG7OQca/UQeGN7zMWHbIK15utUCNw5/XNY+9CVL9MNUvnCvuc1bYyq1NhsuBTdRHLs0f1
        LnJOW3R2xmWNQI33HA2LggO23fP/HmX28UBzOfMZu0uMm/7FT7zw02WGqftt27drt/aIcvEe
        kVlovNBryqmqhOTHFye/9rv1R8Zpf+V0lZDzh1x+FzJKbcnw32z49L9/kJfCq0XGHceUL826
        oP0t6Cr7rM/MvAlyv1qnvlExujE1dd+7qRxNbgt4Z9ySTo9jDft86chjVzeHDR2ShrYZczdO
        P63pNPH0d8/okp82rquXPVq6uPinm6KsEktxRqKhFnNRcSIA+Tdu71oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnG6YY0+Swc/dPBanp55lspjavpfR
        4sn6WcwWlxa5W1zeNYfNYsu/I6wObB4LNpV6bFrVyeaxe8FnJo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKeDu5j72ghati/9S97A2MEzi6GDk5JARMJF79X8/SxcjFISSwm1Gi5eYPpi5G
        DqCElMTBfZoQprDE4cPFECWtTBJPZr1iA+llE9CWWN60jBnEFhHQlDjSOZMdxGYWqJVYveUn
        I0ivsICvxIoOGZAwi4CqxJXVE1lAbF4BG4kbd+4yQ5wgLzHz0nd2iLigxMmZT1ggxshLNG+d
        zTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCQ1JLcwfj9lUf
        9A4xMnEwHmKU4GBWEuHdntiRJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU
        1ILUIpgsEwenVAPT1jQPbqY/S71PV8lsrtPljBRiLRYM9a+fqf+if+bDa/IxZrvsPb+v+F6u
        w9lUG5teOjG1TfvlrcZlAaFbWA1fFe/Zrh8WcdSI8cyfmXocZWYL3GzmJEqfiPd7HVG9zLKf
        ccaOP7vPX39/MuhXg6f9QrGpzauu6x7zmRxqcORctKadpkhFQbb2qn+/P3VqTkz57eoiFfpN
        ITXr367TN2UOzTD06ahm+n3+RrOAmvG/AtXAjSdvbnifOc14SRGTRn39izvvV+Z1aTR9PprQ
        /lX39dZ3JxRTsgPblu8ROZaiwHzHPpM7f9atnjOs/RGvtugzXa/KVC6c0aU1P1c7V74mNSbj
        mMirOOY3BiH/1yixFGckGmoxFxUnAgABde8yuAIAAA==
X-CMS-MailID: 20220524022214epcas1p28d7b7de846e44cedf825eb4f5973932d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220524022214epcas1p28d7b7de846e44cedf825eb4f5973932d
References: <CGME20220524022214epcas1p28d7b7de846e44cedf825eb4f5973932d@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e3c548323d32 ("f2fs: let's allow compression for mmap files"),
it has been allowed to compress mmap files. However, in compress_mode=user,
it is not allowed yet. To keep the same concept in both compress_modes,
f2fs_ioc_(de)compress_file() should also allow it.

Let's remove checking mmap files in f2fs_ioc_(de)compress_file() so that
the compression for mmap files is also allowed in compress_mode=user.

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/f2fs/file.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7aac53ac5acf..a05d842a7e72 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3945,11 +3945,6 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (f2fs_is_mmap_file(inode)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		goto out;
@@ -4017,11 +4012,6 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (f2fs_is_mmap_file(inode)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		goto out;
-- 
2.25.1

