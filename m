Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1794F0C44
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376271AbiDCTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiDCTTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:19:07 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EACB38D89
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:17:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso3904345otj.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ehcFmg+Mkg9BnKgNhNCCaDn3+8UpDGuCPAmWgTV0xw=;
        b=YKTq66ofeUUwKoqp5vOZiShoH+aW48zisWmikLKh+2/pNnuy+Sq3L5f1JfYnmq+rND
         YikeRuZquyRGJb55UpvV8eB2GWRvSKBpPfc4JAWJctpfN4Kv5tou9Y8Gz7i8PwQ5SKHP
         R4tfxSyasVtG80BeJCjd4qryX2ZIS79aZDOPDKsUUAEagXD95AkzWX+Jjij2mZikYHQN
         pHJcRPeisrDgoY5Tlwq0zxCMLhroapa0bzZt0c/7Qr6unzXe3PyqcT8cr92ROYyFzpnE
         gIsZbGPyZj99+8GHK7/DFDOR5cAryDy6avc/49z0c0dry6oh00xshkW0/0gBpwAaj0wM
         ZGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ehcFmg+Mkg9BnKgNhNCCaDn3+8UpDGuCPAmWgTV0xw=;
        b=kTKgCHC1o1be23o9k7xKdv2GH2mcp6Jl9XyOxgqy7iat4wfmN1H7pNnecQq3Os58zW
         sCp5R79W0qzu01JKHnOoe8cx3stGmibMMCKbd8SWodljUYui/B5NT3m7sm/rdBGQVcin
         rlWSGuaGNjEeO9gHa9RsymrE01stCkl8kSNSJ77JKrMhoi+t4xzZXHDKyDl1asSNfeXy
         J9E9S+nsufw206YMUolWzpuONYdivEQfCw/2QiPxbZAdqkBnX9nCtU/6e5N2YjKchXvQ
         C+Dq2Ymv0qEZrfkWx/kg1xAlepIv2Y+c5qq5Y3U8b7HDHuRvfgH5m0WspZk2duxojkXN
         6FXA==
X-Gm-Message-State: AOAM533Z68E6mi9nvWJccTbzjvcbvmXJ5UhMZIjTPf2OAZ7VmzX6P0jW
        XQW6rOy5sSH+plOLO4VC5ao=
X-Google-Smtp-Source: ABdhPJw341HdbepkpPDc7e7UxbgjrgppKpNGL8k43XY3kuFhgG+2GIpXxIszbSIiJu7No+boSil2mA==
X-Received: by 2002:a05:6830:1e8d:b0:5cf:b0e6:82ed with SMTP id n13-20020a0568301e8d00b005cfb0e682edmr4231382otr.177.1649013432655;
        Sun, 03 Apr 2022 12:17:12 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id m23-20020a4add17000000b0032489ab619esm3208837oou.45.2022.04.03.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 12:17:12 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up two *_cmd_callback() functions in rtw_cmd.c
Date:   Sun,  3 Apr 2022 14:17:03 -0500
Message-Id: <cover.1649011311.git.remckee0@gmail.com>
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

These patches perform cleanup in/around functions 
rtw_survey_cmd_callback() and rtw_joinbss_cmd_callback().

Rebecca Mckeever (3):
  staging: r8188eu: remove handlerOS independent comment
  staging: r8188eu: combine both sides of conditional statement
  staging: r8188eu: add blank line between functions

 drivers/staging/r8188eu/core/rtw_cmd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.32.0

