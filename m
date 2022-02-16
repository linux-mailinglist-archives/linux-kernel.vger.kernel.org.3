Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5514B7BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbiBPATS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbiBPATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E14D4C84;
        Tue, 15 Feb 2022 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970718;
        bh=qCM/tv58byTKuTfcOO+5ZjAIYqyDsU/7yoiNZduPVbc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WqvGICTlO3QdrUi5MQ+zmFBuFLCQuHxsrFFnXwQ83v7S9qtTnarhV/KZ5qbNirRzp
         1Z4dsWzpe8DWJQMJOk5h/gpkQbom8kgZQVmdNZTkEwIRfukIMFnz82oQrbdYbGJJx4
         m12Xpz1XOFaeVipiezQgVpOxxEKfyNloiPpvPfYc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1nSPlY1DnS-00AaBh; Wed, 16
 Feb 2022 01:18:38 +0100
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
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
Subject: Move RS485 implementation from drivers to serial core
Date:   Wed, 16 Feb 2022 01:17:54 +0100
Message-Id: <20220216001803.637-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:WAOnSBoen9V/5Ruce80Stg/qtCneLtlKhs4Efq3WOPNDl9vx812
 AjuNO6OVHB2qpJEhdKxARvGUBboW4QwT5JUbhIiKm870Of0oy1PrPKv11/BYFNHwFMcF1pK
 oXTiRPgTtBfY4hf10zi3f0WB134p6/jo/q09Yw+j1Cn8cFBywvpbxiq0Hsm0RZKnU9u6nNU
 0wzqd8bqcWglo34rlg9xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WciePH+zpns=:gVp0/EQtHdBFUAPDyztL58
 a+fRvQ8NtE/l5J+sdgdB/sIa8fYt2DvHdovXuAAL4L/Vka5J3GCXVWMmHYIcCBxP+PQ5cxAk7
 AfqI3Uld9xebHbosEKWVLnhKdM97q35K66UWrZJedNbjhlFZH+Bv7o7X/aPNOj2Bfm+iu5gCo
 /jFPMs7kLFh9CqQOZ3bN2IUOrk+0K0cx/Euv8MK1aG4742ifU7/8swp8AJW5gvrN+aKivDhgl
 Ltyi4h0r6YivyUI3Myv2vaKkr0YuovO/2xrPa7kSGdBK2SRMrlqaFpJk7Lm1lf/G0SMy/gWYr
 8YElUP1eD0i7XtqpENaUy87S+6/sAzm2lJChs50/c/yR59u/yndmuk8RNX9zUukejWrLkFBUY
 MKrSzm1DQy+w2aVOnKyHzbjhT7Y8ar9sRwMi7le1Lc9SPBFQYYKO0layj64o9YXq8eBsnc7on
 ZWgfLPgwPhvXNbQDPQOquUbSLQxCOSzr9LeJfPfjfAo42MCgEhzkEu5I95MVmzSrCRUJkkPM0
 ZkOAFFwHNK8N5jKAiQ7dDYJYSc+XiCexBsqQPXE3Ky/yF6NTkMK+Ejl6bqS4huMy+7w/y2BWn
 twjsW3N35QTEqqcCiAlvdo9AKOFzU6FF6exZ/tqUrs2Oi4OO4iIPL1rsNdK4y3yNQiw5ZIcun
 oiXwBCcCy4gzioGKFp+bC0rCBrNfY5YbaWuMB6toYlS/vDVtTvs052domh+pcnPbGedfpoo1Q
 TR5+hFWdv7vd9vLlVN33yRYbzGQlruN5QR9jM5YExvOMlSkoM+qkiJ+Z+2jb56AflA48Q1rYw
 PYyJ5mhkxuInLTA8z7YZ9Kv8SGGx6Q+yzahwXs9Ejg39eW1QaBZ/n1nb32XVIyxN8xUbkm/ys
 CLvehf234fMZQ4CuMwOvtABaD6mAedR635B2+kkG/BTWH1UkmNrlWMlR3JoBxekUxa64d9vis
 XwI0RYTGq7utHU4a6RCusjt+sS85XFnDVd4hTxt2QGCHpH9FfyBU2OSG297aKLixX6Jvlf05D
 vlYP7epc7dQdpRWO7HUfOzSsoOxcxKiLf6pV2EQ0OLcpQxRMzrl22K6LRWSqXaGJXTcg5TzQH
 uKuKr0ZKa/c984=
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
IFJUUyBkZWxheXMgdG8gMTAwbXMKCgpSZWR1bmRhbnQgY29kZSBoYXMgYmVlbiByZW1vdmVkIGZy
b20gdGhlIGZvbGxvd2luZyBkcml2ZXJzIGZvciBub3c6CgotIGF0bWVsCi0gZnNsX2xwdWFydAot
IGFtYmEKLSBpbXgKLSBtYXgzMTB4Ci0gb21hcC1zZXJpYWwKLSBzYzE2aXM3eHgKLSBzdG0zMi11
c2FydAoKVGhlIGNvZGUgaGFzIGJlZW4gdGVzdGVkIHdpdGggdGhlIGFtYmEgcGwwMTEgZHJpdmVy
LgoKQ2hhbmdlcyBpbiB2MjoKLSB1c2UgYSBtYWtybyBmb3IgbWF4IFJUUyBkZWxheXMgYW5kIGNv
bW1lbnQgaXQgKGFzIHJlcXVlc3RlZCBieSBKaXJpKQotIGFkZCBhIGNvbW1lbnQgY29uY2Vybmlu
ZyB0aGUgbWVtc2V0IG9mIGEgc3RydWN0dXJlcyBwYWRkaW5nIGZpZWxkCi0gY29ycmVjdCB0eXBv
cyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgKGZvdW5kIGJ5IFV3ZSkgCi0gcmVwaHJhc2UgYWxsIGNv
bW1pdCBtZXNzYWdlcyB0byBtYWtlIG1vcmUgY2xlYXIgdGhhdCBmdW5jdGlvbiAKICB1YXJ0X3Nl
dF9yczQ4NV9jb25maWcoKSBoYXMgYmVlbiBleHRlbmRlZCBieSBjaGVja3MgYW5kIG90aGVyCiAg
ZnVuY3Rpb25hbGl0aWVzIChhcyByZXF1ZXN0ZWQgYnkgVXdlKQoKCgo=
