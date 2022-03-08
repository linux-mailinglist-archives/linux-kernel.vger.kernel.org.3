Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E34D1634
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346476AbiCHL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCHL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:27:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F2A443E6;
        Tue,  8 Mar 2022 03:26:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r10so28014975wrp.3;
        Tue, 08 Mar 2022 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dqty/TsmBq2P0dxufcWyURR/ltsPmc0+kvmHNye4yXI=;
        b=BHSaqjEm2Fc29hKVgZGSOyhtVWgV9cM97zb5nQX25Tr+TVY63J1xa6uz1HpH9Yi1qC
         y6Gv+v1bl59rRt4yN7LEvM6IY1N9Gp9PkpEL0z5C4Ul0tS1aI++Q1/TbZZ0e0O4YKAku
         JDO4xmq3sqRV+/sSjq3+EkuJteX5Xx6S143R3W/gnLJrQnxZnQTqL1LAsT1g3xmtEemm
         qxjbgg8N7X4l9r2QdQlO9V397S3KqXF/6ogJ6gk7BLIk7WkKT5K7VpBXOcRn3pIlZes2
         c08cxVKUn2FkF9nTV8nFUDEZxibMq19SujyuVaGbUGeySu93zW1HAuI94wUOKVxuFnkK
         eZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dqty/TsmBq2P0dxufcWyURR/ltsPmc0+kvmHNye4yXI=;
        b=j4zRSif5vQQIUB9kDrh03wg0Jl2Tq5q5erUiN/lxrc8cW98tWqer/hRHqYpr0cuLGI
         Sk4bg0xMJHlvNyQxxwP6ZrpjQ/pIM/hUs+3gNbtDwPPC/woeROB96xBeTGLWQQoeNAQR
         r3z5DumyYHozplavua+SQtefxaR9EPWH3LGIZqTx+V1ne2RPUfKGY5c0tAnhcdivZkop
         SRW5AUs/gjxIphlKFRQmEGge8T2/ynzu/w3j7yRAkY6mCtpLXVGlJLexU1O0td9FF4lx
         k9gDiI3zImtqoSaowQvm3fAqvLxcWtZunJ0Oz0DeJQJ7PchHfRfaxCFIQw5HejUjm4yz
         FGiA==
X-Gm-Message-State: AOAM532rVeDljYcKINcH6x38hiu40uQbcdjA6+g4GdEGUYrE15/fenA4
        yz31HkUJHIEVxtEk84a6B0w=
X-Google-Smtp-Source: ABdhPJznvKM8N9UDgvVSyNbUsEqfibtuEC8ss6x9swDX0tUbsU7FGuqpbqsuPawzfYW+3oRNUEvsZw==
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id v15-20020a5d6b0f000000b001e79432ee8cmr11448484wrw.216.1646738805525;
        Tue, 08 Mar 2022 03:26:45 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm14141215wre.22.2022.03.08.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:26:45 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] MAINTAINERS: minor clean-up from device-tree conversions
Date:   Tue,  8 Mar 2022 12:26:28 +0100
Message-Id: <20220308112630.546-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

please pick these two minor non-urgent clean-up patches for your media-next tree.

Best regards,

Lukas

Lukas Bulwahn (2):
  MAINTAINERS: refurbish MEDIATEK JPEG DRIVER section
  MAINTAINERS: rectify entry for MEDIATEK MEDIA DRIVER

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

