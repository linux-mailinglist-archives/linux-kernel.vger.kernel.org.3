Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294956CF9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGJPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGJPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:04:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDECF64C9;
        Sun, 10 Jul 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465409;
        bh=bCCo/6Am2R09b4nHHeMnoc0FW6xyrYI6zkvE1m2Jm4A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Y/FtNncUF0YYrHQPa7Evn+Mb1X+P6w+n53UBeJWw/TLxD9fLIWe4cYb5JVkpuh/LY
         J6yKdBT8hBDADzp61Bd9gjm761JMMmgW8xDryyqHOI6RZZc37HF/F0KR3woiBY3qma
         a5S8c5/uYkYaBixTKAKVLnWbJMTt8MipDb/cI4CY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTzay-1o16Gp0pN4-00R1T5; Sun, 10 Jul 2022 17:03:29 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 0/8] Fixes and cleanup for RS485
Date:   Sun, 10 Jul 2022 17:03:14 +0200
Message-Id: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:AQK75PXDxb8ruYEg4RoE/3q8W5jyQVLOL7VSy14r6hTADfPrxRR
 2EbnzXFyawPbUTdYZQ/ykqJKFLSyDxYcCc08iF0u2+el+0T+7zW5bDItAYoYWxe3511SRjH
 zp/O8BrHcMqU/cDJZgQ4MVXQTW6Et4MLmXF3DcBOFk/Wuhs8hS2Fr2VtDYI57ufmxEJqifA
 IPJjiw/8Pc0Dd34+hAq9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iEbjkL/2hfg=:niaR/DQ/WNAO6Mr0TXesA4
 7gn2DKaXLYCgjGJL2cwr1hYeBSQlm6MDWRht1KOpSsbmy84kuixgGaBBnTit/j1M+oBo+7zWJ
 vfuJvSxvNdbAoMEtkuorCq3NiLx//sSXBICZtJl1r7xqWTFCJh/bdcBLGkwomox8iiZ7aXVap
 Phg62UdCotuVHHhhurjq3Vuuk0djKShT9X/eaoBahL+Hv1EN/wKxLTAXbXozbiDUbXl1rZloD
 dq9LKR8SEtyoaQGOD3iXvdQUMMGp7xl/DS7zzfRZHdwrZtQsUKJTfaFFxOBnslYgFrRyhAnFL
 VNCWK8rZ2Xn20f+b7IwUlvO+LFwJNhY0Htlh+sflUYcMCEqKCW+mvewG9r9+WX/QvdHVs0jrQ
 jkZfDYVdALp3UAF6MYceVzVzEqyZm6aRgEZcRXb0w24Y2InldZzLlzbSTWvkgnu0kW9w6jSuQ
 4emzhGykA3e54lc6Q1PDKrG7/jHDGfZJvHfgPW7D1/VW4GxANbWwDMUhbaKhhAJ+nDqS8EEqI
 32Q9bWREoZernoY7W1FZp3PomWZCPaRVYbIJNMVQ+IL8lgBlqI/UeX8VrP8jQIxrIVuieG2mI
 pbAJ3ikBRKTX9N03+1P5Cbq4dbBK9ZbjJxHpo+Lx5wf8gsbLjtwY5m9y1fNczx7H7H0JwL11x
 +jHaPn9IFqmnkZG/gXFCqx6ndTC9iwT+A0jEt+29vSt5BZcrRFsSO7Jt6D+xb5yY+2LsQyKC1
 4qWJqPmL4fJecPQdo1D1YAOEjjd3zdX0fJDY7OBQDgIAmwgH1hf5+7E6ZagYAmMHyKTZzTGLA
 b//NE1vryMacSFEGt4EkZHg1akzOtylW79Fxl3WsVUNsO2lmivS35ZFGneE8Azqtih4zUmRT7
 ShJ44SyU5NSFj0kCy1cPTNVQ1JYVQL7dod037n/c9d7V+71dOSMBJRyedPiqid0xEssXHpJzu
 B/bBcL3c9S240qIDXh9PcCSAl6RYvwH88PeIV4UEIXgrCt2yF0x9gn9CtkEhdJqOU49bVXnmk
 2XCJ4Wtp/5dihsnOrvhBsmfURyI7qp77S+rUTuceEwJjmEOiRjuqBprf4F5RCzGIL48zGYhrF
 W4Lz0XotMr7jvXfdNwrZsLz+FJct55QDAupfTMGhtfrPJkcXiC8DfoH3w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBmb2xs
b3dpbmcgc2VyaWVzIGluY2x1ZGVzIGNsZWFudXAgYW5kIGZpeGVzIGFyb3VuZCBSUzQ4NSBpbiB0
aGUgc2VyaWFsCmNvcmUgYW5kIHVhcnQgZHJpdmVyczoKClBhdGNoIDE6IGFyOTMzeDogRml4IGNo
ZWNrIGZvciBSUzQ4NSBzdXBwb3J0ClBhdGNoIDI6IFJlbW92ZSBzdXBlcmZsdW91cyBjb2RlIGlu
IGFyOTMzeC4KUGF0Y2ggMzogU2V0IHRoZSByczQ4NSB0ZXJtaW5hdGlvbiBHUElPIGluIHRoZSBz
ZXJpYWwgY29yZS4gVGhpcyBpcyBuZWVkZWQKCSBzaW5jZSBpZiB0aGUgZ3BpbyBpcyBvbmx5IGFj
Y2Vzc2libGUgaW4gc2xlZXBhYmxlIGNvbnRleHQuIEl0IGFsc28KCSBpcyBhIGZ1cnRoZXIgc3Rl
cCB0byBtYWtlIHRoZSBSUzQ4NSBoYW5kbGluZyBtb3JlIGdlbmVyaWMuClBhdGNoIDQ6IE1vdmUg
c2FuaXRpemluZyBvZiBSUzQ4NSBkZWxheXMgaW50byBhbiBvd24gZnVuY3Rpb24uIFRoaXMgaXMg
aW4gCgkgcHJlcGFyYXRpb24gb2YgcGF0Y2ggNC4KUGF0Y2ggNTogU2FuaXRpemUgUlM0ODUgZGVs
YXlzIHJlYWQgZnJvbSBkZXZpY2UgdHJlZS4KUGF0Y2ggNjogQ29ycmVjdCBSUzQ4NSBkZWxheXMg
aW4gYmluZGluZyBkb2N1bWVudGF0aW9uLgpQYXRjaCA3OiBSZW1vdmUgcmVkdW5kYW50IGNvZGUg
aW4gODI1MF9kd2xpYi4KUGF0Y2ggODogUmVtb3ZlIHJlZHVuZGFudCBjb2RlIGluIDgyNTAtbHBj
MTh4eC4KCkNoYW5nZXMgaW4gdjM6Ci0gcmVtb3ZlIG9ic29sZXRlIHBhdGNoIChkdWUgdG8gY2hh
bmdlcyBieSBJbHBvKQotIGNvcnJlY3RlZCBhbmQgcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2VzIChw
b2ludGVkIG91dCBieSBBbmR5KQotIHJlbW92ZSBzdXBlcmZsdW91cyBjaGVjayAocG9pbnRlZCBv
dXQgYnkgQW5keSkKLSBzZXBhcmF0ZSBhcjkzM3ggVUFSVCBidWdmaXggYW5kIGNsZWFudXAgaW50
byBkaWZmZXJlbnQgcGF0Y2hlcyAoYXMKICBzdWdnZXN0ZWQgYnkgSWxwbykKLSBwdXQgdGhlIGFy
OTMzeCBmaXggYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgc2VyaWVzIChhcyBzdWdnZXN0ZWQgYnkg
QW5keSkKCkNoYW5nZXMgaW4gdjI6Ci0gcHJpbnQgYSB3YXJuaW5nIGlmIHRlcm1pbmF0aW9uIEdQ
SU8gaXMgc3BlY2lmaWVkIGluIERUL0FDUEkgYnV0IGlzIG5vdAogIHN1cHBvcnRlZCBieSBkcml2
ZXIgCi0gZml4ZWQgY29tbWl0IG1lc3NhZ2UgZm9yIGRldnRyZWUgZG9jdW1lbnRhdGlvbiAoYXMg
c3VnZ2VzdGVkIGJ5IEFuZHkpCi0gZml4ZWQgY29kZSBjb21tZW50Ci0gYWRkZWQgcGF0Y2ggNwoK
Ckxpbm8gU2FuZmlsaXBwbyAoOCk6CiAgc2VyaWFsOiBhcjkzM3g6IEZpeCBjaGVjayBmb3IgUlM0
ODUgc3VwcG9ydAogIHNlcmlhbDogYXI5MzN4OiBSZW1vdmUgc3VwZXJmbHVvdXMgY29kZSBpbiBh
cjkzM3hfY29uZmlnX3JzNDg1KCkKICBzZXJpYWw6IGNvcmUsIDgyNTA6IHNldCBSUzQ4NSB0ZXJt
aW5hdGlvbiBncGlvIGluIHNlcmlhbCBjb3JlCiAgc2VyaWFsOiBjb3JlOiBtb3ZlIHNhbml0aXpp
bmcgb2YgUlM0ODUgZGVsYXlzIGludG8gb3duIGZ1bmN0aW9uCiAgc2VyaWFsOiBjb3JlOiBzYW5p
dGl6ZSBSUzQ4NSBkZWxheXMgcmVhZCBmcm9tIGRldmljZSB0cmVlCiAgZHRfYmluZGluZ3M6IHJz
NDg1OiBDb3JyZWN0IGRlbGF5IHZhbHVlcwogIHNlcmlhbDogODI1MF9kd2xpYjogcmVtb3ZlIHJl
ZHVuZGFudCBzYW5pdHkgY2hlY2sgZm9yIFJTNDg1IGZsYWdzCiAgc2VyaWFsOiA4MjUwOiBscGMx
OHh4OiBSZW1vdmUgcmVkdW5kYW50IHNhbml0eSBjaGVjayBmb3IgUlM0ODUgZmxhZ3MKCiAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUueWFtbCAgICAgfCAgNCArLQogZHJpdmVy
cy90dHkvc2VyaWFsLzgyNTAvODI1MF9kd2xpYi5jICAgICAgICAgIHwgMTAgKy0tLQogZHJpdmVy
cy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMgICAgICAgIHwgIDYgKy0KIGRyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jICAgICAgICAgICB8ICAzIC0KIGRyaXZlcnMvdHR5
L3NlcmlhbC9hcjkzM3hfdWFydC5jICAgICAgICAgICAgICB8IDE4ICsrLS0tLQogZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgICAgICAgICAgICAgIHwgNjAgKysrKysrKysrKysrLS0t
LS0tLQogNiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkK
CgpiYXNlLWNvbW1pdDogN2U1YjQzMjJjZGUwNjdlMWQwZjFiZjhmNDkwZTkzZjY2NGE3Yzg0Mwot
LSAKMi4yNS4xCgo=
