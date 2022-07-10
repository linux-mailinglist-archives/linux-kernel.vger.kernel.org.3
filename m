Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A21056CFA0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGJPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGJPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D1654F;
        Sun, 10 Jul 2022 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465413;
        bh=0HR3Zv5yqKQt68jtTzgddRrz6zgVoGHjCf/opyPjVSw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C/G0Dw7qLGqe4pItHN7TBRQgbs/PiZ6WZmsjY77bzdOy8aRoex3cAlp/o+l8oDNKT
         1VoTaZg65/UBaeghR3QT4R0ODfTiXEwtJfWQ3XRD3K+ziqk/l5Or7iBOKowu8TJlSL
         QeVgD/QnMuqu+ezRQdUkR2ylpQyLONjApqfcubFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbzyP-1nZq8p3OYB-00dVRC; Sun, 10 Jul 2022 17:03:32 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 8/8] serial: 8250: lpc18xx: Remove redundant sanity check for RS485 flags
Date:   Sun, 10 Jul 2022 17:03:22 +0200
Message-Id: <20220710150322.2846170-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qzHu4PvDz5P895faBhT9BuPeJF1PRRW2iLbjX8PmLgdI3/snLgi
 OxgKGpRySgUOvEjEysXvo6BSJ+waB04FeaK9eEMhMcIphKa1UL3KezetcBHkQt8dhMZRqkh
 wE5d2J57eK7Q6oDU46JdGPpdgW+StgBq6HYTJkzdeTri8RZQS4Cxx6PG/iLTzyqz4qKuln9
 uqZ3mslLu/zf1Nmp7t7ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8RXqQFDDp2Y=:h0kmsp5HdQeZBg5mCa/jYk
 nCEoVbztb6K5MOvE5NwHK/QFB/XXRNsHL/zRXpmg0+35ERHRPnM8IFB9OhDhqaZ1o5CDVrNXr
 t6jyVaSibtvBU67ujv+tZUxjHUc31nSN7+pymtbzwaujGoR6yU5oBZ0mlfBeGMWBt/bc2gLEa
 HmhRqedM40KDObOWJ6CjahS6gjlHmDqHcNmn1aIt/z8BJ8lza2lzVaqBvFg1AVrWwKeqLA9Rx
 Tu26xjmzAfYhCxB8JO1pvNC9QfQ+tsNGqgl+87jQqlavkanVSv2MI+k/NWme+hfTzJRFG+Plu
 GFL3uozPyYGZdR8zFjjWgfqoo4YSSO3JlcXCSE+xGeSdN7BbnYdhLccp8Ohkv8GKh2YBdy3uQ
 nLimuRhpRkk4QYUtE5rgdvoYC0zZZ1ap9WDiWqhcHLUYPNhIJlb+LSosWZHTl8eSf0RAokyrx
 y0zYRR9yfoSEAsWecSKdFlC+VzOyafpEhxJqcsOWQOJOVlJlRAeW5W31qXGj70PAKzMXMWu9R
 DTXiy4M8H+ckuIdF/KFunJlVQk0nzkPppR+wcq+4S4D12jps8joOxRfEBn/INlJgB5gXtDov8
 JLrh0Nz0K64wD1XKuRdMoPHw0IMV+v92xaf4fjkCO8ZxOGlmw0kna/qD0sef022BQX/+tode9
 LiU8gXHX7W+62xiFCZ8tF2bW/1bKzu9pf3wlW7XgaokQJ72NBP80GWKKoPdiuaN5KetdYHaId
 SLWkSWMbK5nGiyTONxoOa85SEIXx1OwBl16NffFXqGR6wQhOY6/RtR5CwlzC9DVxxS/5CHfRK
 3CltWHs5mnqogsH/JeYG6tjJHZLY4w89+5fhxx7WcGaOvAL/tHCSTYqLfrIWwD/N20I53Uffy
 +B+17T9IBVkCt+m3jrOCr8dTj76yAgrTOEzKwxA/wADi9/mkjAq7TlOqqNYwFFPpwFml6pj6H
 eoMbfinI0tp37P5i/4Eat5Lf98sMFe8IvSOp+0XuGIeB4vIgaQ7d/mRWPExr/uidpKVIOITgH
 G4pa20OwDZa9sHuqd/Mc0lTOPviDIRoXQ/tFU82vdv8NZjt611UsHjPv+X4JlYoJSiNd3t1+G
 6wTklg+guCEyxOfjUmdth6VCWnth1ZQtWpBWqnnJI3PiGlT4W7Bfy0LgA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
UmV2aWV3ZWQtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNv
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYyB8IDYgKy0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2xwYzE4eHguYwppbmRleCBkNmNhMGQ0N2U5ZDUuLjZkYzg1YWFi
YTVkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMK
KysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9scGMxOHh4LmMKQEAgLTQ0LDEyICs0
NCw4IEBAIHN0YXRpYyBpbnQgbHBjMTh4eF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zCiAJCXJzNDg1X2N0cmxfcmVnIHw9IExQQzE4
WFhfVUFSVF9SUzQ4NUNUUkxfTk1NRU4gfAogCQkJCSAgTFBDMThYWF9VQVJUX1JTNDg1Q1RSTF9E
Q1RSTDsKIAotCQlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJ
CWlmIChyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpCiAJCQlyczQ4NV9jdHJs
X3JlZyB8PSBMUEMxOFhYX1VBUlRfUlM0ODVDVFJMX09JTlY7Ci0JCQlyczQ4NS0+ZmxhZ3MgJj0g
flNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsKLQkJfSBlbHNlIHsKLQkJCXJzNDg1LT5mbGFncyB8
PSBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JCX0KIAl9CiAKIAlpZiAocnM0ODUtPmRlbGF5
X3J0c19hZnRlcl9zZW5kKSB7Ci0tIAoyLjI1LjEKCg==
