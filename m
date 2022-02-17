Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15E4BAA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiBQTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:51:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBQTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:51:36 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240812E150
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:51:21 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v19so45421iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=2dcA/6gLsbKZFB+WFymwOUXCsSuxQfOADqfv4IvAXoM=;
        b=cFCQfnHS3K/DlP8d1VPqSnCTbKx1iZzVkmolMF3s2DL60iDMsfY0vKXnLMGOccRkeT
         UuYVsWtKkULwOTztg03a2tqHRIkuywXZPj7y9ddFOWdbLmrWLm5ydStyblCFQ4aNFXaZ
         hDBVTNzMNknv20XeKtxuzX9qSE3Vna5LGZ71HdSTM6tG+6kukaLTnwQDzinDt2Luf0gA
         ibGLuOe87F5D3M6bom33jI/utqryc8i/bDNdaTOzPBzKXflsN992SAtWLZw611wyCUBf
         z1mzh0NionythAlC6SNcokdK9SsiZyK8tvgoASPV5+2KELSPS6Q2+fATauRMl55kbYD/
         74kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=2dcA/6gLsbKZFB+WFymwOUXCsSuxQfOADqfv4IvAXoM=;
        b=Vh8OccY0y49tvC51ofwL1ZLC4PlmRi+TBSM2AFA8B4tDXv+WWTZlQoPVY3KcFyCE0j
         1/Q5q54iurZScJlGKLzr4c8cXcwtAUBLp9QacL6sA9sd7B3YocuiBGMC4r25X/KHi54R
         A9z2zWu8FS/pYZrSl2jknejqBAVSewHOiYKLvSWkHfiutgTWsGCr+fUNjErgY5IBkacj
         ZwrwreBaDnP83YMggeWUsLHNXg8lvUnwb04VQRsC9XWbf2dgMAkG//PT10BbWB1fGgWi
         rrgZqvJP1peZPNTYD2jK9mSpf6foUtjnjf8GG7nNjchVWK6HhZQB7/UWjs9HXoBqPOIE
         CTeQ==
X-Gm-Message-State: AOAM530RbsND43VzkZ9NGQP2Aa6lUYMdAJdzhbaDrfvF9mFvtMtmVn0t
        kX/cNR77V1wNop5OkkmVamhezQ==
X-Google-Smtp-Source: ABdhPJwAzxnstaPx9fMxE6NFTg1pXbvI/p9jgna6qP/N+AALouNmT2tdhGwFdWp3BiOOrXE7cqCPKA==
X-Received: by 2002:a05:6638:d85:b0:314:81d4:2319 with SMTP id l5-20020a0566380d8500b0031481d42319mr3002441jaj.105.1645127480506;
        Thu, 17 Feb 2022 11:51:20 -0800 (PST)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c24sm197351ioh.40.2022.02.17.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 11:51:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <bd7c0495f7656e803e5736708591bb665e6eaacd.1645041650.git.olivier@trillion01.com>
References: <bd7c0495f7656e803e5736708591bb665e6eaacd.1645041650.git.olivier@trillion01.com>
Subject: Re: [PATCH] io_uring: Remove unneeded test in io_run_task_work_sig()
Message-Id: <164512747966.22697.4097732498015286286.b4-ty@kernel.dk>
Date:   Thu, 17 Feb 2022 12:51:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 14:53:42 -0500, Olivier Langlois wrote:
> Avoid testing TIF_NOTIFY_SIGNAL twice by calling task_sigpending()
> directly from io_run_task_work_sig()
> 
> 

Applied, thanks!

[1/1] io_uring: Remove unneeded test in io_run_task_work_sig()
      commit: 9e9d83faa9f59266aa772148e32c265c8ad194d3

Best regards,
-- 
Jens Axboe


