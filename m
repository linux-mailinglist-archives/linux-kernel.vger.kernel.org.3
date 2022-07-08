Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7256BDC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiGHPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbiGHPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:43:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F91B74368;
        Fri,  8 Jul 2022 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657294976;
        bh=LxjBud0pbj6Z4Eq/r+3/joMtPqsu/Mjab1CevPT32tc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AbOcPy0Dhc7Ur2U+z5DgjDcxZfEyRCqOq1m8/rbekBNgJ46L8zbEvLwUljmPRKgHo
         DpYzrqQvTWTADKnbUkfP1OCUz1NFOMe3/1IKZbgnW9S+elC01HsqEJbJnCihQ0D+Oc
         xdv5abBKjxBMqrMFHzzDxm/UMzJGwjw7l2K/oPzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.69] ([157.180.225.69]) by web-mail.gmx.net
 (3c-app-gmx-bs34.server.lan [172.19.170.86]) (via HTTP); Fri, 8 Jul 2022
 17:42:56 +0200
MIME-Version: 1.0
Message-ID: <trinity-1229008e-eed9-46b9-aabf-50e771a91c77-1657294976401@3c-app-gmx-bs34>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Aw: [PATCH 1/2] rtc: hym8563: try multiple times to init device
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 8 Jul 2022 17:42:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220608161150.58919-2-linux@fw-web.de>
References: <20220608161150.58919-1-linux@fw-web.de>
 <20220608161150.58919-2-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:eYEslrPQul6J44xzmHHk/3xmC6KuJA7Heccjpl2RqtLNl34uQdZejcik6wNxcjiiaGl9y
 WunmLARJSLizOFAKsVsIUnR9qBbjXrDZCt4ywilMkn5s32ymh0EG/7kOAp2YfAOVfh/STf27TkeM
 6UtMSXPjzNhyeG/fbIEixpVyzT0P3szzX/AhJBy5irihPkBgHAHtFS2tDGi+ruMeBxjIneV7Zccb
 jABvxQPc9grlvqZcfra26S9PoQKEdZgAZlUKdt9jyp5yX7S0n2gBik9xAkSJifH0Nc/xOA46hcr9
 78=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jya8o0eFnhA=:z+ETFPOwI7vQPoDCD86Vlm
 lOn0RMrMQABH1oOjeXWkad2uD5Sf3uKoLGAFXAR0UHcRiuS64PLaKO+PwQfihY2ExD0TocrL0
 9C7ewaVAKkI2m3DkNZuM9XssfDsrElECv+5FhxMEN9Uln15E/6LhXj3VoGnlqivJoraYgK2KN
 BGOzuBCJn7fBRZt5il4X8MVyHdNYLkWiR7LBrXRBXrlLBucIuQXdRr/C7cFYXABCiRastRJ5N
 3WgxO1jIFwmUdtEHFNkePlG8/PtXtHCycTQoyVOkGhjcqg/C+t97tEGZQOmorDOthPGOwFGUN
 oZjQrOZmHjrt7s/PQtHHdnDpgqk6TO9rLVq7xlRigk6DtFqY7xgW6esaPoXK6jJcSHxtkcM/R
 kTAV6bzyEcezt2/1EzAnh2tngNDPewvgig0DN3nl57QDmKC6Sl7qyh//A0jbup8b+5QKMnKJF
 oOWVdHjD8nUYaoLbjyFt8KKg5rRlXR560BhnIv8qxTaglcqLKraMLXazl2I+TeIOcrmXvqlsH
 R6FCBqFg6wlgusF59z3U0VLlbC+/5CZHASB7hQekW63pxi+K+xHMX8Om59pRL7sW3VaAaITr7
 lUXFHdeo1bURD0Vkt9k84kDwCLbdW4mfVo4cQyXVpHxPr8i0bkoVYA9SmHELRuyeR+B3fp+VC
 gIa9QS3Tl32Lba8ma7mrlcox5zA49a0AyJX6SVKjQNYGt6OyeEUy8pkWB99YHljJkKjcg5h7u
 CTvvGpmGjJ/9qpCLeAmi6jLdffsAZC1e9wj8fMz1OI259B3sSR/aO49Cx+CjWPHYjsJzCDB48
 6KRzDAc
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a gentle ping...any comment on this?

regards Frank
