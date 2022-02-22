Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8D4BEF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiBVBQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbiBVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E8C25586;
        Mon, 21 Feb 2022 17:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492505;
        bh=LnNDspWH53byTON8/DT1vsFZkFZ06dal6CobvbPniSU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ByOUBjvZ5qQCgwW/ZyCEAd8zOtBSQ+R25pr77kXNo9duIknzJd6BY9GEML++kj5kW
         FhH+TkSsPLSlenykp8j8AVcLkp42h9R/fgS4Uw/OoCXhm6a6QaasiNSWXJ2KvLgFko
         SlbO99BbprztNnvK3L/Ur4DMDnui7VLpner+Hkfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1nXpIZ1vHm-00Bff4; Tue, 22
 Feb 2022 02:15:05 +0100
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
        p.rosenberger@kunbus.com
Subject: Move RS485 implementation from drivers to serial core (v3)
Date:   Tue, 22 Feb 2022 02:14:24 +0100
Message-Id: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:fwQhpe5itdtLuhIj4GdcRsArhXYdn4LSccPuJsacLIGEm/VTpGN
 NKVjX2InXVHVGuJSNyb6ZkEZBq9lDRgp1Kp1mp9NpSnjzNDlLcIIp69nDefA1qBOMAyMusU
 arpt1wDgkGzYZ633iMNBDfxEcLDv6h8ZaC8NvuTZAs32NfBg1gRudPEDTNgKNYcOgleJoQ4
 8rumNGGyPJzeeystnF87Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/J/4Umf8mTM=:2koxePhvpaurreLlmdVBi1
 cotdEguPZ/oyA28bLj20RGsxMiG3NFn1fYxfLM0gQTLKyRYJb77VVLWvk4jg0SO080DlgpWIo
 PNj8HC1Tu9AxEuC4l50vbxOIO0Aczka79ByThtk+9GVFTa7gVAJG/JIU9bvIkPbJitVcAFkMT
 3t+JsToy55pEixIr+IkeNApaVFyFS2cbl9jSJtQrESM+GceUqALZhoBZVSqM6cJHbZ9elDuQv
 35eeqHjZog1J0w0V7zNvRO2sb+IPNY9/1aDjvTuWJV4UK+jHR9EUkK7lYR7xLVdDdtF0vRCsE
 LGgWOh3zP2+L91coUFQFoiSVnLV5f0VnNJM0OwpVC0/vurdkdv5t5xNJTdxvO7E4oof6rTbOC
 WPmKv+0hdZsq3ofub/egPLND9PRFz7gb3RLE4Te7Tt70frNksGEQFeAExzLDyOiwpct1Eg1Ck
 +wqK2/a5n8K1zzTU6c9rVud47CMbPpvAywJQlx29oaH61LFLF/QvXHnt07AU1unFToJA0YmUS
 fwioZxEdrD7FPOzlKyufoP3t+J6jwawzdjmJ/wI9M1DAS2pUFWECCwt55hV/m5e9xFUAiKEsq
 fX50tKYYuG2GsMREyvYWRzKkuxpZWRjoQtUim6zzBIkcp1V6Q3aZnwQIudQzEjWZsezOvxn5Z
 mQ0kohW5l9xRa1x+CUUfdYj6ilVYw3ZbSe1Ya6yysWcN78a0banL6ALizXpIwh2btGssSk6yw
 Mov/1XVjEoIyzg/ewKtSvYirygAxc9rnVscK0u5jAdEZn2hx0d9cM9NynNA4aa50ZpYlE3Ly9
 PdNJEGdZBc05O8zP+ZGk+v4EPTR7BSblgLk/ngD4lE5X6wA1Vgfr7SSqUAKB1e0wiuH3RLNXp
 q0T8pDIVquS7dcb59q6JO7tFFlCvdExeu6UhizIP9ULUEooKVLAyzwdrk5q3rCI2HdSCJPGcm
 gfSL4sE8OSxX9AXsvb75/avee1MhZq3XF9jVPSdLHg7t77Twg4lINZj9/mQR85Hd4WpIEusLl
 k0zhSFFDpFN8UKT3jjmtJDeUuCwOHUtr20FU8H8rrRbREggZXf8HKwEQ+D6Yvr2mCPsje7XoN
 osSpPAhuR/+He4=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaXMgYW4gYXR0ZW1wdCB0byBzaW1wbGlmeSByczQ4NSBpbXBsZW1l
bnRhdGlvbiBpbiBkcml2ZXJzCmJ5IG1vdmluZyB0aGUgZm9sbG93aW5nIHRhc2tzIG91dCBvZiB0
aGUgZHJpdmVycyBpbnRvIHRoZSBzZXJpYWwgY29yZToKCi0gZW5zdXJlIHNhbmUgUlRTIHNldHRp
bmdzOiBpbiBjYXNlIG9mIGFuIGludmFsaWQgY29uZmlndXJhdGlvbiAoYm90aCBSVFMKICBhZnRl
ciBzZW5kIGFuZCBSVFMgb24gc2VuZCBzZXQgb3IgYm90aCB1bnNldCkgZW5hYmxlIFJUUyBvbiBz
ZW5kIGFuZAogIGRpc2FibGUgUlRTIGFmdGVyIHNlbmQKCi0gbnVsbGlmeSB0aGUgcGFkZGluZyBm
aWVsZCBvZiB0aGUgc2VyaWFsX3JzNDg1IHN0cnVjdCBiZWZvcmUgaXQgaXMKICByZXR1cm5lZCB0
byB1c2Vyc3BhY2UKCi0gY29weSB0aGUgY29uZmlndXJhdGlvbiBzdG9yZWQgaW4gdGhlIHNlcmlh
bF9yczQ4NSBzdHJ1Y3QgdG8gdGhlIHBvcnQKICBjb25maWd1cmF0aW9uIGlmIHNldHRpbmcgdGhl
IGNvbmZpZ3VyYXRpb24gaW4gdGhlIGRyaXZlciB3YXMgc3VjY2Vzc2Z1bGwKCi0gbGltaXQgdGhl
IFJUUyBkZWxheSB0byAxMDBtcwoKClJlZHVuZGFudCBjb2RlIGhhcyBiZWVuIHJlbW92ZWQgZnJv
bSB0aGUgZm9sbG93aW5nIGRyaXZlcnMgZm9yIG5vdzoKCi0gYXRtZWwKLSBmc2xfbHB1YXJ0Ci0g
YW1iYQotIGlteAotIG1heDMxMHgKLSBvbWFwLXNlcmlhbAotIHNjMTZpczd4eAotIHN0bTMyLXVz
YXJ0CgpUaGUgY29kZSBoYXMgYmVlbiB0ZXN0ZWQgd2l0aCB0aGUgYW1iYSBwbDAxMSBkcml2ZXIu
IFRoaXMgc2VyaWVzIGFwcGxpZXMKYWdhaW5zdCBHcmVncyB0dHktdGVzdGluZyBicmFuY2guCgpD
aGFuZ2VzIGluIHYyOgotIHVzZSBhIG1ha3JvIGZvciBtYXggUlRTIGRlbGF5cyBhbmQgY29tbWVu
dCBpdCAoYXMgcmVxdWVzdGVkIGJ5IEppcmkpCi0gYWRkIGEgY29tbWVudCBjb25jZXJuaW5nIHRo
ZSBtZW1zZXQgb2YgYSBzdHJ1Y3R1cmVzIHBhZGRpbmcgZmllbGQKLSBjb3JyZWN0IHR5cG9zIGlu
IHRoZSBjb21taXQgbWVzc2FnZSAoZm91bmQgYnkgVXdlKSAKLSByZXBocmFzZSBhbGwgY29tbWl0
IG1lc3NhZ2VzIHRvIG1ha2UgbW9yZSBjbGVhciB0aGF0IGZ1bmN0aW9uIAogIHVhcnRfc2V0X3Jz
NDg1X2NvbmZpZygpIGhhcyBiZWVuIGV4dGVuZGVkIGJ5IGNoZWNrcyBhbmQgb3RoZXIKICBmdW5j
dGlvbmFsaXRpZXMgKGFzIHJlcXVlc3RlZCBieSBVd2UpCgpDaGFuZ2VzIGluIHYzOgotIGFkZCB3
YXJuaW5nIG1lc3NhZ2VzIGlmIHRoZSBzZXJpYWwgY29yZSBjb3JyZWN0cyBSUzQ4NSB2YWx1ZXMg
KGFzIHJlcXVlc3RlZCBieSBMdWthcyBXdW5uZXIpCi0gZG9udCBleHBvc2UgdGhlIG1hY3JvIGZv
ciBtYXggUlRTIGRlbGF5cyB0byB1c2Vyc3BhY2UgKGFzIHJlcXVlc3RlZCBieSBHcmVnKSAKCgo=
