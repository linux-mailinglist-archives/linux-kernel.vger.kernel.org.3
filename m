Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA04ED63D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiCaIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCaIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:53:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805575AA77;
        Thu, 31 Mar 2022 01:51:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x31so14761482pfh.9;
        Thu, 31 Mar 2022 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Es8rTOxq6rZzv451nsZJnq7AUxprjIuvSfLkZjw/VNo=;
        b=eyQgpwi9RLMYbT5/aNZSNGIoGmiB+Mn7gLJMxVDaRErjB7vrHSkQ0KqH2ZfD1xZV8E
         PgXmqldTBk/DfOnNc5+RDCnGRqE5TMen18EpOczM2+DxKqRvNg4RshHELEnlNUhkoi/z
         DrzSP362KRH16HbeeWAyyCoLvp7bW0ly6jkPNmeIn/MhSx+NEPLM6k+FzkZtg5mH7Ej4
         Y0RGUU0o4rMRmCJ4E7DAxl8D5RyKrpv0uZSy9hi1G/yvxn4lYrYJ7McrBdl3kezuq9sU
         NKzpLdrZMXFVAqbbbUOoy7z1J3KTOBhmelIflkjGXmp5T1lAPzLM863JaG2Z7Ie+GXit
         pU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Es8rTOxq6rZzv451nsZJnq7AUxprjIuvSfLkZjw/VNo=;
        b=DF7NIhdu280PHTz5JGOCieTC8qarRDuhpTSr57uScJXaWK0M+XbWbyD/oo5BG4HKgT
         HUxa3ub8kDOjro47YVWVm1ophmiRxeRVv4/JlsyVaN4TqH6gKMBsD9QVmP1vlTaDXBMu
         AgGrs/nXbj+XybL16Z5KLwzUTxUJMsMzhgeXYeL2ShLK/WO/smkXddpP0dbPbaFGG1Pe
         qy5bHZmNHTvh0PrbfkHXOCCPqOgPJBWgfQELOimvb+LLTSqYRi1YkcjW5AX0nUxw+LGs
         U1fEJ+hA9x8SAnSLeDb4YwEV7teazp4q4Vs521Mt0fcnrLMelUopoeyMMxIP7xULEsUo
         cX6Q==
X-Gm-Message-State: AOAM533FVoREFDOhMjb40VW7PT5AYZOp/dAVmgXnoTLKWhht/0o085XS
        6myPoIImcTzm+tKKiV6bLNE=
X-Google-Smtp-Source: ABdhPJwDm9EnXV2WmHP3tJTzAyJ7osSyDJO8PTsX52S4lyjmqDwHqfFmn7mDaCDxYcCBWN8RC/Bzkw==
X-Received: by 2002:a63:586:0:b0:386:326:f486 with SMTP id 128-20020a630586000000b003860326f486mr10058537pgf.3.1648716689027;
        Thu, 31 Mar 2022 01:51:29 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id k23-20020a17090a591700b001ca00b46cf9sm4171342pji.18.2022.03.31.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 01:51:28 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        sboyd@kernel.org, vireshk@kernel.org, xiam0nd.tong@gmail.com
Subject: Re: [PATCH v2] opp: use list iterator only inside the loop
Date:   Thu, 31 Mar 2022 16:51:10 +0800
Message-Id: <20220331085110.32416-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331084453.jlmuilvg3n3ve27t@vireshk-i7>
References: <20220331084453.jlmuilvg3n3ve27t@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 14:14:53 +0530, Viresh Kumar wrote:
> This is V3 and not V2. You need to be careful to update them for every
> single version of patch you send.
> 

Thank you very much for your patient reply. I got it.

--
Xiaomeng Tong
