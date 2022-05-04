Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38823519FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350001AbiEDMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349977AbiEDMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:52:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC10366AE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:49:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dk23so2664616ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZOr4HtGpaWrCWq6twhnfSIMm+TDbavFaWLE4oY5Z9c=;
        b=nDXrvhpETmVWGr629uSMqiX19ijYfRXKXMhGz8o5tIvCP8S9zxByN1mXXSY4xpoyTF
         jIY9vEofi63VivguJwzrnZNRqBW7uDuHVGNtAWDnzg4vNj4H2/zyrb0QptxtKV8gLC1F
         dv0FOA9BnfulRLlZab66QXb6HOMz27lWvJIcOv3yF31liu7NCeh+j9BrInw3No6No0Uz
         d9qp5fioReOska3ktJXacTPQ6LTbdnbYSe4vg2Fe96CAXuIjRPmUXLKUB9znlaVBAAot
         UW6WNL/GzCT1Ezrs0i+ltz9xZUWqgynEtu3Y55k7MXOS1CqpSn6V6FWrEpjaVq8skmIW
         9LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZOr4HtGpaWrCWq6twhnfSIMm+TDbavFaWLE4oY5Z9c=;
        b=UwUziZx6xk4DSWxOazpkeK0psl20SiAQcF0wNhAo3yihWatgyLFam6LWszUUaGKTLw
         J4Gr8NTxhMz5fSAY3rgzzPFbGky75YYSFOKZF440EHS4Cvc5hsht0sqHbMePp2FpGfiB
         e39o+/9ZOPxXtM36Mus0Unaxpkcq9oIwWCJtEcjhncaqwhkcG1VDSX+8r5HNU8uGurlk
         iROcoOOMnZPSotVNGlyPK2TeGfE84Jzzq/UKBp/NRoMMGnxZ/YrFbrV74AdBksUQhZVI
         X+1vulF9PeCSBOlvz+bMK4L8pwX/xj+m9iaxc0XIg0nAeCuQxzESvhdIg+BJDnmY/Ady
         olbw==
X-Gm-Message-State: AOAM533nnosoNjGdlu5tKej7hanO2NqSSN1LKB/DqM/Wya2jJ0uFpKjC
        LBwQqp6LF8phRAzthKlfg5k=
X-Google-Smtp-Source: ABdhPJx71yCTi6az8xLbfEKhVrgKgdLuPPk5NgAYoOUVtjv92KGGf6NaeuVDVDWbkMzcbOmU89I5iQ==
X-Received: by 2002:a17:907:2d24:b0:6f4:3152:3d1a with SMTP id gs36-20020a1709072d2400b006f431523d1amr15972250ejc.324.1651668549151;
        Wed, 04 May 2022 05:49:09 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id qr48-20020a1709068cb000b006f3ef214e0bsm5768686ejc.113.2022.05.04.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:49:08 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>
Subject: [BUG] New arm scmi check in linux-next causing rk3568 not to boot due to firmware bug
Date:   Wed, 04 May 2022 14:49:07 +0200
Message-ID: <1698297.NAKyZzlH2u@archbook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

a user on the #linux-rockchip channel on the Libera.chat IRC network
reported that their RK3568 was no longer getting a CPU and GPU clock
from scmi and consequently not booting when using linux-next. This
was bisected down to the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/firmware/arm_scmi/base.c?h=next-20220503&id=3b0041f6e10e5bdbb646d98172be43e88734ed62

The error message in the log is as follows:

arm-scmi firmware:scmi: Malformed reply - real_sz:8  calc_sz:4, t->rx.len is 12, sizeof(u32) is 4, loop_num_ret is 3

The rockchip firmware (bl31) being used was v1.32, from here:

https://github.com/JeffyCN/rockchip_mirrors/blob/rkbin/bin/rk35/rk3568_bl31_v1.32.elf

This seems like a non-fatal firmware bug, for which a kernel workaround is
certainly possible, but it would be good if rockchip could fix this in their
firmware.

The user going by "amazingfate" reported that commenting out the
  ret = -EPROTO; break;
fixes the issue for them.

I'm writing here to get the discussion started on how we can resolve this
before the Linux 5.19 release.

Sudeep Holla has already told me they'll gladly add a workaround before
the 5.19 release, but would rather see this fixed in the vendor firmware
first. Would rockchip be able and willing to fix it and publish a new
bl31 for rk3568?

Regards,
Nicolas Frattaroli


