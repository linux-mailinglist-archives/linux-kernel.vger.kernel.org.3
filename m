Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6935A5305AF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiEVTwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351111AbiEVTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:52:07 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B09B6F;
        Sun, 22 May 2022 12:51:48 -0700 (PDT)
Received: from asfdasdfasdf2.riviera.ds.pw.edu.pl (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 348C41FC90;
        Sun, 22 May 2022 21:51:44 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Date:   Sun, 22 May 2022 21:51:38 +0200
Message-Id: <20220522195138.35943-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

removing these properties will not bring almost any benefit (other than making
some checks happy any saving some <200 LoC) and will make the lives of almost
all people doing independent development for linux-on-msm harder. There are
almost unironically like 3 people outside Linaro and QUIC who have
non-vendor-fused development boards AND the sources to rebuild the
bootloader on their own. Making it harder to boot is only going to
discourage people from developing on these devices, which is already not
that pleasant, especially with newer platforms where you have to fight with
the oh-so-bright ideas of Android boot chain..

This only concerns devices released before sm8350, as the new ones will not
even boot with these properties present (or at least SONY Sagami, but I
doubt it's an isolated case), so other than completing support for older
devices, it won't be an issue going forward, anyway. But there are give
or take 50 locked down devices in mainline right now, and many more waiting
to be upstreamed in various downstream close-to-mainline trees that should
not be disregarded just because Qualcomm is far from the best at making
their BSP software stack clean.

One solution is to chainload another, (n+1)-stage bootloader, but this is
not ideal, as:

1) the stock bootloader can boot Linux just fine on most devices (except
for single exceptions, where beloved OEMs didn't implement arm64 booting or
something)

2) the boot chain on MSM is already 3- or 4- stage and adding to that will
only create an unnecessary mess

3) the job of kernel people is not to break userspace. If the
device can not even exit bootloader after a kernel upgrade, it's a big
failure.

If you *really really really* want these either gone or documented, we can
for example use them in the SOCID driver, read the values from DTB and
compare against what SMEM has to say and for example print a warning when
there are inconsistencies or use it as a fallback when it fails for any
reason, such as using a newer SoC on an older kernel, without updates
for SOCID read (which are sometimes necessary, which was the case for 8450
recently, iirc).

My stance is to just leave them as is, as moving them anywhere, or removing
them at all will cause unnecessary mess and waste time that could have been
spent on more glaring issues..

Konrad
