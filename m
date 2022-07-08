Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7731C56C2DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiGHVAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiGHVAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:00:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595951128;
        Fri,  8 Jul 2022 14:00:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so17359183pgb.4;
        Fri, 08 Jul 2022 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiJSmomcbHamte6wVYKlfnPmeVECX+cd/OIOwALCfbs=;
        b=Y7JXD9tKxLp/rIH8LwnmsaWTmblzBxuRwjNJQU9DzsYTLZXwkE9MkgSDH+BC66EzrE
         92CJRClPfy1c0dgMzisTNKV3g1wf/wCzQ7rmtQE2es+Nxg1OiU9D9rOkeUulCL8qSe84
         DE9AzAHPjmNc7jAjK94mUht/3RQMOI/vGe9/stlA3pFsDArGxByAo8FwYt59wRtSdTqe
         B/oYaoQtHfgz01k3bd8QKmyhd3yFAAnEEK0QQPg5+TL7AP53RHCCa8OvzAqbybR7pnFK
         OQ3KlVLIzRDRREDZ01js7iwI/yrThtOxacRJkw6N9meMRMB7WeRpNQ/wkK1KmkePaD3L
         iNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiJSmomcbHamte6wVYKlfnPmeVECX+cd/OIOwALCfbs=;
        b=tVj5dV5LqBmkYlAfVcAi/OXBadhieWEiJBPyYiX/xAW/FiX28tH+UhFHpO3qWp9z1u
         n8WlZggMqQORrF3YW7d0Jr9BloRzlf5UauekolnMGQKCNIJzdl0qY01vK3vbh14JmJc9
         sm6QXsxr0sbacJFvIuJWWlIG79ZIxPe0FOooppzmQBTDPgDAct8/ndfEUW6qL2F6R3W5
         VclsSLk1EN5uE50LiFRr64zSpCLQdHgcKdJXMwfCaQoXyiKDfF15afxzskm12ldUTv3K
         TANTIdM5jFSN5tdKavmCl5Ev2KGpzxkyTAWBrY+LMvyjfsKRfIJ3Kq1eTtJcdzxtyT3g
         LaAw==
X-Gm-Message-State: AJIora8QD5wkrJRob9SY13p4JBkYA1oaBL5f6rVh78qMxKAMByv6UfSw
        QW67i7r11LEfqOsaoZQnZFM=
X-Google-Smtp-Source: AGRyM1sDEsLmN38LuJJdCcccO2oNjMj/Z40bKcO+y3pr98pU2dKeP6r07wU+lEsPu7l1hAqbvzljmw==
X-Received: by 2002:a63:258:0:b0:40d:3156:6d61 with SMTP id 85-20020a630258000000b0040d31566d61mr4903970pgc.190.1657314049823;
        Fri, 08 Jul 2022 14:00:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h23-20020a632117000000b0041245ccb6b1sm9576927pgh.62.2022.07.08.14.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:00:49 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH v2 4/8] ARM: dts: Add BCM63138 generic board dts
Date:   Fri,  8 Jul 2022 14:00:47 -0700
Message-Id: <20220708210047.2477279-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707070037.261532-5-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com> <20220707070037.261532-5-william.zhang@broadcom.com>
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

On Thu,  7 Jul 2022 00:00:34 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add generic bcm963138.dts file.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
