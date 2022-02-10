Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2304B1308
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244382AbiBJQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:37:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiBJQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:37:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6923E92;
        Thu, 10 Feb 2022 08:37:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i14so10546461wrc.10;
        Thu, 10 Feb 2022 08:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bsK/ywYRhNd6B9acdjFBjLw6uCbq8GkPqEAUDJ0Iq0=;
        b=dKXqotWRGHmTw1XcfRMkhaahkcFHii8qzG21n2LAipNgy4+ZMpWNDEzpbEJeTYQjfB
         2PS7C8cIdy+KbfDa/XAdIUZIGf9OTZpEKEe1houLFIrEFPllqY8nrI1pl1suLDqq9blR
         Rf94A2WkkM1GU97wC/Sjpb+Tr2jr2MsX9l1YLGjt7obLRgwS3S1dHX3EYOAeNdMpNfLj
         YwCUdwSwO5USExY+qg1BM7YqIBdzsO6C5oUe08xwXn6jzBHR1tVjSu7EIJD/XM8noSzX
         Ufr5hk0kJIwtVjvmB2t+7LXDH2KvvM39BK4VIhOsbhmjmrfpuCC9hsnQBlZRGZSeQvQu
         06/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bsK/ywYRhNd6B9acdjFBjLw6uCbq8GkPqEAUDJ0Iq0=;
        b=2TEp0LzfuN4sy+0SZgETWJjdgvQ5E5cXm2PL6nas10+F/W4sh2FqN6860cgRuuwO7U
         +G9xEG/TQND5E37M3ObPipdbo1wx/zMlbLN9ufdtMLnxeGlfXe7nVQkwOnMkwjefVmBf
         B2CcWb3Y4xXf8ffhmYslsaptcM6a7zUuuMFhFkTExeaN2hC1LM4wJzmEXiEwkYq/NQfW
         0FA7U9CXpDtNdXau6RdRd3TDBub2+Ns1XgJUh82jFhZz6HRZyt2lRG2znOuTwYbaNsI6
         KdxypEZvwzlLKUaEC5IN736l3W8Km6ML0B7fHIBxuyT9mkMZcZESTluLcoKP8o+b+ubc
         HniA==
X-Gm-Message-State: AOAM530B9Fr/QCRVBjVRaRFnkG4zgqJV1VBysj0EkK5vIQGg3AA4guOX
        WgxJKqjUji7mFcZV44hx9zS1v7GoYCfmvg==
X-Google-Smtp-Source: ABdhPJx6yKBCZ42CNYBGUShy0xul0X1WOmtXVv5/jph8ifV1YyBOgMP7MaAGG9zeGVSjWbKN8V379g==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr6943525wrc.138.1644511057211;
        Thu, 10 Feb 2022 08:37:37 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id k5sm5871795wrw.117.2022.02.10.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:37:36 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Imagis touchscreens
Date:   Thu, 10 Feb 2022 18:37:05 +0200
Message-Id: <20220210163708.162866-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
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

Add support for Imagis touchscreens, used on various mobile
devices such as Samsung Galaxy J5 (2015), J3 (2015), J5 (2016).

v2: rebase on top of the correct tree

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 329 ++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.35.0

