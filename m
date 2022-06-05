Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB053DC54
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbiFEOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbiFEOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:47:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0B5F52;
        Sun,  5 Jun 2022 07:47:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y19so24508413ejq.6;
        Sun, 05 Jun 2022 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBIsXGbY8qzdmVdRG0nKGJg7amoZ7ILl6oOXlyqXb60=;
        b=iWa+1jKG9G3Up2EliRgZ4ssJICeh/IJNELApuPwwir95Uk3X/4GHv/zNkeNzig06QV
         7NX/86WrFcODdNGYH5KkPgtY2rVUgz7bL2sRBSN45Hb6wEiIXtBn3OPWAdk3OX2wMhmQ
         LFiY3/IZK3bCywL2mPKd2UyVoE+q/lCLoGhVQ5l9pKExP3GD683OopVeJnIz3SN6TYjL
         ekdhzeGqx55ZR/K9puO0723qK8+XA5PawLQkIMYN5YOvDyQWf8I/gsBd1E0whK5j8aSm
         qirJmWy9JrC4a4xXidXlyZ9fc27czuj58+EIkJXX/fitLPQ2xq3CWExkZnC2D92ckKeg
         czQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBIsXGbY8qzdmVdRG0nKGJg7amoZ7ILl6oOXlyqXb60=;
        b=ReCpJQPY2wJNK4Uzw9dQWPIjAipU5S6XC5aSr0FRWhxp6i3khthA83qJznHd3pz8hl
         UYNWdzRSgH6s7Rn7iyTpfDU37pj24KJB9ZMCDyLEkEb/skv09CLbJlztPu1PPzQjNJEv
         KzRrqwgUvRmNrC8HwqGUpxgIXqoy5SWvJX6hY5Ymqlwetu84O9QgS+ZbodlORTqtJrVN
         V5o6KJnZwo13ngsUfJjHQqIuytvJ5BhJRCMGHj8ue+Xi8hknYmZeyqQizO/g/ABGE6tF
         MFyzVf/T2t75u9po2PnSY6rPzj6dvkFHheT6EnCMit2tE21+KxrtpX0dm4feoK1kVHPs
         Jzig==
X-Gm-Message-State: AOAM530Tv5AUuH7cN4iM6o0jGO2XtIX04NfxYkEmfnMvkT6UagekPcKp
        NIPLl8+VjF66koho6VSV1q+d/5PaYF4=
X-Google-Smtp-Source: ABdhPJwtbzSygrfg8J26Ll0HKKJrZ136lFyfLWT8+j9T/qMsK6HzB9UJh2Quq3Wi9mKEvBjr6Arjrg==
X-Received: by 2002:a17:907:1620:b0:710:40d9:a384 with SMTP id hb32-20020a170907162000b0071040d9a384mr8670633ejc.234.1654440445037;
        Sun, 05 Jun 2022 07:47:25 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b0042dd4ccccf5sm6854254edv.82.2022.06.05.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:47:24 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v2 0/4] MAX310X I2C support
Date:   Sun,  5 Jun 2022 17:46:55 +0300
Message-Id: <20220605144659.4169853-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 -> V2:
 * set_ext_reg_en -> extended_reg_enable
 * move extended_reg_enable functions under guards
 * move if_cfg structs under guards
 * remove __maybe_unused from max310x_i2c_driver
 * fix order of error labels in module register
 * guard i2c register error label

Cosmin Tanislav (4):
  serial: max310x: use regmap methods for SPI batch operations
  serial: max310x: use a separate regmap for each port
  serial: max310x: make accessing revision id interface-agnostic
  serial: max310x: implement I2C support

 drivers/tty/serial/Kconfig   |   1 +
 drivers/tty/serial/max310x.c | 261 ++++++++++++++++++++++++++---------
 2 files changed, 200 insertions(+), 62 deletions(-)

-- 
2.36.1

