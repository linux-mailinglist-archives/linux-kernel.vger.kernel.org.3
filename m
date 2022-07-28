Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3329583ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiG1Ix0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiG1IxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:53:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC96558C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:53:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id va17so2120053ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gaVPhbgEcxlsnqy93D4Iqlgm1JoP80V03xVr6Y088CI=;
        b=XP8Ooee/+br+mq6qm1WNXd+xDVeZsfA/vbGdsjcNDfavOrVVaLAxRZee8vsTCFD6LA
         XKaSHJPEhZPWBCBRykmPUONEhuxHgZNuZXsWl7vUNGh5NNGlGKJ9GvNmQcgMpd41rTo/
         A26sc1LUfOkcXMpTlh3euxjoHwC3Kj4oHhHDQoSOQMmk+ytcK4cbtSWEGKsgpT+iRqQZ
         iRMrxfwOWQqu8mS51Nm2b3sald9sbDmD/FbH7/NG9QaGDxDpMQEwsBH8Ty9Skxam/U74
         9ap1Y4ufx7ROSEma+ViN2rlQ2bqiraedr7Z2RwL5mgRsZZY0tbYP9aJCpkS0tkb+Jk0y
         DTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gaVPhbgEcxlsnqy93D4Iqlgm1JoP80V03xVr6Y088CI=;
        b=6aY52U+CsOjcGIZ+k1soco0URyN1mWd8TyNwvWpUqhAmOxD49P1gceaLUIrs29iOf1
         uhdZjIDKPu9leOjmhnqpQzLn7ttAp4pslRN+rx81MlXApkCSMByl/Uu8O6L6jXCe720+
         6Ef3P0BqRg8Tkci22kiO528u2kbpV7Z2TJx+lQJgRmBEfoTSd+E0Ipv9NsUxCD+6FnvH
         EeZfqGu9CtEVGD9UIktjIKGs8LmW/4fpq5VK1GItVtWD0hhDFV0mWb9aHD6ElSA7WKNi
         7qxh6QmVPLy86hGGSIrbqSOFFlL6ID9MB3brau+mmlXWX6bS0wPCiOyPhwWQB5vxsx08
         n2ag==
X-Gm-Message-State: AJIora8uH7yvMbAUS3RDEk/Z8pmusSHAhra6SzLLpnv8qdlmVLmPaHhe
        Zbd0f+cQs3Zj8aCs0sx5wIlEWoANjQmSlAsA
X-Google-Smtp-Source: AGRyM1tMvLweNH+Ko8tTPb/utW+S+fqRSVtWDBfjWyuKttil9/fE6lm+qvuTEf5Xm8vEmG6KaSJf0Q==
X-Received: by 2002:a17:907:6096:b0:72f:1d74:b71b with SMTP id ht22-20020a170907609600b0072f1d74b71bmr20821611ejc.272.1658998391795;
        Thu, 28 Jul 2022 01:53:11 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a26-20020a05640213da00b0043a554818afsm295576edx.42.2022.07.28.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 01:53:11 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:53:10 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     jiri@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, stephen@networkplumber.org,
        edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
        leon@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        michael.chan@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v9 2/2] bnxt_en: implement callbacks for devlink
 selftests
Message-ID: <YuJOdsgzqlzPAZZn@nanopsycho>
References: <20220727165721.37959-1-vikas.gupta@broadcom.com>
 <20220727165721.37959-3-vikas.gupta@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727165721.37959-3-vikas.gupta@broadcom.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 27, 2022 at 06:57:21PM CEST, vikas.gupta@broadcom.com wrote:
>From: vikas <vikas.gupta@broadcom.com>
>
>Add callbacks
>=============
>.selftest_check: returns true for flash selftest.
>.selftest_run: runs a flash selftest.
>
>Also, refactor NVM APIs so that they can be
>used with devlink and ethtool both.
>
>Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
