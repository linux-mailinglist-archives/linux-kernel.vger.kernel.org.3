Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3A50C3AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiDVW02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiDVWZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:25:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C51D1183;
        Fri, 22 Apr 2022 14:17:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so13528183plo.0;
        Fri, 22 Apr 2022 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIs69itnqTJeqlKrFDJsoau1QLIHqRe/eofrygEGG9o=;
        b=mYxUtDN9scaXWfm+E6bU5B4sSS9GUpu9fNUs9Uz9QPP1aW5Pcubu+vKuZF4UJdTCwS
         Z7WWoYWYQQh0fZDMTUux7kaXglKA1XpPz2fZHn9CcAaGsCY3nnagYNQ360ovgCsQsuyp
         Li6GaPxvLyx50PZRKgPVfXeeyoUYaDQ6B+tVXfum68fBR0bEu2hNaC8Q7nn//KHx9JwH
         i/7PNU7fHseanFM5kkCKkRb9cLYwzElHsfgUcmpwrUpdGuRm4nL8wRN/IsV7NoDNnwU5
         gLPKOF0gh/AqyDXLqacEylZ1Dn5Fch9wcgxvJayB8Q3lwYqHtyLA9aSyGEFLRLlRlOMo
         V4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIs69itnqTJeqlKrFDJsoau1QLIHqRe/eofrygEGG9o=;
        b=eTw+bRSNEOOpFtiICtUWV016Xkase7cai/7cmlIraNaaSVp6D4JIT4UZNtb9zLvfZc
         SE9CP76DXtZ3by4QAeIHFhbGiFRTLae5FfVs6FR1NOSLZk3VrP0+N8eDg9V/gMILHcuS
         R97s2/0obd8Tq7v2UzRn3YW7X5w4dHZabUiJfAPXVrSsAe/qHH4sGOjhJgrlOzHryOXR
         eUK9KaqLFjildTNatzpkrj776pfVScO9UoEAigowiVaXdSZwMVMUT+a8ba4o6jILYrT8
         6QFDIG7t5ASTE3kaW/yExBvsFJhx9n73NvgaE2anGKtHfN184fKIGXLTLEDDlMJd752S
         YIyw==
X-Gm-Message-State: AOAM530T2rSQmcRjBZa6m7BOXtRfVq/rAanDqazfjIDQXxmIHu598SBA
        r92V/fLZLDXjOaEogZo53e+X3hYtqUc=
X-Google-Smtp-Source: ABdhPJw+liyeX/H+o3Zmg1xz8kktgAftPgwKarsZ+4N6K73o+lHC2gagLG+A/W/Rximgzn4rs+DF0A==
X-Received: by 2002:a17:902:a581:b0:154:8c7d:736a with SMTP id az1-20020a170902a58100b001548c7d736amr6558775plb.74.1650662274209;
        Fri, 22 Apr 2022 14:17:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q203-20020a632ad4000000b003987c421eb2sm3046922pgq.34.2022.04.22.14.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:17:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: add bcmbca device tree binding document
Date:   Fri, 22 Apr 2022 14:17:51 -0700
Message-Id: <20220422211751.2029442-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413192645.7067-2-william.zhang@broadcom.com>
References: <20220413192645.7067-1-william.zhang@broadcom.com> <20220413192645.7067-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:26:41 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add arch bcmbca device tree binding document for Broadcom ARM based
> broadband SoC chipsets. In this change, only BCM47622 is added. Other
> chipsets will be added in the future.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
