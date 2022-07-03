Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7744B5648B9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiGCRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGCRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F58624F;
        Sun,  3 Jul 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867690;
        bh=A80IEaOvnAlffKMAOwHrks5ajbBOXblTI1M+kCbuuS8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hzPKHzZZbKBd6lfxFyRYOjCi1H+RCoOd0a+IYJcMIyxE0gMvGq7/7j+Qf7el3FR1k
         fx7JveZxbfy7sbN+SjZQiG1yh3kAuTlRSak/1KqVmGNWHZesy+WM7+v0TfqLbWFpaV
         wkeVyQsX1143pJ/ZJClMG72uXCzhCa7O6E3vDnf8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYvY2-1o3d6X3Cca-00Uutl; Sun, 03 Jul 2022 19:01:29 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 0/9] Fixes and cleanup for RS485
Date:   Sun,  3 Jul 2022 19:00:30 +0200
Message-Id: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+BIVud8HUysptY1CRE/8CAqa8UDwjnHqFBBbZV5WVV9svCJLpjR
 +JibWzMCIr/FhhTfcfEKHUqguDgLb1Rteay+VFIjtJs9P2DGvDGbQCMcRmuNZjbZI8uzl8Z
 vmKnCZawWwv1fKlyp3EIDO8Fir9NharaCGEfyOr/Z0lQIIKR998tnWO3SQb1JhZ6XCWlSFu
 JKrQ3vvafo9nGDSweHENw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UeNGYxSx++A=:jYl0ljKHXP+26L/kNcUQX6
 0OUbodQpW7gP0xBKAH2stA3n67W1XVlPi8NeO5jEM63/TzeKnrmSLC259d9uui8RKjmjwu/5T
 OUY13qP5dHwm+bymC04DwlIUfyExgnUHlBm+LD5J8cjt86guq1kaMPQZdorOadBNI1CslWQ97
 2T0WB06jn1UDekFOGEJnehBq6X5EF7LnuQfUVUqqfYtg7HX2XQKnroiP52n1uVp5VmqVFFKjO
 1n4BtDkt58rzKuzTvUuXSf50EuBZWgksSQ/1C3i2niQDyharNUwF1eyvmEOJbRA1E9WyO6gGE
 dlwj7WYCRsvr+jdCVCKP8P/XE22vsa0Wt9aDrWhmgYi9lnmOazgRfUkJT3h3/nPfLVe7zG1Qx
 NhlUcSZrr1M0QWB5Rikwu8+mJF0t4CmmCjRevLDF3M+pn9IPT/w8nuJvm5n02nWMDakSIM54U
 K1kAYccBOKbTGBudoHSblw68VduU6/WMhr16KU0f3/CzRgnYnj1CKr01XQIVhakDdvxeyariL
 LA0vAmsdB0UAY8ciQ+hHPqKO5Bvqeqt/Wt9iXdtDBkB8CyQl1u7AMmtCPikMHp5fvguU/2Xxv
 fCoqzmpE+PcUWcTgmSTQodJfRTHAK3Mb+WwLts0aTprJ27KF2Jv1Gnbh8SaLESKa4K36RJcZJ
 AnKXXB3dkeqo2o71klLcu/PXErXtdaMY82WdFClSOHNkrv+L9weyuLClM3BY2QxBDWOpS+yKq
 LyFENLjSuxMlx2y6fej3uZrO9GlfCH0TUn8Htx5CDLV9SH+LMbp4hG9MuWEajPQgMMZkK+PyI
 PIg2kRgShC0GAuI4BjIYLZs0FCxQpzVJ/6qkOHeIjK6gXDVfLRdpwsfhSi/zKYw5QlJr2YoHR
 X+ouLlpcqZvKhLIYbnrFC+bZpiKKFH1kqKL+eHgLVMmvUxyXgtDp+jyA19acFAT1NAeIOqBNc
 CD64c7cT9IrOvLzPOTG+voYkGRT888q5jmVYn6taOGmhHiAoS2xpVP9QhmU31hHGyWzqwSYK3
 LiER0SUUem+zGwKj1ZTnkOof12j6Wyw4q7lyCOux4B6nRqPPLR0vdCH6SNaQ9GjU67isGFUa1
 /IgQYBfhiLRYiSN4RTQCP8rSDbTytQwUQcc46pRFVnrvfDFnTX2jNaODQ==
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
aGUgc2VyaWFsCmNvcmUgYW5kIHVhcnQgZHJpdmVyczoKClBhdGNoIDE6IE9ubHkgcmVxdWVzdCB0
aGUgcnM0ODUgdGVybWluYXRpb24gZ3BpbyBpZiBpdCBpcyBzdXBwb3J0ZWQuCgkgTk9URTogCgkg
VGhpcyBwYXRjaCBmb2xsb3dzIHRoZSBkZXNpZ24gZGVjaXNpb24gdGhhdCAicnM0ODVfc3VwcG9y
dGVkIiBpcwoJIHNldCBieSB0aGUgZHJpdmVyIGF0IGluaXRpYWxpemF0aW9uIGFuZCBjYW5ub3Qg
YmUgbW9kaWZpZWQKCSBhZnRlcndhcmRzLiBIb3dldmVyIHRoZSBiZXR0ZXIgYXBwcm9hY2ggd291
bGQgYmUgdG8gbGV0IHRoZSBzZXJpYWwKCSBjb3JlIG1vZGlmeSB0aGUgdGVybWluYXRpb24gR1BJ
TyBzdXBwb3J0IHNldHRpbmcgYmFzZWQgb24gdGhlCgkgZXhpc3RlbmNlIG9mIGEgdGVybWluYXRp
b24gR1BJTy4gSWYgInJzNDg1X3N1cHBvcnRlZCIgaXMgbm90IGEgCgkgcmVhZC1vbmx5IHZhbHVl
IGFueSBtb3JlIGluIGZ1dHVyZSB0aGUgbG9naWMgaW1wbGVtZW50ZWQgaW4gdGhpcwoJIHBhdGNo
IHNob3VsZCBiZSBhZGp1c3RlZCBhY2NvcmRpbmdseS4KUGF0Y2ggMjogU2V0IHRoZSByczQ4NSB0
ZXJtaW5hdGlvbiBHUElPIGluIHRoZSBzZXJpYWwgY29yZS4gVGhpcyBpcyBuZWVkZWQKCSBzaW5j
ZSBpZiB0aGUgZ3BpbyBpcyBvbmx5IGFjY2Vzc2libGUgaW4gc2xlZXBhYmxlIGNvbnRleHQuIEl0
IGFsc28KCSBpcyBhIGZ1cnRoZXIgc3RlcCB0byBtYWtlIHRoZSBSUzQ4NSBoYW5kbGluZyBtb3Jl
IGdlbmVyaWMuClBhdGNoIDM6IE1vdmUgc2FuaXRpemluZyBvZiBSUzQ4NSBkZWxheXMgaW50byBh
biBvd24gZnVuY3Rpb24uIFRoaXMgaXMgaW4gCgkgcHJlcGFyYXRpb24gb2YgcGF0Y2ggNC4KUGF0
Y2ggNDogU2FuaXRpemUgUlM0ODUgZGVsYXlzIHJlYWQgZnJvbSBkZXZpY2UgdHJlZS4KUGF0Y2gg
NTogQ29ycmVjdCBSUzQ4NSBkZWxheXMgaW4gYmluZGluZyBkb2N1bWVudGF0aW9uLgpQYXRjaCA2
OiBSZW1vdmUgcmVkdW5kYW50IGNvZGUgaW4gODI1MF9kd2xpYi4KUGF0Y2ggNzogRml4IGNoZWNr
IGZvciBSUzQ4NSBzdXBwb3J0LgpQYXRjaCA4OiBSZW1vdmUgcmVkdW5kYW50IGNvZGUgaW4gYXI5
MzN4LgpQYXRjaCA5OiBSZW1vdmUgcmVkdW5kYW50IGNvZGUgaW4gODI1MC1scGMxOHh4LgoKQ2hh
bmdlcyBpbiB2MjoKLSBwcmludCBhIHdhcm5pbmcgaWYgdGVybWluYXRpb24gR1BJTyBpcyBzcGVj
aWZpZWQgaW4gRFQvQUNQSSBidXQgaXMgbm90CiAgc3VwcG9ydGVkIGJ5IGRyaXZlciAKLSBmaXhl
ZCBjb21taXQgbWVzc2FnZSBmb3IgZGV2dHJlZSBkb2N1bWVudGF0aW9uIChhcyBzdWdnZXN0ZWQg
YnkgQW5keSkKLSBmaXhlZCBjb2RlIGNvbW1lbnQKLSBhZGRlZCBwYXRjaCA3CgoKTGlubyBTYW5m
aWxpcHBvICg5KToKICBzZXJpYWw6IGNvcmU6IG9ubHkgZ2V0IFJTNDg1IHRlcm1pbmF0aW9uIEdQ
SU8gaWYgc3VwcG9ydGVkCiAgc2VyaWFsOiBjb3JlLCA4MjUwOiBzZXQgUlM0ODUgdGVybWluYXRp
b24gZ3BpbyBpbiBzZXJpYWwgY29yZQogIHNlcmlhbDogY29yZTogbW92ZSBzYW5pdGl6aW5nIG9m
IFJTNDg1IGRlbGF5cyBpbnRvIG93biBmdW5jdGlvbgogIHNlcmlhbDogY29yZTogc2FuaXRpemUg
UlM0ODUgZGVsYXlzIHJlYWQgZnJvbSBkZXZpY2UgdHJlZQogIGR0X2JpbmRpbmdzOiByczQ4NTog
Q29ycmVjdCBkZWxheSB2YWx1ZXMKICBzZXJpYWw6IDgyNTBfZHdsaWI6IHJlbW92ZSByZWR1bmRh
bnQgc2FuaXR5IGNoZWNrIGZvciBSUzQ4NSBmbGFncwogIHNlcmlhbDogYXI5MzN4OiBGaXggY2hl
Y2sgZm9yIFJTNDg1IHN1cHBvcnQKICBzZXJpYWw6IGFyOTMzeDogUmVtb3ZlIHJlZHVuZGFudCBh
c3NpZ25tZW50IGluIHJzNDg1X2NvbmZpZwogIHNlcmlhbDogODI1MDogbHBjMTh4eDogUmVtb3Zl
IHJlZHVuZGFudCBzYW5pdHkgY2hlY2sgZm9yIFJTNDg1IGZsYWdzCgogLi4uL2RldmljZXRyZWUv
YmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwgICAgIHwgIDQgKy0KIGRyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfZHdsaWIuYyAgICAgICAgICB8IDEwICstLQogZHJpdmVycy90dHkvc2VyaWFs
LzgyNTAvODI1MF9scGMxOHh4LmMgICAgICAgIHwgIDYgKy0KIGRyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfcG9ydC5jICAgICAgICAgICB8ICAzIC0KIGRyaXZlcnMvdHR5L3NlcmlhbC9hcjkz
M3hfdWFydC5jICAgICAgICAgICAgICB8IDE4ICsrLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYyAgICAgICAgICAgICAgfCA3MCArKysrKysrKysrKysrLS0tLS0tCiA2IGZpbGVz
IGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0
OiA3MzQ5NjYwNDM4NjAzZWQxOTI4MmU3NTk0OTU2MTQwNjUzMTc4NWE1Ci0tIAoyLjI1LjEKCg==
