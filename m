Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878F04FAD72
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiDJKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2FE53718;
        Sun, 10 Apr 2022 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587635;
        bh=bcuHE5LYV9+TYYYh0ydrJw7GifQW+gzYXpAJjFrVMQk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lMxvV4i1Ks1xzYR/VWUoE2+ZOsd6jl0EDnc6VmK6Y8SGiscZalFKsnaKaeUwa4NOZ
         CtaP1VasZJFVM1r9u8kdYAK97CboQr5vQhSnHAt54MfkgmgqE4xGeh/PyW0/GIGHng
         Re6o7NEhpJiEnUjuj4kX85JcpB+dIyfWSWHjN2w0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1o2xMU2AST-017q8t; Sun, 10
 Apr 2022 12:47:15 +0200
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
Subject: [PATCH v4 RESEND 1/9] serial: core: move RS485 configuration tasks from drivers into core
Date:   Sun, 10 Apr 2022 12:46:34 +0200
Message-Id: <20220410104642.32195-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Cbf0m5TvH0ivlHwoDqjuX1YEpNeDKfr+7WrIDoXnHJHL5oc9rwR
 RR0tSPb0vgFgGpPm+NbS5IewZHnWiWlo3WHhYEGogSv1pHWCU+XP7+YOQsda4ZD3VeG2bd0
 U3RjSQ4VrJ9LB0vL6rJoiCQRPu2F12OLni7KTkft35gwUboyxKiTuIAHh1Oc6TJEpjJ1lUe
 Pv7dj4ANcF7hApqa51lnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:00Xfi7TDn+s=:jsge8c7jbl0RII1rtMh0sj
 YboDPgJwYzvC7ao5PHgFgeXSeofkdYBmYCvWSxtbhzEY4Li8Z7LybTJiyBVR8rov39QddSkGq
 B2tmg0HtKQx4S4B+uFr9kI69WV6X/ljpxzRZ3exdyE4/QcV4LvkImo1IoKDLhxCd1RRXSWovN
 ffxQBtABaIH+W+1AYG3VsT/VaGTNDNeyBOaS+e9zUFJTSlXn4D0+XJFJ4z20u7VeZFeOa0cm/
 XZ7qi3qQsOjbz9rJIaVphbDQgissBugsQNs+zQbjg1rmsKf6PTXdS8vu1qTHcRFUUZMqXs3Od
 Wje5OvLTMT5qUZvZzCicCfcVqPeWZqsJ1v23L61quFMfTHux3hEd3tWe/Na64uKtYMey8Owfd
 POygGRtbg0ZLyjCf/1IzhMxwDEpTPAXIOSGmbBK5NIfIg+2+vDW9UNC/aZG3cih1Lp9SevRfk
 5URSvi3djPl3glsOJssJx8avsmaDrPQBPqOfFFLrzYKUxUfsdcaNNVwPhE2EfI+kHxYAWvpOQ
 eUSR6oQQJES8N2Aqj6xwCYe8RZx6aEmeoIm6YSRuyQ6Q/R91ust6EN630T4NNYR81ECi4JZki
 mTnueNiYrIdzDCn37DkY4R6OAR5xNB2y6lyXNHYLFaIYTNRwPoUuac77NELFjSqEYtTKiSGsh
 ijPIZNOHEXWUkZ6sU3pEXmxXgskPNFwOf5Dqm9JbowyCD+zIKuRdXhDk1GdaOWF6M5qd18/It
 Vw7hZ6kOoY4CEPqxMbLExM74RI8SN1RLYBGSBH9KZEuNzcf7nrFJ5D0+JDTngO/CwxSDnlc8q
 3fTs7q0CIAmwUfi+5RV0SpLAZ9uDemz4Af87rKe6J5zagzLkinfq9Rm1GFdXaj3qBMudR3QlK
 LC4vXQBsrXrklC0j6j2JGtGHekNmL64eWdAi3jqtoJqJKN+LcG3ayi9GJzLNCPEWW1yrtkUkP
 9NMm85Xr1uMQvIYGRO2otn6PQfEaBT/5szjjfS5ZzAEMpaQMc8aH3tDgVj+DR5ghhEQW0YkFa
 YVHkVFeq5axL29QilBQRMFo0YII5dPxgyqoHWWLPjMYi0uvXezu/AdrT4GKEwfsXKmpBh7R2u
 dlX7syztAov0lU=
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
c2VyaWFsX2NvcmUuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5k
ZXggNmE4OTYzY2FmOTU0Li4xMDhiMzg5ZTZlMTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5j
CkBAIC00Miw2ICs0MiwxMSBAQCBzdGF0aWMgc3RydWN0IGxvY2tfY2xhc3Nfa2V5IHBvcnRfbG9j
a19rZXk7CiAKICNkZWZpbmUgSElHSF9CSVRTX09GRlNFVAkoKHNpemVvZihsb25nKS1zaXplb2Yo
aW50KSkqOCkKIAorLyoKKyAqIE1heCB0aW1lIHdpdGggYWN0aXZlIFJUUyBiZWZvcmUvYWZ0ZXIg
ZGF0YSBpcyBzZW50LgorICovCisjZGVmaW5lIFJTNDg1X01BWF9SVFNfREVMQVkJMTAwIC8qIG1z
ZWNzICovCisKIHN0YXRpYyB2b2lkIHVhcnRfY2hhbmdlX3NwZWVkKHN0cnVjdCB0dHlfc3RydWN0
ICp0dHksIHN0cnVjdCB1YXJ0X3N0YXRlICpzdGF0ZSwKIAkJCQkJc3RydWN0IGt0ZXJtaW9zICpv
bGRfdGVybWlvcyk7CiBzdGF0aWMgdm9pZCB1YXJ0X3dhaXRfdW50aWxfc2VudChzdHJ1Y3QgdHR5
X3N0cnVjdCAqdHR5LCBpbnQgdGltZW91dCk7CkBAIC0xMjk2LDggKzEzMDEsMzYgQEAgc3RhdGlj
IGludCB1YXJ0X3NldF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAlpZiAo
Y29weV9mcm9tX3VzZXIoJnJzNDg1LCByczQ4NV91c2VyLCBzaXplb2YoKnJzNDg1X3VzZXIpKSkK
IAkJcmV0dXJuIC1FRkFVTFQ7CiAKKwkvKiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIg
aGFzbid0ICovCisJaWYgKCEocnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09
CisJICAgICEocnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSB7CisJCWRl
dl93YXJuX3JhdGVsaW1pdGVkKHBvcnQtPmRldiwKKwkJCSIlcyAoJWQpOiBpbnZhbGlkIFJUUyBz
ZXR0aW5nLCB1c2luZyBSVFNfT05fU0VORCBpbnN0ZWFkXG4iLAorCQkJcG9ydC0+bmFtZSwgcG9y
dC0+bGluZSk7CisJCXJzNDg1LmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VORDsKKwkJcnM0
ODUuZmxhZ3MgJj0gflNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsKKwl9CisKKwlpZiAocnM0ODUu
ZGVsYXlfcnRzX2JlZm9yZV9zZW5kID4gUlM0ODVfTUFYX1JUU19ERUxBWSkgeworCQlyczQ4NS5k
ZWxheV9ydHNfYmVmb3JlX3NlbmQgPSBSUzQ4NV9NQVhfUlRTX0RFTEFZOworCQlkZXZfd2Fybl9y
YXRlbGltaXRlZChwb3J0LT5kZXYsCisJCQkiJXMgKCVkKTogUlRTIGRlbGF5IGJlZm9yZSBzZW5k
aW5nIGNsYW1wZWQgdG8gJXUgbXNcbiIsCisJCQlwb3J0LT5uYW1lLCBwb3J0LT5saW5lLCByczQ4
NS5kZWxheV9ydHNfYmVmb3JlX3NlbmQpOworCX0KKworCWlmIChyczQ4NS5kZWxheV9ydHNfYWZ0
ZXJfc2VuZCA+IFJTNDg1X01BWF9SVFNfREVMQVkpIHsKKwkJcnM0ODUuZGVsYXlfcnRzX2FmdGVy
X3NlbmQgPSBSUzQ4NV9NQVhfUlRTX0RFTEFZOworCQlkZXZfd2Fybl9yYXRlbGltaXRlZChwb3J0
LT5kZXYsCisJCQkiJXMgKCVkKTogUlRTIGRlbGF5IGFmdGVyIHNlbmRpbmcgY2xhbXBlZCB0byAl
dSBtc1xuIiwKKwkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUsIHJzNDg1LmRlbGF5X3J0c19hZnRl
cl9zZW5kKTsKKwl9CisJLyogUmV0dXJuIGNsZWFuIHBhZGRpbmcgYXJlYSB0byB1c2Vyc3BhY2Ug
Ki8KKwltZW1zZXQocnM0ODUucGFkZGluZywgMCwgc2l6ZW9mKHJzNDg1LnBhZGRpbmcpKTsKKwog
CXNwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFncyk7CiAJcmV0ID0gcG9ydC0+cnM0
ODVfY29uZmlnKHBvcnQsICZyczQ4NSk7CisJaWYgKCFyZXQpCisJCXBvcnQtPnJzNDg1ID0gcnM0
ODU7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCWlmIChy
ZXQpCiAJCXJldHVybiByZXQ7CgpiYXNlLWNvbW1pdDogMzEyMzEwOTI4NDE3NmIxNTMyODc0NTkx
ZjdjODFmMzgzN2JiZGMxNwotLSAKMi4zNS4xCgo=
