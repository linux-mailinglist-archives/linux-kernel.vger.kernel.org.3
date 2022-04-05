Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9E4F20EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiDECVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiDECU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:20:57 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2941530CF2B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:15:49 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-e1dcc0a327so8259120fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWQUbrOoxwmYB9P20ebLb/ZcAUVjBSaCgXPVioGRjas=;
        b=CdxPyPtRsQI/ntlcqty+gtnhuGMgiR7GNZNYORSTfB8oyttAskvRfIPJte2S68/aId
         kBJgOIbwWAIwfYHwvrFjMc+9tORlpgSkmBLgiKiOyHqkNLllo/3syT1M9esqosWn+TZG
         5qInbalMfrcpR1GA8o5jR6wlkDOEEGKrG+EKfdwf2JSENsYSXGniYsXuoeP7ANXynrv1
         FioX+4H2NiQ8HriinLwqzAWM/yfCmAzrMtpiliqXVKi/Rl2J3s90GbHTDRz3C5VzkiJz
         UxTF0ULgLfKihJSkJl6KpYztEHx1RhDz/NRzYRCYrJ+U6Nmc/4qucl01xKrFwwiLTZhM
         iJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWQUbrOoxwmYB9P20ebLb/ZcAUVjBSaCgXPVioGRjas=;
        b=drC7rAgkEVcAMFrtmfnD+vFtNsWkwzAoVq+wrb/MBAkSWyw6t8kmdci3iiuFdw+UJ4
         mt47JHNSsUVS+XdLs1+wOZ+fELo1kRlXM0ClFK2W7m+mGW6zGlLfhoSACpWeJ8QloytF
         KTFWIkappEXH8+y4u85EA8mKAd3L5JsZ59TASls0TVrIjwgMXVKHolWr5pSB8zx5/Zte
         EIot+oQv9MWOVQNpBqvTaGPXqtEmEgsO4QDQ8/9SxmMa3UCn2sY+2yAg7BS3WROscuem
         f8O1SihxybLFWdtZLJY6pwdjVsc6L6XxFD25jrSkN15mZt9aF4offmmqEN+QdjHOKscv
         RepA==
X-Gm-Message-State: AOAM531vitM+R0LMZ3Lz0vGCTFvSoKJNpccLU9faW4kD48Frv3nLMbmY
        J/DqHgvE4cyIJVE+NQJ/iVfgGaefbbVuIQ==
X-Google-Smtp-Source: ABdhPJxcMNezG2Fs58i+G61lJGk2QRFQEXlhF9qXgjmBY8ZPaxWu1kvZpTBfEcM+ikqzAlk3Td6Ulg==
X-Received: by 2002:a05:6870:5690:b0:e1:ef0c:271f with SMTP id p16-20020a056870569000b000e1ef0c271fmr533129oao.234.1649121050266;
        Mon, 04 Apr 2022 18:10:50 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d644f000000b005ce0a146bfcsm5075033otl.59.2022.04.04.18.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 18:10:49 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/2] staging: rtl8723bs: clean up two *_cmd_callback() functions in rtw_cmd.c
Date:   Mon,  4 Apr 2022 20:10:42 -0500
Message-Id: <cover.1649120568.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
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

These patches perform cleanup in functions 
rtw_survey_cmd_callback() and rtw_joinbss_cmd_callback().

Rebecca Mckeever (2):
  staging: rtl8723bs: remove handlerOS independent comment
  staging: rtl8723bs: combine both sides of conditional statement

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.32.0

