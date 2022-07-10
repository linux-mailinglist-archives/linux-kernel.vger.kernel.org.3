Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4C56CF9E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGJPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGJPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:04:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DB4656C;
        Sun, 10 Jul 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465410;
        bh=8FT0ij9jO2V6dVyym1DjOHi++3Z/BUIKRaGKBNPBHZ8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j1NDK0qIJSgyoyQmV338pTIYOvQ6MoHZmvrGTE4EmRaq0EK0k6hXp0LR16Bu2iYFa
         NlRG+VpcQyy9QdG0yM+yAxjerCCYcqE2VR6f2HxcHq5zflGY7Dmpc32tCuR2Eropbv
         9JQlLewzSIKnl8HgsfkLjQr5N/+mU7Q2P5zA5+RE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N33Il-1nRUPH1Vxl-013O1Y; Sun, 10 Jul 2022 17:03:30 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 3/8] serial: core, 8250: set RS485 termination gpio in serial core
Date:   Sun, 10 Jul 2022 17:03:17 +0200
Message-Id: <20220710150322.2846170-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qrz8l9nuTB/MvdivY3E4Gq67uW4qo5owht5uptPokpBMWVbqBdB
 gu79o5AcnqycxmjkNIKQ7S4LsmUbyZg0DR1jcf8ASWKU4xy2r0Z34N37xrO1xtwNHVtNCpO
 5/3cWtbSvTusl5UvUGeJ2dq/6MjrMTFxul+nqgyegdAI5EhLQDhe8TKqXlGlM34GADCSjOX
 59bKhFgdWc150BauLLcWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:99l66P87yug=:6330KW07YlG0wPh3HArFB7
 ngV5mGsIwIlZWOuQ5XA8irS1dxOvPVwy4p4conwKbGjEnGU9jns8Yj4PsCcHjgvdSXayXGZRc
 nxm5ih3cQ1AYXJ3C7VaU2SiBEPb9hgZxU+O/gbHJMRlPeyE2zKI0iEciSpEpM8DQAG9YzwvLk
 xj4MOnU98TII/DFm4CrxkjJVYQACaAh4OvF5ypzds1x1KzI7O5516h9L7Z07Uo58flqy7gff7
 rJx20LCmauC1CfNo5NDKCkJj67JS189scZ8lmrwaW6hsRAoBGzLHwq4IfbLGvZH8BprP8Czjr
 scka1uAaYtagPpgKsDSEThMKcEp05iDMtI1zcVaotDV+Wdthmb96MmxUxxB9ZAdr41eHFjuz8
 xui4L9YDcE2oWDazNYJs0YDDI0RH5ZipHVbFPqmJJ3EtzvxNh6oy0G0TBDoMS3GSmGuptcR4d
 qaky/u15vTKjmFven38P16tlFp3dKWnjo/XArpMX3goCVyKa/It9JO7kNvG089mxAsDQXvGxP
 E8fKdK/76OeHW2stu3WI6oFKzym4kTSXVT2l+CbzWaVtMwTkNFhQhHzBzcZSYCzb7jdU6auQ/
 5b7WmZp/FpM62xFuGgaeCM8hvrGATdzxj0l97EZwpOwazIRqAAWwiBckAkwR6peW9VLsB2tDD
 M7smwAKv4OFbNh/exRard+fOzanyNdda5jbJru714p3KAmOngnGZwWARgS+pVBBCd9ZKYOIw9
 TT4p3PckA2Sfpc5GHFEjdaUt0D1AsXNgtDOZyAGW/Ra4puDZ4LM9EQZmF7LgEMxP5R8rf/DYZ
 io2LgEqrXKGp4GYzwzz3sVPVjmzpuWWyhfLTmUUVL+5oAIrJwj/V2HAHJmRmH7D4qz8nrnEpO
 cd+lQOLL7+0QNxpfAH0CDzC5O/MAy97u4t2r2Pnf2mBb6Xp+eYsk4J0gipTGQsr0mvhvPlO8O
 5l2p++rKCCshWslRnYXXTgWi75y+hrjgug9Ln6FI2lIChqYzZ5SB+uhHMVGHjgLjEL/2zuUEo
 soqIFti6fPLEvnSG/NXFWF/f//kThn142/mVisrYHANovIOXkzZW5Bt7RmPV7kEVksjw52oHC
 uNPDYG+bTFlGSJwHemoOqdreYjEC/i/QfRyZzVdrtcemMNacv0wpXpvvA==
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
cmlhbF9jb3JlLmMKaW5kZXggMWRiNDRjZGU3NmY2Li42MTJhOTc3ODgzNDEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCkBAIC0xMzU4LDEyICsxMzU4LDIzIEBAIHN0YXRpYyB2b2lkIHVhcnRf
c2FuaXRpemVfc2VyaWFsX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJp
YWxfcnM0CiAJbWVtc2V0KHJzNDg1LT5wYWRkaW5nMSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5n
MSkpOwogfQogCitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAorCQkJCSAgICAgICBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpy
czQ4NSkKK3sKKwlpZiAoIXJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKQorCQlyZXR1
cm47CisKKwlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfdGVybV9ncGlvLAor
CQkJCSAhIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUykpOworfQorCiBp
bnQgdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIHsKIAlzdHJ1Y3Qg
c2VyaWFsX3JzNDg1ICpyczQ4NSA9ICZwb3J0LT5yczQ4NTsKIAlpbnQgcmV0OwogCiAJdWFydF9z
YW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3Rlcm1p
bmF0aW9uKHBvcnQsIHJzNDg1KTsKIAogCXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCBO
VUxMLCByczQ4NSk7CiAJaWYgKHJldCkKQEAgLTE0MDYsNiArMTQxNyw3IEBAIHN0YXRpYyBpbnQg
dWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAl1YXJ0X3Nhbml0aXplX3Nl
cmlhbF9yczQ4NShwb3J0LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBv
cnQsICZyczQ4NSk7CiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwog
CXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCAmdHR5LT50ZXJtaW9zLCAmcnM0ODUpOwot
LSAKMi4yNS4xCgo=
