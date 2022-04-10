Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1B4FAD70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiDJKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC08F5370E;
        Sun, 10 Apr 2022 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587638;
        bh=ujbfvAQbd8qp3JQ8+v0VTyxUc58rDq3/zEwlGiyKaHI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R8zJzdZfcFWCMg/u/yzzze7pbMrLpLu3EoMtblzUft30AAaVvRTnwCX7kvfYFFAi6
         EeeeVTj+kA47o7wIlqRWvrAC5/jt5LYcpDOLUa+95jwiUK5K8ozS6m8Qyj9AVAQRVo
         tu4uno0QS58F0wjI7ZiesZyq2Y8wCT0wSf5oST4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1o5jJu3o0x-012sKf; Sun, 10
 Apr 2022 12:47:18 +0200
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
Subject: [PATCH v4 RESEND 5/9] serial: omap: remove redundant code in rs485_config
Date:   Sun, 10 Apr 2022 12:46:38 +0200
Message-Id: <20220410104642.32195-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:2Rc0EsovuAn8Uo8sXY1SvLuxqDYGQz2n7zPfi2F2gSkdTaxkkWV
 mGzXqVm/mjtaENAsY7xCBFNqnk3srq0vkZtfq1Uza280CelVRnvHpKxT7uwyfJkDXiPRQR4
 3BcZlfGqr8dsyfAZXp8IwixVAnMsQ8GBqm712HKp1UD58GglZgCiSN5xCjz+6kzG5zsDw3H
 HB6wbRt9SX30/hg0j1Jhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6o8OgF7MF7g=:lsr6W5yjm+ASgDwuqM4coF
 bF/aHB7YyymNKd2NLv7OUqC0ctZ19dE+grRs3aKKzSXTmociiXgAvpU0edNT+B78AbaRT3xA5
 8CS8ZOa8yEted7w4yvNMhl5gyVrDE6TX5gyxhfou7JvzhwyXBjo0wLAQ5lF1VOHU/lGWYtI/h
 zYmxCX+Ctjm5pUyfb6RTKhv/QYuhaF5Mnxe5mDiBB1MREvWFfSpO4zC+MMNxWiHgoqn0FB/Jp
 6qHFCcgB+OIqXl7cs9jT1R+ClXPaIkDTS0UJnqibktdMtB1/4RWioSZwHQvEL8JB/YfgJkmrK
 3eGuS6Z3/HaDO4vprBByDHJjK/v08z21HYvpuJbML65LLSMrfApPBjUSiRwdWut3z3vtMr/1H
 rn9zHKv/k5QWHDF8NpHPcmrDXrwTgC1uccB3eTFJriurL4HA0/sAuDyK+pSHJCdrzBGbXn9G6
 xaVn34wnXByblpef9VTHADatdflCsJpA6i2emQNHo4RB3DlyLF667uKX9Efr9QNS7Kr4fjVt3
 EpmQXjv1e+w0SEEmgu+oWZhPYpvdnAcpphknJxbJnPEP9M3o4Orbh2e3B+Dp68Fotyy9kiL68
 Y+Y799VOvUCmd3f9BloK0BKTbGO4edKsUgmjXLOeqjDMmTS9bCClIFVtFo5KpySZkJC2bEWP1
 wAX4nv6onKDX3vzVzPFA8KfzrXnR7DfyOhwrrJhUC6c1S0TZskcM5/0cY8klqC0wrdWKos2Jc
 6do695q28nBRO/rUzuQvWpJJYh9YgikeV0ff2j24sbjfJ7ImeAzD6KYwti7hqxvabFcQ5Zs/c
 ZF4d1kd4ZJNEGgns6YqwaisIyPJJQo8YAhHB4BUFD4yvOlluwH5xDENE43Nl6XO1N4pGNkqP5
 tUpL0c50+wkm3wxQiwH48e92y/IWRWETQnnDAOIcLh/GEDaSOajPDwHdZCkX58jSGuNnvmVnP
 AJRkLgVmK9F/63vBKkzjaQ07odldalPiILQF29xa+Hdw9gsXT037j3y0uPIwcxXGySUV79Kop
 DXWOQYvkn9bLfmrvCrrUuOdHeKiemKXXJBW53npiX7qYd4tBaHwIeRNsSkYkqRwvrf/yR2Omv
 lHrMs8rctw9Dy0=
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
bWFwLXNlcmlhbC5jCmluZGV4IDhkNWZmYTE5NjA5Ny4uNDZmNGQ0Y2FjYjZlIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYworKysgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvb21hcC1zZXJpYWwuYwpAQCAtMTMzNiwxOCArMTMzNiwxMSBAQCBzZXJpYWxfb21hcF9jb25m
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
LTEzNTgsNyArMTM1MSw3IEBAIHNlcmlhbF9vbWFwX2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKIAkvKiBJZiBSUy00ODUgaXMg
ZGlzYWJsZWQsIG1ha2Ugc3VyZSB0aGUgVEhSIGludGVycnVwdCBpcyBmaXJlZCB3aGVuCiAJICog
VFggRklGTyBpcyBiZWxvdyB0aGUgdHJpZ2dlciBsZXZlbC4KIAkgKi8KLQlpZiAoIShwb3J0LT5y
czQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgorCWlmICghKHJzNDg1LT5mbGFncyAm
IFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgogCSAgICAodXAtPnNjciAmIE9NQVBfVUFSVF9TQ1JfVFhf
RU1QVFkpKSB7CiAJCXVwLT5zY3IgJj0gfk9NQVBfVUFSVF9TQ1JfVFhfRU1QVFk7CiAJCXNlcmlh
bF9vdXQodXAsIFVBUlRfT01BUF9TQ1IsIHVwLT5zY3IpOwotLSAKMi4zNS4xCgo=
