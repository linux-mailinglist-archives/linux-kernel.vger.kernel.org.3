Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75DD4BEF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbiBVBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiBVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218DD24F2A;
        Mon, 21 Feb 2022 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492510;
        bh=eHlPTyV9IH6b1xICykBM6gHlY+Gr9tRTW5duy1JBpCA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eQUngbgwLqLUom8dFWlKScyPSsPcRzNhp2S1l8mr9vwx/IRfkkEPGb3djUohUAC1f
         l5ny3hweItnNF6kAMqIOdzzTjmarP54tzL1BNNYemiqqVcUeAJQzRDPU5SIPuXWyys
         SczksCEqxNegmyJ7hjfVOzVPNdeRM28EH9H9bvWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1o3sKZ3XoU-00jv50; Tue, 22
 Feb 2022 02:15:09 +0100
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
Subject: [PATCH v3 5/9] serial: omap: remove redundant code in rs485_config
Date:   Tue, 22 Feb 2022 02:14:29 +0100
Message-Id: <20220222011433.8761-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:jbVz0BNPswbOMgeN+DDhwoQBpe2I7vCkKwtO+bMQdX/FHpjcwnH
 8mmQEiIsth6jNfR/2SLrMzcaYcWspkmia3HWTqVqCzTIDvE6DLoU2DJS2lwhAeuM4TVnAhw
 zYpKLPMqM+8TdUXBFfI0fcvgqHx2P5E4tA0/ZRMQvsDikWF+zXfKRqAirrwrgk56ReyTgwP
 p3+8aUY1VyqdappZfGP8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DSOyH+r7gr8=:rgl6X+KkNVZhXNpOmDfJK7
 77m3/RGNqTQBAkrsUab0Fz0lqJyPVwXHNlJ1Z39QREf8VuiS/WQN6dy6lQZYyJzG9I2r4xNs/
 FOqOk/inE9zm9UssXDFZX3P6AtG1lItZ90QlddRuQ7QZ89ugcEgewtjXt1smPQgiqgSt9RtSj
 0evq61hHN/iUTjHY9Q4p83XzDlxxs2htazuSdXOd80f35n0MyZ9DHtA1iXtT3gqC/o1kxvlZw
 vT2OJej7bgYIkWcubky3LjkaF8Bx67hdvhwVcTXckOGOxa0UUeAP1Cpl23XwllBhhIlioldVQ
 MA7GfKdZNE7cAfGLDmqdFOboygTZW0T47Ru5zPiIRyahfYFpGT7PDOVD4hyZjldTtpgJm2ohx
 brc0KEa/Shz9H/fg8TsR1klRsJ7d/ElkL2dNWcGWljEQKB1gnGy5sqyun8f/2qj8Zr4Enm+1S
 jyAb+eUp4SzVFhGPj8qq+LUAHth5ZOmpAPHYr93ObhgBLp4HohpYHHZSCLAcyy+MLccru6rKx
 W3P1X3Ctv0HPli9zNRABgW//IN+hIOzdvnc7D48d2rxOdqLuUP/H8Iq9y1YJluzFxCkPxLEtZ
 Vmf42iiSf0lZbWlaL3ppsaPqpMjDd5Dk3Q7gk8sAnyb0Lulr7ZF06MPNYgqmD+p9n99aYwzO0
 iKmwfQ8ABvYXtz+jbsbsedurmLMoSpTW4Cp1Ie3aW4mbX5wSIBN5+NLbE4UK2ujQup7AKEGs0
 8z2Gpbju4XX27Mq46wgeO587ryrX2MdbUtKBmvJBvxHhcKKlrfX1iT9YlZfPrNG/ZMwehta0v
 +4WTsbniX4j+I2P2CpV2jWL3zu0ie0sLg0EZNw67NPy2zUywJ50G4Fujtm8K8IrCeUM22PJ22
 A7gUzNU8uPeboGsq/NebpEEzpKyx6v0SX10X+wKZ0YSuUyCH2N6Nmf+ToFrTWQTgI1RBhGKOp
 YFaB/r7oEM/Ylo0VUMmVBwdAiQBUjocarplDuBPwaB1yA9wpmVX6ZeG5HBNZrScwlvUZuIRKX
 U+EhKOdxP71r/3im1hNFIlgfRuvZRCzfa2gir0nmFpDgppqldW3qhWOqW740Gnn4oSiAXi49b
 W24XQav1t/0uRs=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgY2xhbXBz
IHRoZSBSVFMgZGVsYXlzLgpJdCBhbHNvIGFzc2lnbnMgdGhlIHBhc3NlZCBzZXJpYWxfcnM0ODUg
c3RydWN0IHRvIHRoZSB1YXJ0IHBvcnQuCgpTbyByZW1vdmUgdGhlc2UgdGFza3MgZnJvbSB0aGUg
ZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlvbiB0byBhdm9pZApyZWR1bmRhbmN5LgoKU2ln
bmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQog
ZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMgfCAxMyArKystLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9v
bWFwLXNlcmlhbC5jCmluZGV4IDA4NjI5NDE4NjJjOC4uYTNhZmNjY2ZiZDk2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYworKysgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvb21hcC1zZXJpYWwuYwpAQCAtMTM1MCwxOCArMTM1MCwxMSBAQCBzZXJpYWxfb21hcF9jb25m
aWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0
ODUpCiAJdXAtPmllciA9IDA7CiAJc2VyaWFsX291dCh1cCwgVUFSVF9JRVIsIDApOwogCi0JLyog
Q2xhbXAgdGhlIGRlbGF5cyB0byBbMCwgMTAwbXNdICovCi0JcnM0ODUtPmRlbGF5X3J0c19iZWZv
cmVfc2VuZCA9IG1pbihyczQ4NS0+ZGVsYXlfcnRzX2JlZm9yZV9zZW5kLCAxMDBVKTsKLQlyczQ4
NS0+ZGVsYXlfcnRzX2FmdGVyX3NlbmQgID0gbWluKHJzNDg1LT5kZWxheV9ydHNfYWZ0ZXJfc2Vu
ZCwgMTAwVSk7Ci0KLQkvKiBzdG9yZSBuZXcgY29uZmlnICovCi0JcG9ydC0+cnM0ODUgPSAqcnM0
ODU7Ci0KIAlpZiAodXAtPnJ0c19ncGlvZCkgewogCQkvKiBlbmFibGUgLyBkaXNhYmxlIHJ0cyAq
LwotCQl2YWwgPSAocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgPworCQl2
YWwgPSAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpID8KIAkJCVNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORCA6IFNFUl9SUzQ4NV9SVFNfT05fU0VORDsKLQkJdmFsID0gKHBvcnQtPnJz
NDg1LmZsYWdzICYgdmFsKSA/IDEgOiAwOworCQl2YWwgPSAocnM0ODUtPmZsYWdzICYgdmFsKSA/
IDEgOiAwOwogCQlncGlvZF9zZXRfdmFsdWUodXAtPnJ0c19ncGlvZCwgdmFsKTsKIAl9CiAKQEAg
LTEzNzIsNyArMTM2NSw3IEBAIHNlcmlhbF9vbWFwX2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKIAkvKiBJZiBSUy00ODUgaXMg
ZGlzYWJsZWQsIG1ha2Ugc3VyZSB0aGUgVEhSIGludGVycnVwdCBpcyBmaXJlZCB3aGVuCiAJICog
VFggRklGTyBpcyBiZWxvdyB0aGUgdHJpZ2dlciBsZXZlbC4KIAkgKi8KLQlpZiAoIShwb3J0LT5y
czQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgorCWlmICghKHJzNDg1LT5mbGFncyAm
IFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgogCSAgICAodXAtPnNjciAmIE9NQVBfVUFSVF9TQ1JfVFhf
RU1QVFkpKSB7CiAJCXVwLT5zY3IgJj0gfk9NQVBfVUFSVF9TQ1JfVFhfRU1QVFk7CiAJCXNlcmlh
bF9vdXQodXAsIFVBUlRfT01BUF9TQ1IsIHVwLT5zY3IpOwotLSAKMi4zNS4xCgo=
