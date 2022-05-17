Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA352A250
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346695AbiEQM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347095AbiEQM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:58:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E14C788
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:57:46 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125745epoutp03420cc706d91b6cfd43fccdef7aa55dea~v5c7pLMAj0390003900epoutp03X
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:57:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125745epoutp03420cc706d91b6cfd43fccdef7aa55dea~v5c7pLMAj0390003900epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792265;
        bh=+LuFjZ47M4iyPMAd4HutYcuH5OmT3P0Nw+AtWPJ5ZsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRoqvmswFvKs78NkmUEjCt+Ppy1fuW6/k1zlKj9wUde2iK8iWwiooYC75u8DeKqbb
         GMCN67vQ/wvOmA5MaQpGltL4hDdckreJSbyMsZm4S9TSmudvpE9bUWJouIzqPlnao+
         OkfWZeygYJ2A0Xkx1kpN2Xxq6NlOTmubLa7B42jk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220517125744epcas5p1e62bd4e068f18010e635939916a2882f~v5c64qTW33158631586epcas5p1u;
        Tue, 17 May 2022 12:57:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2bkX59TLz4x9Pp; Tue, 17 May
        2022 12:57:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.1C.09762.1CB93826; Tue, 17 May 2022 21:57:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157~v5bX98dSJ2182421824epcas5p2M;
        Tue, 17 May 2022 12:55:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125558epsmtrp1bd21605f5741ba1f8eb98f0478b0b45d~v5bX8vR1T3276532765epsmtrp1K;
        Tue, 17 May 2022 12:55:58 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-8a-62839bc1d604
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.36.08924.D5B93826; Tue, 17 May 2022 21:55:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125554epsmtip1ea09529dd8a0dcabd6efa91352936b85~v5bU45N-M2352323523epsmtip1e;
        Tue, 17 May 2022 12:55:54 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 03/20] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Date:   Tue, 17 May 2022 18:25:31 +0530
Message-Id: <20220517125548.14746-4-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+5tby8klZvixhkLjF1HFoxgy6NeiGxT0FyGc2wjE7eZroVL
        IZT2rrcgc2NWhY7xVBcMIA8HCAGUR3lYgS28DAYcQqwQFhiICEM0oh2TiJO1tmz/ffI73+/v
        98v3nIOjoknMHU9U6xitWq4iMWdeR7+Pj2/v+VMKcU3mW9RseQdGVa0tItRMlYVH9bW2C6g2
        83mUqh3s4VMVAyN86krvHI9q+dN6OlY8zaMWKxoBtVTyB0YZ747zqTv3D1G3OksxKre5nU9d
        HpgWUBcnxhCqxvgcoSrb/xJQmb8MCKjp7g5AZRgGkPfd6EvllwBtmq4G9ET1E5S+WjItoKu6
        lxDaWP8jRk+Nd2N0a/VxOvPaMx6d31YP6BcnywR09sAERluMnvTQqkUQteXzpN0JjDyO0Xox
        6lhNXKJaGUpGfioLkwVJxRJfSTC1i/RSy5OZUDL8QJTv/kSVNQHSK1WuSrGWouQcR+58d7dW
        k6JjvBI0nC6UZNg4FRvI+nHyZC5FrfRTM7oQiVjsH2QVfpWUMLyYj7GDWFqVYR7TAwM/Gzjh
        kAiEOWujWDZwxkVEF4DD+qs824GIeALgTzk+drYAuHSB3TS09j8FdkMngK1zzQ53BgIXlqsQ
        mwojdsC/Hw1jNt5KnADwbpbOxiixjsJis6eNXYn9sHixEbUxj/CGjVmLL1cSEsHQPJuH2qe9
        CRuae6yM405ECCx7ccQ2CxIbOJxpMfHsmnC43pfl0LvC+4NtAju7w6UCg4OVcMZyCtiZhWX6
        NsTO78EecynP1h8lfGBT50572QMWDjUi9pW3wLz1eYdcCE3lm0zCyhvXHe0hvP2w3ZEoDduK
        ann2TPIAHLlSyD8NPEv+H3EBgHrwOsNyyUqGC2ID1MzR/+4sVpNsBC/f+PZIE5ibXfHrAwgO
        +gDEUXKrUJymV4iEcfJvjjFajUybomK4PhBkze8M6v5qrMb6SdQ6mSQwWBwolUoDgwOkEtJN
        SGycUIgIpVzHJDEMy2g3fQju5K5Hth1aZ2MeZ34xeu3LYVEo7mfip+5z2VVfqTiKeh+8ERTx
        /Fz/G7ra+d9lue1FhZ8VpOlvHu/xP5divLjHM34q67C6+Zllga0Je2fiAw+ICAOGP1qPSF+I
        bvIS5/7QcivjH/OkTiGZvdnY9fH19LNLPi7z4nvRAKvYQG4bmlZyQqbMe+vOpDq7nh1Xme68
        lqd48MqvYSVozMEdX9ctu7qcXHNRxLgUzDRHe3wb/vi71e/9DZ0fNjiPp8dHa5cDHqxo947u
        GWLxEq7wE2XRMfenvfvivfM7L0fIxpZXW123cV35D0MPpE1KK1SPiCM/l9YN0fGH3ZrGI7ve
        XmgQ+o8l3Isf+Y3kcQlyyXZUy8n/BVhNmQhsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnG7s7OYkgy9PLC0ezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFoq1f2C1a9x5ht7i7ZxujRUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9/jXNZffoOnKdzePzJjmPU18/swfwRXHZpKTmZJalFunbJXBlnH7ex1ZwnK1icdsTtgbG
        NtYuRk4OCQETic2HvzN2MXJxCAnsYJR48nM1I0RCQmLl70lQtrDEyn/P2SGKmpgkdt9qZAFJ
        sAnoSHx7f5oNJCEi0MoocX1lJxOIwywwkUViyvVfzCBVwgJuEjOfrwOzWQRUJdZ1PAfbzStg
        KXHlQS8zxAp5idUbDgDZHBycAlYSc//FgphCQCVP91tMYORbwMiwilEytaA4Nz232LDAKC+1
        XK84Mbe4NC9dLzk/dxMjONq0tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeg4qGJCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYpI8KvN548OuEtWK8y2Ze2evN
        vWYRx9Ktqs5d/65ttvs1/VuQ+RQZhgv8HE94ryxMsCn8/cFYM+m8ttDRX782Otf2zbxbesRJ
        WUL57b3lHL179PPjlF4uWvPjuuGy/6nvlKa6rVVQtN26QW3PrJ1/wrQmHw44cmn54sv7a2tm
        PmVsLbnQYdKjkxNdWnunqW5eJuOJl2bTrYsPzhZeuEL++kzZ/T9uCTLrO5Yks0gfkHM8wbnz
        stlnFT3/Dp+Axxb5mfb5fmKS9Xr/0/d9fPJOuZ6nujl/9WP7c33nglZybtKe9vD55sScX5vf
        p/FJpl3bI1/4wH1r73SlyB3uqicEhQ/5sG5LPQFMBnZ7635XKLEUZyQaajEXFScCAO5IFLwl
        AwAA
X-CMS-MailID: 20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds DT schema for s5p-mfc with a new compatible
string for mfcv12 variant.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 Documentation/devicetree/bindings/media/s5p-mfc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.yaml b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
index fff7c7e0d575..209da53f3582 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
@@ -21,6 +21,7 @@ properties:
       - samsung,mfc-v8                  # Exynos5800
       - samsung,exynos5433-mfc          # Exynos5433
       - samsung,mfc-v10                 # Exynos7880
+      - samsung,mfc-v12                 # Tesla FSD
 
   reg:
     maxItems: 1
-- 
2.17.1

