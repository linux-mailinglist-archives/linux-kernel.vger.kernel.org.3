Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64155EF70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiF1UXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiF1UVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:21:53 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E33DA42
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:19:44 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso18573841fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9Cx8w0rhio/ohewZOiPkphH/+aLsZ6/01SB1YTtLYI=;
        b=p/DlhyfKCSFPcL6w9AzCO0KMH4C8H0pY9pmF8N8pz/4MoxdZ9EqTAOv7B7NiivqT1i
         SHs+SVVvMAoKIkZkFXfcMNUIvzCweyDrMW5gV3X9Ea9cSBSTo4IrF6DgQfOxlGe5s/2Z
         OzBrony0Z1wBKOBbOxSCO23m4jee23FzMMU8mci9o/dbWsYPHhSPLe4J/DOYYA+xyKX+
         gWci7WQZtiRVCJ3o03NDR7omcHBeCbylncOj1lw4VyZkCF7dFI9+vlV7jO/alpzPSndJ
         KPkatwjdW5hQxBwH6NFPH2p3BboC+z0ZmAFfQ7t60GNG8VltuO3BSuzhuh3KI3mbP8A1
         3+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9Cx8w0rhio/ohewZOiPkphH/+aLsZ6/01SB1YTtLYI=;
        b=jaVq7JmQSMG9i+fkto6uAkFt2j1APFioTghxmVYEZJmnIxPvG9YSeQPCl+quTzSn5Y
         5U13g9LlYakWnhjNqAEGrPhxgrDKR6DAIJefX2IWpnm8w7IplrvQ6HFNuMlG4Xc8KDqu
         xtNzBsMRbroQA8gqvX8ZhnquSI67CrpcItApiAgzJS+4Ag+uYmBHz2ghTdQWB7S+SzDa
         19PbvlpRujHYZvindjFuXPKwf9D94VgCGraV3MhoewhCSz5FFVdInE+qGRX5zQH6Assn
         VXXtGBKQc9IhRS+izgJl1ufqCWwfmN6OoHS8XE1HC730lrDb0TxIXntb0BYS+3AnVH3m
         3tAg==
X-Gm-Message-State: AJIora9nKhHUkWo5Vy8gxEBWloKwn9LnRc+1pyzTW9M5u6fIBniTf++e
        owRssj4i9sMuCsESgObTR3l8sA==
X-Google-Smtp-Source: AGRyM1tk8tFX5leFZcJMH675bmFyeUZelspx+usO0ZdCsH3TSfslgxEJsCegsEWOHJ4em5Yui/hnIQ==
X-Received: by 2002:a05:6870:80c9:b0:102:e5ff:d9a8 with SMTP id r9-20020a05687080c900b00102e5ffd9a8mr965947oab.22.1656447583371;
        Tue, 28 Jun 2022 13:19:43 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:19:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     wim@linux-watchdog.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: (subset) [PATCH 10/11] ARM: dts: qcom: sdx65: Add Watchdog support
Date:   Tue, 28 Jun 2022 15:19:10 -0500
Message-Id: <165644753307.10525.16816165065434330941.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1654080312-5408-11-git-send-email-quic_rohiagar@quicinc.com>
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com> <1654080312-5408-11-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 16:15:11 +0530, Rohit Agarwal wrote:
> Enable Watchdog support for Application Processor Subsystem (APSS) block
> on SDX65 platform.
> 
> 

Applied, thanks!

[10/11] ARM: dts: qcom: sdx65: Add Watchdog support
        commit: 39eebfce4bdb88f53959d570ab9c8956bb9f0988

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
