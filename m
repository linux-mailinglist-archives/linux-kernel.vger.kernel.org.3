Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD750C342
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiDVW0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiDVW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:26:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E6121957;
        Fri, 22 Apr 2022 14:18:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q3so13524617plg.3;
        Fri, 22 Apr 2022 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Z+uefvnFWrT0pZ39OKSdS02ASLZ9DpBHMH3b5C53dU=;
        b=BYSiNBZ0B0anZ78AQwcxV5rZDxx48ybN35h5nqlSNTX6g/t/mlCWXICBWb3DM26agR
         FqgIr9PnjNe5l5qHYzKCDAYmkG5WLSdI+rKUMtqFdvGgf9FQkp8LmpNqJ8eh158/+UH1
         8Yeh2+SCSulFsMm5iLf5sVztgt/2Kew53i+26ZDN6LCS5JDmsNZr4WbXyufl1+MwtG4U
         tZQE/Txr7/0DRlNy7levUOnsY95pdrCefQSOor4NdNIjP3W9BSt0PajvY9/QmnfgTGOQ
         KQxqb0NxH97AzlsaqPGe+NN8oYXWx3fpnwATSJ0HAVfPlagL8D6LHPY8Cg/Ql1NsutRU
         RVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Z+uefvnFWrT0pZ39OKSdS02ASLZ9DpBHMH3b5C53dU=;
        b=OwFlN3NHQ4+9UZoQiZBRGgPUaduPgpONhQo31xJ42IPn4dtJUDAFSDT27xBDcy+gau
         q9QUGbY1Gx3Xq2miOtLTBUdGwHeQG1oOs0AfD61KX57GNZ8tCg3FKsbm1G6bd1/aIUXl
         i5qCrxlCNZVMFSzje/29/z1ZN9tmYxTCzdy/DtaXa82r+d4Hm+1AGTry0s1WcW8zlS4v
         hTTVV2fFvxY61McXChGfpf2p3FQ39LLaDZa3L844W5KhlNpXfVRLt3TwY0dQf30xHHs5
         MifLhyUhYcnyaDqsXO/rF1xwaz45QomhsNeXTKvgpIAsCvlZC/NtI9AU8eeRUwJOq/Mn
         Zn5w==
X-Gm-Message-State: AOAM532DkCrFaQ2hPYXGsaIWt3lDUEVTLaNyZay7hZSppSUq7qAgIB2h
        0sJw61xJgaMX5Aft7ln0I9w=
X-Google-Smtp-Source: ABdhPJx7GMxfQ6CDtKtsV5W8yHeMmUDvquJVtCKxvVxlFbf+WnAkrApdnTrXBABxdMg6t37lm8hcRw==
X-Received: by 2002:a17:902:9b92:b0:158:57d8:3a20 with SMTP id y18-20020a1709029b9200b0015857d83a20mr6484373plp.34.1650662322330;
        Fri, 22 Apr 2022 14:18:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm3608508pfe.153.2022.04.22.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:18:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH v2 3/5] ARM: dts: add dts files for bcmbca soc 47622
Date:   Fri, 22 Apr 2022 14:18:39 -0700
Message-Id: <20220422211839.2029771-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413192645.7067-4-william.zhang@broadcom.com>
References: <20220413192645.7067-1-william.zhang@broadcom.com> <20220413192645.7067-4-william.zhang@broadcom.com>
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

On Wed, 13 Apr 2022 12:26:43 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add dts for ARMv7 based broadband SoC BCM47622. bcm47622.dtsi is the
> SoC description dts header and bcm947622.dts is a simple dts file for
> Broadcom BCM947622 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
