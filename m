Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C55AE515
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiIFKM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiIFKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:12:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790C33359;
        Tue,  6 Sep 2022 03:12:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v4so10179758pgi.10;
        Tue, 06 Sep 2022 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IZ9wqMiAS8T5F34wY5ClrLEGhUO/wD1wIUmQ3qIVn+I=;
        b=aLLkQR3n+oKSmaaMQrlcldkJKdJ/KPIH6hRMPXFeUFgn6DDr7ubuuwLotvHm8kNb8B
         Ifv1VneVRWMsn9o5cvu1t5bTCNVXrEEhstMChsr0UTfXehVhUcc4ZE1eyR3I1oZANqdL
         JOHMA7yrDeGApvWdyZ4Ju72jisf7NE/6qJmyUOn/aukOCKANAyJ+pIPov81XNa63d2Mi
         SsasReJ9PdPp+tWo42SmrlH1NE61AxH53BUlQxJlGVTOpcpToJ9p8V4MLlCp0A60RhWr
         6qMlRZf4kiaQQYV6Rqm3FB6XM9ieoVPabZQQ2tY+SKIvReW6/VODSu2LnHtF2OVkkdJk
         FNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IZ9wqMiAS8T5F34wY5ClrLEGhUO/wD1wIUmQ3qIVn+I=;
        b=qG3jvEZDdAkSSMTrRB9gxuuyxTR3aI0ypcqv3jQbbholSEoj81s3U+DX5WO9Cf/Zgt
         C9uv57CdGAoMMPU33ve0G4SEbx94CgDD/O29bp+4fFJJyZHF9pif2/fgyINQWl77v7Rc
         VQGGOFN8sRbkxM7qiiQRUWdpB1a6bMtFErFHdoKMAdBX+MhU7xsJazMf5qxcOCWLA6Zp
         yKU6Fg39WHlti/zXBr7JT1uxanB7LsY9zq3Qopb2WcBirSJDyEXiBJM6zBH4cop2GP5C
         pLcn1UN1wxLMYFsrY5FFlvR+GHi2X8z4f+A9d0kkvJkWVI5pRxFPsr6D1EQ82L2BPwrP
         dc9A==
X-Gm-Message-State: ACgBeo0gB1FNl1+cEqfKOZsygscFVknzEBKfg1C2/cSrRGWcJbc/J7fh
        0ZY+W84fc5qJMBe+km1iyrhc0ilKu4On9g==
X-Google-Smtp-Source: AA6agR7RsWMoIhEfMO/PpZo+/t7Fx6lBx03dsKZuqz+hW2WI2JYDyigNhWz05vKyWB/6Ri7IB7rO9w==
X-Received: by 2002:a05:6a00:994:b0:537:d9e4:e939 with SMTP id u20-20020a056a00099400b00537d9e4e939mr52109988pfg.12.1662459172344;
        Tue, 06 Sep 2022 03:12:52 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id mn22-20020a17090b189600b001fd7cde9990sm12532385pjb.0.2022.09.06.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:12:52 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: RE: [PATCH v9 0/6] thunderbolt: Add support for ASMedia NVM firmware image format
Date:   Tue,  6 Sep 2022 18:12:45 +0800
Message-Id: <20220906101245.6559-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Hi,

> Hi all,
> 
> This series adds support for ASMedia NVM images. It is based on the
> work of Szuying Chen with a couple of changes from me. The first
> patches move Intel specific NVM validation into nvm.c and >adds a
> vendor table for both routers and retimers that can be extended to
> support different >vendor NVM image formats. Once that is done the
> ASMedia NVM image format support is added.
> 
> The previous version of the patch series can be found here:
> 
>   https://lore.kernel.org/linux-usb/20220902094010.2170-1-chensiying21@gmail.com/
> 
> Changes from the previous version:
> 
>   * Shuffled the ordering of the patches a bit
>   * Add tb_retimer_nvm_read() and tb_switch_nvm_read()
>   * Add ->write_headers() callback that is used with Thunderbolt 2
>     routers
>   * Cover retimers too
>   * Minor cleanups and tweaks
> 
> I have tested this on Intel Thunderbolt 3 and Thunderbolt 4 routers.
> ASMedia folks, can you try this also on your side and let me know if it works or not?

I send a comments in separate email please help to modify it.
I have tested this on ASMedia USB4 router. It work well.

> 
> Mika Westerberg (1):
>   thunderbolt: Provide tb_retimer_nvm_read() analogous to tb_switch_nvm_read()
> 
> Szuying Chen (5):
>   thunderbolt: Allow NVM upgrade of USB4 host routers
>   thunderbolt: Extend NVM version fields to 32-bits
>   thunderbolt: Rename and make nvm_read() available for other files
>   thunderbolt: Move vendor specific NVM handling into nvm.c
>   thunderbolt: Add support for ASMedia NVM image format
> 
>  drivers/thunderbolt/nvm.c     | 385 +++++++++++++++++++++++++++++++++-
>  drivers/thunderbolt/retimer.c | 105 ++++------  drivers/thunderbolt/switch.c  | 162 +++++---------
>  drivers/thunderbolt/tb.c      |   5 +-
>  drivers/thunderbolt/tb.h      |  30 ++-
>  5 files changed, 498 insertions(+), 189 deletions(-)

Thanks!

<p></p>
