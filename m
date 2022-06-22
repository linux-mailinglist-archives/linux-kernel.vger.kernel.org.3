Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6B554FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359582AbiFVPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359516AbiFVPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0243DDEA;
        Wed, 22 Jun 2022 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912841;
        bh=USV3fl+twKeaglXK8ND9rNj7pBUi2D1D0ABm0cxEvko=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UUswrZCOZwnVPIrtWkrISAJD5rAj5sXkVJ6a2FK4S7ogLnKGOE7AB6uoJONiZvpZy
         GFcYDw2xLOxfQkf6yxGc88/IOu6Az36J/NmES+kIhCRG3ueISlyh961UR0LU3Jxyzu
         CIOdMM1emnxbSaDDjVOHd5xtT69vpJ8k7X06qKKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1njsGI44rK-00y96s; Wed, 22
 Jun 2022 17:47:21 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 4/8] serial: core: sanitize RS485 delays read from device tree
Date:   Wed, 22 Jun 2022 17:46:55 +0200
Message-Id: <20220622154659.8710-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:e/jK6Z9VQvfhmbL4/RIZnEERZwYLu9YwLTfCCrPInSYYBm2ZMlu
 CdYKgEWHWZyP0DyZUusPmYZ7dOqtX0318268vHy0EiQ9da2TtNeALxihcGNyb2GVCKq6WIf
 K1WN8b7AtCjRUKa0B50guV58p7oloY6sGrhWQiJMpkUMsqd8nZGzppNMBusaPxFoaPa/iU6
 3Vi/pHI8FXMt1veuMQuNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:prhJy9QMOTc=:QgaCgmiMiRr/jtLsmjd/QX
 yOO5BLgh+6c5I/D7ExYmUEkszGqa1iFGUtVzTEnmdWuI59UKmXPEKEL/opxgHpdFhHpev67aU
 Re+56rDXQXyzgqWoxT84lFFYoC3w1j2lzNs4PI3b4ADpwW9k8/9AMW327z5l8PbA4DLIfE/Wo
 gXMjFaiSHBCYAy6oGKOkB1ptHnnGndgCixavf0/NnnCkhN4mNz74SKDLCxgU/5XDWkh1heBUi
 m9FBLUj2gLKu9SBsySl1JoS9f84CZXUZ7Bi0pX3UovOF9AAADsTx5g++ZODJNbkzF6rT5SNIy
 mwlZLenjF1gX8rOtaHYpImziRBJHVLMK/wQkRo42cZNrnLjk88oikKfgCDRwI1ypWRj+UJiub
 TkCE572PllH+X/tZVTSqAmIbuZe7ZyaYrwjCcy/QnIf7c3aH1e3Q3NyjQApcKEdLdQi8feRQH
 Bql9UIwvcpbgtTVSFY7kNKZGe+FvS1AcNZnsq6O27u+SlkeNMHd5i4K/QJoYr/HdITiTIVs1T
 1bg/ffXjDgG0suzrzvgBY1ZzIgaNav8XYzRRY/VrEl6Tr7lYiVfCpN5i23thYtWe3xV2O7oEW
 HToPEpqarAtMdVh9wJPLCwtQX3SHyJdX/Zhc9Hq1whcHK7Urkydu0RHYEOHAL04/ksZmviQbX
 4I5g8hFtDgWyVAcE4GkW7wLhsO8vFwVXAKMnFsMw6icgrFmAj5h0VXcodH9i3MUk9HKGdEef8
 DBskoAa3Pcc6XcVIqJwQy7cdqBZ5H9xkhIG8D0mdfwI9hz360zB7mJ6oMq9I+s4b3xqTMM0p/
 0xJzzxWLVnOKuTZIlVvzjUOdXXVUJAdmlGqCalkfPMEyLR990t5LKFXkAbiLr9WfM3KQM2mem
 I3HTTWY4nSskMIUdlIpAnyxCDQVHgf307hrkz6giYUj+nuX1M/Gl6HkJVh8OZLVAce6BsGogs
 0iySkke9+0e6N26x5iWAvq3QKOOzHQsvWZBaMY0C4/5x9Ur8yYoe+l5rVubK3ETUHRqvaOn9H
 3zXdUNjM7pJBe39Z555W7asmxuDquQQEQjBpVeSqGSda/ad7MmWQ5/pBSjWzpP416PveRUMZl
 I/BDunea9pML9crCdcYZdMlt4ErDobXSqD0fYFJHPU7zBG8v/ozpNOwPg==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldoZW4gc2V0
dGluZyB0aGUgUlM0ODUgY29uZmlndXJhdGlvbiBmcm9tIHVzZXJzcGFjZSB2aWEgVElPQ1NSUzQ4
NSB0aGUKZGVsYXlzIGFyZSBjbGFtcGVkIHRvIDEwMG1zLiBNYWtlIHRoaXMgY29uc2lzdGVudCB3
aXRoIHRoZSB2YWx1ZXMgcGFzc2VkCmluIGJ5IG1lYW5zIG9mIGRldmljZSB0cmVlIHBhcmFtZXRl
cnMuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMu
Y29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMiArKwogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXgg
ZmE2YWNhZGQ3ZDBjLi4yZTlmOTBlNzNlNjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBA
IC0zMzgyLDYgKzMzODIsOCBAQCBpbnQgdWFydF9nZXRfcnM0ODVfbW9kZShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0KQogCQlyczQ4NWNvbmYtPmRlbGF5X3J0c19hZnRlcl9zZW5kID0gMDsKIAl9CiAK
Kwl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMocG9ydCwgcnM0ODVjb25mKTsKKwog
CS8qCiAJICogQ2xlYXIgZnVsbC1kdXBsZXggYW5kIGVuYWJsZWQgZmxhZ3MsIHNldCBSVFMgcG9s
YXJpdHkgdG8gYWN0aXZlIGhpZ2gKIAkgKiB0byBnZXQgdG8gYSBkZWZpbmVkIHN0YXRlIHdpdGgg
dGhlIGZvbGxvd2luZyBwcm9wZXJ0aWVzOgotLSAKMi4zNi4xCgo=
