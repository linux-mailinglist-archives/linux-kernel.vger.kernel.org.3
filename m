Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F645A8906
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiHaWcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiHaWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:32:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0744C6D9E3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:32:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k18so9678855lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dTwAMPh/9V/Am+K9PM8dwE1AGq+3RYvXPgc7SOQjnXU=;
        b=AwCm+X3GWpKn0gfiVI5YDWhY7Hf+771k/0DlcRP6gYXp2EXsCGfghmTJ4IKa/KFpIS
         ndqIV2Ht4wC63q6JXp0jzti09VE2ztBngbuRXiGlzbegYrDG7GLZ5jjxBI9UU8gUbaG8
         R+7dCpnkZoa4bYVwZoIQJk9HwWhKNr68vv3LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dTwAMPh/9V/Am+K9PM8dwE1AGq+3RYvXPgc7SOQjnXU=;
        b=IId2OCL1Ng7mVOd2bg7+2HssmqP9pV3pYR1KLSV5BD8wM+2InOTjffPrt8JWbhMw9y
         GwprSBWBB3zxeKi7Oju8DyjXd+eH1ERqfHaS2Vu81DDdF2m1wF6rkU5uGXp1ul4Cuc3e
         BPidTCC2ZwtaizWTSOTOvwjnl45wkEVeaE0fzJImmq4kXlL27ZqMIZxesdFDyq2R6pmM
         InootpqGQqNqPLM8yPuNsor+TRZzC4pL1t72ApsXb9WBwU+FEdDmj8/i4aR7HrUCRcN6
         FZ1iYJdA6zVxR4ee/VCUOOG7G6yP03iifpF2XDggDHxNz1hqtVPud1BD93Zwo8KtaAcD
         hWCQ==
X-Gm-Message-State: ACgBeo0vj+la4mWgI6YR9MB/uW+uCeUqUaygI4nzFbrZWnaNeqaa3X/8
        UbA2Dwnhr7qiRw4Ho0UJ6SNvUgSQNn3T2WDxROoI5g==
X-Google-Smtp-Source: AA6agR6zL6ec+fOQDfG2ED2J8ChXlfhLt6WeEMM9bGcsMW2OyMEhKYlRi7lqU2CnT/LDwCJvo/3tnA==
X-Received: by 2002:a2e:be28:0:b0:25f:d901:16ef with SMTP id z40-20020a2ebe28000000b0025fd90116efmr9399329ljq.126.1661985137146;
        Wed, 31 Aug 2022 15:32:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p6-20020ac24ec6000000b004946da0f075sm496997lfr.135.2022.08.31.15.32.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 15:32:14 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id g7so4963825lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:32:12 -0700 (PDT)
X-Received: by 2002:a05:6512:23a1:b0:48a:fde8:ce8c with SMTP id
 c33-20020a05651223a100b0048afde8ce8cmr10438685lfv.393.1661985132356; Wed, 31
 Aug 2022 15:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220830045923.net-next.v1.1.I4fee0ac057083d4f848caf0fa3a9fd466fc374a0@changeid>
 <166198321700.20200.2886724035407277786.git-patchwork-notify@kernel.org>
In-Reply-To: <166198321700.20200.2886724035407277786.git-patchwork-notify@kernel.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Wed, 31 Aug 2022 15:32:00 -0700
X-Gmail-Original-Message-ID: <CAM7w-FWjcQBOsRa=EK8CAiS_1WvFAjUVktzWx_3ksL5Vs2jGfg@mail.gmail.com>
Message-ID: <CAM7w-FWjcQBOsRa=EK8CAiS_1WvFAjUVktzWx_3ksL5Vs2jGfg@mail.gmail.com>
Subject: Re: [PATCH net-next v1] r8152: allow userland to disable multicast
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     linux-kernel@vger.kernel.org, levinale@google.com,
        chithraa@google.com, frankgor@google.com, aaron.ma@canonical.com,
        dober6023@gmail.com, davem@davemloft.net, edumazet@google.com,
        chenhao288@hisilicon.com, hayeswang@realtek.com, kuba@kernel.org,
        jflf_kernel@gmx.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Hayes and Jakub for taking this upstream.
