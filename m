Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60C554FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359536AbiFVPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359499AbiFVPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96773DA73;
        Wed, 22 Jun 2022 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912839;
        bh=L8drsTWcNOyZJVCVCetGz7KjvhiqquEoLgBrlbOh1+E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fKyDBlcys7eskg8MJlSh8wgaowKKA7y6IHbsrVa/uG/8xXfXeyWw/h+qJ3w9qfmSk
         /D0rViqCdCQrjD2Qiy9aqkbnN8kTO2Sv15i6A0aGegBctuFdhxGFwDIzGobWxNy7ka
         ufHEQ5YFuc8sIlhlhdH23cPa6Asyxhc6miVeeMIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1nzcjH1wwa-004WFY; Wed, 22
 Jun 2022 17:47:19 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 0/8] Fixes and cleanup for RS485
Date:   Wed, 22 Jun 2022 17:46:51 +0200
Message-Id: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:e/eU2TOHo85vgoolisGNSxZ7p2gsZGNQv2/UUXz7pRlUZkCwexO
 VOGzoIc01yVuZM+KA3OahdIof1j4JHtzJ+JOV6jFx+y9i6NJsvBiWOfdKPRWOUyIdQP6USs
 ObASqb6eUGW+8HQKK9Wi62s0LiAxdkkF33cNCpOP5wGnsHPpNBVQ3UfCHzVB37lgwxOnT4C
 Q8pAQEJJNjzsT3qDnDx0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M7ZkbU9xVqI=:3bMQJUSUIkd6h/NCT/6iAs
 2jyEFZRUA8GYFKeY1e5BbSuEk0T3DPxCkG89prgaQIBkktHHVdJtQkZ/BzfiF21Brb75oCp2U
 H9UN3YNRSpx0d4Jj9JpVxzyfXEJLNXZ2FuFiIh5/wstHJm1XZJmFLW7JB71WDskRBGUxH0LnD
 WxFgS5WRDoU7o59cwvGB6d/ZbkLRrqohBkjMN0a6HHub6Tmnh3EbsueXc6dE1ig9zFuFvG507
 GFi7K5L2WoRNLocTNcO0MTMCatcwpceB6vWVswKMd3NzcLt5trsTF2JdIr3Bqw7udjr8PkYBb
 cBzV+5hpYwqxycNCH8v9aR2pLDZjZZHuBemHiMrexjkwjU3xqzRlJyPEesXTbFKxfkxIPJ00m
 iSu+hpU/DmV9z8C+GpFFcsfqGjTQAVww7P/y4gLuG6V3gDeiDIoI7s20oeVWUKbVtP7dFbZ+1
 BggxoumcDg5/Do6dIa3oy6GXaeNovGNk5BTwdHCJg6SyPH0asrt2rgAwjm2dOQnJEo2McqCye
 cSiQzajILAZCRABRwrSonf7q4WaeBVJSD+0IallsfzF3cIzQfcIHjtDTHbQgfEhGOOFirORUM
 tWFITzYCt1/Igb4jLK0UeASxFvb+BzHslHo9DG+mJVuqkW9k6LtU/tg395DtAB8/eApb0oODl
 HZzcwQpV/S0sJ51j9/cGVjl2Kz2YMY+bn5DE/knJiipeyg60/ifzQpY7WrdHj7KJ1hq7N5jXF
 EHOmsI52BUR75RfQ7uxe4o1K0k/quAOYrLhAcJgBLUTZjrKAZGRMTEf15x18d1uCArisHgZer
 cZbrdOhm6unBDCBcAhMrz9syCWD1CJ0YIKofcfNx8Gen/bNMF7RAOrGfJs2goCC2BNAtVwk02
 NUQ6mp2rlm3jXWQVXhQz1DDB66+1YbpWmaHw+sb43FQvy7cIbtYpU4XCXz4s6NxKdRP/3J7NN
 uDNv+Xi4mVQAcYiUThGb78QfMcGDDyfrGW9EnaU96F9qnTBchO49G51L5ro2Sr47hRoG17x0K
 EFSMNgzvQ4cvd3DQLdKQ4paqT32WoQctU5y6efugJGzbZurdvy4JaKq4zj0dVijmsB02N8BTE
 m14JLl6e9vkwfk6BLpaJcRPqXrW1e5VeaXuNlD7Z44inSioyVm2ktgISg==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBmb2xs
b3dpbmcgc2VyaWVzIGluY2x1ZGVzIGNsZWFudXAgYW5kIGZpeGVzIGFyb3VuZCBSUzQ4NSBpbiB0
aGUgc2VyaWFsCmNvcmUgYW5kIHVhcnQgZHJpdmVyczoKClBhdGNoIDE6IE9ubHkgcmVxdWVzdCB0
aGUgcnM0ODUgdGVybWluYXRpb24gZ3BpbyBpZiBpdCBpcyBzdXBwb3J0ZWQuClBhdGNoIDI6IFNl
dCB0aGUgcnM0ODUgdGVybWluYXRpb24gR1BJTyBpbiB0aGUgc2VyaWFsIGNvcmUuIFRoaXMgaXMg
bmVlZGVkCgkgc2luY2UgaWYgdGhlIGdwaW8gaXMgb25seSBhY2Nlc3NpYmxlIGluIHNsZWVwYWJs
ZSBjb250ZXh0LiBJdCBhbHNvCgkgaXMgYSBmdXJ0aGVyIHN0ZXAgdG8gbWFrZSB0aGUgUlM0ODUg
aGFuZGxpbmcgbW9yZSBnZW5lcmljLgpQYXRjaCAzOiBNb3ZlIHNhbml0aXppbmcgb2YgUlM0ODUg
ZGVsYXlzIGludG8gYW4gb3duIGZ1bmN0aW9uLiBUaGlzIGlzIGluIAoJIHByZXBhcmF0aW9uIG9m
IHBhdGNoIDQuClBhdGNoIDQ6IFNhbml0aXplIFJTNDg1IGRlbGF5cyByZWFkIGZyb20gZGV2aWNl
IHRyZWUuClBhdGNoIDU6IENvcnJlY3QgUlM0ODUgZGVsYXlzIGluIGJpbmRpbmcgZG9jdW1lbnRh
dGlvbi4KUGF0Y2ggNjogUmVtb3ZlIHJlZHVuZGFudCBjb2RlIGluIDgyNTBfZHdsaWIuClBhdGNo
IDc6IFJlbW92ZSByZWR1bmRhbnQgY29kZSBpbiBhcjkzM3guClBhdGNoIDg6IFJlbW92ZSByZWR1
bmRhbnQgY29kZSBpbiA4MjUwLWxwYzE4eHguCgpUaGlzIHBhdGNoc2V0IGlzIGJhc2VkIHR0eS10
ZXN0aW5nLgoKTGlubyBTYW5maWxpcHBvICg4KToKICBzZXJpYWw6IGNvcmU6IG9ubHkgZ2V0IFJT
NDg1IHRlcm1pbmF0aW9uIGdwaW8gaWYgc3VwcG9ydGVkCiAgc2VyaWFsOiBjb3JlLCA4MjUwOiBz
ZXQgUlM0ODUgdGVybWluYXRpb24gZ3BpbyBpbiBzZXJpYWwgY29yZQogIHNlcmlhbDogY29yZTog
bW92ZSBzYW5pdGl6aW5nIG9mIFJTNDg1IGRlbGF5cyBpbnRvIG93biBmdW5jdGlvbgogIHNlcmlh
bDogY29yZTogc2FuaXRpemUgUlM0ODUgZGVsYXlzIHJlYWQgZnJvbSBkZXZpY2UgdHJlZQogIGR0
X2JpbmRpbmdzOiByczQ4NTogQ29ycmVjdCBkZWxheSB2YWx1ZXMKICBzZXJpYWw6IDgyNTBfZHds
aWI6IHJlbW92ZSByZWR1bmRhbnQgc2FuaXR5IGNoZWNrIGZvciBSUzQ4NSBmbGFncwogIHNlcmlh
bDogYXI5MzN4OiBSZW1vdmUgcmVkdW5kYW50IGFzc2lnbm1lbnQgaW4gcnM0ODVfY29uZmlnCiAg
c2VyaWFsOiA4MjUwOiBscGMxOHh4OiBSZW1vdmUgcmVkdW5kYW50IHNhbml0eSBjaGVjayBmb3Ig
UlM0ODUgZmxhZ3MKCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUueWFtbCAg
ICAgfCAgNCArLQogZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kd2xpYi5jICAgICAgICAg
IHwgMTAgKy0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYyAgICAgICAg
fCAgNiArLQogZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMgICAgICAgICAgIHwg
IDMgLQogZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91YXJ0LmMgICAgICAgICAgICAgIHwgIDEg
LQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgICAgICAgICAgICAgIHwgODUgKysr
KysrKysrKysrLS0tLS0tLQogNiBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCA1MCBk
ZWxldGlvbnMoLSkKCgpiYXNlLWNvbW1pdDogZGYzNmYzZTNmYmI3NmQzMGQ2MjNhMTYyM2UzMWUz
Y2U5YzJmYTc1MAotLSAKMi4zNi4xCgo=
