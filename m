Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7625C5648CC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiGCRCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiGCRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC3615B;
        Sun,  3 Jul 2022 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867693;
        bh=nviYHbsk7MUrNRrU2LChICEnd9k2yAJfBhTih4EkRFU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bfdg9Q49+9fanC418tQVocQrYkJukV2m2YyGouT3Gtfn9930Ay67FU8PMbEX2Ncvo
         VASUlpgLNTfF+bQC6ikmKXX10KopUCt0Dpfe42ofDYkYRLW9G3C++1NiUUo0TRFi04
         4LUemO34zsS9GxuSSISO8GiX5ZjkuAinkZmPgM7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtfNl-1nKbyt39up-00v91q; Sun, 03 Jul 2022 19:01:32 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 7/9] serial: ar933x: Fix check for RS485 support
Date:   Sun,  3 Jul 2022 19:00:37 +0200
Message-Id: <20220703170039.2058202-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VoZAD9Dbxt7x089Nyq0L5L28YRZ0OXJkTCsDYq8757Tu1x7ijrb
 1s3UwQ7BRlBMhPG9SvgbwyjHMfPBn5G7Zc9ba0MC107DvPp1VJqChWY2oeiFtO6WtuVxNA3
 UaZ7cGMKvIj9AXKhn2DsI/eQhmBIbFeXjMP+TrR2OySjsUSb35l2VTPBip44TNBWdNK5MBE
 VLqQ1oI1j6MzoLicOuncA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fI0Hk2c+rTM=:1XyIzL8b6fUbwwxLVUcz2o
 tl9xpNLJF40NPd6lue0eD5eU/48Xii+Y0WhsQrWxTkjg+37M/Hj9EX81+NeD35yfIbqVMfaMI
 +/NStccZRRwhwqcwQZ4MxTtZRvGsf4YzGc6k5TQGoHfsbmUEabln34I2k0AHsT7L9o3VRkhWX
 tpIL2xiSlRF6Zn4XpDq9BCdcdRcINuROys9s0+g4SuRYxsYBPbgVfPguLuwM6Gtxeya7d/47P
 5waOEkawMoQOSmL3BGogEhtL+YcFyJMKprrZ9iT88igOY2kqQ95ycbe4SURJ7wQWWs5nO+umM
 N0b1+UOK33mxlbiwubQWA37GpmbUhHmulsdr3ytTdV9xq5TbuktW6OPly92PgH0XApi82Myiq
 B/aTfI3cbiMne4rb0B3+qw7kdh+FUUp81yUhtZKaryT24NkyvckG/9NpZPRa8CldQVNcPv4tC
 q8ZugZY7MexU+AlZdGNcdhwsqMxyQ5UVnGIlDhikXFnPelqtCKRwsQXXEdoY6pvD8rU2x3Apf
 dGySC+FR1dc1iVmIATkQOKhAX4C0pdxgHOe3EN5GFnFq7iHYQAdncuhOzh6NOgNLj/JFfzjhJ
 FywHCMR6UzahErs67Boudc+LR+XVaQt3GshuhixTk+Qt9D5I5PyXwuWON1iwMJ+ouh1btTKYb
 gjUBd5L3W8rFf7UkCw2yJlpNundDpnTRFEl/ti+gYMzYyebTXIrocGy0Ojmker/fWdBMXckxT
 PRFt5wYgzS1P5xUO+uKLK8Zu5sTW5t4/QQhbnUeTyoXFhUUHQJKhhXlelEB2yf8Sz1kn5SiPn
 g8OvF0Hosp3M+9ZfW5qs5Y5kVmjWq/WQFKZLcrG5ZVDYzz/KnS3o9N3c9mYU4xDeAI/NpLAYo
 RZ5A4n8I5sXCxWZGNP2VdzpS1Va8Qz/Q0l4yifOV3jsrj8sY6WQg0VFLTeYInQ9YyqiuWpcZv
 gcPEDVJllns4/zpaeayYvNIJ9YzMN/e749djGIpm7wCZotQefi2xB2c7gdfFKSWm/hB106m4q
 Mn/gw9P4T/zl6OMY91B84wkxb0zX65tAhnLV5VMXNCNQkbbRKzxJsVzbBIeQXD3TJihR5aap/
 Qh7ZIf3nhmME+JwVeyDt/XxwVbZOwJ1VCI0JXFtqeKYo4JnbSzuUnF+Mw==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldpdGhvdXQg
YW4gUlRTIEdQSU8gUlM0ODUgaXMgbm90IHBvc3NpYmxlIHNvIGRpc2FibGUgdGhlIHN1cHBvcnQK
cmVnYXJkbGVzcyBvZiB3aGV0aGVyIFJTNDg1IGlzIGVuYWJsZWQgYXQgYm9vdHRpbWUgb3Igbm90
LiBBbHNvIHJlbW92ZSB0aGUKbm93IHN1cGVyZmx1b3VzIGNoZWNrIGZvciB0aGUgUlRTIEdQSU8g
aW4gYXI5MzN4X2NvbmZpZ19yczQ4NSgpLgoKRml4ZXM6IGU4NDkxNDVlMWZkZCAoInNlcmlhbDog
YXI5MzN4OiBGaWxsIGluIHJzNDg1X3N1cHBvcnRlZCIpClNpZ25lZC1vZmYtYnk6IExpbm8gU2Fu
ZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFs
L2FyOTMzeF91YXJ0LmMgfCAxNyArKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkv
c2VyaWFsL2FyOTMzeF91YXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXI5MzN4X3VhcnQuYwpp
bmRleCBiNzNjZTEzNjgzZGIuLmRhYzQ4YTMzMGRiNiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2FyOTMzeF91YXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2FyOTMzeF91YXJ0
LmMKQEAgLTU4MywxNCArNTgzLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1YXJ0X29wcyBhcjkz
M3hfdWFydF9vcHMgPSB7CiBzdGF0aWMgaW50IGFyOTMzeF9jb25maWdfcnM0ODUoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLAogCQkJCXN0cnVjdCBzZXJp
YWxfcnM0ODUgKnJzNDg1Y29uZikKIHsKLQlzdHJ1Y3QgYXI5MzN4X3VhcnRfcG9ydCAqdXAgPQot
CQljb250YWluZXJfb2YocG9ydCwgc3RydWN0IGFyOTMzeF91YXJ0X3BvcnQsIHBvcnQpOwotCi0J
aWYgKChyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpICYmCi0JICAgICF1cC0+
cnRzX2dwaW9kKSB7Ci0JCWRldl9lcnIocG9ydC0+ZGV2LCAiUlM0ODUgbmVlZHMgcnRzLWdwaW9c
biIpOwotCQlyZXR1cm4gMTsKLQl9CiAJcG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOwogCXJldHVy
biAwOwogfQpAQCAtNzk4LDExICs3OTAsMTIgQEAgc3RhdGljIGludCBhcjkzM3hfdWFydF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCiAJdXAtPnJ0c19ncGlvZCA9IG1jdHJs
X2dwaW9fdG9fZ3Bpb2QodXAtPmdwaW9zLCBVQVJUX0dQSU9fUlRTKTsKIAotCWlmICgocG9ydC0+
cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgJiYKLQkgICAgIXVwLT5ydHNfZ3Bpb2Qp
IHsKLQkJZGV2X2VycigmcGRldi0+ZGV2LCAibGFja2luZyBydHMtZ3BpbywgZGlzYWJsaW5nIFJT
NDg1XG4iKTsKLQkJcG9ydC0+cnM0ODUuZmxhZ3MgJj0gflNFUl9SUzQ4NV9FTkFCTEVEOworCWlm
ICghdXAtPnJ0c19ncGlvZCkgewogCQlwb3J0LT5yczQ4NV9zdXBwb3J0ZWQgPSAmYXI5MzN4X25v
X3JzNDg1OworCQlpZiAocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgewor
CQkJZGV2X2VycigmcGRldi0+ZGV2LCAibGFja2luZyBydHMtZ3BpbywgZGlzYWJsaW5nIFJTNDg1
XG4iKTsKKwkJCXBvcnQtPnJzNDg1LmZsYWdzICY9IH5TRVJfUlM0ODVfRU5BQkxFRDsKKwkJfQog
CX0KIAogI2lmZGVmIENPTkZJR19TRVJJQUxfQVI5MzNYX0NPTlNPTEUKLS0gCjIuMjUuMQoK
