Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA075648CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiGCRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiGCRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41776274;
        Sun,  3 Jul 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867690;
        bh=4T+L3fj2rIaDf0LyMh9vktfUXwU/37+/jmdujXAyxz0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FEuqHqg0WG5nVktHv6xCd3W1Ld6jtB5zAnlm/hfeHGjRN6Yvx+WK7KZ0ix1XOe/KH
         Xz2o8FO+6xxwOB7ztgX+NX3bVE6WtFKxUf6wsoQHWizke8Wf4wPpYI5FKUGIAYl1RT
         z0BrGsQRBedJMDB5HbP8B4dl8XpeKYnXsLUIHS2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1wq3-1nRnF52VdB-012Kq0; Sun, 03 Jul 2022 19:01:30 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 2/9] serial: core, 8250: set RS485 termination gpio in serial core
Date:   Sun,  3 Jul 2022 19:00:32 +0200
Message-Id: <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:R+T9lTd5QNKfU/UVz9Zl9hUp72gfyo/5kcqc7ITMzukGKBCRWX+
 igQ4FnN+qs1jxL/Sq2SfxXLcA8lc6ToVFJuQMItUdRh04VQQ3nGqPGCdyhnnzDMSq/XxivC
 rcAB5CHDsNN986vE8DN8LcHJeuOAFeIBGDJw+OzV9XGU1yjia5dPB65u8RL3sDOxMA6b69B
 ajJNcwPkDzRq9vEzlvjMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGcbVIfRMao=:/7A90dMhuM6exf6PSho3Rv
 +HmiAaN/vZ0khcOt75Ls70aICa8xr5x1aDIYtA5WX8oWL08fBYV/C8GZIOoBO5bBjy0ecgd/Z
 isKGaYxm1dVkZCYbIJ5fumRtuJ3qVaLqur1w2YWCeRLma81CJ7IJYiwEVJltmIHPRE+UfdKf5
 UHXfTuE6BupZ247plxA8quuUymIpPsnywZdbCt1LNF087AHBwLsQr41FXXLeJXfnLN9WXp6or
 B0BTzTi7U1SodMU+/Q6C3wttYH766/ZT+OmCg1fjOZjbdtfYm62lC3SclIaBMbOnXcTjzst7l
 WzQ0KgDG8ukL2WTbGiMWt/4c/9le7Dg94H+BhuuFUkqW0oeMOIGDfi1nbWimUkFq8mPyI9yeD
 kkeTzsY3OaxfrlINafetA/H9AckDIXlmrU07XmMQ6bUfZEUJwFALkC1X1e62og0BDBss1wSR2
 s7ZMqSUQ5EVK6SfUxYvJcg2c6iqGCSHa/AlTrmybJG94nCyY1DWkjFnDHLO/Ivjn6NalwdZfj
 Y5J1KcgLwGeKXLZp6cIXYispu+PEX9DGz98vWw1EbBUhd8mHuB/5ytv6ZusUz3LyRWxqrq2It
 gwJ+NBm0p81uKpAFdEU+cKpsnBjTx/lPW5nlZ2H2xcXZWk8u1x0khyT3VOt8xI6UjkGtGHPLU
 TiE0mGBmTPW9tkFhZa+Y0bLcpoLzzPlzqcTi61NNS/uGuOkw7VODOovMCz1khl+PFJVPqzB8s
 xQKpe1YgNFpYAaMiMtyml0B3YDINDsMKTxAFQSE3fnUWV8j+8BKiJIzG0iW3mkiMUi76M5eB/
 AKrMnc6y2FDwGHcR/crZaU++34um5YhKei4KDIcxW2j+uJPzuPMfzFgawUh0OH5koJh36JpaZ
 9S1pabv9aVkZBL6iAngcJK73Qw8pVAcbfcw9A1zf2azLRypkN5qGnq8XzED2UtQAch/WacOv/
 bXJUkQn41u4O9BDyOqkJTNtBgJtFDE2PEzA+CmVKOUzaXeTsBFrqxTF4BzUyxoyX4iNZ5Yv3k
 v7jtFg4PdlSIOzm+5S70okhmX/J8BNd2TUPCeO2fL+cU15TaDlG7TDSel0eds6ysiClwqiR7G
 9GgOI6ZkBqiabwN3VsqOED5hyBNiPpS8ulfrW1YenrA/d21STfPn1kAgg==
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
aCBpbnN0ZWFkIG9mCmdwaW9kX3NldF92YWx1ZSgpIGFsbG93cyB0byBzbGVlcC4KCkJlc2lkZSBm
aXhpbmcgdGhlIHRlcm1pbmF0aW9uIEdQSU8gbGluZSBzZXR0aW5nIGZvciB0aGUgODI1MCBkcml2
ZXIgdGhpcwpjaGFuZ2UgYWxzbyBtYWtlcyBzZXR0aW5nIHRoZSB0ZXJtaW5hdGlvbiBHUElPIGdl
bmVyaWMgZm9yIGFsbCBVQVJUCmRyaXZlcnMuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlw
cG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfcG9ydC5jIHwgIDMgLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyAg
ICB8IDEyICsrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBf
cG9ydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMKaW5kZXggZWQyYTYw
NmYyZGE3Li43MjI1MmQ5NTZmMTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfcG9ydC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jCkBA
IC02NzYsOSArNjc2LDYgQEAgaW50IHNlcmlhbDgyNTBfZW00ODVfY29uZmlnKHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywKIAkJcnM0ODUtPmZsYWdzICY9
IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CiAJfQogCi0JZ3Bpb2Rfc2V0X3ZhbHVlKHBvcnQt
PnJzNDg1X3Rlcm1fZ3BpbywKLQkJCXJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVf
QlVTKTsKLQogCS8qCiAJICogQm90aCBzZXJpYWw4MjUwX2VtNDg1X2luaXQoKSBhbmQgc2VyaWFs
ODI1MF9lbTQ4NV9kZXN0cm95KCkKIAkgKiBhcmUgaWRlbXBvdGVudC4KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3Nlcmlh
bF9jb3JlLmMKaW5kZXggMzc2ODY2M2RmYTRkLi45YzI5ZDAzMWI0MDQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jCkBAIC0xMzU4LDEyICsxMzU4LDIzIEBAIHN0YXRpYyB2b2lkIHVhcnRfc2Fu
aXRpemVfc2VyaWFsX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxf
cnM0CiAJbWVtc2V0KHJzNDg1LT5wYWRkaW5nMSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5nMSkp
OwogfQogCitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LAorCQkJCSAgICAgICBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4
NSkKK3sKKwlpZiAoIXBvcnQtPnJzNDg1X3Rlcm1fZ3BpbyB8fCAhKHJzNDg1LT5mbGFncyAmIFNF
Ul9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0dXJuOworCisJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVw
KHBvcnQtPnJzNDg1X3Rlcm1fZ3BpbywKKwkJCQkgISEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1
X1RFUk1JTkFURV9CVVMpKTsKK30KKwogaW50IHVhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQpCiB7CiAJc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUgPSAmcG9ydC0+cnM0
ODU7CiAJaW50IHJldDsKIAogCXVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KHBvcnQsIHJzNDg1
KTsKKwl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihwb3J0LCByczQ4NSk7CiAKIAlyZXQgPSBw
b3J0LT5yczQ4NV9jb25maWcocG9ydCwgTlVMTCwgcnM0ODUpOwogCWlmIChyZXQpCkBAIC0xNDA2
LDYgKzE0MTcsNyBAQCBzdGF0aWMgaW50IHVhcnRfc2V0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdHR5
X3N0cnVjdCAqdHR5LCBzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCWlmIChyZXQpCiAJCXJldHVy
biByZXQ7CiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgJnJzNDg1KTsKKwl1YXJ0
X3NldF9yczQ4NV90ZXJtaW5hdGlvbihwb3J0LCAmcnM0ODUpOwogCiAJc3Bpbl9sb2NrX2lycXNh
dmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsKIAlyZXQgPSBwb3J0LT5yczQ4NV9jb25maWcocG9ydCwg
JnR0eS0+dGVybWlvcywgJnJzNDg1KTsKLS0gCjIuMjUuMQoK
