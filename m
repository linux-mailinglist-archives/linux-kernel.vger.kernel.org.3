Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E4530532
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiEVSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiEVSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 14:34:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8743135A;
        Sun, 22 May 2022 11:34:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so24512708ejj.10;
        Sun, 22 May 2022 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zja7XvNY7Cfy4mTlLxR1XsgPqR561q6HRHAxx3WkJKc=;
        b=O6rAA86ewpmN2TQtr38f1vWkc+reyvDORtuBfltVtK9wbuR78i2wOCutL3JXg8Rglh
         ek7PH7i03UTUpBkazZ28Eg7rwvBRh8ttb7lMAKC/3qslgeCQvz/JXET0NpG0b296dp4C
         hj+cpOIUEWoLJIJHDUb4Ta+427n5JMtc345W7YingzVP45T2sGG5wRFGFwQKt0jOdzZ1
         PM3WAAVdEc3t7fITE0tp7f278qv/UDGJRrjWk9lRLl4Y+Vi8segreVRMM5yyXkUZcmvm
         UQMOl/5+ldmSIjYJsEJKF7VUee50X/k97Pd5YNq7id0fh3ErhbtqPCw2a+4TSGPMz4kw
         RnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zja7XvNY7Cfy4mTlLxR1XsgPqR561q6HRHAxx3WkJKc=;
        b=WDpcCj6RFt/RCUNouAXSdAIf5LqRKgFtUN3eFevHzlaSTj6VCvCP7Gn5zRsjFGUW7d
         +iCRfBvKDjxk6t1vp/7uIfZxAj4r2fH2XPtsMY/GgzgGWI0l2RAMIV1VgH/3SWpMZNQm
         xP6yRv2Tt2WhFSBu+EOJTyMXSapgCKr3p9onfgZcUrjnfeCoK8Jxb2B+bBqERZFTi6Qf
         ZmR6jCpD76OwxAG//YZFsBqhmLSF8qu8SXjnMKD88MKesu3CGFyR7vY1uC3MrGjW06dI
         CoC/UxwgQdAWNLwZzxJWziUZLCahnTRKEEZzqWk9b70zPPpx3/njdS8Hran9o5HTVU7o
         ejbg==
X-Gm-Message-State: AOAM533uDh02dD/pl76Z/LSmIONkMcDuCu/Jvy48podvG3bkOQyMgAoo
        ogI5safIMYhgEYhGnxMtR7Wyu7B07PWmRw==
X-Google-Smtp-Source: ABdhPJwfNbUaHBNQN3VRJoxBEmezzMuqwCqgZFO2FQqts01naha88rVn8CJBAbGSiLEmUY0HjjHt1A==
X-Received: by 2002:a17:907:972a:b0:6f4:f456:50a7 with SMTP id jg42-20020a170907972a00b006f4f45650a7mr16409951ejc.431.1653244460061;
        Sun, 22 May 2022 11:34:20 -0700 (PDT)
Received: from DESKTOP-A98GP49 (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm2388004ejc.105.2022.05.22.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 11:34:19 -0700 (PDT)
Date:   Sun, 22 May 2022 20:34:17 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix an error handling path
 in aqc_probe()
Message-ID: <YoqCKdfYQKyrFtxN@DESKTOP-A98GP49>
References: <be6b955d50de140fcc96bd116150b435021bf567.1653225250.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6b955d50de140fcc96bd116150b435021bf567.1653225250.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Christophe!

Aleksa
