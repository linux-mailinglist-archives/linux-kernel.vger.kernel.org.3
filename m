Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192704DA36B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349881AbiCOToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbiCOToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:44:23 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DB02717E;
        Tue, 15 Mar 2022 12:43:10 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k125so318764qkf.0;
        Tue, 15 Mar 2022 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKu3nmS3v/LQaqq+B9ZCEnDTqSzm6XtvlIto1bfR63g=;
        b=IdiLmIWpTGfkkPcFEYEnyCXEdwaXrcc0jHbs+91wno6/tbiHYH11hDByy/nk3Ve2hl
         zC7AwvnqUaWq24GX0U1P53RWYxgQiWHKJ9IS8qCi+2Rs0UwbzxPFyftIzl4Um9by/uGL
         CHrirMty3ja03xADwSJedvsxl3JlRrOykHk7QJsJBevTEAJ/zQJ2nyu0b+5MgJB+j06T
         JaoGZaCs1p7E3083HfP5BxlyRziPZwIepmSzoLA54PMq5AcHnBsdd77zk+87INqkv6a1
         3/xbAsco0+ldkOB5M0U/Vw3SBbf8DuJoIgzGmkmkW2Ui9ZTTbBoyjta2+GRlKh6HEAUm
         nBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKu3nmS3v/LQaqq+B9ZCEnDTqSzm6XtvlIto1bfR63g=;
        b=Mu7oEJOcDH+jTMA/0R8F3KjOqV4zzsibBgC6F1AkBJs2JFYkcjIl+kb3xG/kiN/EbT
         OIakWalgFfSl8JzH0s8M2iAgTJo3gpAPgsFuj+98xLSw7+Bq2AAEwJ2F4AdH8BVp1U9+
         rmdRSJI4DzYp2kO0thkNMZ2buOXmT8KQrRg//ONKRozY/znTn/Zd0DkN/YMjKv5l41OJ
         2eTwPYfaOF+kKbVpKzwg5+aJPi1kX+2TliMhSL4CKh/rjC0V1B4aAtrNKQN3wpGYSwm5
         H9Tp1gzoDPD9TnIJwrCFXoSWDewxqY+qjJOqc5RZKosIUMlDkUgNB9zitQEduThp5JVH
         /C6w==
X-Gm-Message-State: AOAM531/U+vMqXp5ODR+uGLPi/IzMjYIlVvKB/I26vJvN0fQUfV0e4Vf
        vLmjeTi0TfU7i+u6iIPMFOc=
X-Google-Smtp-Source: ABdhPJzlbp25jVqpnsN6A8hBbQMbGpKfd/7ew3+1zyP6hYX1+sQXK8h/OBJXT3liWI/7tnBfVCDsCw==
X-Received: by 2002:a05:620a:4493:b0:67b:1eab:7b10 with SMTP id x19-20020a05620a449300b0067b1eab7b10mr19019239qkp.264.1647373389845;
        Tue, 15 Mar 2022 12:43:09 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id 1-20020a05620a078100b00648cc800c9dsm9845318qka.103.2022.03.15.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:43:09 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 0/1] First set of Counter fixes for the 5.17 cycle.
Date:   Tue, 15 Mar 2022 15:43:03 -0400
Message-Id: <cover.1647373336.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First set of Counter fixes for the 5.17 cycle.

Uwe Kleine-König (1):
  counter: Stop using dev_get_drvdata() to get the counter device

 drivers/counter/counter-sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.35.1

