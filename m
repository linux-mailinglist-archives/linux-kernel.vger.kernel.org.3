Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F46F56032A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiF2OgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiF2OgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:36:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3733E2F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:36:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h192so15529751pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Cg1pbA8vIKsss/kduipyHmYHYgUtQpcCeOfwW78IFgk=;
        b=GcMt/zaitMPYugutR+SZbG8M9T/N16kxs59mw5xfHrWn3wgmjtCps6KvZUculXB/zP
         BMNQHYek++ptp4nFdFap2MU2a/OQvy9lEtvJxjQjEvwj3DRP2+QE63Wzslc9YzV3aPnS
         s/E/AzNQsF+oHLGpZDQw5pnOZ5UBcngE7pQzWIfRrXvKSVfh9GawDvVB99rYE+wEhDDE
         ZNZBwV4f2if5FBySi+9K2gXfCZau0UND++tVj2U2t2OVAE7D3VxT8G2wAl+b2C88+UCU
         vBWpBhC+bNCptN0X+Q7TIIHyWf9wmpvfJVrC3ct08z2tjf57t+HZTAwwTyJSFNufpJDt
         s/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Cg1pbA8vIKsss/kduipyHmYHYgUtQpcCeOfwW78IFgk=;
        b=3MbZ2PrmOaZTxZL0mkcN52yW05DqkDNLi9NES/XKWW6GS4sMG6smO0utrdcWq+30bC
         D0Vx6OMAv2ClbNQUzlB1EVE75J77OOrH+kqle3p2wPPTlt3w5Uv60HJ0udJnSz60yqiA
         JwXvAiZ5Clv9mJvWNixK2xqN3xG9apv1sLqbjpZw3vmjxZ/4XW0H7roSMzm+UxQrv859
         aAN0zbvy9UFxQwQZZYK8t9pAC1ahYZM6T8ZHMyvB+W3CU9wHi1PanlwXfRZFWjTjt2Fs
         xTqXn+0uLnjdY58ox2sJjOaCOXOKUD6G6DyBFIv4MQ7ngXCzX7nEygDDRac1uwYeXRFr
         LJWQ==
X-Gm-Message-State: AJIora8t953NbSShrfj5J4f0d0OF80bNcZc9mOn1Zhcs1mZB0OeZw8/u
        aTOTVLKNP7u6uvCbtKfJJBLLq0ADizpu7w==
X-Google-Smtp-Source: AGRyM1stm4fyWSf7REgYqTMd1NfRqcl//TAv1qlj6MdBpHhH4uFqSyO2ypVvwasYllN/edw/OpgRlg==
X-Received: by 2002:a05:6a00:1748:b0:525:4731:7f11 with SMTP id j8-20020a056a00174800b0052547317f11mr10798576pfc.72.1656513365429;
        Wed, 29 Jun 2022 07:36:05 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902f14400b0015e8d4eb2d1sm11335911plb.283.2022.06.29.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:36:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     sunying@nj.iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
References: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
Subject: Re: [PATCH] block: remove "select BLK_RQ_IO_DATA_LEN" from BLK_CGROUP_IOCOST dependency
Message-Id: <165651336468.5627.13656015345010304082.b4-ty@kernel.dk>
Date:   Wed, 29 Jun 2022 08:36:04 -0600
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

On Wed, 29 Jun 2022 14:24:09 +0800, sunying@nj.iscas.ac.cn wrote:
> From: Ying Sun <sunying@nj.iscas.ac.cn>
> 
> The configuration item BLK_RQ_IO_DATA_LEN is not declared in the kernel.
> Select BLK_RQ_IO_DATA_LEN is meaningless which could be removed.
> 
> 

Applied, thanks!

[1/1] block: remove "select BLK_RQ_IO_DATA_LEN" from BLK_CGROUP_IOCOST dependency
      commit: b9a1c179bdfa133d28ab8b7d30631b0accdc2057

Best regards,
-- 
Jens Axboe


