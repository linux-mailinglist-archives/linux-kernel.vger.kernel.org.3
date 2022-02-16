Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B194B7BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiBPAT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbiBPATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D1D5572;
        Tue, 15 Feb 2022 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970722;
        bh=9fjzLBN+PWaAWLzb25vUWj/J8xwxeq7xuYNRStHQTXY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TRWqadBfpr7rXZETxXnexOCp6OoWAYSskM8CzJzSwwM4rgEEehYeH93UEQki8dlkm
         5GozK644G2TnN/4/WOtHzVm9egbeTz/fJ5ltBzD5OgUSMzWDa9Zyn0MJgjbVLPFhXn
         FQhIG6pmbAPlxpya9Su+pDVGmegzB7B651sV7oaQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHns-1o9Ljs0JhK-00thbF; Wed, 16
 Feb 2022 01:18:42 +0100
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
Subject: [PATCH 2 5/9] serial: omap: remove redundant code in rs485_config
Date:   Wed, 16 Feb 2022 01:17:59 +0100
Message-Id: <20220216001803.637-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:/tz633QAQ1FCT4Yf0dg8eH/yTxYQTHHuIgr3F7fDKxaDLTEMWfe
 0WvgIa6xZbYzyxJbrmhlAc1kl4UgQlreMe4xgdm6LcjZ/ormhh6Gbj6g1SeFMEkV50vusEg
 GM3o8gWe8OsYLW7m1QdsliQ+aKaQlpWnVMo9orcFLR9YxCzWYXB+G4ACr1wxje7J0ZnDYQg
 VEBc9+xvvhv1krq8PDlQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T84ZUqvS1kM=:/YXYpP6Mtxpi/jTICB252b
 OCIdLsaQBwP5p8uM0yynpYrVhaTyb8JcbJOK1SM41xuT830pDk+RWYGoYSbfPcHmUmGdt0Z0N
 IWqGbe2qEhzTuuBVLQZr1GBnPr5dXsGK+TJ854uZjqHcBEL4qLcGpnFMxGtmkmOCQhn80axYr
 WxQ8kRFucSAeRTthxOHkMGBxzjDLf6gE2QLilJfzAex87RuaxRTSXdXw1VyVt6ncMX5N+zx+H
 B8bhLEMo/36++c7KHrQOXPuFZws7IEa+gPL4cUinBbBBSB+TKvaVdSHl6ILA9CPbOypzHni9i
 BDveYO3yEBm6pms34fb5vK2RccA5ZMZoSqZA6r2igb/EUAz9qCmFVGtnKlGKMKYzb5Z4+qX6+
 RNmHVpWiDhF61OwDVooHKoMi0kRlq1BcAPEIGIXMLKP/Q7GdhLkmWtSi6pK2ytfvxINX0ypsc
 xvEhTx7WwO0lG2ky7ZmpAOyLB8wgDfJbgtsyJZUjPBKwDs9toJW6Dd38R4RKET675OLqj2S+u
 O3C/jmn9xNIJ4lYWdtu7VKfpAsH6zRgBuG+mTn1aJLKdeuvnDDVOrnwgM3syFL+iirMfrQfCH
 lZiA53asWW9Fz5GuKX9bx0ZMft1X8kxLROrmuHFmQ3eV2OEe8BpWcEN5fDIUt920OybHaK0lc
 Y2EVGw5VDJOQU/Vi27QojPnhOSRmiqH55F0BflxYkdsl6vUdatlEnCsiYEBncGYJg8mcGfwgT
 NeAhpnZxVs70PXh44kAOdy7jtgyPbj36SNN4DhkUJBySGAzSvpwTE75LYF5OCcCjjeaOsghsK
 5N9ONFbDAhEfgPkpSWpPllfYe+hhcWHhWehiBN4B5St0Aem3ptLXFl8OUpvVb0ppNT9rE9rbF
 mw9xMhFAremA9ks/3NWW4dBkakdOsDV5N3XGs57uwCGR2GCo6uAfaz9Vge1EG4txWZMtfOeGW
 nfq6WbQg9tT7UGeF58rpUHd9QuVAg9JIHpzY9T+VPg4nXBQXCAG9+dINuQQw0nQZ73XDtxUEv
 Ss4TKSOWU5N6Kl/F/0fNoMTzru6kFCUHKBgil9mralYkoo/GGS0E2j8ToK76EUf0oYEq4Zazt
 vWM627MxQ6T3LM=
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
bF9vdXQodXAsIFVBUlRfT01BUF9TQ1IsIHVwLT5zY3IpOwotLSAKMi4zNC4xCgo=
