Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5204C614A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiB1ClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB1Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B96D4F2;
        Sun, 27 Feb 2022 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015991;
        bh=s7PQLkyF7lgwD3XBQiSaqNoJa0DuoiTYpx9LJQP/Mls=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cxpUscFLGUZJNcWt88FoOwBRPkoIN93GG0po2YwCVFNCRwfHt2GBaOum3BkF2QZYW
         ldIyQx9k8nFEALMlOWGIv631902+dQR4M46lVwG/+52ltRkBiS9LsEFMoWmJSYlJt2
         eQgVFw1ngAqm2Sp03hXt4Trb1XrPfm5Ton43sq+M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1nytxL1gXU-00ptLI; Mon, 28
 Feb 2022 03:39:51 +0100
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
Subject: [PATCH v4 1/9] serial: core: move RS485 configuration tasks from drivers into core
Date:   Mon, 28 Feb 2022 03:39:20 +0100
Message-Id: <20220228023928.1067-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:YyRUGiMq45KbcRKKJ3U/JHT8I4NesVil7nhtV13/29TW+GJXRoX
 Pf/8SR9YukbA1QMs8UGUiOzhxfyOA+kAAwIoOhrF07ECYmOkfIoyaCtz/zfEzdBgPnZUv34
 dVj5mtDXkQEbG/53/jau9Mc8euWvMdWvWdpp3MbqxlpRwKvmZ7hUf0A7ReoWnADXHww59Uo
 Ur6JsXNkhtqZ4ThEzYr2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6riyR5wDhXQ=:lEWlpN6no3qJp3+G1QlEVt
 e8G/phjdUIcBqYZknMZ1Q3/aKVNjUBOkQEEOe0PD6Rc96uFjemUUZ3Y0Gnw79kWBJi2HQQb8s
 nxTKp6kjLKq58/OTd7fEX8qJFcHqIc8vrVfZBWxvOX4D8NpCKDNFUKwQFH8/LGmUuSFCZlsxy
 HsHWnnLfj5ENMw0tk8eELbDxPzYElN38ljG1olO//WHEbG7u5KY0uajiNAPvpge3s1Kq3iN9t
 X1rmR18lbnk8im3MPTlI8RiuQgwcNPSCIoI2eBlTrW/VxavGBRM+sMJ5Yh33uTItGJVq7Mn4C
 q68v48xbHVGGatXkUrhlEDIkC1q88BTEp6Y74vALQuOogkl2/3o/vFBOhbCE4AZqTsz4WO4T8
 Fq/3YNG1WN3sTD8h12g7CHIUT1yUa+jJKLmb2CAIVchoFirWIPnkreCNkoAfE7+V6Cn3CI/bW
 eLncy1KCmPAzQpaldG3EI+owWVVKH/HrIC74K1EFuecTYuU09qrLE6NM4wsBtQl2ucHEeb9hB
 Y+3mAV1xBZ7WmhhB4+sIDPSXvOyBUAI+kc2X5SGEILRF2iho+8UI8M0lgNcu/9YCx3TTqxCQ9
 VTXdceMbMHG6E+4tNLeDA3GEnpOcipHT0nue7+RCNkz7gxVOlmlDIAqvibM0IbiXZTF0jHcFc
 c+ekGlgK4ObGZzuEvUqj1c9hD+gPiQNah+u3Op1EN6DD4OZjj0+QuEG0dk/XdwNkSCK0HV5qp
 V7hrPzIT8J6aLyN0EDfG9kMX7OaMlCj33OJ9d/WcAWE0KhADQ+4m+1uO/tFxCGCNE4Hh+MmQ9
 I/YzYvh5CNxPTjqq7BOdhqxVN3MI/EOrnSImyBfYUN+8wfnJa8K1BUzDLak2GtYw0Ec5ag78G
 fd9oXevkBRI7B16+Jvgv5bSVTvqVPiU15C32e49NdiuXS0jL9dMiZgweh7VeJZnrANFFEZ6WS
 W2eM8wXk2Xpgbp3vz+4H3fUdmMR9pF+/7PNlzZrMnFlaZ4F2mUhDIuQE8k6+Ke1NWGCp1d80J
 i3igUQBF9hn8tv1wMOHQNezy0avDyrMlTnK5ymElvjPcaseOQyAWf1+q6jXeOM+yi+v7NI0nl
 w+ur/ENLj9LS9k=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
ZXggODQ2MTkyYTdiNGJmLi4wNmViM2NmYmU2MTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5j
CkBAIC00Miw2ICs0MiwxMSBAQCBzdGF0aWMgc3RydWN0IGxvY2tfY2xhc3Nfa2V5IHBvcnRfbG9j
a19rZXk7CiAKICNkZWZpbmUgSElHSF9CSVRTX09GRlNFVAkoKHNpemVvZihsb25nKS1zaXplb2Yo
aW50KSkqOCkKIAorLyoKKyAqIE1heCB0aW1lIHdpdGggYWN0aXZlIFJUUyBiZWZvcmUvYWZ0ZXIg
ZGF0YSBpcyBzZW50LgorICovCisjZGVmaW5lIFJTNDg1X01BWF9SVFNfREVMQVkJMTAwIC8qIG1z
ZWNzICovCisKIHN0YXRpYyB2b2lkIHVhcnRfY2hhbmdlX3NwZWVkKHN0cnVjdCB0dHlfc3RydWN0
ICp0dHksIHN0cnVjdCB1YXJ0X3N0YXRlICpzdGF0ZSwKIAkJCQkJc3RydWN0IGt0ZXJtaW9zICpv
bGRfdGVybWlvcyk7CiBzdGF0aWMgdm9pZCB1YXJ0X3dhaXRfdW50aWxfc2VudChzdHJ1Y3QgdHR5
X3N0cnVjdCAqdHR5LCBpbnQgdGltZW91dCk7CkBAIC0xMjgyLDggKzEyODcsMzYgQEAgc3RhdGlj
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
ZXQpCiAJCXJldHVybiByZXQ7CgpiYXNlLWNvbW1pdDogNzE0MDRmNjUzY2Y3ODU4ZmRiYjgxZGQ1
NDE5YThhNGFjNGZmYTIwYwotLSAKMi4zNS4xCgo=
