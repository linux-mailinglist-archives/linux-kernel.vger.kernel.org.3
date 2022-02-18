Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC384BB176
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiBRFc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRFcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:32:55 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0FC559D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:32:38 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220218053236epoutp04d67600e141d552f32b35a6fe613eed3a~UynJITs8h0102201022epoutp04L
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220218053236epoutp04d67600e141d552f32b35a6fe613eed3a~UynJITs8h0102201022epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645162356;
        bh=/3mzPEe2xJULE51u7JXzlalFBnc6s+qxmL4k9iF36qk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IOgyoh+MoY/MgpVLucr4g5foDKwvLI+4dsgWENDLkFTtCRtAcRLs1pY0aHyVL/83L
         sx6bkZfnraPSZzUBsObY3s34lu3Uw/73Pfom8N2FtNxAyOUGcqykqPuvCmPRcg6qp/
         slMIX8c0h9V9dsgykhClWU3LIEMekMIo6I/UhNMY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220218053235epcas2p214e20afb27d5b392e217de4f3ad36f56~UynIU6IzB2212722127epcas2p29;
        Fri, 18 Feb 2022 05:32:35 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K0L1W404jz4x9QH; Fri, 18 Feb
        2022 05:32:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.44.12141.8DE2F026; Fri, 18 Feb 2022 14:30:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc~UynEN5-xG1023810238epcas2p1K;
        Fri, 18 Feb 2022 05:32:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220218053230epsmtrp14a3ed867cd919c7c3bd637ec45f950b5~UynENfylY1115011150epsmtrp15;
        Fri, 18 Feb 2022 05:32:30 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-73-620f2ed88aa8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.05.29871.E6F2F026; Fri, 18 Feb 2022 14:32:30 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220218053230epsmtip20d5ee0b0180143f058cd5ab95033a8b0~UynD9r6p_1926019260epsmtip2K;
        Fri, 18 Feb 2022 05:32:30 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>
Subject: usb: gadget: function: add spinlock for rndis response list
Date:   Fri, 18 Feb 2022 14:29:55 +0900
Message-Id: <1645162195-54476-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmqe4NPf4kgyXPJS3mrF/DZnGs7Qm7
        xdZviRZ3FkxjsmhevJ7N4vKuOWwWi5a1Mlts3XuV3eLg/XPMDpwe/06sYfNovHGDzWPTqk42
        jxMzfrN47J+7ht2jb8sqRo8Hk94wenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0npJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PXhL+MBdPEK2ZNe8rcwLheuIuRk0NCwERi
        w8bbbCC2kMAORolJS1W6GLmA7E+MEmc/9bFBON8YJZrebWeD6fi/9B0rRGIvo8S9OZOhnB9A
        VRtfAzkcHGwCWhLfFzKCxEUEOpgkHq5fwQrSzSyQL/Hq6m0WEFtYwEXixdRZTCA2i4CqxNTX
        W8FsXgFXibbm+4wQ2+Qkbp7rZAYZJCFwiV3i04r1zCALJICat9yB+kFY4tXxLewQtpTEy/42
        KLtYYtenViaI3gZGicYHJ5ghEsYSs561M4LMYRbQlFi/Sx9ipLLEkVssEGfySXQc/ssOEeaV
        6GgTgmhUlph+eQIrhC0pcfD1OahjPCTev/eCBGKsRO/PW0wTGGVnIYxfwMi4ilEstaA4Nz21
        2KjABB5Fyfm5mxjB6U3LYwfj7Lcf9A4xMnEwHmKU4GBWEuH9cJA3SYg3JbGyKrUoP76oNCe1
        +BCjKTC0JjJLiSbnAxNsXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYO
        TqkGJrNYseMnN2x58H/9nFsf24K+cSQUWWzcxr3vicLLyLLELWx8jwRvpUbxnpmvvyDzf1BP
        xsoOxevvrR7WBNctVs9nruPcon5Yrlz0SkT889QTOhsms5QleV3rEtZS3/7zovAjV8lepV0r
        xWJu3sg71jjTOldCfMFC8Y/27gs4ohYJ7fwnIrqm7ll5tZ5Z77bnP9/tPlv/nX+zqG5064oN
        Xbf94ybGKfPXOx2SV9n27WK9p9mFjUVdO9qWa76uWjuvxX0Vd/qBs9YK538c2uCidFpe4Nvk
        +gOWFqsOdCtVNPzZKyDRYXJYRT1WyWGdm5PrivN8K7pz5mhISwka6vz2Z1+gkHJ9uUSxwYlD
        dQbsSizFGYmGWsxFxYkAbS2u8PgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSvG6ePn+SwaLzqhZz1q9hszjW9oTd
        Yuu3RIs7C6YxWTQvXs9mcXnXHDaLRctamS227r3KbnHw/jlmB06PfyfWsHk03rjB5rFpVSeb
        x4kZv1k89s9dw+7Rt2UVo8eDSW8YPT5vkgvgiOKySUnNySxLLdK3S+DK2DXhL2PBNPGKWdOe
        MjcwrhfuYuTkkBAwkfi/9B1rFyMXh5DAbkaJ57+/MUEkJCWWzr3BDmELS9xvOQJV9I1Rov3r
        QZYuRg4ONgEtie8LGUHiIgI9TBLTT68Ha2AWKJQ4tGgRmC0s4CLxYuossKEsAqoSU19vBbN5
        BVwl2prvM0IskJO4ea6TeQIjzwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFh
        p6W5g3H7qg96hxiZOBgPMUpwMCuJ8H44yJskxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4
        IYH0xJLU7NTUgtQimCwTB6dUA9MK1t71LWJ2/BdCeq/2b8rgfiZyY9+y6t3vX9Uwu7z12t02
        0cN5S9DElISizzvyZpWuTn7LOTuYYyLb7sPbhDxjou7sn7Q3pHP6B74AzfIdS74oXYxiXiCu
        ne5u4hu7PfAA57n2g4szKuW/uXh8VFZc7S0cIZIb2Punr3CvQetC/XRvI6WK07873n64IOqz
        9L91yRG2XOYJx7ws7U9cmRmxouZFHn97y5WNl3LunphTaSB4bdXzR4cvBJ2J/z0p17B42pr6
        iVaTX53a3FwsJbZqkdP+Expq4dxHW0SClOXnKV+8GefxScxhwnPV7tdJ0bPOSZ3u9n9/6PQe
        Vr27PTkz5D/c/hXDen3XB8afV/YpsRRnJBpqMRcVJwIAiV8/hKoCAAA=
X-CMS-MailID: 20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc
References: <CGME20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no lock for rndis response list. It could cause list corruption
if two different list_add at the same time like below.
It's better to add in rndis_add_response / rndis_free_response
/ rndis_get_next_response to prevent any race condition on response list.

[  361.894299] [1:   irq/191-dwc3:16979] list_add corruption.
next->prev should be prev (ffffff80651764d0),
but was ffffff883dc36f80. (next=ffffff80651764d0).

[  361.904380] [1:   irq/191-dwc3:16979] Call trace:
[  361.904391] [1:   irq/191-dwc3:16979]  __list_add_valid+0x74/0x90
[  361.904401] [1:   irq/191-dwc3:16979]  rndis_msg_parser+0x168/0x8c0
[  361.904409] [1:   irq/191-dwc3:16979]  rndis_command_complete+0x24/0x84
[  361.904417] [1:   irq/191-dwc3:16979]  usb_gadget_giveback_request+0x20/0xe4
[  361.904426] [1:   irq/191-dwc3:16979]  dwc3_gadget_giveback+0x44/0x60
[  361.904434] [1:   irq/191-dwc3:16979]  dwc3_ep0_complete_data+0x1e8/0x3a0
[  361.904442] [1:   irq/191-dwc3:16979]  dwc3_ep0_interrupt+0x29c/0x3dc
[  361.904450] [1:   irq/191-dwc3:16979]  dwc3_process_event_entry+0x78/0x6cc
[  361.904457] [1:   irq/191-dwc3:16979]  dwc3_process_event_buf+0xa0/0x1ec
[  361.904465] [1:   irq/191-dwc3:16979]  dwc3_thread_interrupt+0x34/0x5c

Fixes: f6281af9d62e ("usb: gadget: rndis: use list_for_each_entry_safe")
Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/gadget/function/rndis.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index b7ccf1803656..b4d58324e2d2 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -1011,16 +1011,21 @@ void rndis_add_hdr(struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(rndis_add_hdr);
 
+/* add spinlock to prevent race condition for rndis response list */
+static DEFINE_SPINLOCK(resp_lock);
+
 void rndis_free_response(struct rndis_params *params, u8 *buf)
 {
 	rndis_resp_t *r, *n;
 
+	spin_lock(&resp_lock);
 	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
 		if (r->buf == buf) {
 			list_del(&r->list);
 			kfree(r);
 		}
 	}
+	spin_unlock(&resp_lock);
 }
 EXPORT_SYMBOL_GPL(rndis_free_response);
 
@@ -1030,14 +1035,17 @@ u8 *rndis_get_next_response(struct rndis_params *params, u32 *length)
 
 	if (!length) return NULL;
 
+	spin_lock(&resp_lock);
 	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
 		if (!r->send) {
 			r->send = 1;
 			*length = r->length;
+			spin_unlock(&resp_lock);
 			return r->buf;
 		}
 	}
 
+	spin_unlock(&resp_lock);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(rndis_get_next_response);
@@ -1054,7 +1062,9 @@ static rndis_resp_t *rndis_add_response(struct rndis_params *params, u32 length)
 	r->length = length;
 	r->send = 0;
 
+	spin_lock(&resp_lock);
 	list_add_tail(&r->list, &params->resp_queue);
+	spin_unlock(&resp_lock);
 	return r;
 }
 
-- 
2.31.1

