Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15104F1EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380159AbiDDVsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380012AbiDDSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:39:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8631376;
        Mon,  4 Apr 2022 11:37:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o20so3134615pla.13;
        Mon, 04 Apr 2022 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfWRX/jkqkt0fvf3Wi0JA4yvjLY1BhvyntSCc8i0J1Y=;
        b=JfHWB2RWEo56zM1BQLktaCftezUYTofojtiy9/sG/LPR5qvA7O5uWix4/YrC9pyXma
         cnsAWJno+vFhuUiaLIH/XVG++fuLlWi0aSsZw/fNOCjEM2npB4cgUTr33vwafuer/mc/
         GC2LOCt79h/jbxJMiz0TMt0L+JvITdD8b8R7CVuWSgLySFi/1NcQTU6CAuG7Vr+QPViJ
         dplVl4fcXblCjNEXTe3yKyvnKeJTRAwN3PHWEB+9H6zjsHFn5bRi22ajJJVIi3i5+vC7
         sEDagMs/2o09ur4wP5paQndg5Z04XMZlBLviQeQrXvHze17Y7R25bEIB1AMkSM31GJRR
         TrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfWRX/jkqkt0fvf3Wi0JA4yvjLY1BhvyntSCc8i0J1Y=;
        b=rPQIzB4yPzKnrEwtLdjaqSaRz9HhhnQdym0E9dvsHUlCw2Imh7X3wSTQ/77zILzBUV
         XInfmxuWTcEtyOdi8Jvtt4/nhwP1HL5o5FwYaevnO25cd7on4JHjRCbPdg8LJlcsQQZ5
         7+EAy39I9xRPUPa1oM+EOikC0pMM7ZbiyA+cBXC8ODgLd3M22yDqoqXHqzUfKzOuUC0K
         YNKq1wsvatp811n/MqHeUpB/tkDqZ5NrlG06UUPRnHwiNj7vCqcSle5F9fPPFNvUjmnD
         zfMrD/P+fjgLa/1rZdxhb3nvLfgvfOCcRdGJ1p0SzZNcsnlFrNYLvtIA9zr2A1U0RJoM
         afvA==
X-Gm-Message-State: AOAM532CjIvnS2MM4sJCbyMN+cpL4bd6iO0TPlc9tHnlGu7FStxp9e7a
        dyZ4pSos5cjaa7l0dzUyqmU=
X-Google-Smtp-Source: ABdhPJwHeNj0U42J+KBpx355LXxsTk7OFtpC+tfbltPOj47hl3iyaFbY98J7JcRsG1IHsGIDtDHSbA==
X-Received: by 2002:a17:90b:4f44:b0:1c7:9f03:9b2d with SMTP id pj4-20020a17090b4f4400b001c79f039b2dmr602956pjb.24.1649097477043;
        Mon, 04 Apr 2022 11:37:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x18-20020a63b212000000b00398f0e07c91sm8367450pge.29.2022.04.04.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:37:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: bcm: fix BCM53012 and BCM53016 SoC strings
Date:   Mon,  4 Apr 2022 11:37:54 -0700
Message-Id: <20220404183754.2317605-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-1-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com>
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

On Sat,  2 Apr 2022 23:46:19 +0300, Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> Fix inaccurate SoC strings brcm,brcm53012 and brcm,brcm53016 to respectively
> brcm,bcm53012 and brcm,bcm53016.
> 
> Fixes: 4cb5201fcb5d ("dt-bindings: arm: bcm: Convert BCM4708 to YAML")
> Fixes: a2e385f5374d ("dt-bindings: ARM: add bindings for the Meraki MR32")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
