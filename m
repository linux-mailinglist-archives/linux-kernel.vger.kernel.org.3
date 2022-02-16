Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC84B7BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiBPATf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244983AbiBPATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A9DE2D9;
        Tue, 15 Feb 2022 16:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970719;
        bh=KNlkTrX8x7yAcANSC5T8c+HtH9VyTbcyT6PC6GXfNX0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lmL5TL9e+J65+t5P61LMu2xnn2PLAmk9tl1GigRmC544abjRh0xeCnXitGDoqa8Iv
         jbAIamZm0+kOtISNRSLq9i/v6hNTYAsr7AAWmA+P/zHi2/yK3xQe0Oey7U0dha42XY
         p3iv0OvZNfnx/WbVS9gFykVcP2t/5i/isqMVlkpM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1njwcK3TbK-00S74X; Wed, 16
 Feb 2022 01:18:39 +0100
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
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2 1/9] serial: core: move RS485 configuration tasks from drivers into core
Date:   Wed, 16 Feb 2022 01:17:55 +0100
Message-Id: <20220216001803.637-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:DwBoOp3Hdle0l17X4ijaaS7OBJw4SZaNDHP7xyTK6n4Ia+pqp61
 m5aTrloSjRFLWCErb6bGxl+l45wdG2RZGKpDO8a92NbQobSbg5o8vrxWevw4wFdrF6rYRI6
 1cMPsfUCYy9egVD77ZpRSaNixbyqrj8RjtewfB99e/arVo5MJqcq/SpvMi+njnaJDMsdS51
 dQrqvKKE9JRUOK6s85f1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bmNCB1gxVX4=:J/sglHkC1SJ4i/puh7f5KG
 dCF/XX0YugPYdaSgqSNypFVuDenNFU+oCu4TKRRwGWAIBLeamPuuMf+aucPSGfwqoqqYTncMJ
 4Y2C0vtbYbQYCje6UG921VNMRlWV+ndKj761KYBaJT2X+78KWkMS1noc2RoIWcAN6v/pF1YyH
 +Fby8SiOTsGBG1mDDTN/ssLKhahM4HkYrinnTh2cg+R5jTurQNhDTfFm+gylQVR1/Mobs/K3M
 X/8vHQo8fXHoC7b1S2KSlvR2ncMjkFQnlAGmtw+TyBVryZg5PogTjvbT0wTGapNf0hH/Twhux
 mAgtbfH5jYgHDZTGcQuV4b6Cn8ZBhCVnsK+q0PAJ44GFyHiHk3xlB1Z6LgM/4Mhk3SQZYAt95
 HQEp+v9VbHJzldFFRpAnmN4lHxtdoud7052dQJk80JS1fIja/+3A5flzITM5O8xN3fob/PLwZ
 aKoet4dDHwT1lJmkc6QxgACT6iKX2EdbcJ43kot45O0ML9yAydqQ1LOGfRbI6LyI3nxlC+NpR
 f0ldMq0bSoIXIiyTDkdoUyqCa4U9jkzfwt9riKJVC0fTWwbD1GpWXjvxtJeppGBbxxd6epXsf
 OBbRFtP2rYa5Q9gzazfKov7NFaNE0sq6h8eWClMzzh3jISA7+wlgEWfHKcCZuAS3MXLDDS0vp
 8ITJrqIIZvQcTeMG2WzcNDXIRl53L9mj6PQUwwz5koz6EL6kI9/Uaj0eg3hPRaUGSsL5F2Xbl
 M8LFguEVjqKtgnzICeLDLiMYV3eBRHONudG/f51BQhHteKhnY7j8VB8RKhH/mdNguD7/Awai1
 ArXuA3seKBHMYr9gTPayeCQx/Ik20Mn2pbRs6XUaAHrOFqH2kRlIRBq5i8bY2ievvJzigcJad
 Xtny68ZVsbldCPRcHxk6RRaov343h1B1sHtF1FP9NS82gbvPMpLR2jcK41RmFzREE3UKt7U/l
 BvQEh/nP4YJpnfdhA4LZH9WYP0fDechUpM/GRzRVFvOOSbrhh7z5gjuypt43stQ+xI+0LVLM3
 I+g8dcrv00Dv/2ssYMrBKToRgCMt2ZJhc600Jx8OxBsTOf6suchlWHJkb5F8RJMy8BQDNWBQZ
 jm/PSdl6IbIHOI=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
c2VyaWFsX2NvcmUuYyB8IDE4ICsrKysrKysrKysrKysrKysrKwogaW5jbHVkZS91YXBpL2xpbnV4
L3NlcmlhbC5oICAgICAgfCAgMyArKysKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggODQ2MTkyYTdiNGJmLi5hNGY3ZTg0N2Q0
MTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0xMjgyLDggKzEyODIsMjYgQEAgc3Rh
dGljIGludCB1YXJ0X3NldF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAlp
ZiAoY29weV9mcm9tX3VzZXIoJnJzNDg1LCByczQ4NV91c2VyLCBzaXplb2YoKnJzNDg1X3VzZXIp
KSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAKKwkvKiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVz
ZXIgaGFzbid0ICovCisJaWYgKCEocnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQp
ID09CisJICAgICEocnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSB7CisJ
CXJzNDg1LmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VORDsKKwkJcnM0ODUuZmxhZ3MgJj0g
flNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsKKwl9CisKKwlyczQ4NS5kZWxheV9ydHNfYmVmb3Jl
X3NlbmQgPSBtaW5fdCh1bnNpZ25lZCBpbnQsCisJCQkJCSAgICByczQ4NS5kZWxheV9ydHNfYmVm
b3JlX3NlbmQsCisJCQkJCSAgICBTRVJfUlM0ODVfTUFYX1JUU19ERUxBWSk7CisJcnM0ODUuZGVs
YXlfcnRzX2FmdGVyX3NlbmQgPSBtaW5fdCh1bnNpZ25lZCBpbnQsCisJCQkJCSAgIHJzNDg1LmRl
bGF5X3J0c19hZnRlcl9zZW5kLAorCQkJCQkgICBTRVJfUlM0ODVfTUFYX1JUU19ERUxBWSk7CisJ
LyogUmV0dXJuIGNsZWFuIHBhZGRpbmcgYXJlYSB0byB1c2Vyc3BhY2UgKi8KKwltZW1zZXQocnM0
ODUucGFkZGluZywgMCwgc2l6ZW9mKHJzNDg1LnBhZGRpbmcpKTsKKwogCXNwaW5fbG9ja19pcnFz
YXZlKCZwb3J0LT5sb2NrLCBmbGFncyk7CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQs
ICZyczQ4NSk7CisJaWYgKCFyZXQpCisJCXBvcnQtPnJzNDg1ID0gcnM0ODU7CiAJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCWlmIChyZXQpCiAJCXJldHVybiBy
ZXQ7CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvc2VyaWFsLmggYi9pbmNsdWRlL3Vh
cGkvbGludXgvc2VyaWFsLmgKaW5kZXggZmE2YjE2ZTVmZGQ4Li44NTkwNDVhNTMyMzEgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9zZXJpYWwuaAorKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvc2VyaWFsLmgKQEAgLTEyOCw2ICsxMjgsOSBAQCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IHsKIAkJ
CQkJCQkgICAoaWYgc3VwcG9ydGVkKSAqLwogCV9fdTMyCWRlbGF5X3J0c19iZWZvcmVfc2VuZDsJ
LyogRGVsYXkgYmVmb3JlIHNlbmQgKG1pbGxpc2Vjb25kcykgKi8KIAlfX3UzMglkZWxheV9ydHNf
YWZ0ZXJfc2VuZDsJLyogRGVsYXkgYWZ0ZXIgc2VuZCAobWlsbGlzZWNvbmRzKSAqLworI2RlZmlu
ZSBTRVJfUlM0ODVfTUFYX1JUU19ERUxBWQkJMTAwCQkvKiBNYXggdGltZSB3aXRoIGFjdGl2ZQor
CQkJCQkJCSAgIFJUUyBiZWZvcmUvYWZ0ZXIKKwkJCQkJCQkgICBkYXRhIHNlbnQgKG1zZWNzKSAq
LwogCV9fdTMyCXBhZGRpbmdbNV07CQkvKiBNZW1vcnkgaXMgY2hlYXAsIG5ldyBzdHJ1Y3RzCiAJ
CQkJCSAgIGFyZSBhIHJveWFsIFBJVEEgLi4gKi8KIH07CgpiYXNlLWNvbW1pdDogODAyZDAwYmQ3
NzRiNzdmZTEzMmU5ZTgzNDYyYjk2ZmI5OTE5NDExYwotLSAKMi4zNC4xCgo=
