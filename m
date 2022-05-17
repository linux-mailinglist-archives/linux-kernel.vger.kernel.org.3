Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98A52A491
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348730AbiEQORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348671AbiEQORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:17:00 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307827FCD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:16:56 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 009983F5FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652797014;
        bh=amqAY6a7uXQ/wQEdkz2aFV8cXJ/9YzvYuaPpxxw+q7Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bWtB1BdEIfK0c1ZKH3IgcR6gAs/KglR7Om8jdw06cwhpGAk7Nq/KrIfmJdp31jOjY
         iYAbVEaYy++EABgTMqxgeEJzKpL7dV4hnnl17cJXiq9Rw8FLi+nhwDDXBzcMtm+h7b
         roKhwJG2ygALof16YF+iyXFLCoqbr27dFCcUHaxbo7HdYROYzsFECady2OazDghKZM
         IQ5ag22sHqn85FLlxUATZMLCAIbKjl6B96/18/ZRZzjmqPumIvU09a9PIgAx+vzpu6
         axM1cNbvLIbK9nZxs/lHuNhSMNnNCrkdhgUo8Gg6HCc9dBKEQyI/qHLvlrnHCvAm1N
         6+FxmdDE0zDfQ==
Received: by mail-ed1-f72.google.com with SMTP id w14-20020a50fa8e000000b0042ab142d677so4122371edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amqAY6a7uXQ/wQEdkz2aFV8cXJ/9YzvYuaPpxxw+q7Y=;
        b=N+hpt+B4AjbH5fb8KzUMFs2K2n3N4mioadCXna6hLAPI3i4ieZHpHz8Fp2QzAwZ0un
         N3Vb9VDfRh6qrjFcaPeeaW0v6XiXfD/kwrLKguaDRJsBkL/73VjC+n0QYzUy36T08S1+
         bIpWhHQM63O/rLFswOlhzQ6gYGAAk78qNQ5KZucajNJI/q+RTa0LmWKD60y4beX0yMe/
         cXFvHYNmNJZPOQMI7sOLk/DM3Bea24Jls+bygRX8s7iUJPQYjhSKcKg8ERJxahH8KFtK
         CGVbJu6sne05q84GegGFa0RuStSyCaS6XPydRc4oajrOnEUlxnJtDrXIatMqAM9w0Ve+
         09Ig==
X-Gm-Message-State: AOAM5305TT+FzE8ngz/voKJlGo+PgfYFNNvShSxGUaFFfH0aSEzhf75B
        uSmf1O1wna28l/O9okQ6SCAsD96aA5vkIwLH/A07WgV982mwggtGVoegLS0IWBz6uKR+nVSKRSU
        emvPY8mHoUa6zKZNyeYW4z0HPyJQiCI32iSqMd5pI4Q==
X-Received: by 2002:a05:6402:388d:b0:42a:ba9f:f85c with SMTP id fd13-20020a056402388d00b0042aba9ff85cmr8333380edb.292.1652797012297;
        Tue, 17 May 2022 07:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWqmUr3EfSZZVLUvlRBufZdHAW5+JbfxPJcgeJBp6Kk7yUuKbrIK7KXP7YPNiw+kSP4ald9A==
X-Received: by 2002:a05:6402:388d:b0:42a:ba9f:f85c with SMTP id fd13-20020a056402388d00b0042aba9ff85cmr8333360edb.292.1652797012077;
        Tue, 17 May 2022 07:16:52 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bo3-20020a170906d04300b006f3ef214dcesm1065035ejb.52.2022.05.17.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:16:51 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/2] arm64: Kconfig: Style cleanups
Date:   Tue, 17 May 2022 16:16:46 +0200
Message-Id: <20220517141648.331976-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it:
  - Add trailing comments to endif/endmenu statements for better
    readability.

Juerg Haefliger (2):
  arm64: Kconfig: Fix indentation and add comments
  arm64: Kconfig.platforms: Add comments

 arch/arm64/Kconfig           | 95 ++++++++++++++++++------------------
 arch/arm64/Kconfig.platforms |  2 +-
 2 files changed, 48 insertions(+), 49 deletions(-)

-- 
2.32.0

