Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED947FBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhL0KcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:32:10 -0500
Received: from mail.logobject.ch ([81.7.230.227]:38144 "EHLO mail.logobject.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236006AbhL0KcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:32:09 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 05:32:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=logobject.ch; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=5fEbQ2oMVXJSMSAMMcAJm5+tGJT29UQz99w7q0SAdE0=;
        b=hKG15/Tov3EU3MBDzc8PEPvzQt2YvrPlSZZNCDX5NKgd6f8fCjgLWmQ+RlCShiOBCeSEwZWKyiJSn
         0vXLtsBONxxjMNrybZ1y1K0Z25cOOm4hleP3ujSc4MqctIYeubFuzVXD63+lZKc4Uxbc6og7udu/iL
         oyylxf15RogrPH6WADjZwmDOafjbvKCUYAwwWqyud+mCK3g/f3gOp05ULFlzUFNhISh3szaeHvlN6k
         w1UOpiJ9KAQGm8wsWYJhHb+iJfKQeBqOtoDOKl6w1+wUkQTzL9JyzgqCOWqhxZhHdZchsBx5AOARAV
         CoDpGQq1eIcfp9CPCg7ADx1I9XuY5Dw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.1.1366, Stamp: 3], Multi: [Enabled, t: (0.000004,0.010844)], BW: [Enabled, t: (0.000014)], RTDA: [Enabled, t: (0.027613), Hit: No, Details: v2.19.0; Id: 15.52k9jh.1fntmrog8.2eu8c], total: 0(700)
X-Spam-Status: No, hits=0.0 required=5.0
        tests=KERIO_ANTI_SPAM: -0.000, AWL: 0.013, BAYES_00: -1.665,
        CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.652,autolearn=ham
X-Spam-Level: 
X-Footer: bG9nb2JqZWN0LmNo
Received: from [192.168.112.4] ([217.22.138.64])
        (authenticated user ortwin.glueck@logobject.ch)
        by mail.logobject.ch with ESMTPSA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits));
        Mon, 27 Dec 2021 11:27:00 +0100
Content-Type: multipart/mixed; boundary="------------qTCOCjEB9Hs4u3nABFvx3MFz"
Message-ID: <b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch>
Date:   Mon, 27 Dec 2021 11:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <ortwin.glueck@logobject.ch>
Subject: [PATCH] fix 5.15 init regression for Intel Bluetooth
To:     linux-kernel@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <856c5dc7-9fb4-8438-3451-7b369832056a@odi.ch>
Content-Language: en-US
In-Reply-To: <856c5dc7-9fb4-8438-3451-7b369832056a@odi.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------qTCOCjEB9Hs4u3nABFvx3MFz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi

On all 5.15 kernels the Intel Bluetooth no longer works. All was fine in 5.14.
Apparently the quirk is needed for this device.

vanilla 5.15.5:
    Bluetooth: hci0: Reading Intel version command failed (-110)
    Bluetooth: hci0: command tx timeout

with patch:
    Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17 2014
    Bluetooth: hci0: Intel device is already patched. patch num: 32

Please apply to stable too.

Thanks

Ortwin
--------------qTCOCjEB9Hs4u3nABFvx3MFz
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Bluetooth-btusb-Add-init-quitk.patch"
Content-Disposition: attachment;
 filename="0001-Bluetooth-btusb-Add-init-quitk.patch"
Content-Transfer-Encoding: base64

RnJvbSBmYjcyMTk4ODQyNWZmZDQwZTA5NjAzYTNlOGIxNDFjMGI0NmI3NGUwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/T3J0d2luPTIwR2w9QzM9QkNjaz89
IDxvZGlAb2RpLmNoPgpEYXRlOiBTYXQsIDQgRGVjIDIwMjEgMTQ6MjU6NTYgKzAxMDAKU3Vi
amVjdDogW1BBVENIXSBCbHVldG9vdGg6IGJ0dXNiOiBBZGQgaW5pdCBxdWl0awpNSU1FLVZl
cnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29u
dGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKRml4ZXMgdGhlIGJvb3QgcmVncmVzc2lv
biBhZ2FpbnN0IDUuMTQ6CiBCbHVldG9vdGg6IGhjaTA6IFJlYWRpbmcgSW50ZWwgdmVyc2lv
biBjb21tYW5kIGZhaWxlZCAoLTExMCkKIEJsdWV0b290aDogaGNpMDogY29tbWFuZCB0eCB0
aW1lb3V0CgpTaWduZWQtb2ZmLWJ5OiBPcnR3aW4gR2zDvGNrIDxvZGlAb2RpLmNoPgpDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZwotLS0KIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMg
fCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgYi9kcml2ZXJzL2Js
dWV0b290aC9idHVzYi5jCmluZGV4IDc5ZDBkYjU0MmRhMy4uMjMyY2ZjYjQxNzM0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCisrKyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0dXNiLmMKQEAgLTM2Niw3ICszNjYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVz
Yl9kZXZpY2VfaWQgYmxhY2tsaXN0X3RhYmxlW10gPSB7CiAJeyBVU0JfREVWSUNFKDB4ODA4
NywgMHgwN2RhKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfQ1NSIH0sCiAJeyBVU0JfREVWSUNF
KDB4ODA4NywgMHgwN2RjKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfSU5URUxfQ09NQklORUQg
fAogCQkJCQkJICAgICBCVFVTQl9JTlRFTF9CUk9LRU5fSU5JVElBTF9OQ01EIH0sCi0JeyBV
U0JfREVWSUNFKDB4ODA4NywgMHgwYTJhKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfSU5URUxf
Q09NQklORUQgfSwKKwl7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhMmEpLCAuZHJpdmVyX2lu
Zm8gPSBCVFVTQl9JTlRFTF9DT01CSU5FRCB8CisJCQkJCQkgICAgIEJUVVNCX0lOVEVMX0JS
T0tFTl9JTklUSUFMX05DTUQgfSwKIAl7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhMmIpLCAu
ZHJpdmVyX2luZm8gPSBCVFVTQl9JTlRFTF9DT01CSU5FRCB9LAogCXsgVVNCX0RFVklDRSgw
eDgwODcsIDB4MGFhNyksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0lOVEVMX0NPTUJJTkVEIH0s
CiAJeyBVU0JfREVWSUNFKDB4ODA4NywgMHgwYWFhKSwgLmRyaXZlcl9pbmZvID0gQlRVU0Jf
SU5URUxfQ09NQklORUQgfSwKLS0gCjIuMzIuMAoK
--------------qTCOCjEB9Hs4u3nABFvx3MFz--


