Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5ED578870
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiGRRaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiGRR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:29:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173A10FE9;
        Mon, 18 Jul 2022 10:29:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r14so18124434wrg.1;
        Mon, 18 Jul 2022 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8P6fzDlj93zGAanL5j63jQH4jkjUjd03Bh+brTNrS50=;
        b=EJ8zo1BaxiyDnK6+1dbpxjvOYzzYkEI/qVGt4euU1RiuEgumLw6+zN0MoPIprceW/A
         OlK5ZP+CwEQKELPA5lCDZgsCW5eHtu+X5MynHXIqSFVy6RM+PNal/no1eNpm5uexd1Xd
         X5QMBA2ziV7skLTJJFqxJP44gH5cmHRKYYaGG5F6Qzli6e4e6RSaCQsBbOCaFAsp3l0D
         49tXCsnKrLGRsLSkuxGvrGoIuC4x90mK+Mj0EYoHxSrMYQ2YxtkbpIgZHTiicna2PENF
         vyauXxAzdM/I8Iq9n4Av8FUTuZAIX0am+nbiCFivqjNovySSDXYz0k2RnoOUVWDOBYjg
         aFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8P6fzDlj93zGAanL5j63jQH4jkjUjd03Bh+brTNrS50=;
        b=pmAxaDHgTy84t9qFxe9jiVoJDYnZMoUBaeQEzCAxdqXQLMROf2wdQXU9xuSCigcr3s
         DR2iy3/KPExlWPy+ublidzK6zDtLoRJsVlR9FXQPJ+zG1AFYiZ+qCCOPtgHRVZ8rMoco
         BgI5D19KYUCRifNHEdjsf5pJMPUU3paHMrKzPexEfUGB0n8xHHEAXUyC2DXjf7e7WBte
         NJdoDJ3ohDp30akVL4f0n2JeQoByJruvth8iGNnONyEXh+pGZtXe6lsodi9X/SFs0E0D
         P7lnfJ7GvwRiQpnPXJNV8f55c6gX8gjtwjqDHGO5BcR3LBHN4vVIC+Lf3Xgcsf5B7Z+T
         Il1g==
X-Gm-Message-State: AJIora8XZ09/8j7WukAb0Zi8ak0OYrLrcqg5c/ouU8zvI5Ka/p75jRR2
        +FHpjF5AU9nRSRg4j9ncj7mX7KdLR6FbWQ==
X-Google-Smtp-Source: AGRyM1s94uT9jUPW7kdH6HLFA1e6HRnqISvSgcXZgyfeQPBDhMdc4mKrragi9BAI7KiYrNwV9K0rhg==
X-Received: by 2002:a05:6000:1c01:b0:21e:2de6:817 with SMTP id ba1-20020a0560001c0100b0021e2de60817mr301480wrb.570.1658165394572;
        Mon, 18 Jul 2022 10:29:54 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id q5-20020a1c4305000000b0039747cf8354sm15716613wma.39.2022.07.18.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:29:54 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     spbnick@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] UCLogic: Filtering unsupported HUION tablets
Date:   Mon, 18 Jul 2022 19:29:53 +0200
Message-Id: <20220718172953.6817-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

No code yet, just a kind request for comments and hopefully some wisdom
and experience from Nikolai dealing with HUION devices.

HUION keeps reusing the same vendor and product IDs for their devices.
This makes it really difficult to differentiate between devices and
handle them in the kernel and also in user space.

Reusing IDs could introduce a problem:

If HUION, or other vendor following the same practices, releases a new
tablet with a duplicated product ID, the UCLogic driver would handle it.
The device might work with the existing code or it might fail because of
a new feature or a whole different firmware.

As far as I know, at the moment there is not a mechanism in place to
avoid this situation.
I think that it'd be better to ignore those devices in UCLogic and let
the HID generic driver handle them because using HID generic would
provide a basic user experience while using UCLogic might fail to probe
the tablet.

DIGImend's web already provides a nice list of supported devices:
http://digimend.github.io/tablets/

So, I wonder:

 - Do you think it makes sense to ignore untested devices?
 - If the answer is yes, do we have a better option than checking the
   device name against an allow-list? It'd be great to hear other
   people's ideas.

Best wishes,
José Expósito

