Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD1538B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiEaGoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiEaGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:44:00 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC56D1B9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:43:57 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220531064352epoutp0466139856d0c761569132cb8b6ed27a79~0HYfixuu61028510285epoutp04O
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:43:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220531064352epoutp0466139856d0c761569132cb8b6ed27a79~0HYfixuu61028510285epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653979432;
        bh=vageBDolnhTvTUz8OlYak/qIpkqe10Ke7/TPTPW8ls4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gS/SaG59x9pgfqB868EPIjrbA5XDzeH16KuHZnC3rjWMUwYtvVVp/7P+aOGMkFXoE
         9REtimVQ55Af7p1HWV1Mzhqfa0ss/4bXKGDEczegSs62ZopNYCHhC5EcTsCXV5EMZe
         DSPOecnQxl9DR2WzyYIAnqZ3E49BdBgZv0qTVx90=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220531064352epcas2p19487ad8137ccaaa40ffb910d25ae10e5~0HYfMwLP63165331653epcas2p1L;
        Tue, 31 May 2022 06:43:52 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LC2mj3Z0kz4x9Pv; Tue, 31 May
        2022 06:43:49 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.17.10028.529B5926; Tue, 31 May 2022 15:43:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531064348epcas2p2168f11ba49e9a119219bebe18a769dff~0HYcCaSWY1021310213epcas2p2M;
        Tue, 31 May 2022 06:43:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531064348epsmtrp22e7aa0b86522856eb0983e4484469244~0HYcBmhko1906119061epsmtrp2c;
        Tue, 31 May 2022 06:43:48 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-b1-6295b9252ba3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.7C.08924.429B5926; Tue, 31 May 2022 15:43:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220531064348epsmtip120046ca9fc34675cb59a956a44e33a89~0HYb1dASM1634216342epsmtip1T;
        Tue, 31 May 2022 06:43:48 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] linux/time32.h: correct ns_to_kernel_old_timeval prototype
Date:   Tue, 31 May 2022 15:43:46 +0900
Message-Id: <20220531064346.51677-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmha7qzqlJBtunclj8nXSM3eLyfm2L
        Pyc2sllc3jWHzeLftY0sFps3TWV2YPP4/WsSo8eCTaUem1Z1snm8O3eO3aNvyypGj8+b5ALY
        orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COUFIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZk
        Z8x4+4y9YBpnRdunGcwNjO/Yuxg5OSQETCTObr/H2MXIxSEksINR4vaLbjYI5xOjxOz+PawQ
        zmdGidW/DzPBtOxbfZQFIrGLUWLTzrfsEM5HRoljS/6zgVSxCehKbHn+ihHEFhHIlnjx6Sgr
        iM0skCPx/dtdsBphAW+JabP2AjVzcLAIqEr03rEECfMK2En8XX6RBWKZvMSG+b3MEHFBiZMz
        n7BAjJGXaN46mxlkr4TAOXaJT/dnsILMkRBwkZi13heiV1ji1fEtUH9KSXx+t5cNwi6WWDrr
        ExNEbwOjxOVtv6ASxhKznrUzgsxhFtCUWL9LH2KkssSRW1Br+SQ6Dv9lhwjzSnS0CUE0qksc
        2D4d6mJZie45n1khbA+J+S9fgl0gJBArMXPBdNYJjPKzkDwzC8kzsxD2LmBkXsUollpQnJue
        WmxUYAyP0+T83E2M4GSo5b6DccbbD3qHGJk4GA8xSnAwK4nwWkVMTRLiTUmsrEotyo8vKs1J
        LT7EaAoM3YnMUqLJ+cB0nFcSb2hiaWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+J
        g1OqgSnzOst2/pere1luWp7abK+hX7xsXXLy74dF8wK4gjryDm/g+TZ1p6X2x8mTnrzadZ9z
        c9pT28ZPVsGLH92Q7QtMT3i2fEl1CDvrrJRHlxa5Nsdr1KR+3/3xwwkmxnOzw9onuFedWeP/
        w/y0xNsJvzsWfl5cUM/fXF5dvjXs+dd+voI1C5gu89YcS7Zz/TjneNyB3xsVjINF88StP3pp
        nvyj0H9fuYaPa2n9mnlds46tkf84h+fQ5WVKlQ83q7/xLzG1z5uvLbm6cr2RuIKKOKtkjn3N
        9ns6jIUvWUt519z+8vkMk5JQzcFt1yYy7tB6Zcd7quBOPFtj4gQ9zaXZt6c4rE1ZybQ8n/+H
        m97qWlMlluKMREMt5qLiRADIiovUDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnK7KzqlJBitf6ln8nXSM3eLyfm2L
        Pyc2sllc3jWHzeLftY0sFps3TWV2YPP4/WsSo8eCTaUem1Z1snm8O3eO3aNvyypGj8+b5ALY
        orhsUlJzMstSi/TtErgyZrx9xl4wjbOi7dMM5gbGd+xdjJwcEgImEvtWH2XpYuTiEBLYwSix
        498zZoiErMSzdzugioQl7rccYYUoes8oMeHXOrAiNgFdiS3PXzGC2CICuRIHHzezgtjMAnkS
        P5ues4DYwgLeEtNm7QUaxMHBIqAq0XvHEiTMK2An8Xf5RRaI+fISG+b3MkPEBSVOznzCAjFG
        XqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERygWlo7
        GPes+qB3iJGJg/EQowQHs5IIr1XE1CQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQn
        lqRmp6YWpBbBZJk4OKUamHaa/Fy/0F8r62fWQXblp0X8N4z6eZv/ie7/ptazRlyHxfDAXPv+
        o9JtKTd+yk3ex2CYcXnl3AnyvdUfvqVytH//kMm/VSZl2bfeF8vK7xxaekRJQ1OhYV7w5pbX
        lxgYec69M48LvpZW/PnuF51rj6V8Eiff8j5+KmZ7busXBmnDJznHl1vrrFVwEpPzvOrhKi2z
        u93qy5ldmc3Ve387X67ZUPFSsb1vV6lpXD9ra1iFeOepvQvD5kQf16r7e9Dv9IRimS9Xo/oX
        nt2R3rJv6xwTydmfl336+Dj/YFcK613uj4pt358VNiXeyn+/8jUPo8a5iDZ+polPXlyeeqRV
        /Hl15kaD58VXQ9/f3jLr8C0lluKMREMt5qLiRAA0FvOXvwIAAA==
X-CMS-MailID: 20220531064348epcas2p2168f11ba49e9a119219bebe18a769dff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531064348epcas2p2168f11ba49e9a119219bebe18a769dff
References: <CGME20220531064348epcas2p2168f11ba49e9a119219bebe18a769dff@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function argument is defined with const identifier in
kernel/time/time.c but the prototype looks different between time.c and
time32.h. There is a review[1] why it was omitted during review stage but
they should be matched.

- The function is defined in kernel/time/time.c as below:
struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)

[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1637458.html
Fixes: a84d1169164b ("y2038: Introduce struct __kernel_old_timeval")
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 include/linux/time32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index 83a400b6ba99..88c135d4c557 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -67,6 +67,6 @@ int put_old_timex32(struct old_timex32 __user *, const struct __kernel_timex *);
  *
  * Returns the timeval representation of the nsec parameter.
  */
-extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
+extern struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec);
 
 #endif
-- 
2.36.1

