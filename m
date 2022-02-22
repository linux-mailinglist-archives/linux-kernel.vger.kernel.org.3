Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B694BEEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiBVBQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiBVBQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D925589;
        Mon, 21 Feb 2022 17:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492506;
        bh=VqDtjCu1On8E90PP+zcmUBiCFF/DRJ7DnsmAzRfKwqs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RNrqn3EGfsrYU7qAwyec8yYuxacsBA3JJj2OSnWGScS2QimbzXLMIK7d2XTnPvzz1
         e/EoyrF7kRS915ouO1baNbEwCZptCjFGttoiweCVHkqTyEwUZT/YSHjb8071UQUelS
         4sUmoFj15lAavtgtD+p2fNSomniGai4/LanotcWo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1nqy1F0fOZ-00fkCh; Tue, 22
 Feb 2022 02:15:06 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH v3 1/9] serial: core: move RS485 configuration tasks from drivers into core
Date:   Tue, 22 Feb 2022 02:14:25 +0100
Message-Id: <20220222011433.8761-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:SSsn/0UwWR3j7W6KX8VHiJO40uYcDYbhSEf6Uj+6iT5yAPMPiY2
 DRtOInCigEKQmPnoKe2o/eI4N3ft3SFBNYY3rzbb4FqEShSJSAq0ZJut4p2B0+uFtki9HY8
 O0g5SqO8bnSG9ZBK6IjSfYw6ZOxyTPOlYstuIej508E5Bg5nSVTtHF7+AksSve/UNN6w5/a
 gwWSJT4IxjADoN+sTrxnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QmI32g1894s=:RsjLS1yif5G6gEPcRSo6AJ
 +GufJ9SftvEz8xJ1dECRlgc5t4+2cUaR8CxxDi+4K6nQ2Mqoe4qXIYF7IX1crVxbKdElNurki
 xyEz2dacQqAY8/I69QBbs8gu+IX9tAht7N9Y7Cquy8Rn2K/lVXBwl35iRzLLXVzDRcI2Ye9rc
 rTSUPs6Tj6BAmITa2OiHIbXpW52QvccbPxXHq5GIRQCY+H6ZtFVDp0ON/aeu/zouD/qHVXK5Q
 DVnUW30yEO0F3YIht3gVCylV1DIbnMp3XaRjIA+igDj0vMyRUmNfsGEK484zs6Le+NfKPXJY8
 2zp+sGNfhacpaMGW4mVbCj5ZlZq3pFBpOt1bKavMLd0/yJDZmtip0+9p48/WqLpBqhdOvPdGQ
 IyechYq8cSwGaC6DeMzUd95h69h0fERuxWVtrGZclFXW3pSXeAjmL8cG0BNDFKl1Z1ZliofOM
 tlRqGtSIgbGc3UuPh+wMYeYmyJOlHcAYUkLYjXhYC04c7ejWPFh/I61w/r8z0Dpx5jyZoUoIs
 m5rWeTH019U1XsjAWAg5XYiYdtx+RMNcVjKnnVhgf38YmyNlCZG4x1ecny9vd1Nh8u5p23ln7
 E23r3IjbTmOGx0VpX/T77YAI/TMayw9aY0EbDJPcyu/E82+wPOj9E1m7krj4BqpAS7aTQ30RV
 SXwKUgnFlHjccFvJNb2/1su53GogUOdalfSCVEtyRCRrVPx2h6E7TuUfuzO/nKO4oQVlg+sk5
 QIFrZrTWuodSul3xQ3qTn5MGRYKlfK16fPj/y2/h+2irH3OqhWEOLAHo9aeKlHuJaTF7iLv9a
 zMGk46hg823+9E1bOr4IPGkk6ANrcry4vcJzXmLM2Y9ZuvQcJSBV7/XIaURMcRHoBz/8l31j6
 pA8z4hLuPwUHa9esLbPDmkATaP54BMiBwS0FEgDcSIBM5r7N9MeZmPOqofOM1/PqDRctCru6K
 3weNt2ojBUjN69/ruP/olavuzCwM6rTHIP2Cxs18Y0sez3pJ2Y8C/WjHfoEv1X137lqqYtU/y
 lDX9d5l2FF5JPbcoxhCfR2ZAE/0HFr/Ybu0r69Uy9S/sqKX+r6JHmbifbguik2kMjy6jlHDna
 aAaAUmlkxhxbYM=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2V2ZXJhbCBkcml2ZXJzIHRoYXQgc3VwcG9ydCBzZXR0aW5nIHRoZSBSUzQ4NSBjb25maWd1cmF0
aW9uIHZpYSB1c2Vyc3BhY2UKaW1wbGVtZW50IG9uZSBvciBtb3JlIG9mIHRoZSBmb2xsb3dpbmcg
dGFza3M6CgotIGluIGNhc2Ugb2YgYW4gaW52YWxpZCBSVFMgY29uZmlndXJhdGlvbiAoYm90aCBS
VFMgYWZ0ZXIgc2VuZCBhbmQgUlRTIG9uCiAgc2VuZCBzZXQgb3IgYm90aCB1bnNldCkgZmFsbCBi
YWNrIHRvIGVuYWJsZSBSVFMgb24gc2VuZCBhbmQgZGlzYWJsZSBSVFMKICBhZnRlciBzZW5kCgot
IG51bGxpZnkgdGhlIHBhZGRpbmcgZmllbGQgb2YgdGhlIHJldHVybmVkIHNlcmlhbF9yczQ4NSBz
dHJ1Y3QKCi0gY29weSB0aGUgY29uZmlndXJhdGlvbiBpbnRvIHRoZSB1YXJ0IHBvcnQgc3RydWN0
CgotIGxpbWl0IFJUUyBkZWxheXMgdG8gMTAwIG1zCgpNb3ZlIHRoZXNlIHRhc2tzIGludG8gdGhl
IHNlcmlhbCBjb3JlIHRvIG1ha2UgdGhlbSBnZW5lcmljIGFuZCB0byBwcm92aWRlCmEgY29uc2lz
dGVudCBiZWhhdmlvdXIgYW1vbmcgYWxsIGRyaXZlcnMuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNh
bmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwv
c2VyaWFsX2NvcmUuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXgg
ODQ2MTkyYTdiNGJmLi4yYjNhZmUwMzhjMWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBA
IC00Miw2ICs0MiwxMSBAQCBzdGF0aWMgc3RydWN0IGxvY2tfY2xhc3Nfa2V5IHBvcnRfbG9ja19r
ZXk7CiAKICNkZWZpbmUgSElHSF9CSVRTX09GRlNFVAkoKHNpemVvZihsb25nKS1zaXplb2YoaW50
KSkqOCkKIAorLyoKKyAqIE1heCB0aW1lIHdpdGggYWN0aXZlIFJUUyBiZWZvcmUvYWZ0ZXIgZGF0
YSBpcyBzZW50LgorICovCisjZGVmaW5lIFJTNDg1X01BWF9SVFNfREVMQVkJMTAwIC8qIG1zZWNz
ICovCisKIHN0YXRpYyB2b2lkIHVhcnRfY2hhbmdlX3NwZWVkKHN0cnVjdCB0dHlfc3RydWN0ICp0
dHksIHN0cnVjdCB1YXJ0X3N0YXRlICpzdGF0ZSwKIAkJCQkJc3RydWN0IGt0ZXJtaW9zICpvbGRf
dGVybWlvcyk7CiBzdGF0aWMgdm9pZCB1YXJ0X3dhaXRfdW50aWxfc2VudChzdHJ1Y3QgdHR5X3N0
cnVjdCAqdHR5LCBpbnQgdGltZW91dCk7CkBAIC0xMjgyLDggKzEyODcsMzIgQEAgc3RhdGljIGlu
dCB1YXJ0X3NldF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAlpZiAoY29w
eV9mcm9tX3VzZXIoJnJzNDg1LCByczQ4NV91c2VyLCBzaXplb2YoKnJzNDg1X3VzZXIpKSkKIAkJ
cmV0dXJuIC1FRkFVTFQ7CiAKKwkvKiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIgaGFz
bid0ICovCisJaWYgKCEocnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09CisJ
ICAgICEocnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSB7CisJCXByX3dh
cm4oImludmFsaWQgUlRTIHNldHRpbmcsIHVzaW5nIFJUU19PTl9TRU5EIGluc3RlYWRcbiIpOwor
CQlyczQ4NS5mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkQ7CisJCXJzNDg1LmZsYWdzICY9
IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CisJfQorCisJaWYgKHJzNDg1LmRlbGF5X3J0c19i
ZWZvcmVfc2VuZCA+IFJTNDg1X01BWF9SVFNfREVMQVkpIHsKKwkJcnM0ODUuZGVsYXlfcnRzX2Jl
Zm9yZV9zZW5kID0gUlM0ODVfTUFYX1JUU19ERUxBWTsKKwkJcHJfd2FybigiUlRTIGRlbGF5IGJl
Zm9yZSBzZW5kaW5nIGNsYW1wZWQgdG8gJXUgbXNcbiIsCisJCQlyczQ4NS5kZWxheV9ydHNfYmVm
b3JlX3NlbmQpOworCX0KKworCWlmIChyczQ4NS5kZWxheV9ydHNfYWZ0ZXJfc2VuZCA+IFJTNDg1
X01BWF9SVFNfREVMQVkpIHsKKwkJcnM0ODUuZGVsYXlfcnRzX2FmdGVyX3NlbmQgPSBSUzQ4NV9N
QVhfUlRTX0RFTEFZOworCQlwcl93YXJuKCJSVFMgZGVsYXkgYWZ0ZXIgc2VuZGluZyBjbGFtcGVk
IHRvICV1IG1zXG4iLAorCQkJcnM0ODUuZGVsYXlfcnRzX2FmdGVyX3NlbmQpOworCX0KKwkvKiBS
ZXR1cm4gY2xlYW4gcGFkZGluZyBhcmVhIHRvIHVzZXJzcGFjZSAqLworCW1lbXNldChyczQ4NS5w
YWRkaW5nLCAwLCBzaXplb2YocnM0ODUucGFkZGluZykpOworCiAJc3Bpbl9sb2NrX2lycXNhdmUo
JnBvcnQtPmxvY2ssIGZsYWdzKTsKIAlyZXQgPSBwb3J0LT5yczQ4NV9jb25maWcocG9ydCwgJnJz
NDg1KTsKKwlpZiAoIXJldCkKKwkJcG9ydC0+cnM0ODUgPSByczQ4NTsKIAlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsK
CmJhc2UtY29tbWl0OiBhNjAzY2E2MGNlYmZmODU4OTg4MjQyN2E2N2Y4NzBlZDk0NmIzZmM4Ci0t
IAoyLjM1LjEKCg==
