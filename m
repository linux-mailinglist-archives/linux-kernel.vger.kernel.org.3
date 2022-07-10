Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6351256D029
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiGJQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGJQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281513E25;
        Sun, 10 Jul 2022 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471496;
        bh=r9kQ+eb8XdjZm2Ia2YL2lmH1Q4foW6xhwQY0wLK1kO0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q+2VyhytvwOF/Ho43AS3sCGevrGN3OZMunGLb3xBpMl48zX/xQiNocBP1h11IBHbr
         YMO0M2doffF0EYPv5dn5oyXeWdmwpLpmNthrkyUlP6J0cEetzyz2xQZ97rpOMd6LAU
         d2n/dFbopqmN093Ux//1k2vRYZlLKtCm8NtjNvGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MHoNC-1oONqA1uYY-00Eu3u; Sun, 10 Jul 2022 18:44:56 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 3/8] serial: core, 8250: set RS485 termination GPIO in serial core
Date:   Sun, 10 Jul 2022 18:44:37 +0200
Message-Id: <20220710164442.2958979-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XurQd/pVhRtOn7OmlHi3+KPTToa5xwcFYC++6/bubt0RdZdvo6J
 gmhM2JkWta63OpaxAP0Y5e6LXwH/H+snbwgl/zqf7OOq/96WMEAQyPzh8pQjnhHb3+bpzVx
 OZpc/Wp308+PIBJipIYUqLakfsKJol2RctIFXlpPQEL348z1F+Oz/jCVQua1+k0ADNKzVe/
 sfU9Z5eXrYB5e5OdxZ/kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XwqQq1X6clI=:DCwiGFcWHsjQeAfaCMj/Om
 TJnm0UR2TQiVt23i/ofuM4uMhE930cIXqxxoXhAai6QyLQ8qgvqUOFV0fY20XVS//qlSHaSAw
 e0AFhnqvHSgMVy9bjEhROTVXw7yIpXrblxc/TZd54aGJgP2llafFsm9qPzVYkBH85xxQ6+rsz
 pMW4sWfVaSOqTmWNfmrxWmfVDZoZW2VQVKhbsouUBQWPHnu7RWjV0foRfOYOevu+OEVoU+jxc
 cvX/2oWrYZph54eYD89xHu8Bxi1Frv885AbW/ay9Zzt+MSghCEAR65bNSz69khSJOKDKeviUi
 mC3gFOTXdbYjVtJ67GRisuYz7Go6+I8S+WlrQ31TMpN4EVhi4m4we0B63zGDRrRzm2EwTWbBD
 EG82W9iu5GCqBpqnYumwNXhadNKIrOhaJ+MKGNSOA3vI8n2YY+y0CfNEQDjgMoD9y4umvdoC+
 Fo9VGh9mTSM7IGH44JUZMQv54ER0Fc4mgXdxFzUTRZ8PXwdAQQHojsx8yKmiI9J5JLl/Lx3W/
 pBLsfqiWcoHyXxAlpY8pUB/ySNU1pMIe44cJU60G8ygVxyzJcnsEE4L+qqViYAlqr7aB7PNHY
 CYFbTSntQbuPDMAe0l2eLLLscber3pmCq06MZht4Xks9zWLBKYiDkQROtGKYRuIDq08hcUSik
 MTVpcyy6nXsk7xeswcs9UfuOt7DJq+rrCqSB0yCKAB8zPKQDgHbCH/CGud4LmOv46iEmT2gEn
 9sQu0NIfwiyK7UcGpreZA3uRl8GZItODXlI9+6RrzKccLDwAqkw3Vq9v3o3CEytAtkT2xe6+j
 Ni1HrE8dbHrrA7ts7whPh0AbK8i9uwu6zgpnYhM2OJKqMPUSZ8xbp4GWV0SeDTcRhOIziOiuY
 dnH8PgTurz8tyI4TeyXgHDWiB2pMerIKmiZpLVeyIYhVBCesXCO7XjeD0LOeyvlsYzcQW78gc
 JUVUsyQQmO6BZiUtlbkabCvyoR5i1rUaC8oVhcIkOyJJnuAPAyneU9zzaYZboGtpZDHCWlemM
 hhKY6RO4OJ2ez5iwS6GvqQ9wiylSkfSgfYz/f3dU9NzTZKy1ICjqWm3HZHYh3gvl1wqoD35Ba
 9LJM8Xiv1CXhoO2Ls8FDpMyvX+A7wDcNfDRy23pWQO0rIcaBrQYEItUdA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHNlcmlh
bDgyNTBfZW00ODVfY29uZmlnKCkgdGhlIHRlcm1pbmF0aW9uIEdQSU8gaXMgc2V0IHdpdGggdGhl
IHVhcnRfcG9ydApzcGlubG9jayBoZWxkLiBUaGlzIGlzIGFuIGlzc3VlIGlmIHNldHRpbmcgdGhl
IEdQSU8gbGluZSBjYW4gc2xlZXAgKGUuZy4Kc2luY2UgdGhlIGNvbmNlcm5pbmcgR1BJTyBleHBh
bmRlciBpcyBjb25uZWN0ZWQgdmlhIFNQSSBvciBJMkMpLgoKRml4IHRoaXMgYnkgc2V0dGluZyB0
aGUgdGVybWluYXRpb24gbGluZSBvdXRzaWRlIG9mIHRoZSB1YXJ0X3BvcnQgc3BpbmxvY2sKaW4g
dGhlIHNlcmlhbCBjb3JlIGFuZCB1c2luZyBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoKSB3aGlj
aCBpbnN0ZWFkIG9mCmdwaW9kX3NldF92YWx1ZSgpIGFsbG93cyBpdCB0byBzbGVlcC4KCkJlc2lk
ZSBmaXhpbmcgdGhlIHRlcm1pbmF0aW9uIEdQSU8gbGluZSBzZXR0aW5nIGZvciB0aGUgODI1MCBk
cml2ZXIgdGhpcwpjaGFuZ2UgYWxzbyBtYWtlcyBzZXR0aW5nIHRoZSB0ZXJtaW5hdGlvbiBHUElP
IGdlbmVyaWMgZm9yIGFsbCBVQVJUCmRyaXZlcnMuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZp
bGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfcG9ydC5jIHwgIDMgLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YyAgICB8IDEyICsrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgy
NTBfcG9ydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMKaW5kZXggZWQy
YTYwNmYyZGE3Li43MjI1MmQ5NTZmMTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfcG9ydC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5j
CkBAIC02NzYsOSArNjc2LDYgQEAgaW50IHNlcmlhbDgyNTBfZW00ODVfY29uZmlnKHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywKIAkJcnM0ODUtPmZsYWdz
ICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CiAJfQogCi0JZ3Bpb2Rfc2V0X3ZhbHVlKHBv
cnQtPnJzNDg1X3Rlcm1fZ3BpbywKLQkJCXJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5B
VEVfQlVTKTsKLQogCS8qCiAJICogQm90aCBzZXJpYWw4MjUwX2VtNDg1X2luaXQoKSBhbmQgc2Vy
aWFsODI1MF9lbTQ4NV9kZXN0cm95KCkKIAkgKiBhcmUgaWRlbXBvdGVudC4KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMKaW5kZXggMWRiNDRjZGU3NmY2Li4wNDdlYzUxZGJkNDEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCkBAIC0xMzU4LDEyICsxMzU4LDIzIEBAIHN0YXRpYyB2b2lkIHVhcnRf
c2FuaXRpemVfc2VyaWFsX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJp
YWxfcnM0CiAJbWVtc2V0KHJzNDg1LT5wYWRkaW5nMSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5n
MSkpOwogfQogCitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAorCQkJCSAgICAgICBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpy
czQ4NSkKK3sKKwlpZiAoIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkpCisJCXJl
dHVybjsKKworCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV90ZXJtX2dwaW8s
CisJCQkJICEhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTKSk7Cit9CisK
IGludCB1YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogewogCXN0cnVj
dCBzZXJpYWxfcnM0ODUgKnJzNDg1ID0gJnBvcnQtPnJzNDg1OwogCWludCByZXQ7CiAKIAl1YXJ0
X3Nhbml0aXplX3NlcmlhbF9yczQ4NShwb3J0LCByczQ4NSk7CisJdWFydF9zZXRfcnM0ODVfdGVy
bWluYXRpb24ocG9ydCwgcnM0ODUpOwogCiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQs
IE5VTEwsIHJzNDg1KTsKIAlpZiAocmV0KQpAQCAtMTQwNiw2ICsxNDE3LDcgQEAgc3RhdGljIGlu
dCB1YXJ0X3NldF9yczQ4NV9jb25maWcoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCwKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCXVhcnRfc2FuaXRpemVf
c2VyaWFsX3JzNDg1KHBvcnQsICZyczQ4NSk7CisJdWFydF9zZXRfcnM0ODVfdGVybWluYXRpb24o
cG9ydCwgJnJzNDg1KTsKIAogCXNwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFncyk7
CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQsICZ0dHktPnRlcm1pb3MsICZyczQ4NSk7
Ci0tIAoyLjI1LjEKCg==
