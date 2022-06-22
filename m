Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C59554FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359498AbiFVPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359075AbiFVPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208553A5DF;
        Wed, 22 Jun 2022 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912842;
        bh=P76JCAoBEwYxagrCxqz0x5UalaF1hec9VzDLAcDAK90=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gI1K62Ac1Y8Zx3itipz4l03G0B4VpHAqQssoOhMy45OJHJ7d6vl6R48KWA23w5wHX
         lLpcQtAu5Z9rWcNJ3tME5m7Xum9Y/CA553ucU33xukIAk0a0rh5Ww1jYD9CkfhF0xb
         OHrcXkxYHMChG59WJajHANGnes5KYp99xt9wn8f8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1naV942eE0-015Fq4; Wed, 22
 Jun 2022 17:47:22 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 8/8] serial: 8250: lpc18xx: Remove redundant sanity check for RS485 flags
Date:   Wed, 22 Jun 2022 17:46:59 +0200
Message-Id: <20220622154659.8710-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:WKHLwSJiQn/lE+w+iwlvUVlY+hSjpvhwDHxzI/x8AFxyiTj4QCk
 GTI2fk9fSpQP3EnqiPKgLA/I98tb8vKF0Q4dwXlGNBk+RnRJLkvLOrJCT6JkraJYyX6hvfP
 vss2kjip1uOIBclB0Issx6scJCOIPxFsNJAMk229SIDjibTBwNB7AZyWoVlB4lRWToVKN2K
 d8myOgdT/Z2X1ICVbHXYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iVH+DtPsNl4=:I3yIIZMg6ftu/BPmnCuV47
 yr8woBxBq0n/NEkF8Th+CcdZiXC7vlGyp/DN5B2FPGur7o6AD7/UwSCwFC2WWldf3HpK6OraY
 evL1IQ3wIeTMr5JCtM40+ZHdHTLlcvRwcuCWeGoM/CiQsWG88IrqJofXafcbYofa+QKC/oI9L
 pmXngFqXuXxjkbJ2PKUg5Rp3Zo85K16r1yP1QghTo1I2xmvY3m/T/Lc3GvKS7J6XIhHHZdYBF
 9OzaTIur2dtfwY+Lbl+QGrlsb3ktTV7vodgPnuegX53RClh4IZrvTgmXSM/Y/mQNwLz+zfhBC
 eMr0c5O1pwibXgELsJcJ8RTCFDQpSuxV2rOXjS+95feRbXLicHC7fFIKDquNnvkH+mwAcnmxz
 neQzO8FAVdvlwHRC7xyGO0GXMnGK1x9JTDvsnLZ98nCC2K1/myWxTM2FPPOeOTB1ULtIkXbKM
 hW8k66Tj2b6vHr9QVzNB0AEipTEf64Aeq+MCMfty+xgj9TPu+WeIgn4OjD53jQ0M3cnjCLFSR
 BMvhayoW0tLe7ByS8THdHvKlVD9cRasuODbeO3jEHj52xUUtXiegDK50ZGp+FQ4qHqCfQenLW
 iV4Xi9E7umRJQ9hs5pugWESRDR8jSDF9DcM38ZNfaTQaNtG+QAequSopBEmdNawhDl52X8AiD
 fKbSe3wwSvJ0Z2TwwaZqR3/vjsVEy1WJhkYXgJwO8m2lrcLdAMI17nC6k/qL10m4kyEsyV+u4
 IpQbpuAybwIOQ9O3yM2e6m+xfO+r1tAOUxlkzv1ZrRsvrcx00oPNPJrq4zgObvsu/zi76iQZd
 TeGcZY8stRdVkgGhiDln3yQ5LxmqSWr4i9zIcJFz0zfsobOVbHPx2Wo3c+zp4Qo3d2WvKMC9S
 qKHcZngglEppklaE/EDJIX83T9lPMDdg2yI9oWCHxLYDvguUFYIg8xcVE0mWIkEQcRILkVxvV
 k5Ualh/6T56zYez6mbthhUVMnCfMtJCkdAq2PxJbyJYovtnPZpa8Ce8vYjLUKWppwDmK5FHDv
 JXG7eX2lcdFtWpaHT7R5y6uoXJBngAj48KDaqlLvRd9d+h+2xy63+q/HpgurFGdhAmyCayLSR
 bDyfDbXYqaQ1UyRrhTcSQwcbo0ELvbYfNOLdMgV/G0PN2Ko6+H/mfLWcA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJlZm9yZSB0
aGUgZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlvbiBpcyBjYWxsZWQgdGhlIHNlcmlhbCBj
b3JlCmFscmVhZHkgZW5zdXJlcyB0aGF0IG9ubHkgb25lIG9mIGJvdGggb3B0aW9ucyBSVFMgb24g
c2VuZCBvciBSVFMgYWZ0ZXIgc2VuZAppcyBzZXQuIFNvIHJlbW92ZSB0aGUgY29uY2VybmluZyBz
YW5pdHkgY2hlY2sgaW4gdGhlIGRyaXZlciBmdW5jdGlvbiB0bwphdm9pZCByZWR1bmRhbmN5LgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
LS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYyB8IDYgKy0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYwppbmRleCAzYTFjYjUxY2JjOTEuLjIxODk2YWRlYjE3
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMKKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMKQEAgLTQ0LDEyICs0NCw4
IEBAIHN0YXRpYyBpbnQgbHBjMTh4eF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCwKIAkJcnM0ODVfY3RybF9yZWcgfD0gTFBDMThYWF9VQVJUX1JTNDg1Q1RSTF9OTU1FTiB8CiAJ
CQkJICBMUEMxOFhYX1VBUlRfUlM0ODVDVFJMX0RDVFJMOwogCi0JCWlmIChyczQ4NS0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpIHsKKwkJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4
NV9SVFNfT05fU0VORCkKIAkJCXJzNDg1X2N0cmxfcmVnIHw9IExQQzE4WFhfVUFSVF9SUzQ4NUNU
UkxfT0lOVjsKLQkJCXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwot
CQl9IGVsc2UgewotCQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsK
LQkJfQogCX0KIAogCWlmIChyczQ4NS0+ZGVsYXlfcnRzX2FmdGVyX3NlbmQpIHsKLS0gCjIuMzYu
MQoK
