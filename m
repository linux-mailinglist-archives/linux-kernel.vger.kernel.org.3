Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8004B3E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiBMWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiBMWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:34:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54A54BE0;
        Sun, 13 Feb 2022 14:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791634;
        bh=qLYG3ShC2H3ubPzsSwJCdlMrSsl/GQcb1NMteyXFxUQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A4tA82OppBmIjt8/B6k4xEFGXfP9PH82xsLuWBrRi0yxA6c+IDNGtwsu/oymvy2kb
         eggeK0lbLBZRmRCLJL1+fLAxmogiNEtbNQ3M011n4zwE/rkIoMmjynjvqFW4WmGLI1
         SafSW2vu3AdeTvYCNwCXfG+mCRMZ5cy5FM9CdKgU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1nWcsj2aye-00DExV; Sun, 13
 Feb 2022 23:28:09 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 6/9] serial: max310: remove redundant code in rs485_config
Date:   Sun, 13 Feb 2022 23:27:34 +0100
Message-Id: <20220213222737.15709-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:pNx+oEQyE87SI8SUhuYE/49GQx6eFVSP9sCHmwT/ditRcv0ylZN
 rkC/z0D7Q2MUrIrRUkpVmA71yNbDTddrfPtrt8KCP/4yOZ2GPb61Nh3ULguiKqL0WQstrUN
 QGKtvqxZref4S6azX7N1AacR+IVk1yMV8IHdwiZZEUXR+W4Bo/HkFSxPoooN5TYo9XQpjMZ
 K15CBILg6Irsn1kmnCbgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KFVBimZyooQ=:g3yHkv5cYs/FUFqcfKZs9z
 Y2pq5lZjKOPHeUVnvVOrp7UzHqauIgGU7WkACWjIK4T8qR56umvUiZlccERTv1k2vNeSLxdX/
 TwA3p9aA/vIOBYe5ThqRFsQfYRLvhgnjSVQzS6u/RkKlrps4E2pSejrk10GdfADWqGeK10H7t
 +K4lkkGJX++AyPaL4/QQasQFUUJi+ZbYBOIoVDtmIyjhjGiQ93TK8P34L/BQDA12umb3YK1fM
 nqbMwgeTmxb9MNObQ9miQjCXbr/8svARONA17eiK8Lbht+8R05lzzUKMdJub0/8QnKhw7qDfu
 CYwx2vW9kg3UFs+TPcQ34Nx5m0Wwe5ck+T3YwdIH/GvooJ5wNW2+coeCNAvvpbYHCz8AYPBNR
 offq2ubqRZ/ZMvJxOxbRbnf9nM5sn50HYj16dbQvwu696yGaM2r2hHUXjlEODdk9xQYVvZIZY
 cmTeTU/dg7/h+8JwVlZa/3bSMJl67gcjK5i70kqxO4tiphTEz7tXLDM2s48P1WATNJaJjkDNs
 8N6Taq0UhJC6w2BieAft9CuEwvlJGu6lDbiprc8c1mAmZ6Df4nNlF+M6LAcAUjmeBdkgcpHwi
 /QRBdMrnk3l+PPlzonwSpZI4hLtVgcEIPJcsFHVHpJ9DgI12d/TLqVd96zd6jG5La721fnpv7
 DMWMobnWqVOmjKpOgGA6EEzadU4IKD8cOr6TD770H15C5ZIyXeO3N+nLZKrQMjxeHhnF5n47e
 FhpJI5rXqr+C2QtPbLVTTNIHYiqyj8IO5XE340lw+5RoKBrhPKuAMbgD+Am9SCmB8nY5KnMYA
 umV4MCeNhrHXyqIZGj6zg5ygckJyL/N/QTNkZTIjK9tnu4o7eLa7MmftSpvp3xlZL77Wnltnd
 zuD4rIOZunWSPHJtYWpzw+JoLDAzXMwaT9tRdAr/p76ZS1xg9myQzVRXtE6goJJgvbyBcsxr4
 /1jj/uw+hlDZXXoglf87akB8Lzo9KdNIKPWa5MBVUz44DwqXT86iAnJoUpccAU2JmgXg+UTUK
 oBr1iBcqofPTLF3NDQilGRN7hBcWLyeFUgNfxY9iP0xfN37jM8OFXf5oJcSiUMfu7xOddXAVW
 UnK0ShGsRhg6VU=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBSUzQ4NSBpcyBjb25maWd1cmVkIGJ5IHVzZXJzcGFjZSB0aGUgc2VyaWFsIGNvcmUgYWxy
ZWFkeSBudWxsaWZpZXMgdGhlCnBhZGRpbmcgZmllbGQgb2YgdGhlIHJldHVybmVkIGNvbmZpZ3Vy
YXRpb24gc3RydWN0LiBEb2luZyB0aGUgc2FtZSBpbiB0aGUKZHJpdmVycyByczQ4NV9jb25maWcg
ZnVuY3Rpb24gaXMgcmVkdW5kYW50LCBzbyByZW1vdmUgdGhlIGNvbmNlcm5pbmcKY29kZSBpbiB0
aGlzIGZ1bmN0aW9uLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmls
aXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL21heDMxMHguYyB8IDEgLQogMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvbWF4MzEweC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL21heDMxMHguYwppbmRleCBkZGUwODI0
YjJmYTUuLjJlY2M1ZjY2ZGVhZiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL21heDMx
MHguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4MzEweC5jCkBAIC0xMDM3LDcgKzEwMzcs
NiBAQCBzdGF0aWMgaW50IG1heDMxMHhfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQsCiAKIAlyczQ4NS0+ZmxhZ3MgJj0gU0VSX1JTNDg1X1JUU19PTl9TRU5EIHwgU0VSX1JTNDg1
X1JYX0RVUklOR19UWCB8CiAJCQlTRVJfUlM0ODVfRU5BQkxFRDsKLQltZW1zZXQocnM0ODUtPnBh
ZGRpbmcsIDAsIHNpemVvZihyczQ4NS0+cGFkZGluZykpOwogCXBvcnQtPnJzNDg1ID0gKnJzNDg1
OwogCiAJc2NoZWR1bGVfd29yaygmb25lLT5yc193b3JrKTsKLS0gCjIuMzQuMQoK
