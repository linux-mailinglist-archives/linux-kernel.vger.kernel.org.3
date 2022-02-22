Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FD64BF18D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiBVFdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:33:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBVFch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:32:37 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA6522EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:32:10 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220222053207epoutp0438165676fc415c69329564484f1489df~WBL3qfB5a0822708227epoutp04v
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:32:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220222053207epoutp0438165676fc415c69329564484f1489df~WBL3qfB5a0822708227epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645507927;
        bh=MOL+q7NBpp1V/dFjwZiOH41GVE61PFykanhJAfeP67E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rKXtXlyx4YrqsefSUdYSXxkNwWcoqsEBjYELs0Hpz+KNEe3feozXRkaRNMmXAAnjd
         pbdHymFPrwBLv32clRPhaup5Cs6PHyRgBEnbXuOIyfICC2uNLsVh32Forsh1qJvrJ9
         oXeaaMQzWcqPl2uhhH5zYNcUnQVPw9xnf6ptz4Hs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220222053206epcas2p3f416e7805cf4a6e889d35b7b01e82556~WBL2yED0G0458404584epcas2p3B;
        Tue, 22 Feb 2022 05:32:06 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K2nq65ptrz4x9Qf; Tue, 22 Feb
        2022 05:32:02 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.3D.25540.9E474126; Tue, 22 Feb 2022 14:30:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220222053200epcas2p4eddfc8f1083a9d998456164259004b36~WBLxhdVJa3024730247epcas2p43;
        Tue, 22 Feb 2022 05:32:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220222053200epsmtrp13ee02e9d515edcbb502dfe17953b8525~WBLxggLth3216732167epsmtrp10;
        Tue, 22 Feb 2022 05:32:00 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-b2-621474e96358
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.73.29871.05574126; Tue, 22 Feb 2022 14:32:00 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220222053200epsmtip19a4951bbd33192d6edd24aec651a76d7~WBLxWs2Io0579805798epsmtip1r;
        Tue, 22 Feb 2022 05:32:00 +0000 (GMT)
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
Subject: usb: gadget: rndis: add spinlock for rndis response list
Date:   Tue, 22 Feb 2022 14:29:28 +0900
Message-Id: <1645507768-77687-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmqe7LEpEkg9mzdS3mrF/DZnGs7Qm7
        xdZviRZ3FkxjsmhevJ7N4vKuOWwWi5a1Mlts3XuV3eLg/XPMDpwe/06sYfNovHGDzWPTqk42
        jxMzfrN47J+7ht2jb8sqRo8Hk94wenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0npJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+PsrzWsBZNlKnbP+MjUwHhJvIuRk0NCwERi
        ycbrjF2MXBxCAjsYJbbsvskM4XxilDh9/wg7hPONUeLzlbnsMC1PO84zQST2Mkqc39zLBuH8
        YJTo/vkRqIqDg01AS+L7QrC5IgIdTBIP169gBelmFsiXeHX1NguILSzgKPF57ycwm0VAVWLr
        vN1gG3gFXCU2LZrDBLFNTuLmuU6wmyQELrFLNMxfB3WGi8TtK9PZIGxhiVfHt0DFpSRe9rdB
        2cUSuz61MkE0NzBKND44wQyRMJaY9aydEeRSZgFNifW79EFMCQFliSO3WCDu5JPoOPyXHSLM
        K9HRJgTRqCwx/fIEVghbUuLg63NQAz0kmva/YwSxhQRiJSa3tDBNYJSdhTB/ASPjKkax1ILi
        3PTUYqMCY3gsJefnbmIEJzkt9x2MM95+0DvEyMTBeIhRgoNZSYT3DrtwkhBvSmJlVWpRfnxR
        aU5q8SFGU2B4TWSWEk3OB6bZvJJ4QxNLAxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUw
        fUwcnFINTKIvRQ1cdH55SKdcPtSWfLdZfMe5N2oXHacveKsucqU+O7vKZHsk967q6lCugr2H
        nz1ZdZ1r4WW2OqbK9qWJh0PnWpZN+bbUrnP3q3amc9uO8W1XVZhh/WmX5QqNqNX1i922yR19
        YbVJMbSSR9VuN0PYzV1qfIXrMm/aByv48gaL/g9We6TptJtpN0PS/K23ll9YUcf29bHchYXZ
        i5pzOI9Mvn9sfe2KL00mJz42p+bOkvv4+PSjXYJOn1USHDkmqN8xmr9lhcIx3tx5sTcEnQ26
        a0PrL2QcDOyYW7RvteTG35I5sXKMRxm/b1gyZWlGv/+HH51yh3ivZfLcXcwrESiwI+XHnD3z
        pA5seeG5yUmJpTgj0VCLuag4EQAkydyo+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnG5AqUiSwddGc4s569ewWRxre8Ju
        sfVbosWdBdOYLJoXr2ezuLxrDpvFomWtzBZb915ltzh4/xyzA6fHvxNr2Dwab9xg89i0qpPN
        48SM3ywe++euYffo27KK0ePBpDeMHp83yQVwRHHZpKTmZJalFunbJXBlnP21hrVgskzF7hkf
        mRoYL4l3MXJySAiYSDztOM/UxcjFISSwm1Hi552TrBAJSYmlc2+wQ9jCEvdbjrBCFH1jlNjX
        vo2xi5GDg01AS+L7QkaQuIhAD5PE9NPrwRqYBQolDi1aBGYLCzhKfN77iQXEZhFQldg6bzdY
        nFfAVWLTojlMEAvkJG6e62SewMizgJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
        cNhpae5g3L7qg94hRiYOxkOMEhzMSiK8d9iFk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpgMk/ef6XmIJPR8sg9jMe87b59N3pyz+A41wxD8Z6HzBdr
        +Iy0ft2aVG1afInH06dz/kaBdLUVt6oWzmE8VFBbML+4086O2/2/jsyZtnWv7vXbRtiKpd7p
        Ot87S5vZ5dEqywT7lUx6vFyvgm1XfJ0YlnmxwVVW7kfaXxUpwaoq2zKjiRkntM+XtIZdiNqQ
        tSB2qe6Vg1d59+33aWfpZL34tvdAO4NTtQn/3resxfZ+hUsnFCszJnR0yqi/PLE/r0Vykty2
        4N5PbHrrrv8//H4Rw5yGe8Yeq3/MWMq//+rHXedmnD/136ezIKGeY1/YZhtRg8RsyzdhtxOq
        JjRzLLob0PZTr7XVgMH6+T6h1+eVWIozEg21mIuKEwE26HbzqgIAAA==
X-CMS-MailID: 20220222053200epcas2p4eddfc8f1083a9d998456164259004b36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220222053200epcas2p4eddfc8f1083a9d998456164259004b36
References: <CGME20220222053200epcas2p4eddfc8f1083a9d998456164259004b36@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no lock for rndis response list. It could cause list corruption
if there're two different list_add at the same time like below.
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
 drivers/usb/gadget/function/rndis.c | 8 ++++++++
 drivers/usb/gadget/function/rndis.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 431d5a7..79fd994 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -919,6 +919,7 @@ struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)
 	params->resp_avail = resp_avail;
 	params->v = v;
 	INIT_LIST_HEAD(&params->resp_queue);
+	spin_lock_init(&params->resp_lock);
 	pr_debug("%s: configNr = %d\n", __func__, i);
 
 	return params;
@@ -1012,12 +1013,14 @@ void rndis_free_response(struct rndis_params *params, u8 *buf)
 {
 	rndis_resp_t *r, *n;
 
+	spin_lock(&params->resp_lock);
 	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
 		if (r->buf == buf) {
 			list_del(&r->list);
 			kfree(r);
 		}
 	}
+	spin_unlock(&params->resp_lock);
 }
 EXPORT_SYMBOL_GPL(rndis_free_response);
 
@@ -1027,14 +1030,17 @@ u8 *rndis_get_next_response(struct rndis_params *params, u32 *length)
 
 	if (!length) return NULL;
 
+	spin_lock(&params->resp_lock);
 	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
 		if (!r->send) {
 			r->send = 1;
 			*length = r->length;
+			spin_unlock(&params->resp_lock);
 			return r->buf;
 		}
 	}
 
+	spin_unlock(&params->resp_lock);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(rndis_get_next_response);
@@ -1051,7 +1057,9 @@ static rndis_resp_t *rndis_add_response(struct rndis_params *params, u32 length)
 	r->length = length;
 	r->send = 0;
 
+	spin_lock(&params->resp_lock);
 	list_add_tail(&r->list, &params->resp_queue);
+	spin_unlock(&params->resp_lock);
 	return r;
 }
 
diff --git a/drivers/usb/gadget/function/rndis.h b/drivers/usb/gadget/function/rndis.h
index f6167f7..6206b8b 100644
--- a/drivers/usb/gadget/function/rndis.h
+++ b/drivers/usb/gadget/function/rndis.h
@@ -174,6 +174,7 @@ typedef struct rndis_params {
 	void			(*resp_avail)(void *v);
 	void			*v;
 	struct list_head	resp_queue;
+	spinlock_t		resp_lock;
 } rndis_params;
 
 /* RNDIS Message parser and other useless functions */
-- 
2.7.4

