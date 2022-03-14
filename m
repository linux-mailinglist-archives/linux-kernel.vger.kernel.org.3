Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2384D8AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiCNRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCNRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:23:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14683F309;
        Mon, 14 Mar 2022 10:22:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so20931782edw.6;
        Mon, 14 Mar 2022 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaBMEcrePt+w27MCrGFS0ZRIBB+TLDUM++NKsoUse28=;
        b=F/GbgPgJJas+sWwxDfEdIEAV9MWpQmQZ6gGHvDgtsLI4ueojnctMqU+Ro0y6CE2jQ7
         7HfL0iW/kaYCw+0kfIOftIbVIwr6QG6MYwB9MVnen+D5b9abOs9torl8wGRAu7pdQm/i
         +FsSIKv3ftoqqo98xW4SbXxB3S9BeXWDR57rNoVIjO2wEh/n6XaeI5g7mVip+Z524Cyi
         KrhWaUk0jLHNnh1HFg16Z87GrqIRn95tDPK0/8M6r/fC5vRSO8jGGlWGxeU4oTOxuv1I
         I6yIkpSjzQalprgeeLcAnrb06WXcdkH68KPhC48XBm+zYHKs2a2WbqNEVl2b/II74CWe
         r6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaBMEcrePt+w27MCrGFS0ZRIBB+TLDUM++NKsoUse28=;
        b=v3BPBKzV6rLXiJ/ytoPCNIJ4uNiQ5M32bomNuhCeXmZmWCS5pe9o0PGc0xZSOTFwTa
         9BRsCNsS5qANzJuuAgS+HXgn8xX678bcx1H7x/U3KV3Dt8VYYKbfbnTrlPfY8FWkNYWO
         +7hLcw/RuTdJeJ3iRrFvfzn3bU2MmF7b8zshYn3llatON251jnsluVnorcDSpIYsQRB2
         8Ac6M6nhugdsFF/YOankJL+6Fl570GLuYsWKQvQchADEa1bZLzvpi1mPVx9qVKo88ZHy
         9iIgdHzefLroM08tYyz3nv74nDphRXOIn+LTgCnb9/dnTdBNtkDgYC+/RmDu1yQZ3Kkm
         h7VQ==
X-Gm-Message-State: AOAM530/2rBbecz0Dd950JG/hZAbEWb8+5WW9UNZY3erhm4e/IA1zjGt
        7JEF1J4kfB34zj9TBbQQhwY=
X-Google-Smtp-Source: ABdhPJyE14lC5sdDZko7CQASEf8TpHDb+WCoI++ZZovUsci3NcAk1M2ARl/8wru+mO0QLzE8MgfoCQ==
X-Received: by 2002:aa7:dd17:0:b0:416:320:5e56 with SMTP id i23-20020aa7dd17000000b0041603205e56mr21902178edv.240.1647278542246;
        Mon, 14 Mar 2022 10:22:22 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm7037886eji.67.2022.03.14.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 10:22:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Ondrej Jirman <megous@megous.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 47/67] media: platform: rename sunxi/ to allwinner/
Date:   Mon, 14 Mar 2022 18:22:20 +0100
Message-ID: <2816975.e9J7NaK4W3@kista>
In-Reply-To: <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org> <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
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

Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho Chehab 
napisal(a):
> As the end goal is to have platform drivers split by vendor,
> rename sunxi/ to allwinner/.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

I would rather not do that. Everything related to Allwinner is called sunxi, 
albeit there are a few outliers. This is similar to Amlogic/meson situation.

Best regards,
Jernej


