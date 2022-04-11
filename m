Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F64FBC44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbiDKMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346166AbiDKMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:41:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666C3EB90;
        Mon, 11 Apr 2022 05:39:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c64so6048115edf.11;
        Mon, 11 Apr 2022 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ud08G4s/0xjBy6Vv4C3jyp2d/2WCW9Z15cTVyED8BKc=;
        b=oAOIW4z3DcQ4J+Ql7KHgqtzw3+pKUPC7cpD+7xpymzdsGwvSaTmGEiNYL2PkWK8jo1
         lIK6flFSiDB+bVC0erzxMvJ5hiRhVOH7v5NgTfmygl/4USPlyr4BLpgAVv4JcW/oVmFa
         SM5VFQbf/sALbUd4FOrS5tKrOp1ZM2JXdkMidunSGOHNZYEAxqWHMG0N+x45H1c1pCwF
         EYEVThL665B7y2jrXTyDnKCKbp5BP7YvXICJaz45ebjwUSi2uILVdgSnW0qOYHbYkYyT
         Uovkv5zGkRbkP59Z9gXhCdviBPUZmSmtmZA1mlLSeKClDOyy7+1bFyKAgEbsf6S3b85M
         7c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ud08G4s/0xjBy6Vv4C3jyp2d/2WCW9Z15cTVyED8BKc=;
        b=2pevS1HF4mGQzf/D4Q8Rfirh39OJEeQ10OnYa5X7nWCxlBHHnpYKF/3ItBO79KbN00
         72oLhHFS0tJR52kbFNiTip7AJY/1L+G7YTrYFxQQb5qNVBnAelfHH47mrQUKIRaOHTqR
         UQBaWAYOBbZOaeszJzJtuKPyzeXHTTSGSvayDwi5aM762bQa1/bzQAiVhTB39MJm1X3Z
         fnuAuybaWpi6aGSW/S462mcakwzQvTBrDnGQV5u3bSJzvhSmBAJX7O4T2xjmQzs+F88L
         DmPCvqA9LRW5XBTBiRoKy/pkIg5x3u2VPfU/dnlmOK/Wvdf3mRXsBI9myOAGwEjZzZho
         bHqw==
X-Gm-Message-State: AOAM532ib+DoAOiL1Zkwwl/8O5l+WPGjdPCnrBnyldcnPLiArqLRMwED
        iMONqhBZNpxFkJD+ayNay5N+xqam2VA=
X-Google-Smtp-Source: ABdhPJyKXVNmQUBaNyN3MN5SEMx8A8Il7pcI0GIX+S0c4wogac6dfMFHedHThQkRv9cnv1j16He+DQ==
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id f20-20020a056402005400b004199b58e305mr32680114edu.158.1649680762381;
        Mon, 11 Apr 2022 05:39:22 -0700 (PDT)
Received: from ThinkStation-P340.. (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm11898283ejo.190.2022.04.11.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 05:39:21 -0700 (PDT)
From:   Daniele Palmas <dnlplm@gmail.com>
To:     dnlplm@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, mhi@lists.linux.dev,
        quic_bbhatt@quicinc.com, quic_hemantk@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Sort mhi_pci_id_table based on the PID'
Date:   Mon, 11 Apr 2022 14:37:15 +0200
Message-Id: <20220411123715.3640935-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411054831.16344-1-manivannan.sadhasivam@linaro.org>
References: <20220411054831.16344-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),

Shouldn't this entry be after all PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306,
ones?

Otherwise will it catch all of them?

Thanks,
Daniele
